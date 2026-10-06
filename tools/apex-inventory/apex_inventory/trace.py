"""APEX-to-EVS traceability matrix.

One row per APEX region. Rows on pages in the migration slice (legacy/mapping.json) are
`planned` (or whatever status the mapping says once a region ships); every other region is
`not_migrated`. Coverage = migrated regions / total regions.
"""

from __future__ import annotations

import csv
import json
from collections import Counter
from pathlib import Path
from typing import Any

TRACE_COLUMNS = [
    "apex_page",
    "apex_page_name",
    "apex_region_id",
    "apex_region_name",
    "apex_region_type",
    "evs_route",
    "evs_component",
    "api_endpoint",
    "sql_object",
    "test_id",
    "status",
]
STATUSES = ("not_migrated", "planned", "in_progress", "migrated", "retired")


def load_mapping(path: Path | str) -> dict[str, Any]:
    return json.loads(Path(path).read_text(encoding="utf-8"))


def _region_override(page_map: dict[str, Any], region: dict) -> dict[str, Any]:
    overrides = page_map.get("regions", {})
    return overrides.get(region["id"]) or overrides.get(region.get("display_name") or "") or {}


def _shell_override(mapping: dict[str, Any], region: dict) -> dict[str, Any]:
    shell = mapping.get("shell_regions", {})
    return shell.get(region["source_type"]) or shell.get(region.get("display_name") or "") or {}


def build_trace_rows(inventory: dict[str, Any], mapping: dict[str, Any]) -> list[dict[str, str]]:
    pages_by_no = {p["page"]: p for p in inventory["pages"]}
    slice_by_page = {int(entry["apex_page"]): entry for entry in mapping.get("slice", [])}
    rows: list[dict[str, str]] = []
    for region in sorted(inventory["regions"], key=lambda r: (r["page"], r["sequence"] or 0, r["id"])):
        page = pages_by_no.get(region["page"], {})
        page_map = slice_by_page.get(region["page"])
        shell = _shell_override(mapping, region)
        if page_map is not None:
            override = _region_override(page_map, region)
            merged = {**page_map, **shell, **override}
            status = merged.get("status", "planned")
        else:
            merged = shell
            status = shell.get("status", "not_migrated")
        if status not in STATUSES:
            raise ValueError(f"unknown status {status!r} for region {region['id']}")
        sql_object = merged.get("sql_object")
        if sql_object is None:
            sql_object = ";".join(region.get("schema_objects", []))
        rows.append(
            {
                "apex_page": str(region["page"]),
                "apex_page_name": page.get("display_name") or "",
                "apex_region_id": region["id"],
                "apex_region_name": region.get("display_name") or "",
                "apex_region_type": region["source_type"],
                "evs_route": merged.get("evs_route", "") if page_map is not None else "",
                "evs_component": merged.get("evs_component", ""),
                "api_endpoint": merged.get("api_endpoint", ""),
                "sql_object": sql_object,
                "test_id": merged.get("test_id", "") if page_map is not None else "",
                "status": status,
            }
        )
    return rows


def write_trace_csv(rows: list[dict[str, str]], path: Path | str) -> None:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=TRACE_COLUMNS, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def coverage(rows: list[dict[str, str]]) -> dict[str, Any]:
    by_status = Counter(r["status"] for r in rows)
    total = len(rows)
    migrated = by_status.get("migrated", 0)
    planned = by_status.get("planned", 0) + by_status.get("in_progress", 0) + migrated
    slice_pages = sorted({int(r["apex_page"]) for r in rows if r["status"] != "not_migrated"})
    return {
        "total_regions": total,
        "by_status": dict(sorted(by_status.items())),
        "migrated_regions": migrated,
        "planned_regions": planned,
        "coverage_migrated": round(migrated / total, 4) if total else 0.0,
        "coverage_planned": round(planned / total, 4) if total else 0.0,
        "slice_pages": slice_pages,
        "formula": "migrated regions / total regions",
    }
