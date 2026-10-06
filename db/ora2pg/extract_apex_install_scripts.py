"""Unwrap the Oracle APEX supporting-object install scripts into plain Oracle SQL files.

APEX exports wrap every install script as
    wwv_flow_imp_shared.create_install_script(... p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2('line', ...)))
ora2pg cannot read that, so this script rebuilds the original SQL text, orders scripts by
p_sequence and writes one file per object kind into db/ora2pg/oracle/.

Usage: python db/ora2pg/extract_apex_install_scripts.py <path to f7150 dir or strategic-planner.zip> [out_dir]
"""

from __future__ import annotations

import io
import re
import sys
import zipfile
from pathlib import Path

SCRIPT_RE = re.compile(
    r"p_name=>'([^']*)'.*?p_sequence=>(\d+).*?p_script_type=>'(\w+)'"
    r".*?p_script_clob=>wwv_flow_string\.join\(wwv_flow_t_varchar2\((.*?')\)\)\s*\);",
    re.S,
)
CREATE_RE = re.compile(
    r"^\s*create\s+(?:or\s+replace\s+)?(?:(?:non)?editionable\s+)?(?:unique\s+|bitmap\s+)?"
    r"(package\s+body|package|view|trigger|sequence|table|index|function|procedure|type)\b",
    re.I,
)

KIND_FILES = {
    "sequence": "01_sequences.sql",
    "table": "02_tables.sql",
    "index": "02_tables.sql",
    "view": "03_views.sql",
    "trigger": "04_triggers.sql",
    "package": "05_packages.sql",
    "package body": "05_packages.sql",
    "function": "06_functions_procedures.sql",
    "procedure": "06_functions_procedures.sql",
    "seed": "07_seed_data.sql",
    "sample": "08_sample_data.sql",
    "other": "09_other_plsql.sql",
}


def read_install_scripts(source: Path) -> dict[str, str]:
    """Return {filename: text} for application/deployment/install/*.sql."""
    files: dict[str, str] = {}
    if source.suffix == ".zip":
        with zipfile.ZipFile(source) as zf:
            for name in zf.namelist():
                if "/application/deployment/install/" in name and name.endswith(".sql"):
                    files[Path(name).name] = io.TextIOWrapper(zf.open(name), encoding="utf-8").read()
    else:
        for path in sorted((source / "application" / "deployment" / "install").glob("*.sql")):
            files[path.name] = path.read_text(encoding="utf-8")
    return files


CHUNK_RE = re.compile(r"p_script_clob=>wwv_flow_string\.join\(wwv_flow_t_varchar2\((.*?')\)\)\s*\);", re.S)


def _literals(body: str) -> str:
    body = re.sub(r"'\s*\n\|\|'", "", body)
    parts = re.findall(r"'((?:[^']|'')*)'", body)
    return "\n".join(p.replace("''", "'") for p in parts)


def unwrap(text: str) -> tuple[str, int, str] | None:
    """Join create_install_script plus every append_to_install_script chunk (long scripts span several)."""
    m = SCRIPT_RE.search(text)
    if not m:
        return None
    name, seq, _typ, _body = m.groups()
    chunks = [_literals(c) for c in CHUNK_RE.findall(text)]
    # append_to_install_script concatenates clobs byte for byte; a chunk boundary can fall inside a line
    return name, int(seq), "".join(chunks)


def split_statements(sql: str) -> list[str]:
    """Split on '/' terminator lines (PL/SQL units) and on ';' for plain DDL/DML.

    A chunk between two '/' lines may hold several plain statements followed by one PL/SQL
    unit (create table ...; create index ...; create or replace trigger ... end;), so plain
    statements are cut at ';' until a PL/SQL unit starts, which then runs to the chunk end.
    """
    plsql_start = re.compile(
        r"^\s*(create\s+(?:or\s+replace\s+)?(?:(?:non)?editionable\s+)?"
        r"(?:package|trigger|function|procedure|type)\b|declare\b|begin\b)",
        re.I,
    )
    units: list[str] = []
    for chunk in re.split(r"^\s*/\s*$", sql, flags=re.M):
        if not chunk.strip():
            continue
        lines = chunk.splitlines()
        buf: list[str] = []
        for idx, line in enumerate(lines):
            if plsql_start.match(line) and not any(ln.strip() and not ln.lstrip().startswith("--") for ln in buf):
                units.append("\n".join(lines[idx:]).strip())
                buf = []
                break
            buf.append(line)
            if line.rstrip().endswith(";") and not plsql_start.match(buf[0]):
                units.append("\n".join(buf).strip())
                buf = []
        if any(ln.strip() for ln in buf):
            units.append("\n".join(buf).strip())
    return [u for u in units if u.strip("-\n ").strip()]


def classify(unit: str, script_name: str) -> str:
    body = "\n".join(ln for ln in unit.splitlines() if not ln.lstrip().startswith("--"))
    m = CREATE_RE.match(body)
    if m:
        return m.group(1).lower()
    if re.match(r"^\s*alter\s+table\b", body, re.I):
        return "table"
    if re.match(r"^\s*insert\b", body, re.I):
        return "sample" if "sample data" in script_name.lower() else "seed"
    return "other"


CASE_CONCAT_RE = re.compile(r"\b(case\s+when\b[^\n;]*?\bend)(\s*\|\|)", re.I)


def fix_case_concat(unit: str) -> str:
    """ora2pg drops the rest of a PL/SQL unit after `case when ... end||'x'`; `(case ... end)||'x'` converts."""
    unit = CASE_CONCAT_RE.sub(r"(\1)\2", unit)
    # ora2pg drops the last character of a sequence name that is followed directly by ';'
    return re.sub(r"(?i)(create\s+sequence\s+\w+);", r"\1\n;", unit)


def main() -> None:
    source = Path(sys.argv[1])
    out_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path(__file__).resolve().parent / "oracle"
    out_dir.mkdir(parents=True, exist_ok=True)
    scripts = []
    for fname, text in read_install_scripts(source).items():
        parsed = unwrap(text)
        if parsed:
            scripts.append((parsed[1], parsed[0], fname, parsed[2]))
    scripts.sort()

    buckets: dict[str, list[str]] = {f: [] for f in dict.fromkeys(KIND_FILES.values())}
    counts: dict[str, int] = {}
    for seq, name, fname, sql in scripts:
        for unit in split_statements(sql):
            kind = classify(unit, name)
            if kind == "table":
                # ora2pg file-input parser drops CREATE TABLE statements with comment-only lines in the column list
                unit = "\n".join(ln for ln in unit.splitlines() if not ln.strip().startswith("--"))
            counts[kind] = counts.get(kind, 0) + 1
            terminator = "\n/" if kind in {"package", "package body", "trigger", "function", "procedure", "other"} else ""
            if not terminator and not unit.rstrip().endswith(";"):
                unit = unit.rstrip() + ";"  # scripts that used the "/" terminator alone
            buckets[KIND_FILES[kind]].append(f"-- source: {fname} (p_sequence {seq}, {name})\n{unit}{terminator}\n")

    header = (
        "-- Oracle DDL/DML rebuilt from the APEX 24.2 Strategic Planner starter app export (f7150, MIT licence).\n"
        "-- Generated by db/ora2pg/extract_apex_install_scripts.py; input to ora2pg. Do not edit by hand.\n\n"
    )
    for fname, units in buckets.items():
        if units:
            (out_dir / fname).write_text(header + "\n".join(fix_case_concat(u) for u in units), encoding="utf-8")
    for kind, n in sorted(counts.items()):
        print(f"{kind:14s} {n}")


if __name__ == "__main__":
    main()
