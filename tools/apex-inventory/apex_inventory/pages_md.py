"""Render page-definition metadata (title, regions, items, processes) as Markdown tables."""

from __future__ import annotations

from typing import Any


def _esc(value: Any) -> str:
    if value is None:
        return ""
    return str(value).replace("|", "\\|").replace("\n", " ")


def page_markdown(inventory: dict[str, Any], page_no: int, route: str | None = None) -> str:
    page = next((p for p in inventory["pages"] if p["page"] == page_no), None)
    if page is None:
        raise KeyError(page_no)
    regions = [r for r in inventory["regions"] if r["page"] == page_no]
    reports = [r for r in inventory["reports"] if r["page"] == page_no]
    charts = [c for c in inventory["charts"] if c["page"] == page_no]
    items = [i for i in inventory["items"] if i["page"] == page_no]
    processes = [p for p in inventory["processes"] if p["page"] == page_no]
    das = [d for d in inventory["dynamic_actions"] if d["page"] == page_no]
    by_id = {r["id"]: r for r in regions}

    out = [f"### APEX page {page_no}: {_esc(page['display_name'])}", ""]
    meta = [
        ("Title", page.get("display_title")),
        ("Mode", page.get("mode")),
        ("Page group", page.get("page_group")),
        ("Authorization", page.get("authorization") or "none (any authenticated user)"),
        ("EVS route", route or "none"),
        ("Source file", f"`{page['file']}`"),
    ]
    out += ["| Attribute | Value |", "|---|---|"]
    out += [f"| {k} | {_esc(v)} |" for k, v in meta]
    out.append("")
    out += [
        f"**Regions ({len(regions)})**",
        "",
        "| Seq | Region | Type | Parent | SQL objects |",
        "|---|---|---|---|---|",
    ]
    for r in sorted(regions, key=lambda r: (r["sequence"] or 0, r["id"])):
        parent = by_id.get(r["parent_region_id"] or "", {}).get("display_name", "")
        out.append(
            f"| {_esc(r['sequence'])} | {_esc(r['display_name'])} | {_esc(r['source_type'])} | "
            f"{_esc(parent)} | {_esc(', '.join(r['schema_objects']))} |"
        )
    out.append("")
    if reports:
        out += [
            f"**Interactive Reports ({len(reports)})**",
            "",
            "| Region | Columns | Saved reports | Detail link |",
            "|---|---|---|---|",
        ]
        for rep in reports:
            out.append(
                f"| {_esc(rep['region_name'])} | {len(rep['columns'])} | {rep['saved_reports']} | "
                f"{_esc(rep['detail_link'])} |"
            )
        out.append("")
    if charts:
        out += [
            f"**Charts ({len(charts)})**",
            "",
            "| Region | Type | Series | SQL objects |",
            "|---|---|---|---|",
        ]
        for c in charts:
            objs = sorted({o for s in c["series"] for o in s["schema_objects"]})
            names = ", ".join(_esc(s["name"]) for s in c["series"])
            out.append(
                f"| {_esc(c['region_name'])} | {_esc(c['chart_type'])} | {names} | {_esc(', '.join(objs))} |"
            )
        out.append("")
    visible = [i for i in items if i["display_as"] != "NATIVE_HIDDEN"]
    hidden = len(items) - len(visible)
    out += [
        f"**Items ({len(items)}, {hidden} hidden)**",
        "",
        "| Item | Display as | Prompt | Region | Required |",
        "|---|---|---|---|---|",
    ]
    for i in sorted(visible, key=lambda i: (i["sequence"] or 0, i["name"] or "")):
        region = by_id.get(i["region_id"] or "", {}).get("display_name", "")
        out.append(
            f"| {_esc(i['name'])} | {_esc(i['display_as'])} | {_esc(i['prompt'])} | {_esc(region)} | "
            f"{'yes' if i['is_required'] else ''} |"
        )
    out.append("")
    if processes:
        out += [
            f"**Processes ({len(processes)})**",
            "",
            "| Process | Type | Point | PL/SQL objects |",
            "|---|---|---|---|",
        ]
        for p in sorted(processes, key=lambda p: p["sequence"] or 0):
            out.append(
                f"| {_esc(p['name'])} | {_esc(p['type'])} | {_esc(p['point'])} | "
                f"{_esc(', '.join(p['schema_objects']))} |"
            )
        out.append("")
    if das:
        out += [f"**Dynamic actions ({len(das)})**", "", "| Name | Event | Actions |", "|---|---|---|"]
        for d in sorted(das, key=lambda d: d["sequence"] or 0):
            acts = ", ".join(_esc(a["action"]) for a in d["actions"])
            out.append(f"| {_esc(d['name'])} | {_esc(d['event'])} | {acts} |")
        out.append("")
    return "\n".join(out)
