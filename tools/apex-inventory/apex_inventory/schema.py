"""Extract the supporting-object install scripts (SP_ schema DDL/DML) from an export.

APEX stores supporting objects as `wwv_flow_imp_shared.create_install_script` calls whose
`p_script` holds the SQL text, continued by `append_to_install_script` calls. This writes one
ordered `.sql` file per script plus an index so ora2pg (or psql after translation) can consume
them without an Oracle database.
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any

from apex_inventory.plsql import parse_file

DDL_KIND_RE = re.compile(
    r"create\s+(?:or\s+replace\s+)?(?:editionable\s+)?"
    r"(table|view|package\s+body|package|trigger|function|procedure|sequence|type|index)\s+"
    r"(?:\"?([A-Za-z0-9_]+)\"?\.)?\"?([A-Za-z0-9_]+)\"?",
    re.I,
)
DML_RE = re.compile(
    r"^\s*(insert\s+into|update|merge\s+into|delete\s+from)\s+([A-Za-z0-9_\".]+)", re.I | re.M
)


def _slug(name: str) -> str:
    return re.sub(r"[^a-z0-9]+", "_", name.lower()).strip("_")


def classify_script(sql: str) -> dict[str, Any]:
    objects: dict[str, list[str]] = {}
    for m in DDL_KIND_RE.finditer(sql):
        kind = re.sub(r"\s+", "_", m.group(1).lower())
        objects.setdefault(kind, []).append(m.group(3).lower())
    dml_targets = sorted({m.group(2).strip('"').lower() for m in DML_RE.finditer(sql)})
    if objects:
        kind = "ddl"
    elif dml_targets:
        kind = "dml"
    else:
        kind = "plsql_block"
    return {
        "kind": kind,
        "objects": {k: sorted(set(v)) for k, v in objects.items()},
        "dml_targets": dml_targets,
    }


def _script_text(call) -> str:
    text = call.get("p_script_clob")
    if not isinstance(text, str):
        text = call.get("p_script")
    return text if isinstance(text, str) else ""


def collect_install_scripts(export_dir: Path) -> list[dict[str, Any]]:
    export_dir = Path(export_dir)
    install_dirs = list(export_dir.glob("**/deployment/install"))
    scripts: list[dict[str, Any]] = []
    for install_dir in install_dirs:
        for path in sorted(install_dir.glob("*.sql")):
            current: dict[str, Any] | None = None
            for call in parse_file(path, export_dir):
                if call.name == "create_install_script":
                    current = {
                        "id": call.id(),
                        "name": call.get("p_name"),
                        "sequence": call.get("p_sequence") or 0,
                        "sql": _script_text(call),
                        "file": call.file,
                    }
                    scripts.append(current)
                elif call.name == "append_to_install_script" and current is not None:
                    current["sql"] += _script_text(call)
    scripts.sort(key=lambda s: (s["sequence"], s["name"] or ""))
    for s in scripts:
        s.update(classify_script(s["sql"]))
    return scripts


def collect_deinstall_script(export_dir: Path) -> str | None:
    for path in Path(export_dir).glob("**/deployment/definition.sql"):
        for call in parse_file(path, export_dir):
            if call.name == "create_install":
                text = call.get("p_deinstall_script")
                return text if isinstance(text, str) else None
    return None


def write_schema_dir(export_dir: Path, out_dir: Path) -> dict[str, Any]:
    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    scripts = collect_install_scripts(export_dir)
    written: list[dict[str, Any]] = []
    all_sql: list[str] = []
    for i, s in enumerate(scripts, start=1):
        fname = f"{i:03d}_{_slug(s['name'] or 'script')}.sql"
        body = s["sql"].rstrip() + "\n"
        header = (
            f"-- APEX supporting object install script: {s['name']}\n"
            f"-- sequence {s['sequence']}, source {s['file']}\n"
            f"-- kind: {s['kind']}\n\n"
        )
        (out_dir / fname).write_text(header + body, encoding="utf-8")
        all_sql.append(f"@@{fname}")
        written.append(
            {"file": fname, **{k: s[k] for k in ("name", "sequence", "kind", "objects", "dml_targets")}}
        )
    (out_dir / "install_all.sql").write_text(
        "-- Runs every supporting-object script in APEX install order (SQL*Plus / SQLcl syntax).\n"
        + "\n".join(all_sql)
        + "\n",
        encoding="utf-8",
    )
    deinstall = collect_deinstall_script(export_dir)
    if deinstall:
        (out_dir / "deinstall.sql").write_text(deinstall.rstrip() + "\n", encoding="utf-8")

    counts: dict[str, int] = {}
    for w in written:
        for kind, names in w["objects"].items():
            counts[kind] = counts.get(kind, 0) + len(names)
    lines = [
        "# SP_ schema install scripts",
        "",
        "Extracted from the APEX supporting objects (`application/deployment/install/*.sql`) by",
        "`python -m apex_inventory ... --schema-out`. Files run in APEX install order; `install_all.sql`",
        "chains them for SQL*Plus or SQLcl. These are Oracle SQL and PL/SQL; WP2 feeds the DDL files to",
        "ora2pg (`ora2pg -t TABLE -i <file>`) and ports the packages by hand or through ora2pg's",
        "PL/SQL pass.",
        "",
        "Object counts: " + ", ".join(f"{v} {k}" for k, v in sorted(counts.items())) + ".",
        "",
        "| # | File | Kind | Objects |",
        "|---|---|---|---|",
    ]
    for i, w in enumerate(written, start=1):
        objs = "; ".join(f"{k}: {', '.join(v)}" for k, v in w["objects"].items())
        if not objs and w["dml_targets"]:
            objs = "rows into " + ", ".join(w["dml_targets"])
        lines.append(f"| {i} | `{w['file']}` | {w['kind']} | {objs} |")
    (out_dir / "README.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    return {"scripts": len(written), "object_counts": counts, "files": written}
