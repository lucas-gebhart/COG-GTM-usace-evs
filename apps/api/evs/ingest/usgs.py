"""USGS NWIS Instantaneous Values (WaterML 2 JSON). Gage height 00065 (ft) and discharge 00060 (cfs)."""

import json
from dataclasses import dataclass
from datetime import datetime

from evs.ingest.timeparse import parse_iso

USGS_IV_URL = "https://waterservices.usgs.gov/nwis/iv/"
MAX_SITES_PER_CALL = 100


def iv_url(base: str, sites: list[str]) -> str:
    return f"{base}?format=json&sites={','.join(sites)}&parameterCd=00065,00060&siteStatus=all"


@dataclass
class UsgsReading:
    site: str
    site_name: str | None
    observed_at: datetime | None
    gage_height_ft: float | None
    discharge_cfs: float | None
    provisional: bool


def parse_iv(text: str) -> dict[str, UsgsReading]:
    out: dict[str, UsgsReading] = {}
    for ts in (json.loads(text).get("value") or {}).get("timeSeries") or []:
        info = ts.get("sourceInfo") or {}
        codes = info.get("siteCode") or [{}]
        site = str(codes[0].get("value") or "").strip()
        if not site:
            continue
        var = ((ts.get("variable") or {}).get("variableCode") or [{}])[0].get("value")
        values = (ts.get("values") or [{}])[0].get("value") or []
        if not values:
            continue
        latest = values[-1]
        try:
            v = float(latest.get("value"))
        except (TypeError, ValueError):
            continue
        if v <= -999990:
            continue
        reading = out.setdefault(site, UsgsReading(site, info.get("siteName"), None, None, None, False))
        reading.observed_at = max(
            filter(None, [reading.observed_at, parse_iso(latest.get("dateTime"))]), default=None
        )
        reading.provisional = reading.provisional or "P" in (latest.get("qualifiers") or [])
        if var == "00065":
            reading.gage_height_ft = v
        elif var == "00060":
            reading.discharge_cfs = v
    return out
