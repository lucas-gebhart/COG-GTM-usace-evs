"""Deterministic Markov simulator used when EVS_FEED_SOURCE=simulated or when LPMS has failed for over 6 h.

States follow report section 2.7: Green -> Yellow 4 % per 15 min step, Yellow -> Green 30 %,
Yellow -> Red 10 %, Red -> Yellow 25 %, with the Green -> Yellow probability tripled in March through May
(high water). Stoppage reasons are drawn from the 36 real LPMS reason codes
(legacy/data_samples/lpms/lookup_stoppage_reason_codes.json). Rows have the same shapes as the live adapters
and carry source = "simulated". Output depends only on (lock set, seed, step index) so repeated runs and tests
are reproducible.
"""

import hashlib
import random
from dataclasses import dataclass
from datetime import UTC, datetime, timedelta

from evs.ingest.gis import LockDim
from evs.ingest.lpms import DelayRow, LockStatusRow, StoppageRow

STATES = ("green", "yellow", "red")
P_GREEN_TO_YELLOW = 0.04
P_YELLOW_TO_GREEN = 0.30
P_YELLOW_TO_RED = 0.10
P_RED_TO_YELLOW = 0.25
HIGH_WATER_MONTHS = (3, 4, 5)
HIGH_WATER_MULTIPLIER = 3.0
STEP = timedelta(minutes=15)
EPOCH = datetime(2026, 1, 1, tzinfo=UTC)
WEATHER = ("CLR", "PC", "OVC", "RA", "FG")
NOTES_YELLOW = (
    "One chamber in service for maintenance",
    "River chamber only, land chamber dewatered",
    "Restricted tows to 12 barges",
    "Outdraft advisory above the dam",
)


@dataclass
class SimulatedLock:
    lock_id: str
    state: str
    step: int
    reason_code: str | None
    delay_4h_min: float
    pending: int


def _rng(seed: int, lock_id: str, step: int) -> random.Random:
    digest = hashlib.sha256(f"{seed}:{lock_id}:{step}".encode()).digest()
    return random.Random(int.from_bytes(digest[:8], "big"))


def step_index(now: datetime) -> int:
    return int((now - EPOCH) / STEP)


def simulate_state(lock_id: str, now: datetime, seed: int, reason_codes: list[str]) -> SimulatedLock:
    """Replay the last 400 steps (100 h) of the chain up to `now`; the chain mixes within that horizon."""
    steps = step_index(now)
    state, reason = "green", None
    high_water = now.month in HIGH_WATER_MONTHS
    base = _rng(seed, lock_id, 0)
    # start a fraction of locks in yellow so the first cycle is not all green
    if base.random() < 0.08:
        state = "yellow"
    begin = max(0, steps - 400)
    for i in range(begin, steps + 1):
        r = _rng(seed, lock_id, i).random()
        if state == "green":
            p = P_GREEN_TO_YELLOW * (HIGH_WATER_MULTIPLIER if high_water else 1.0)
            if r < p:
                state, reason = "yellow", reason_codes[_rng(seed, lock_id, i).randrange(len(reason_codes))]
        elif state == "yellow":
            if r < P_YELLOW_TO_RED:
                state = "red"
            elif r < P_YELLOW_TO_RED + P_YELLOW_TO_GREEN:
                state, reason = "green", None
        elif state == "red" and r < P_RED_TO_YELLOW:
            state = "yellow"
    rng = _rng(seed, lock_id, steps + 7)
    if state == "green":
        delay, pending = round(rng.uniform(0, 45), 1), rng.randint(0, 4)
    elif state == "yellow":
        delay, pending = round(rng.uniform(60, 200), 1), rng.randint(3, 9)
    else:
        delay, pending = round(rng.uniform(240, 600), 1), rng.randint(6, 14)
    return SimulatedLock(lock_id, state, steps, reason, delay, pending)


def simulate_cycle(
    locks: list[LockDim], now: datetime, seed: int, reason_codes: list[str]
) -> tuple[list[LockStatusRow], list[DelayRow], list[StoppageRow]]:
    status_rows, delay_rows, stoppages = [], [], []
    for d in locks:
        sim = simulate_state(d.lock_id, now, seed, reason_codes)
        rng = _rng(seed, d.lock_id, sim.step + 11)
        if sim.state == "yellow" and rng.random() < 0.5:
            notes = rng.choice(NOTES_YELLOW)
        else:
            notes = None
        status_rows.append(
            LockStatusRow(
                lock_id=d.lock_id,
                river_code=d.river_code,
                lock_no=d.lock_no,
                eroc=d.district,
                lock_name=d.lock_name,
                entry_at=now - timedelta(minutes=rng.randint(5, 55)),
                upper_gauge_ft=round(rng.uniform(300, 420), 1),
                lower_gauge_ft=round(rng.uniform(290, 410), 1),
                weather_code=rng.choice(WEATHER),
                air_temp_f=round(rng.uniform(35, 90)),
                pending_arrivals=sim.pending,
                locking_now=rng.randint(0, 2),
                locked_up_24h=rng.randint(4, 20),
                locked_down_24h=rng.randint(4, 20),
                avg_delay_4h_min=sim.delay_4h_min,
                active_stoppage=sim.state != "green" and notes is None,
                ntni_notices=[],
                notes=notes,
                latitude=d.latitude,
                longitude=d.longitude,
                raw={"simulated": True, "state": sim.state, "step": sim.step},
            )
        )
        delay_rows.append(
            DelayRow(
                d.lock_id,
                d.district,
                d.river_code,
                d.lock_no,
                sim.delay_4h_min,
                round(sim.delay_4h_min * rng.uniform(0.6, 1.1), 1),
            )
        )
        if sim.state != "green" and (notes is None or sim.state == "red"):
            begin = now - timedelta(hours=rng.randint(1, 36))
            stoppages.append(
                StoppageRow(
                    lock_id=d.lock_id,
                    chamber_no="1",
                    begin_at=begin,
                    end_at=None if sim.state == "red" else begin + timedelta(hours=rng.randint(40, 96)),
                    is_scheduled=sim.state != "red" and rng.random() < 0.6,
                    reason_code=sim.reason_code,
                    traffic_stopped=sim.state == "red",
                    hw_cycles=None,
                    refresh_at=now,
                    raw={"simulated": True, "state": sim.state},
                )
            )
    return status_rows, delay_rows, stoppages
