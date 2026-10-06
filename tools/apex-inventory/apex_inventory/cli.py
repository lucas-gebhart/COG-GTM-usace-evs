"""Command line entry point: python -m apex_inventory <export_dir> [options]."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from apex_inventory import __version__
from apex_inventory.inventory import build_inventory
from apex_inventory.pages_md import page_markdown
from apex_inventory.schema import write_schema_dir
from apex_inventory.split import split_export
from apex_inventory.trace import build_trace_rows, coverage, load_mapping, write_trace_csv

SUMMARY_ROWS = [
    ("Pages", "pages"),
    ("Regions (all)", "regions"),
    ("  Interactive Reports (NATIVE_IR)", "interactive_reports"),
    ("  Classic reports (create_report_region)", "classic_reports"),
    ("  JET charts", "charts"),
    ("  Regions with SQL source", "regions_with_sql"),
    ("  Regions with table source (forms, IRs)", "regions_with_table_source"),
    ("IR columns", "interactive_report_columns"),
    ("Chart series", "chart_series"),
    ("Page items", "items"),
    ("Buttons", "buttons"),
    ("Processes (all types)", "processes"),
    ("  PL/SQL processes (NATIVE_PLSQL)", "plsql_processes"),
    ("Validations", "validations"),
    ("Computations", "computations"),
    ("Branches", "branches"),
    ("Dynamic actions", "dynamic_actions"),
    ("  DA actions", "dynamic_action_actions"),
    ("Lists of values", "lovs"),
    ("Authorization schemes", "authorization_schemes"),
    ("  Authorization references", "authorization_references"),
    ("SP_ objects referenced", "schema_objects_referenced_count"),
    ("PL/SQL lines in processes", "plsql_lines"),
    ("SQL lines in region sources", "sql_lines"),
]


def render_summary(inventory: dict, cov: dict | None = None) -> str:
    s = inventory["summary"]
    app = inventory.get("application", {})
    width = max(len(label) for label, _ in SUMMARY_ROWS) + 2
    lines = [
        f"APEX application {app.get('app_id')} '{app.get('name')}' v{app.get('version')} "
        f"(APEX {app.get('apex_version')})",
        "=" * (width + 10),
    ]
    for label, key in SUMMARY_ROWS:
        lines.append(f"{label:<{width}}{s.get(key, 0):>8,}")
    if cov:
        lines.append("-" * (width + 10))
        lines.append(f"{'Regions in migration slice':<{width}}{cov['planned_regions']:>8,}")
        lines.append(f"{'Regions migrated':<{width}}{cov['migrated_regions']:>8,}")
        lines.append(f"{'Coverage (migrated / total)':<{width}}{cov['coverage_migrated'] * 100:>7.1f}%")
        lines.append(f"{'Coverage if slice ships':<{width}}{cov['coverage_planned'] * 100:>7.1f}%")
        lines.append(f"Slice pages: {', '.join(str(p) for p in cov['slice_pages'])}")
    return "\n".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="apex_inventory",
        description="Parse an Oracle APEX split export into an inventory and traceability matrix.",
    )
    parser.add_argument("export_dir", type=Path, help="Split export directory (contains application/pages)")
    parser.add_argument("--out", type=Path, help="Write inventory JSON here")
    parser.add_argument("--trace", type=Path, help="Write traceability CSV here (requires --mapping)")
    parser.add_argument("--mapping", type=Path, help="Mapping JSON of APEX pages to EVS routes")
    parser.add_argument(
        "--schema-out", type=Path, help="Extract supporting-object install scripts to this dir"
    )
    parser.add_argument(
        "--pages-md", type=Path, help="Write page-definition Markdown for the slice pages here"
    )
    parser.add_argument("--split", type=Path, help="Split a monolithic f*.sql into export_dir first")
    parser.add_argument("--summary", action="store_true", help="Print the summary table")
    parser.add_argument("--version", action="version", version=f"apex-inventory {__version__}")
    args = parser.parse_args(argv)

    if args.split:
        written = split_export(args.split, args.export_dir)
        print(f"split {args.split} into {len(written)} files under {args.export_dir}", file=sys.stderr)

    inventory = build_inventory(args.export_dir)

    cov = None
    rows = None
    mapping = load_mapping(args.mapping) if args.mapping else None
    if mapping is not None:
        rows = build_trace_rows(inventory, mapping)
        cov = coverage(rows)
        inventory["coverage"] = cov
    elif args.trace:
        parser.error("--trace requires --mapping")

    if args.out:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(json.dumps(inventory, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    if args.trace and rows is not None:
        write_trace_csv(rows, args.trace)
    if args.schema_out:
        result = write_schema_dir(args.export_dir, args.schema_out)
        print(f"wrote {result['scripts']} install scripts to {args.schema_out}", file=sys.stderr)
    if args.pages_md:
        if mapping is None:
            parser.error("--pages-md requires --mapping")
        sections = []
        for entry in mapping["slice"]:
            sections.append(page_markdown(inventory, int(entry["apex_page"]), entry.get("evs_route")))
        args.pages_md.parent.mkdir(parents=True, exist_ok=True)
        args.pages_md.write_text("\n\n".join(sections) + "\n", encoding="utf-8")
    if args.summary or not (args.out or args.trace or args.schema_out or args.pages_md):
        print(render_summary(inventory, cov))
    return 0
