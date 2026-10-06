"""NOAA National Water Prediction Service (NWPS) gauge API: observed and forecast stage, flood categories."""

import json
from dataclasses import dataclass, field
from datetime import datetime

from evs.ingest.timeparse import parse_iso

NWPS_BASE_URL = "https://api.water.noaa.gov/nwps/v1"
FLOOD_CATEGORIES = ("action", "minor", "moderate", "major")
# One list call over the inland waterway region returns every gauge (about 6700 on 2026-10-06, 6.8 MB) with
# observed and forecast status, which keeps the worker inside the NWPS limit of 10 requests per 5 minutes.
REGION_BBOX = (-98.0, 28.5, -77.0, 47.0)


def gauge_url(base: str, lid: str) -> str:
    return f"{base.rstrip('/')}/gauges/{lid}"


def region_url(base: str, bbox: tuple[float, float, float, float] = REGION_BBOX) -> str:
    xmin, ymin, xmax, ymax = bbox
    return (
        f"{base.rstrip('/')}/gauges?bbox.xmin={xmin}&bbox.ymin={ymin}&bbox.xmax={xmax}&bbox.ymax={ymax}"
        "&srid=EPSG_4326"
    )


@dataclass
class NwpsGauge:
    lid: str
    usgs_id: str | None
    name: str | None
    observed_at: datetime | None
    stage_ft: float | None
    flow_kcfs: float | None
    flood_category: str | None
    forecast_category: str | None
    forecast_at: datetime | None
    forecast_stage_ft: float | None
    categories: dict[str, float] = field(default_factory=dict)
    latitude: float | None = None
    longitude: float | None = None

    @property
    def moderate_stage_ft(self) -> float | None:
        return self.categories.get("moderate")


def _value(v) -> float | None:
    try:
        f = float(v)
    except (TypeError, ValueError):
        return None
    return None if f <= -999 else f


def _category(v) -> str | None:
    if not v:
        return None
    text = str(v).strip().lower()
    return text or None


def _gauge(d: dict) -> NwpsGauge:
    status = d.get("status") or {}
    obs, fc = status.get("observed") or {}, status.get("forecast") or {}
    cats = {
        k: _value((v or {}).get("stage")) for k, v in ((d.get("flood") or {}).get("categories") or {}).items()
    }
    return NwpsGauge(
        lid=d.get("lid"),
        usgs_id=str(d["usgsId"]) if d.get("usgsId") else None,
        name=d.get("name"),
        observed_at=parse_iso(obs.get("validTime")),
        stage_ft=_value(obs.get("primary")),
        flow_kcfs=_value(obs.get("secondary")),
        flood_category=_category(obs.get("floodCategory")),
        forecast_category=_category(fc.get("floodCategory")),
        forecast_at=parse_iso(fc.get("validTime")),
        forecast_stage_ft=_value(fc.get("primary")),
        categories={k: v for k, v in cats.items() if v is not None},
        latitude=_value(d.get("latitude")),
        longitude=_value(d.get("longitude")),
    )


def parse_gauge(text: str) -> NwpsGauge:
    return _gauge(json.loads(text))


def parse_gauge_list(text: str) -> dict[str, NwpsGauge]:
    """`gauges?bbox...` response: same per-gauge shape as the detail endpoint minus flood categories."""
    out: dict[str, NwpsGauge] = {}
    for d in json.loads(text).get("gauges") or []:
        if d.get("lid"):
            out[d["lid"]] = _gauge(d)
    return out
