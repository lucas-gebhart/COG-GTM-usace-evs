"""LPMS (Corps Locks) ORDS feed parsing.

Endpoints are documented on the corpslocks "Data Web Services" page; shapes are captured in
legacy/data_samples/lpms. Gotchas handled here: `lock_delay_json` is invalid JSON (values missing a closing
quote), `latitude`/`longitude` are swapped in `lock_status_report`, `activeStallStoppages` and
`ntniNoticesLinks` are HTML anchors, numeric fields are padded strings, lock numbers are not zero padded.
"""

import csv
import io
import json
import re
from dataclasses import dataclass, field
from datetime import datetime
from typing import Any

from evs.ingest.timeparse import parse_entry, parse_zoned

NOTICE_RE = re.compile(r"in_nav_notice_number=(\d+)")
DELAY_REPAIR_RE = re.compile(r'": "([^"{}\[\],]*),"')
NOTE_KEYWORDS = ("one chamber", "land chamber only", "river chamber only", "restricted", "outdraft")


def lock_id(river_code: str, lock_no: str | int) -> str:
    no = str(lock_no).strip()
    return f"{river_code.strip().upper()}-{no.zfill(2) if no.isdigit() else no.upper()}"


def num(value: Any) -> float | None:
    if value is None:
        return None
    text = str(value).strip()
    if not text or text.upper() in {"N/A", "NA", "NULL", "-"}:
        return None
    try:
        return float(text)
    except ValueError:
        return None


def intnum(value: Any) -> int | None:
    v = num(value)
    return None if v is None else int(v)


class LpmsEndpoints:
    def __init__(self, base: str) -> None:
        self.base = base.rstrip("/")

    @property
    def lock_status(self) -> str:
        return f"{self.base}/json/lock_status_report?in_river_codes=ALL"

    @property
    def lock_delay(self) -> str:
        return f"{self.base}/lock_delay_json"

    @property
    def stall_stoppage(self) -> str:
        return f"{self.base}/stall_stoppage_json"

    def lock_queue(self, river: str, lock: str) -> str:
        return f"{self.base}/json/lock_queue_json?in_river={river}&in_lock={lock}"

    def traffic(self, river: str, lock: str) -> str:
        return f"{self.base}/json/traffic_report?in_river={river}&in_lock={lock}"

    def lookup(self, name: str) -> str:
        return f"{self.base}/lookups/{name}"


@dataclass
class LockStatusRow:
    lock_id: str
    river_code: str
    lock_no: str
    eroc: str | None
    lock_name: str | None
    entry_at: datetime | None
    upper_gauge_ft: float | None
    lower_gauge_ft: float | None
    weather_code: str | None
    air_temp_f: float | None
    pending_arrivals: int | None
    locking_now: int | None
    locked_up_24h: int | None
    locked_down_24h: int | None
    avg_delay_4h_min: float | None
    active_stoppage: bool
    ntni_notices: list[str]
    notes: str | None
    latitude: float | None
    longitude: float | None
    raw: dict = field(default_factory=dict, repr=False)


@dataclass
class DelayRow:
    lock_id: str
    eroc: str | None
    river_code: str
    lock_no: str
    delay_4h_min: float | None
    delay_24h_min: float | None


@dataclass
class StoppageRow:
    lock_id: str
    chamber_no: str | None
    begin_at: datetime | None
    end_at: datetime | None
    is_scheduled: bool
    reason_code: str | None
    traffic_stopped: bool
    hw_cycles: int | None
    refresh_at: datetime | None
    raw: dict = field(default_factory=dict, repr=False)

    def active_at(self, now: datetime) -> bool:
        if self.begin_at is None or self.begin_at > now:
            return False
        return self.end_at is None or self.end_at >= now


@dataclass
class QueueRow:
    lock_id: str
    vessel_no: str
    vessel_name: str | None
    direction: str | None
    num_barges: int | None
    arrival_at: datetime | None
    sol_at: datetime | None
    end_of_lockage_at: datetime | None
    mmsi: str | None


@dataclass
class LockageRow:
    lock_id: str
    vessel_no: str
    vessel_name: str | None
    direction: str | None
    num_barges: int | None
    number_processed: int | None
    hazard_code: str | None
    arrival_at: datetime | None
    sol_at: datetime | None
    end_of_lockage_at: datetime


def _loads(text: str) -> list[dict]:
    data = json.loads(text)
    if isinstance(data, dict):
        data = data.get("items") or data.get("locks") or []
    return [row for row in data if isinstance(row, dict)]


def parse_lock_status(text: str) -> list[LockStatusRow]:
    rows: list[LockStatusRow] = []
    for r in _loads(text):
        river, no = str(r.get("riverCode", "")).strip(), str(r.get("lockNo", "")).strip()
        if not river or not no:
            continue
        # The feed stores longitude in `latitude` and vice versa (all 77 rows on 2026-10-06).
        swapped_lat, swapped_lon = num(r.get("longitude")), num(r.get("latitude"))
        if swapped_lat is not None and abs(swapped_lat) > 90:
            swapped_lat, swapped_lon = swapped_lon, swapped_lat
        rows.append(
            LockStatusRow(
                lock_id=lock_id(river, no),
                river_code=river,
                lock_no=no.zfill(2),
                eroc=r.get("eroc"),
                lock_name=(r.get("lockName") or "").strip() or None,
                entry_at=parse_entry(r.get("entryDatetime"), r.get("eroc")),
                upper_gauge_ft=num(r.get("upperGauge")),
                lower_gauge_ft=num(r.get("lowerGauge")),
                weather_code=r.get("weatherCode"),
                air_temp_f=num(r.get("airTemparture")),
                pending_arrivals=intnum(r.get("totalPendingArrivals")),
                locking_now=intnum(r.get("totalLocking")),
                locked_up_24h=intnum(r.get("totalLockedUp24Hours")),
                locked_down_24h=intnum(r.get("totalLockedDown24Hours")),
                avg_delay_4h_min=num(r.get("average4HourDelay")),
                active_stoppage=bool(r.get("activeStallStoppages")),
                ntni_notices=NOTICE_RE.findall(r.get("ntniNoticesLinks") or ""),
                notes=r.get("notes"),
                latitude=swapped_lat,
                longitude=swapped_lon,
                raw=r,
            )
        )
    return rows


def repair_delay_json(text: str) -> str:
    """lock_delay_json emits `"fourHourAverageDelayInMinutes": "N/A,"twentyFour...` (no closing quote).
    Re-insert the quote before the comma; valid JSON passes through unchanged."""
    try:
        json.loads(text)
        return text
    except json.JSONDecodeError:
        return DELAY_REPAIR_RE.sub(r'": "\1","', text)


def parse_lock_delay(text: str) -> list[DelayRow]:
    rows: list[DelayRow] = []
    for r in _loads(repair_delay_json(text)):
        river, no = str(r.get("riverCode", "")).strip(), str(r.get("lockNumber", "")).strip()
        if not river or not no:
            continue
        rows.append(
            DelayRow(
                lock_id(river, no),
                r.get("eroc"),
                river,
                no.zfill(2),
                num(r.get("fourHourAverageDelayInMinutes")),
                num(r.get("twentyFourHourAverageDelayInMinutes")),
            )
        )
    return rows


def parse_stoppages(text: str) -> list[StoppageRow]:
    rows: list[StoppageRow] = []
    for r in _loads(text):
        river, no = str(r.get("riverCode", "")).strip(), str(r.get("lockNumber", "")).strip()
        if not river or not no:
            continue
        rows.append(
            StoppageRow(
                lock_id=lock_id(river, no),
                chamber_no=(str(r["chamberNumber"]) if r.get("chamberNumber") is not None else None),
                begin_at=parse_zoned(r.get("beginStopDate")),
                end_at=parse_zoned(r.get("endStopDate")),
                is_scheduled=str(r.get("isScheduled", "")).strip().lower() == "yes",
                reason_code=(r.get("reasonCode") or "").strip() or None,
                traffic_stopped=str(r.get("trafficStopped", "")).strip().upper() == "Y",
                hw_cycles=intnum(r.get("numHwCycles")),
                refresh_at=parse_zoned(r.get("refreshDate")),
                raw=r,
            )
        )
    return rows


def newest_refresh(stoppages: list[StoppageRow]) -> datetime | None:
    stamps = [s.refresh_at for s in stoppages if s.refresh_at]
    return max(stamps) if stamps else None


def parse_queue(text: str, lock: str) -> list[QueueRow]:
    rows: list[QueueRow] = []
    for r in _loads(text):
        tz = r.get("timezone")
        vessel_no = str(r.get("vesselNo") or "").strip()
        if not vessel_no:
            continue
        rows.append(
            QueueRow(
                lock,
                vessel_no,
                r.get("vesselName"),
                r.get("direction"),
                intnum(r.get("numBarges")),
                parse_zoned(r.get("arrivalDate"), tz),
                parse_zoned(r.get("SOLdate") or r.get("solDate"), tz),
                parse_zoned(r.get("endOfLockage"), tz),
                str(r["MMSI"]) if r.get("MMSI") is not None else None,
            )
        )
    return rows


def parse_traffic(text: str, lock: str) -> list[LockageRow]:
    rows: list[LockageRow] = []
    for r in _loads(text):
        tz = r.get("timezone")
        end = parse_zoned(r.get("endOfLockage"), tz)
        vessel_no = str(r.get("vesselNo") or "").strip()
        if end is None or not vessel_no:
            continue
        rows.append(
            LockageRow(
                lock,
                vessel_no,
                r.get("vesselName"),
                r.get("direction"),
                intnum(r.get("numBarges")),
                intnum(r.get("numberProcessed")),
                r.get("hazardCode"),
                parse_zoned(r.get("arrivalDate"), tz),
                parse_zoned(r.get("solDate"), tz),
                end,
            )
        )
    return rows


def parse_lookup_csv(text: str) -> list[dict[str, str]]:
    reader = csv.DictReader(io.StringIO(text.strip()))
    return [{(k or "").strip(): (v or "").strip() for k, v in row.items()} for row in reader]


def parse_reason_codes(text: str) -> list[str]:
    return [row.get("STOPPAGE_REASON", "") for row in parse_lookup_csv(text) if row.get("STOPPAGE_REASON")]


def note_keyword(notes: str | None) -> str | None:
    lowered = (notes or "").lower()
    for kw in NOTE_KEYWORDS:
        if kw in lowered:
            return kw
    return None
