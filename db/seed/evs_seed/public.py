"""Loaders for the real public samples: NDC Locks GIS layer, LPMS JSON feeds and SRP figures.

Rows keep their provenance (source = 'ndc-gis' / 'fixtures' / 'cited-public' with source URLs).
The baseline status evaluation reproduces the status engine rules from docs/PLAN.md so fixtures
mode and database mode agree on every lock.
"""

from __future__ import annotations

import json
import re
from datetime import UTC, datetime, timedelta, timezone

from evs_seed import DATA, NOW

PUBLIC = DATA / "public"
RIVER_NAMES = {
    "OH": "Ohio River",
    "MI": "Mississippi River",
    "IL": "Illinois Waterway",
    "TN": "Tennessee River",
    "CU": "Cumberland River",
    "AR": "Arkansas River (MKARNS)",
    "AG": "Allegheny River",
    "MO": "Monongahela River",
    "GI": "Gulf Intracoastal Waterway",
    "KA": "Kanawha River",
    "GR": "Green River",
    "BS": "Black Warrior-Tombigbee",
    "TT": "Tennessee-Tombigbee",
    "RR": "Red River",
    "CH": "Columbia River",
    "SN": "Snake River",
    "KY": "Kentucky River",
    "OU": "Ouachita River",
    "AT": "Atchafalaya",
    "WH": "White River",
}
OWNER_CODES = {"1": "USACE", "2": "Other federal", "3": "State", "4": "Local", "5": "Private"}
TZ_OFFSET_HOURS = {"GMT": 0, "EST": -5, "EDT": -4, "CST": -6, "CDT": -5, "MST": -7, "MDT": -6, "PST": -8, "PDT": -7}
GIS_URL = "https://services7.arcgis.com/n1YM8pTrFmm7L4hs/ArcGIS/rest/services/Locks/FeatureServer/0"
LPMS_URLS = {
    "LPMS lock_status_report": "https://ndc.ops.usace.army.mil/ords/lpms/json/lock_status_report?in_river_codes=ALL",
    "LPMS lock_delay_json": "https://ndc.ops.usace.army.mil/ords/lpms/lock_delay_json",
    "LPMS stall_stoppage_json": "https://ndc.ops.usace.army.mil/ords/lpms/stall_stoppage_json",
}


def _num(v):
    try:
        return float(str(v).strip())
    except (TypeError, ValueError):
        return None


def lock_display_name(navstr: str | None, pms_name: str | None, lock_id: str) -> str:
    """NDC names some locks by number only ('22', ' 2'); use the PMS name or 'Lock and Dam N' instead."""
    for name in (navstr, pms_name):
        if name and re.search(r"[A-Za-z]{2}", name):
            return name.strip().replace("&", "and").title().replace(" And ", " and ")
    return f"Lock and Dam {lock_id.split('-', 1)[-1]}"


def lock_key(river: str, lock_no: str) -> str:
    return f"{river}-{str(lock_no).lstrip('0') or '0'}"


def lock_dims() -> list[dict]:
    """One row per lock (river, lock number) with chamber count and the main chamber's dimensions."""
    features = json.load((PUBLIC / "usace_locks_full.geojson").open())["features"]
    by_lock: dict[str, list[dict]] = {}
    for f in features:
        p = f["properties"]
        by_lock.setdefault(lock_key(p["RIVERCD"], p["LOCKCD"]), []).append(
            {**p, "coords": (f.get("geometry") or {}).get("coordinates")}
        )
    rows = []
    for lock_id, chambers in by_lock.items():
        chambers.sort(key=lambda c: c.get("CHMBCD") or "9")
        main = max(chambers, key=lambda c: (c.get("LENGTH") or 0, c.get("WIDTH") or 0))
        coords = next((c["coords"] for c in chambers if c.get("coords")), None)
        river = main["RIVERCD"]
        rows.append(
            {
                "lock_id": lock_id,
                "river_code": river,
                "lock_no": lock_id.split("-", 1)[1],
                "lock_name": lock_display_name(main.get("NAVSTR"), main.get("PMSNAME"), lock_id),
                "river_name": RIVER_NAMES.get(river) or (main.get("RIVER") or river).title(),
                "ndc_code": main.get("NDCCODE"),
                "eroc": None,
                "river_mile": _num(main.get("RIVERMI")),
                "chambers": len(chambers),
                "lift_ft": _num(main.get("LIFT")),
                "chamber_length_ft": _num(main.get("LENGTH")),
                "chamber_width_ft": _num(main.get("WIDTH")),
                "chamber_dimensions": "; ".join(
                    f"{c.get('CHAMBN') or 'Chamber ' + str(c.get('CHMBCD'))}: {c.get('LENGTH')} x {c.get('WIDTH')} ft"
                    for c in chambers
                ),
                "year_opened": int(main["YEAROPEN"]) if main.get("YEAROPEN") else None,
                "district": main.get("DISTRICT"),
                "division": main.get("DIVISION"),
                "state": main.get("STATE"),
                "town": main.get("TOWN"),
                "owner": OWNER_CODES.get(str(main.get("OWNER1")), main.get("OWNER1")),
                "operator": "USACE"
                if str(main.get("OPER1")) in {"1", "8"}
                else OWNER_CODES.get(str(main.get("OPER1")), main.get("OPER1")),
                "lon": coords[0] if coords else None,
                "lat": coords[1] if coords else None,
                "gauge_lid": None,
                "usgs_site": None,
                "source": "ndc-gis",
                "source_as_of": NOW,
            }
        )
    return rows


def lpms_baseline(known_locks: set[str], thresholds: dict[str, float]) -> tuple[list[dict], list[dict], list[dict], list[dict]]:
    """Return (lock_status_fact rows, status_eval rows, stoppage rows, extra lock_dim rows for LPMS-only locks)."""
    status_rows = json.load((PUBLIC / "lock_status_report_ALL.json").open())
    delays = {lock_key(d["riverCode"], d["lockNumber"]): d for d in json.load((PUBLIC / "lock_delay_fixed.json").open())}
    stoppages = json.load((PUBLIC / "stall_stoppage.json").open())
    refresh = datetime.strptime(stoppages[0]["refreshDate"], "%m/%d/%Y %H:%M:%S GMT").replace(tzinfo=UTC)

    def parse_stop(ts: str | None):
        """LPMS gives '06/10/2015 00:00:00 CDT'; an open stoppage has only the zone (' EDT')."""
        if not ts or len(ts.strip()) < 19:
            return None
        zone = ts.strip()[-3:]
        offset = TZ_OFFSET_HOURS.get(zone, 0)
        return datetime.strptime(ts.strip()[:19], "%m/%d/%Y %H:%M:%S").replace(tzinfo=timezone(timedelta(hours=offset)))

    facts, evals, stops, extra_dims = [], [], [], []
    seen_locks = set(known_locks)
    for s in stoppages:
        lid = lock_key(s["riverCode"], s["lockNumber"])
        if lid not in seen_locks:
            continue
        stops.append(
            {
                "lock_id": lid,
                "chamber_no": s.get("chamberNumber"),
                "begin_at": parse_stop(s["beginStopDate"]),
                "end_at": parse_stop(s.get("endStopDate")),
                "is_scheduled": s.get("isScheduled") == "Yes",
                "traffic_stopped": s.get("trafficStopped") == "Y",
                "reason_code": s.get("reasonCode"),
                "hw_cycles": s.get("numHwCycles"),
                "refresh_at": refresh,
                "source": "fixtures",
                "raw": s,
            }
        )
    for r in status_rows:
        lid = lock_key(r["riverCode"], r["lockNo"])
        if lid not in seen_locks:
            # LPMS swaps latitude/longitude in this payload
            extra_dims.append(
                {
                    "lock_id": lid,
                    "river_code": r["riverCode"],
                    "lock_no": lid.split("-", 1)[1],
                    "lock_name": lock_display_name(r.get("lockName"), None, lid),
                    "river_name": RIVER_NAMES.get(r["riverCode"], r["riverCode"]),
                    "ndc_code": None,
                    "eroc": r.get("eroc"),
                    "river_mile": None,
                    "chambers": None,
                    "lift_ft": None,
                    "chamber_length_ft": None,
                    "chamber_width_ft": None,
                    "chamber_dimensions": None,
                    "year_opened": None,
                    "district": None,
                    "division": None,
                    "state": None,
                    "town": None,
                    "owner": None,
                    "operator": None,
                    "lon": r.get("latitude"),
                    "lat": r.get("longitude"),
                    "gauge_lid": None,
                    "usgs_site": None,
                    "source": "lpms",
                    "source_as_of": refresh,
                }
            )
            seen_locks.add(lid)
        d = delays.get(lid)
        d4 = _num(d["fourHourAverageDelayInMinutes"]) if d else _num(r.get("average4HourDelay"))
        d24 = _num(d["twentyFourHourAverageDelayInMinutes"]) if d else None
        active = [s for s in stoppages if lock_key(s["riverCode"], s["lockNumber"]) == lid and s.get("trafficStopped") == "Y"]
        entry = datetime.fromisoformat(r["entryDatetime"]).replace(tzinfo=UTC)
        newest = max(entry, refresh)
        age_min = (NOW - newest).total_seconds() / 60
        queue = r.get("totalPendingArrivals") or 0
        facts.append(
            {
                "lock_id": lid,
                "polled_at": NOW,
                "source_as_of": newest,
                "entry_datetime": entry,
                "hours_of_operation": r.get("hoursOfOperation"),
                "weather_code": r.get("weatherCode"),
                "upper_gauge_ft": _num(r.get("upperGauge")),
                "lower_gauge_ft": _num(r.get("lowerGauge")),
                "air_temp_f": _num(r.get("airTemparture")),
                "water_temp_f": _num(r.get("waterTemperature")),
                "vessels_queued": queue,
                "total_locking": r.get("totalLocking"),
                "locked_up_24h": r.get("totalLockedUp24Hours"),
                "locked_down_24h": r.get("totalLockedDown24Hours"),
                "avg_delay_4h_min": d4,
                "avg_delay_24h_min": d24,
                "active_stoppages": len(active),
                "notes": r.get("notes"),
                "raw": {"status": r, "delay": d, "stoppages": active},
                "source": "fixtures",
            }
        )
        evals.append(
            {
                "lock_id": lid,
                "evaluated_at": NOW,
                "source": "fixtures",
                "source_as_of": newest,
                "freshness": "stale" if age_min > thresholds["stale_after_minutes"] else ("aging" if age_min > 15 else "fresh"),
                **evaluate(d4, queue, active, age_min, thresholds, chambers=None),
            }
        )
    return facts, evals, stops, extra_dims


def evaluate(d4, queue, active, age_min, t, chambers):
    """Status engine rules (docs/PLAN.md): stoppage > red delay > yellow delay or queue > stale > operating."""
    inputs = {
        "avg_delay_4h_min": d4,
        "vessels_queued": queue,
        "active_stoppages": len(active),
        "age_minutes": round(age_min, 1),
        "thresholds": t,
    }
    if active and (any(s["isScheduled"] == "No" for s in active) or chambers == 1):
        return {
            "status": "closed",
            "status_reason": f"Traffic stopped: {active[0]['reasonCode']}",
            "inputs_used": inputs,
        }
    if d4 is not None and d4 >= t["delay_red_minutes"]:
        return {
            "status": "closed",
            "status_reason": f"4-hour average delay {d4:.0f} min",
            "inputs_used": inputs,
        }
    if active or (d4 is not None and d4 >= t["delay_yellow_minutes"]) or queue >= t["queue_yellow_vessels"]:
        reason = (
            f"Scheduled stoppage: {active[0]['reasonCode']}"
            if active
            else f"4-hour delay {d4 or 0:.0f} min, {queue} vessels queued"
        )
        return {"status": "delayed", "status_reason": reason, "inputs_used": inputs}
    if age_min > t["stale_after_minutes"]:
        return {
            "status": "stale",
            "status_reason": f"Last operator entry {age_min / 60:.1f} h ago",
            "inputs_used": inputs,
        }
    return {
        "status": "operating",
        "status_reason": "No active stoppage, queue below threshold",
        "inputs_used": inputs,
    }


def srp_rows() -> tuple[list[dict], list[dict], dict]:
    d = json.load((PUBLIC / "srp_sources.json").open())
    return d["snapshots"], d["sites"], d["headline"]


def feed_health_rows() -> list[dict]:
    rows = [
        ("LPMS lock_status_report", LPMS_URLS["LPMS lock_status_report"], 15, NOW, None, 840),
        (
            "LPMS lock_delay_json",
            LPMS_URLS["LPMS lock_delay_json"],
            15,
            NOW,
            "Invalid JSON repaired before parse",
            610,
        ),
        ("LPMS stall_stoppage_json", LPMS_URLS["LPMS stall_stoppage_json"], 15, NOW, None, 590),
        ("NDC Locks FeatureServer", GIS_URL, 1440, NOW, None, 1200),
        ("NOAA NWPS gauges", "https://api.water.noaa.gov/nwps/v1/gauges/{lid}", 30, None, None, None),
        ("USGS NWIS IV", "https://waterservices.usgs.gov/nwis/iv/", 30, None, None, None),
    ]
    return [
        {
            "source": s,
            "endpoint": e,
            "cadence_minutes": c,
            "last_success_at": ok,
            "last_error": err,
            "latency_ms": ms,
            "status": "fixtures",
        }
        for s, e, c, ok, err, ms in rows
    ]
