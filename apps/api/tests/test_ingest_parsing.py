"""Parsing tests against the captured public payloads in legacy/data_samples (2026-10-06)."""

import json
from datetime import UTC, datetime
from pathlib import Path

from evs.ingest import gis, lpms, noaa, ntni, usgs
from evs.ingest.timeparse import parse_entry, parse_http_date, parse_zoned

SAMPLES = Path(__file__).resolve().parents[3] / "legacy" / "data_samples"


def sample(name: str) -> str:
    return (SAMPLES / name).read_text()


def test_lock_status_rows_and_swapped_coordinates():
    rows = lpms.parse_lock_status(sample("lpms/lock_status_report_ALL.json"))
    assert len(rows) == 77
    by_id = {r.lock_id: r for r in rows}
    olmsted = by_id["OH-79"]
    raw = olmsted.raw
    # the feed stores longitude under "latitude" and vice versa; parsed values are in the right fields
    assert float(raw["latitude"]) < -80 and float(raw["longitude"]) > 30
    assert 36 < olmsted.latitude < 38 and -90 < olmsted.longitude < -88
    assert olmsted.lock_no == "79" and olmsted.river_code == "OH"
    assert olmsted.ntni_notices and all(n.isdigit() for n in olmsted.ntni_notices)
    assert olmsted.pending_arrivals == 10
    assert isinstance(olmsted.entry_at, datetime) and olmsted.entry_at.tzinfo is not None
    assert all(len(r.lock_id.split("-")[1]) >= 2 for r in rows)


def test_lock_delay_json_is_repaired_before_parsing():
    raw = sample("lpms/lock_delay.json")
    try:
        json.loads(raw)
    except json.JSONDecodeError:
        pass
    else:  # pragma: no cover
        raise AssertionError("sample is expected to be malformed")
    repaired = lpms.repair_delay_json(raw)
    assert json.loads(repaired) == json.loads(sample("lpms/lock_delay_fixed.json"))
    rows = lpms.parse_lock_delay(raw)
    assert len(rows) == 192
    assert {r.lock_id for r in rows} >= {"OH-79", "MI-27", "AG-42"}
    na = [r for r in rows if r.raw_na] if hasattr(rows[0], "raw_na") else []
    assert na == []
    assert lpms.repair_delay_json('[{"a": "b"}]') == '[{"a": "b"}]'


def test_stoppages_parse_times_and_active_window():
    rows = lpms.parse_stoppages(sample("lpms/stall_stoppage.json"))
    assert len(rows) == 22
    refresh = lpms.newest_refresh(rows)
    assert refresh == datetime(2026, 10, 6, 14, 26, 17, tzinfo=UTC)
    open_ended = [r for r in rows if r.end_at is None]
    assert open_ended and all(r.active_at(refresh) for r in open_ended)
    assert all(r.begin_at is not None for r in rows)
    assert all(r.traffic_stopped for r in rows) and {r.is_scheduled for r in rows} == {True, False}


def test_queue_and_traffic():
    queue = lpms.parse_queue(sample("lpms/lock_queue_OH79.json"), "OH-79")
    assert len(queue) == 619
    waiting = [q for q in queue if q.end_of_lockage_at is None]
    assert 0 < len(waiting) < len(queue)
    traffic = lpms.parse_traffic(sample("lpms/traffic_OH79.json"), "OH-79")
    assert len(traffic) == 609
    assert all(t.end_of_lockage_at.tzinfo is not None for t in traffic)


def test_lookup_reason_codes():
    codes = lpms.parse_reason_codes(sample("lpms/lookup_stoppage_reason_codes.json"))
    assert len(codes) == 36 and "High Water" in codes


def test_gis_collapses_chambers_to_locks():
    rows = gis.parse_locks_geojson(sample("gis/usace_locks_full.geojson"))
    assert len(rows) == 232
    olmsted = next(r for r in rows if r.lock_id == "OH-79")
    assert olmsted.chambers == 2 and olmsted.chamber_dimensions == "1200 x 110 ft"
    assert abs(olmsted.latitude - 37.18) < 0.01 and abs(olmsted.longitude + 89.06) < 0.01
    assert olmsted.river_name == "Ohio River" and olmsted.district == "LRL"


def test_noaa_gauge_detail_and_list():
    g = noaa.parse_gauge(sample("noaa/gauge_CNNI3.json"))
    assert g.lid == "CNNI3" and g.usgs_id == "03303280"
    assert g.flood_category == "no_flooding" and g.moderate_stage_ft == 46.0
    assert g.stage_ft == 11.56 and g.observed_at == datetime(2026, 10, 6, 13, 0, tzinfo=UTC)
    listed = noaa.parse_gauge_list(sample("noaa/gauges_bbox.json"))
    assert len(listed) == 32 and all(v.latitude is not None for v in listed.values())
    assert noaa.region_url("https://x/v1").startswith("https://x/v1/gauges?bbox.xmin=")


def test_usgs_iv_latest_values():
    readings = usgs.parse_iv(sample("usgs/iv_03303280.json"))
    r = readings["03303280"]
    assert r.gage_height_ft == 11.47 and r.discharge_cfs == 41000.0 and r.provisional
    assert r.observed_at == datetime(2026, 10, 6, 14, 0, tzinfo=UTC)


def test_ntni_notice_effective_window_and_locks():
    n = ntni.parse_notice(sample("ntni/notice_214992.html"), "214992")
    assert n.lock_ids == ["OH-79"]
    assert n.effective_from == datetime(2026, 9, 8, 4, 0, tzinfo=UTC)
    assert n.effective_to == datetime(2026, 11, 13, 4, 0, tzinfo=UTC)
    assert n.active_at(datetime(2026, 10, 6, tzinfo=UTC)) and not n.active_at(
        datetime(2026, 12, 1, tzinfo=UTC)
    )


def test_time_parsing_edge_cases():
    assert parse_zoned("10/06/2026 14:26:17 GMT") == datetime(2026, 10, 6, 14, 26, 17, tzinfo=UTC)
    assert parse_zoned("06/10/2015 00:00:00 CDT") == datetime(2015, 6, 10, 5, 0, tzinfo=UTC)
    assert parse_zoned("10/06/26 06:34", "EDT") == datetime(2026, 10, 6, 10, 34, tzinfo=UTC)
    assert parse_zoned(" EDT") is None and parse_zoned("") is None and parse_zoned(None) is None
    assert parse_entry("2026-10-06T08:00:00", "H2") == datetime(2026, 10, 6, 12, 0, tzinfo=UTC)
    assert parse_entry("2026-10-06T08:00:00", "B2") == datetime(2026, 10, 6, 13, 0, tzinfo=UTC)
    assert parse_http_date("Tue, 06 Oct 2026 14:26:17 GMT") == datetime(2026, 10, 6, 14, 26, 17, tzinfo=UTC)
    assert parse_http_date("garbage") is None
