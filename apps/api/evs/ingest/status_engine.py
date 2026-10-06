"""Ordered lock status rules from docs/research/evs_public_data_report.md section 2.6.

RED 1-4, YELLOW 5-9, GREEN 10, STALE 11. The first matching rule wins. `as_of` is the newest input
timestamp; the feed refresh time (stoppage refreshDate or HTTP Date) counts as an input so that operator
entryDatetime lag of several hours does not mark every lock stale.
"""

from dataclasses import asdict, dataclass, field
from datetime import datetime, timedelta
from typing import Literal

from evs.ingest.lpms import LockStatusRow, StoppageRow, note_keyword
from evs.ingest.noaa import NwpsGauge
from evs.ingest.ntni import NtniNotice
from evs.ingest.usgs import UsgsReading

Status = Literal["operating", "delayed", "closed", "stale", "unknown"]
Freshness = Literal["fresh", "aging", "stale", "simulated"]
NOAA_RED = {"moderate", "major"}
NOAA_YELLOW = {"action", "minor"}


@dataclass(frozen=True)
class Thresholds:
    stale_after_minutes: int = 120
    delay_yellow_minutes: int = 60
    delay_red_minutes: int = 240
    queue_yellow_vessels: int = 6
    forecast_window_hours: int = 48
    aging_after_minutes: int = 60

    @classmethod
    def from_settings(cls, settings) -> "Thresholds":
        return cls(
            settings.stale_after_minutes,
            settings.delay_yellow_minutes,
            settings.delay_red_minutes,
            settings.queue_yellow_vessels,
        )

    def with_overrides(self, rows: dict[str, float]) -> "Thresholds":
        values = asdict(self)
        for key, value in rows.items():
            if key in values:
                values[key] = int(value)
        return Thresholds(**values)


@dataclass
class StatusInputs:
    lock_id: str
    now: datetime
    status_row: LockStatusRow | None = None
    delay_4h_min: float | None = None
    delay_24h_min: float | None = None
    stoppages: list[StoppageRow] = field(default_factory=list)
    chambers: int | None = None
    noaa: NwpsGauge | None = None
    usgs: UsgsReading | None = None
    notices: list[NtniNotice] = field(default_factory=list)
    feed_refresh_at: datetime | None = None
    previous_status: Status | None = None
    source: str = "live"


@dataclass
class StatusResult:
    status: Status
    status_reason: str
    rule_no: int | None
    as_of: datetime | None
    freshness: Freshness
    inputs_used: dict


def _iso(dt: datetime | None) -> str | None:
    return dt.isoformat() if dt else None


def newest_input(inp: StatusInputs) -> datetime | None:
    stamps = [inp.feed_refresh_at]
    if inp.status_row:
        stamps.append(inp.status_row.entry_at)
    stamps.extend(s.refresh_at for s in inp.stoppages)
    stamps.extend(s.begin_at for s in inp.stoppages if s.begin_at and s.begin_at <= inp.now)
    if inp.noaa:
        stamps.append(inp.noaa.observed_at)
    if inp.usgs:
        stamps.append(inp.usgs.observed_at)
    present = [s for s in stamps if s is not None and s <= inp.now + timedelta(minutes=5)]
    return max(present) if present else None


def evaluate(inp: StatusInputs, th: Thresholds) -> StatusResult:
    now = inp.now
    row = inp.status_row
    active = [s for s in inp.stoppages if s.active_at(now)]
    delay = inp.delay_4h_min if inp.delay_4h_min is not None else (row.avg_delay_4h_min if row else None)
    pending = row.pending_arrivals if row else None
    noaa_cat = inp.noaa.flood_category if inp.noaa else None
    usgs_stage = inp.usgs.gage_height_ft if inp.usgs else None
    moderate = inp.noaa.moderate_stage_ft if inp.noaa else None
    as_of = newest_input(inp)
    age_min = (now - as_of).total_seconds() / 60 if as_of else None

    used = {
        "evaluated_at": _iso(now),
        "feed_refresh_at": _iso(inp.feed_refresh_at),
        "entry_at": _iso(row.entry_at) if row else None,
        "delay_4h_min": delay,
        "delay_24h_min": inp.delay_24h_min,
        "pending_arrivals": pending,
        "active_stoppages": [
            {
                "chamber": s.chamber_no,
                "begin_at": _iso(s.begin_at),
                "end_at": _iso(s.end_at),
                "reason": s.reason_code,
                "traffic_stopped": s.traffic_stopped,
                "scheduled": s.is_scheduled,
            }
            for s in active
        ],
        "lpms_active_stoppage_flag": row.active_stoppage if row else None,
        "chambers": inp.chambers,
        "noaa": {
            "lid": inp.noaa.lid,
            "observed_at": _iso(inp.noaa.observed_at),
            "stage_ft": inp.noaa.stage_ft,
            "flood_category": noaa_cat,
            "forecast_category": inp.noaa.forecast_category,
            "forecast_at": _iso(inp.noaa.forecast_at),
            "moderate_stage_ft": moderate,
        }
        if inp.noaa
        else None,
        "usgs": {
            "site": inp.usgs.site,
            "observed_at": _iso(inp.usgs.observed_at),
            "gage_height_ft": usgs_stage,
            "discharge_cfs": inp.usgs.discharge_cfs,
        }
        if inp.usgs
        else None,
        "notes": row.notes if row else None,
        "ntni_notices": [n.notice_no for n in inp.notices],
        "age_minutes": round(age_min, 1) if age_min is not None else None,
        "thresholds": asdict(th),
        "source": inp.source,
    }

    def result(status: Status, reason: str, rule: int | None) -> StatusResult:
        if inp.source == "simulated":
            fresh: Freshness = "simulated"
        elif age_min is None or age_min > th.stale_after_minutes:
            fresh = "stale"
        elif age_min > th.aging_after_minutes:
            fresh = "aging"
        else:
            fresh = "fresh"
        used["rule_no"] = rule
        return StatusResult(status, reason, rule, as_of, fresh, used)

    # RED 1: unscheduled stoppage with traffic stopped, now inside the window
    for s in active:
        if s.traffic_stopped and not s.is_scheduled:
            return result(
                "closed", f"Unscheduled stoppage, traffic stopped ({s.reason_code or 'reason not given'})", 1
            )
    # RED 2: traffic stopped at a single chamber lock (scheduled or not)
    for s in active:
        if s.traffic_stopped and inp.chambers == 1:
            return result(
                "closed", f"Traffic stopped at single-chamber lock ({s.reason_code or 'scheduled'})", 2
            )
    # RED 3: four hour average delay at or above the red threshold
    if delay is not None and delay >= th.delay_red_minutes:
        return result(
            "closed", f"Average 4 hour delay {delay:.0f} min (at or above {th.delay_red_minutes})", 3
        )
    # RED 4: moderate or major flooding observed, or USGS stage above NWPS moderate stage
    if noaa_cat in NOAA_RED:
        return result("closed", f"NOAA observed {noaa_cat} flooding at {inp.noaa.lid}", 4)
    if usgs_stage is not None and moderate is not None and usgs_stage > moderate:
        return result(
            "closed", f"USGS stage {usgs_stage:.1f} ft above moderate flood stage {moderate:.1f} ft", 4
        )

    # YELLOW 5: any other active stoppage or the LPMS active stoppage indicator
    if active:
        s = active[0]
        kind = "scheduled" if s.is_scheduled else "unscheduled"
        return result("delayed", f"Active {kind} stoppage ({s.reason_code or 'reason not given'})", 5)
    if row and row.active_stoppage:
        return result("delayed", "LPMS reports an active stall or stoppage", 5)
    # YELLOW 6: delay in the yellow band or a long queue
    if delay is not None and delay >= th.delay_yellow_minutes:
        return result("delayed", f"Average 4 hour delay {delay:.0f} min", 6)
    if pending is not None and pending >= th.queue_yellow_vessels:
        return result("delayed", f"{pending} vessels pending arrival", 6)
    # YELLOW 7: action or minor flooding observed or forecast within the window
    if noaa_cat in NOAA_YELLOW:
        return result("delayed", f"NOAA observed {noaa_cat} stage at {inp.noaa.lid}", 7)
    if (
        inp.noaa
        and inp.noaa.forecast_category in NOAA_YELLOW | NOAA_RED
        and inp.noaa.forecast_at
        and inp.noaa.forecast_at <= now + timedelta(hours=th.forecast_window_hours)
    ):
        return result(
            "delayed",
            f"NOAA forecast {inp.noaa.forecast_category} stage at {inp.noaa.lid} within "
            f"{th.forecast_window_hours} h",
            7,
        )
    # YELLOW 8: restriction keywords in LPMS notes
    kw = note_keyword(row.notes) if row else None
    if kw:
        return result("delayed", f"LPMS notes: {kw}", 8)
    # YELLOW 9: open NTNI notice in effect
    for n in inp.notices:
        if inp.lock_id in n.lock_ids and n.active_at(now):
            return result("delayed", f"Navigation notice {n.notice_no} in effect", 9)

    # STALE 11 (checked before GREEN so GREEN only applies to fresh inputs)
    if age_min is None or age_min > th.stale_after_minutes:
        prior = inp.previous_status if inp.previous_status not in (None, "stale", "unknown") else None
        if as_of is None:
            return result("unknown" if prior is None else prior, "No input timestamps available", 11)
        if prior:
            return result(
                prior, f"Inputs older than {th.stale_after_minutes} min, showing last known status", 11
            )
        return result("stale", f"Inputs older than {th.stale_after_minutes} min", 11)
    # GREEN 10
    return result("operating", "No stoppage, delay, flood or restriction reported", 10)
