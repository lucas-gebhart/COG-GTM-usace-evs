from datetime import UTC, datetime
from pathlib import Path

from evs.ingest import gis, lpms, simulator

SAMPLES = Path(__file__).resolve().parents[3] / "legacy" / "data_samples"


def test_simulator_is_deterministic_and_uses_real_reason_codes():
    locks = gis.parse_locks_geojson((SAMPLES / "gis/usace_locks_full.geojson").read_text())
    codes = lpms.parse_reason_codes((SAMPLES / "lpms/lookup_stoppage_reason_codes.json").read_text())
    now = datetime(2026, 10, 6, 15, 0, tzinfo=UTC)
    a = simulator.simulate_cycle(locks, now, 42, codes)
    b = simulator.simulate_cycle(locks, now, 42, codes)
    assert [r.raw for r in a[0]] == [r.raw for r in b[0]]
    assert [s.raw for s in a[2]] == [s.raw for s in b[2]]
    states = {r.raw["state"] for r in a[0]}
    assert states == {"green", "yellow", "red"}
    assert all(s.reason_code in codes for s in a[2] if s.reason_code)
    assert all(r.raw["simulated"] for r in a[0])
    c = simulator.simulate_cycle(locks, now, 7, codes)
    assert [r.raw["state"] for r in c[0]] != [r.raw["state"] for r in a[0]]


def test_high_water_months_raise_yellow_probability():
    locks = gis.parse_locks_geojson((SAMPLES / "gis/usace_locks_full.geojson").read_text())
    codes = ["High Water"]
    spring = simulator.simulate_cycle(locks, datetime(2026, 4, 15, tzinfo=UTC), 1, codes)
    autumn = simulator.simulate_cycle(locks, datetime(2026, 10, 15, tzinfo=UTC), 1, codes)
    non_green = lambda rows: sum(r.raw["state"] != "green" for r in rows)  # noqa: E731
    assert non_green(spring[0]) > non_green(autumn[0])
