"""One hand-built case per rule of report section 2.6, in order, plus precedence checks."""

from datetime import UTC, datetime, timedelta

import pytest

from evs.ingest.lpms import LockStatusRow, StoppageRow
from evs.ingest.noaa import NwpsGauge
from evs.ingest.ntni import NtniNotice
from evs.ingest.status_engine import StatusInputs, Thresholds, evaluate, newest_input
from evs.ingest.usgs import UsgsReading

NOW = datetime(2026, 10, 6, 15, 0, tzinfo=UTC)
TH = Thresholds()


def row(**over) -> LockStatusRow:
    base = dict(
        lock_id="OH-79",
        river_code="OH",
        lock_no="79",
        eroc="H2",
        lock_name="Olmsted",
        entry_at=NOW - timedelta(hours=5),
        upper_gauge_ft=None,
        lower_gauge_ft=None,
        weather_code=None,
        air_temp_f=None,
        pending_arrivals=2,
        locking_now=0,
        locked_up_24h=5,
        locked_down_24h=5,
        avg_delay_4h_min=10.0,
        active_stoppage=False,
        ntni_notices=[],
        notes=None,
        latitude=37.2,
        longitude=-89.1,
    )
    base.update(over)
    return LockStatusRow(**base)


def stop(**over) -> StoppageRow:
    base = dict(
        lock_id="OH-79",
        chamber_no="1",
        begin_at=NOW - timedelta(hours=2),
        end_at=None,
        is_scheduled=False,
        reason_code="Repairing lock or lock hardware",
        traffic_stopped=True,
        hw_cycles=None,
        refresh_at=NOW - timedelta(minutes=10),
    )
    base.update(over)
    return StoppageRow(**base)


def gauge(**over) -> NwpsGauge:
    base = dict(
        lid="CNNI3",
        usgs_id="03303280",
        name="Ohio River at Cannelton",
        observed_at=NOW - timedelta(minutes=30),
        stage_ft=20.0,
        flow_kcfs=None,
        flood_category="no_flooding",
        forecast_category="no_flooding",
        forecast_at=None,
        forecast_stage_ft=None,
        categories={"action": 40.0, "minor": 42.0, "moderate": 46.0, "major": 50.0},
    )
    base.update(over)
    return NwpsGauge(**base)


def inputs(**over) -> StatusInputs:
    base = dict(
        lock_id="OH-79", now=NOW, status_row=row(), chambers=2, feed_refresh_at=NOW - timedelta(minutes=10)
    )
    base.update(over)
    return StatusInputs(**base)


def test_rule_1_unscheduled_stoppage_traffic_stopped():
    r = evaluate(inputs(stoppages=[stop()]), TH)
    assert (r.status, r.rule_no) == ("closed", 1)
    assert "Repairing" in r.status_reason
    assert r.inputs_used["active_stoppages"][0]["traffic_stopped"] is True


def test_rule_1_ignores_stoppages_outside_window():
    past = stop(begin_at=NOW - timedelta(days=3), end_at=NOW - timedelta(days=1))
    future = stop(begin_at=NOW + timedelta(hours=3))
    r = evaluate(inputs(stoppages=[past, future]), TH)
    assert r.rule_no == 10


def test_rule_2_scheduled_stoppage_single_chamber():
    r = evaluate(inputs(stoppages=[stop(is_scheduled=True)], chambers=1), TH)
    assert (r.status, r.rule_no) == ("closed", 2)
    # the same scheduled stoppage at a two chamber lock is only yellow
    assert evaluate(inputs(stoppages=[stop(is_scheduled=True)], chambers=2), TH).rule_no == 5


def test_rule_3_delay_at_or_above_red_threshold():
    assert evaluate(inputs(delay_4h_min=240.0), TH).rule_no == 3
    assert evaluate(inputs(status_row=row(avg_delay_4h_min=630.0)), TH).rule_no == 3
    assert evaluate(inputs(delay_4h_min=239.0), TH).rule_no == 6
    assert evaluate(inputs(delay_4h_min=239.0), Thresholds(delay_red_minutes=200)).rule_no == 3


def test_rule_4_noaa_moderate_or_major_or_usgs_above_moderate():
    assert evaluate(inputs(noaa=gauge(flood_category="moderate")), TH).rule_no == 4
    assert evaluate(inputs(noaa=gauge(flood_category="major")), TH).status == "closed"
    usgs = UsgsReading("03303280", None, NOW - timedelta(minutes=15), 47.0, None, True)
    r = evaluate(inputs(noaa=gauge(), usgs=usgs), TH)
    assert r.rule_no == 4 and "USGS" in r.status_reason
    usgs_low = UsgsReading("03303280", None, NOW - timedelta(minutes=15), 45.9, None, True)
    assert evaluate(inputs(noaa=gauge(), usgs=usgs_low), TH).rule_no == 10


def test_rule_5_other_active_stoppage_or_lpms_flag():
    r = evaluate(inputs(stoppages=[stop(traffic_stopped=False)]), TH)
    assert (r.status, r.rule_no) == ("delayed", 5)
    assert evaluate(inputs(status_row=row(active_stoppage=True)), TH).rule_no == 5


def test_rule_6_delay_band_or_queue():
    assert evaluate(inputs(delay_4h_min=60.0), TH).rule_no == 6
    assert evaluate(inputs(delay_4h_min=59.0), TH).rule_no == 10
    r = evaluate(inputs(status_row=row(pending_arrivals=6)), TH)
    assert r.rule_no == 6 and "6 vessels" in r.status_reason
    assert evaluate(inputs(status_row=row(pending_arrivals=5)), TH).rule_no == 10


def test_rule_7_action_or_minor_observed_or_forecast_within_48h():
    assert evaluate(inputs(noaa=gauge(flood_category="action")), TH).rule_no == 7
    assert evaluate(inputs(noaa=gauge(flood_category="minor")), TH).status == "delayed"
    soon = gauge(forecast_category="minor", forecast_at=NOW + timedelta(hours=24))
    assert evaluate(inputs(noaa=soon), TH).rule_no == 7
    late = gauge(forecast_category="minor", forecast_at=NOW + timedelta(hours=72))
    assert evaluate(inputs(noaa=late), TH).rule_no == 10


@pytest.mark.parametrize(
    "note",
    [
        "ONE CHAMBER in service",
        "Land chamber only",
        "river chamber only until Friday",
        "Tows restricted to 9 barges",
        "Strong outdraft at upper approach",
    ],
)
def test_rule_8_note_keywords(note):
    r = evaluate(inputs(status_row=row(notes=note)), TH)
    assert (r.status, r.rule_no) == ("delayed", 8)


def test_rule_9_open_ntni_notice():
    notice = NtniNotice(
        "214992", ["OH-79"], "Chamber closure", NOW - timedelta(days=10), NOW + timedelta(days=30)
    )
    r = evaluate(inputs(notices=[notice]), TH)
    assert (r.status, r.rule_no) == ("delayed", 9) and "214992" in r.status_reason
    expired = NtniNotice("1", ["OH-79"], None, NOW - timedelta(days=10), NOW - timedelta(days=1))
    other_lock = NtniNotice("2", ["OH-78"], None, NOW - timedelta(days=1), None)
    assert evaluate(inputs(notices=[expired, other_lock]), TH).rule_no == 10


def test_rule_10_green_when_fresh_and_nothing_matches():
    r = evaluate(inputs(), TH)
    assert (r.status, r.rule_no, r.freshness) == ("operating", 10, "fresh")
    assert r.as_of == NOW - timedelta(minutes=10)


def test_rule_11_stale_keeps_prior_colour_and_as_of():
    old = inputs(status_row=row(entry_at=NOW - timedelta(hours=9)), feed_refresh_at=NOW - timedelta(hours=3))
    r = evaluate(old, TH)
    assert (r.status, r.rule_no, r.freshness) == ("stale", 11, "stale")
    assert r.as_of == NOW - timedelta(hours=3)
    kept = evaluate(StatusInputs(**{**old.__dict__, "previous_status": "delayed"}), TH)
    assert kept.status == "delayed" and kept.rule_no == 11 and "last known" in kept.status_reason
    nothing = evaluate(StatusInputs("OH-79", NOW, status_row=row(entry_at=None), feed_refresh_at=None), TH)
    assert nothing.status == "unknown" and nothing.rule_no == 11


def test_feed_refresh_time_counts_as_input_despite_entry_lag():
    lagging = inputs(
        status_row=row(entry_at=NOW - timedelta(hours=7)), feed_refresh_at=NOW - timedelta(minutes=5)
    )
    r = evaluate(lagging, TH)
    assert r.status == "operating" and r.as_of == NOW - timedelta(minutes=5)
    assert newest_input(lagging) == NOW - timedelta(minutes=5)


def test_rule_order_red_beats_yellow_and_simulated_freshness():
    both = inputs(stoppages=[stop()], status_row=row(notes="one chamber", pending_arrivals=12))
    assert evaluate(both, TH).rule_no == 1
    sim = evaluate(inputs(source="simulated"), TH)
    assert sim.freshness == "simulated" and sim.inputs_used["source"] == "simulated"


def test_thresholds_from_db_rows_override_settings():
    th = TH.with_overrides({"delay_red_minutes": 300, "unknown_key": 1})
    assert th.delay_red_minutes == 300 and th.delay_yellow_minutes == 60
