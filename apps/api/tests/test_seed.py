"""Deterministic generator and public loader checks (no database needed)."""

import json
import sys
from pathlib import Path

import pytest

SEED_DIR = Path(__file__).resolve().parents[3] / "db" / "seed"
sys.path.insert(0, str(SEED_DIR))

from evs_seed import public, synth  # noqa: E402


@pytest.fixture(scope="module")
def data():
    return synth.generate()


def test_generator_is_deterministic(data):
    again = synth.generate()
    assert [p.p2_project_no for p in again.projects] == [p.p2_project_no for p in data.projects]
    assert again.funding[:5] == data.funding[:5]
    assert again.components[:5] == data.components[:5]


def test_generator_volumes(data):
    assert 15 <= len(data.programs) <= 20
    assert 100 <= len(data.projects) <= 150
    assert 150 <= len(data.components) <= 300
    assert {p.division for p in data.projects} >= {"LRD", "MVD", "SWD", "NWD", "SAD"}
    assert len({r["district"] for r in data.labor}) == 8
    assert len({r["pay_period"] for r in data.labor}) == 26
    work_items = {w["work_item_code"] for p in data.projects for w in p.work_items}
    months = {(r["work_item_code"], r["fiscal_month"]) for r in data.funding}
    assert all((w, m) in months for w in work_items for m in range(1, 13))
    assert {r["appropriation"] for r in data.funding} <= set(synth.APPROPRIATIONS)


def test_generator_stories(data):
    assert sum(p.story == "over_obligated" for p in data.programs) == 1
    assert sum(p.story == "slipped_milestones" for p in data.projects) == 2
    slipped = [p for p in data.projects if p.story == "slipped_milestones"]
    assert all(any(m["status"] == "slipped" for m in p.milestones) for p in slipped)
    assert any(c["story"] == "low_ci" and c["ci"] < 60 for c in data.components)
    spike = [r for r in data.labor if r["district"] == synth.OVERTIME_DISTRICT]
    assert sum(r["hours_overtime"] for r in spike) > sum(
        r["hours_overtime"] for r in data.labor if r["district"] == "LRL"
    )


def test_every_project_uses_a_real_jsheet_line(data):
    assert all(p.jsheet_source.startswith("FY26") for p in data.projects)
    assert all(p.jsheet_amount > 0 for p in data.projects)


def test_gis_collapses_chambers_to_locks():
    rows = public.lock_dims()
    features = json.load((public.PUBLIC / "usace_locks_full.geojson").open())["features"]
    assert sum(r["chambers"] for r in rows) == len(features) == 234
    assert len({r["lock_id"] for r in rows}) == len(rows)
    assert all(r["source"] == "ndc-gis" for r in rows)


def test_lpms_baseline_is_labelled_fixtures():
    thresholds = {
        "delay_yellow_minutes": 60,
        "delay_red_minutes": 180,
        "queue_yellow_vessels": 5,
        "stale_after_minutes": 180,
    }
    facts, evals, stops, extra = public.lpms_baseline({r["lock_id"] for r in public.lock_dims()}, thresholds)
    assert len(facts) == len(evals) == 77
    assert {f["source"] for f in facts} == {e["source"] for e in evals} == {"fixtures"}
    assert {e["status"] for e in evals} <= {"operating", "delayed", "closed", "stale"}
