"""Unit tests for the Strategic Planner PL/SQL ports (no database, no HTTP)."""

from datetime import date

import pytest

from evs.legacy_ports import (
    ProjectValidationError,
    apply_milestone_update,
    apply_project_status,
    archive_project,
    kanban_column,
    normalize_tags,
    pct_for_column,
    project_history_events,
    status_label,
    un_archive_project,
    validate_project_form,
)

PROJECT = {
    "p2_project_no": "1",
    "pct_complete": 40,
    "phase": "PED",
    "baseline_finish": "2027-01-01",
    "current_finish": "2027-01-01",
}
STATE = {"archived": False, "status_scale": "A", "link_url": None, "link_name": None, "note": None}


def test_page24_validations():
    with pytest.raises(ProjectValidationError) as e:
        validate_project_form({"pct_complete": 50})
    assert e.value.errors[0]["item"] == "P24_TARGET_COMPLETE"
    with pytest.raises(ProjectValidationError) as e:
        validate_project_form({"pct_complete": 10, "link_url": "https://x"})
    assert "link url and name" in e.value.message
    with pytest.raises(ProjectValidationError) as e:
        validate_project_form({"pct_complete": 55})
    assert "multiple of 10" in e.value.message
    validate_project_form({"pct_complete": 50, "current_finish": date(2027, 1, 1)})


def test_apply_project_status_and_history():
    out = apply_project_status(
        PROJECT, STATE, {"pct_complete": 80, "current_finish": date(2027, 6, 1), "status_scale": "B"}
    )
    assert out["changes"]["pct_complete"] == 80
    assert out["changes"]["schedule_health"] == "late"
    assert out["state"]["status_scale"] == "B"
    events = project_history_events("1", PROJECT, out["changes"], "pm", "UPDATE", STATE, out["state"])
    attrs = {e["attribute"] for e in events}
    assert {"PCT_COMPLETE", "TARGET_COMPLETE", "STATUS_SCALE"} <= attrs
    tc = next(e for e in events if e["attribute"] == "TARGET_COMPLETE")
    assert tc["old_value"] == "01-JAN-2027" and tc["new_value"] == "01-JUN-2027"


def test_archive_round_trip_blocks_edits():
    archived = archive_project(STATE, "pm")
    assert archived["archived"] and archived["archived_by"] == "pm" and archived["archived_at"]
    with pytest.raises(ProjectValidationError):
        apply_project_status(PROJECT, archived, {"pct_complete": 50, "current_finish": date(2027, 1, 1)})
    restored = un_archive_project(archived)
    assert not restored["archived"] and restored["archived_at"] is None and restored["archived_by"] == "pm"


def test_kanban_columns_match_page4_case():
    assert [kanban_column(p)["column_id"] for p in (10, 20, 30, 40, 50, 70, 80, 100)] == [
        1,
        1,
        2,
        3,
        4,
        4,
        5,
        5,
    ]
    assert [pct_for_column(c) for c in (1, 2, 3, 4, 5)] == [20, 30, 40, 50, 80]
    with pytest.raises(ValueError):
        pct_for_column(6)


def test_status_label_and_tags_trigger():
    assert status_label(40) == "Specification Approved" and status_label(100) == "Complete"
    assert normalize_tags("  big data,  ml ops ") == "BIG-DATA, ML-OPS"
    assert normalize_tags(None) is None


def test_page508_milestone_rules():
    current = {
        "code": "AWARD",
        "status": "scheduled",
        "baseline_date": "2027-02-26",
        "current_date": "2027-02-26",
    }
    with pytest.raises(ProjectValidationError) as e:
        apply_milestone_update(current, {"status": "complete"})
    assert {x["item"] for x in e.value.errors} == {"P508_TARGET_COMPLETE", "P508_OWNER_ID"}
    changes = apply_milestone_update(current, {"actual_date": date(2026, 1, 15), "owner": "M. Chen"})
    assert changes["status"] == "complete" and "status_last_changed_on" in changes
    slipped = apply_milestone_update(current, {"current_date": date(2027, 8, 25)})
    assert slipped["status"] == "slipped"
