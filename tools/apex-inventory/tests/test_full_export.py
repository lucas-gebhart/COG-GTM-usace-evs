"""Runs against the checked-in Strategic Planner export (skipped when absent)."""

import csv
import json
from pathlib import Path

from apex_inventory.inventory import build_inventory
from apex_inventory.trace import TRACE_COLUMNS, build_trace_rows, coverage, load_mapping

REPO_ROOT = Path(__file__).resolve().parents[3]
SLICE_PAGES = {1, 3, 4, 21, 74, 86, 161, 10000}


def test_full_export_counts(full_export):
    inv = build_inventory(full_export)
    s = inv["summary"]
    assert inv["application"]["app_id"] == 7150 and inv["application"]["name"] == "Strategic Planner"
    # Orders of magnitude from docs/PLAN.md; exact values are what the export contains.
    assert s["pages"] == 262
    assert inv["call_counts"]["wwv_flow_imp_page.create_page_plug"] == 757
    assert s["regions"] == 757 + s["classic_reports"] == 917
    assert s["interactive_reports"] == 88
    assert s["processes"] == 341 and s["plsql_processes"] == 134
    assert s["charts"] == 3 and s["chart_series"] == 4
    assert s["items"] == 1233 and s["validations"] == 50 and s["computations"] == 168
    assert s["dynamic_actions"] == 382 and s["dynamic_action_actions"] == 561
    assert s["lovs"] == 34 and s["authorization_schemes"] == 3
    assert {a["name"] for a in inv["authz"]} == {
        "Administration Rights",
        "Contribution Rights",
        "Reader Rights",
    }
    names = {p["page"]: p["display_name"] for p in inv["pages"]}
    assert names[1] == "home" and names[3] == "Project Details" and names[4] == "Kanban Board"
    assert names[21] == "Initiatives" and names[74] == "People" and names[86] == "Projects"
    assert names[161] == "Cumulative Flow" and names[10000] == "Administration"
    assert all(r["sql"] or r["table"] for r in inv["reports"]), (
        "every IR carries its region SQL or source table"
    )
    assert all(r["region_id"] for r in inv["reports"])
    assert all(len(r["columns"]) > 0 for r in inv["reports"])
    plsql = [p for p in inv["processes"] if p["type"] == "NATIVE_PLSQL"]
    assert all(p["plsql"] for p in plsql)


def test_full_export_trace_matches_mapping(full_export):
    mapping_path = REPO_ROOT / "legacy" / "mapping.json"
    inv = build_inventory(full_export)
    rows = build_trace_rows(inv, load_mapping(mapping_path))
    assert len(rows) == inv["summary"]["regions"]
    assert {int(r["apex_page"]) for r in rows if r["status"] != "not_migrated"} == SLICE_PAGES
    assert all(r["status"] in ("planned", "migrated", "not_migrated") for r in rows)
    cov = coverage(rows)
    assert cov["total_regions"] == 917 and cov["coverage_migrated"] > 0.0 and cov["planned_regions"] > 0


def test_checked_in_artifacts_are_current(full_export):
    """legacy/inventory.json and traceability.csv must match a fresh run (make inventory)."""
    inv_path = REPO_ROOT / "legacy" / "inventory.json"
    csv_path = REPO_ROOT / "legacy" / "traceability.csv"
    if not inv_path.exists() or not csv_path.exists():
        return
    checked_in = json.loads(inv_path.read_text())
    fresh = build_inventory(full_export)
    assert checked_in["summary"] == fresh["summary"]
    with csv_path.open(newline="") as fh:
        reader = csv.DictReader(fh)
        assert reader.fieldnames == TRACE_COLUMNS
        rows = list(reader)
    assert len(rows) == fresh["summary"]["regions"]
    assert rows == build_trace_rows(fresh, load_mapping(REPO_ROOT / "legacy" / "mapping.json"))
