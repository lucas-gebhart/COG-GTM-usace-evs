import csv
import json

from apex_inventory.cli import main, render_summary
from apex_inventory.inventory import build_inventory
from apex_inventory.pages_md import page_markdown
from apex_inventory.schema import collect_install_scripts, write_schema_dir
from apex_inventory.trace import TRACE_COLUMNS, build_trace_rows, coverage, load_mapping

EXPECTED_KEYS = {
    "pages",
    "regions",
    "reports",
    "charts",
    "items",
    "processes",
    "validations",
    "dynamic_actions",
    "lovs",
    "authz",
    "summary",
}


def test_mini_export_inventory(mini_export):
    inv = build_inventory(mini_export)
    assert EXPECTED_KEYS <= set(inv)
    assert inv["application"]["name"] == "Mini Planner"
    assert inv["application"]["apex_version"] == "24.2.15"
    s = inv["summary"]
    assert s["pages"] == 2 and s["pages_by_mode"] == {"NORMAL": 1, "MODAL": 1}
    assert s["regions"] == 5 and s["classic_reports"] == 1
    assert s["interactive_reports"] == 1 and s["interactive_report_columns"] == 2
    assert s["charts"] == 1 and s["chart_series"] == 1
    assert s["items"] == 2 and s["buttons"] == 1
    assert s["processes"] == 2 and s["plsql_processes"] == 1
    assert s["validations"] == 1 and s["computations"] == 1 and s["branches"] == 1
    assert s["dynamic_actions"] == 1 and s["dynamic_action_actions"] == 2
    assert s["lovs"] == 1 and s["authorization_schemes"] == 1

    home = inv["pages"][0]
    assert home["page"] == 1 and home["page_group"] == "Home"
    assert home["display_title"] == "Our Strategic Planner home"
    assert home["authorization"] == "Administration Rights"
    detail = inv["pages"][1]
    assert detail["display_name"] == "Project Details" and detail["mode"] == "MODAL"

    ir = next(r for r in inv["regions"] if r["source_type"] == "NATIVE_IR")
    assert ir["display_name"] == "My Projects"
    assert ir["sql"].startswith("select p.id, p.name, 'it''s' note")
    assert ir["schema_objects"] == ["sp_favorites", "sp_projects"]
    report = inv["reports"][0]
    assert report["region_id"] == ir["id"] and report["saved_reports"] == 1
    assert [c["heading"] for c in report["columns"]] == ["Id", "Project Name"]

    chart = inv["charts"][0]
    assert chart["chart_type"] == "area" and chart["series"][0]["schema_objects"] == ["sp_project_history"]
    chart_region = next(r for r in inv["regions"] if r["id"] == chart["region_id"])
    assert chart_region["schema_objects"] == ["sp_project_history"]

    owner = next(i for i in inv["items"] if i["name"] == "P1_OWNER")
    assert owner["named_lov"] == "SP_TEAM_MEMBERS" and owner["is_required"] and owner["prompt"] == "Person"

    proc = next(p for p in inv["processes"] if p["type"] == "NATIVE_PLSQL")
    assert proc["plsql"] == "sp_log.log_view(:APP_PAGE_ID);\nsp_util.touch('HOME');"
    assert proc["schema_objects"] == ["sp_log", "sp_util"]
    assert proc["success_message"] == "Saved (it's done)."

    da = inv["dynamic_actions"][0]
    assert da["event"] == "change" and [a["action"] for a in da["actions"]] == [
        "NATIVE_EXECUTE_PLSQL_CODE",
        "NATIVE_REFRESH",
    ]
    assert da["actions"][0]["plsql"].startswith("sp_log.log_interaction(")
    assert da["actions"][1]["affected_region_id"] == ir["id"]

    lov = inv["lovs"][0]
    assert (
        lov["name"] == "SP_TEAM_MEMBERS"
        and lov["columns"] == 1
        and lov["schema_objects"] == ["sp_team_members"]
    )
    authz = inv["authz"][0]
    assert authz["attribute"] == "Administrator" and authz["error_message"] == "You aren't an admin."
    assert {u["kind"] for u in authz["used_by"]} == {"page", "button"}


def test_mini_trace_and_coverage(mini_export, mini_mapping):
    inv = build_inventory(mini_export)
    rows = build_trace_rows(inv, load_mapping(mini_mapping))
    assert list(rows[0]) == TRACE_COLUMNS
    assert len(rows) == inv["summary"]["regions"]
    by_name = {r["apex_region_name"]: r for r in rows}
    assert (
        by_name["Breadcrumb"]["evs_component"] == "app/AppLayout"
        and by_name["Breadcrumb"]["sql_object"] == ""
    )
    assert by_name["My Projects"]["status"] == "planned"
    assert by_name["My Projects"]["sql_object"] == "sp_favorites;sp_projects"
    assert (
        by_name["My Projects"]["evs_route"] == "/"
        and by_name["My Projects"]["test_id"] == "web:Home.test.tsx"
    )
    assert (
        by_name["Burn down"]["status"] == "migrated"
        and by_name["Burn down"]["evs_component"] == "pages/Home/Chart"
    )
    assert by_name["Detail"]["status"] == "not_migrated" and by_name["Detail"]["evs_route"] == ""
    cov = coverage(rows)
    assert cov["total_regions"] == 5 and cov["migrated_regions"] == 1 and cov["planned_regions"] == 4
    assert cov["coverage_migrated"] == 0.2 and cov["slice_pages"] == [1]


def test_schema_extraction(mini_export, tmp_path):
    scripts = collect_install_scripts(mini_export)
    assert [s["name"] for s in scripts] == ["tables", "seed"]
    assert scripts[0]["kind"] == "ddl" and scripts[0]["objects"] == {
        "table": ["sp_projects"],
        "view": ["sp_projects_v"],
    }
    assert "create or replace view sp_projects_v" in scripts[0]["sql"]
    assert scripts[1]["kind"] == "dml" and scripts[1]["dml_targets"] == ["sp_projects"]
    result = write_schema_dir(mini_export, tmp_path / "schema")
    assert result["scripts"] == 2
    assert (tmp_path / "schema" / "001_tables.sql").exists()
    assert (tmp_path / "schema" / "deinstall.sql").read_text().startswith("drop table sp_projects")
    assert "install_all.sql" in {p.name for p in (tmp_path / "schema").iterdir()}


def test_page_markdown(mini_export):
    md = page_markdown(build_inventory(mini_export), 1, "/")
    assert md.startswith("### APEX page 1: home")
    assert "| 20 | My Projects | NATIVE_IR |" in md
    assert "**Items (2, 1 hidden)**" in md


def test_cli_end_to_end(mini_export, mini_mapping, tmp_path, capsys):
    out = tmp_path / "inventory.json"
    trace = tmp_path / "trace.csv"
    rc = main(
        [
            str(mini_export),
            "--mapping",
            str(mini_mapping),
            "--out",
            str(out),
            "--trace",
            str(trace),
            "--schema-out",
            str(tmp_path / "schema"),
            "--pages-md",
            str(tmp_path / "pages.md"),
            "--summary",
        ]
    )
    assert rc == 0
    inv = json.loads(out.read_text())
    assert EXPECTED_KEYS <= set(inv) and "coverage" in inv
    with trace.open(newline="") as fh:
        reader = csv.DictReader(fh)
        assert reader.fieldnames == TRACE_COLUMNS
        assert len(list(reader)) == 5
    text = capsys.readouterr().out
    assert "Mini Planner" in text and "Coverage (migrated / total)" in text and "20.0%" in text
    assert render_summary(inv, inv["coverage"]).count("\n") > 10
