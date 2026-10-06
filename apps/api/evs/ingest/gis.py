"""NDC Locks FeatureServer (ArcGIS) GeoJSON: authoritative lock geometry and characteristics.
One feature per chamber (234 on 2026-10-06); collapsed to one row per lock on RIVERCD + LOCKCD."""

import json
from dataclasses import dataclass

from evs.ingest.lpms import lock_id, num

GIS_LOCKS_URL = (
    "https://services7.arcgis.com/n1YM8pTrFmm7L4hs/ArcGIS/rest/services/Locks/FeatureServer/0/query"
    "?where=1%3D1&outFields=*&f=geojson"
)


@dataclass
class LockDim:
    lock_id: str
    river_code: str
    lock_no: str
    river_name: str | None
    lock_name: str | None
    river_mile: float | None
    district: str | None
    division: str | None
    state: str | None
    town: str | None
    chambers: int | None
    lift_ft: float | None
    chamber_dimensions: str | None
    year_opened: int | None
    owner: str | None
    operator: str | None
    latitude: float | None
    longitude: float | None
    geom_source: str = "gis"


def _title(value: str | None) -> str | None:
    if not value:
        return None
    return " ".join(w if w in {"&", "L/D", "L&D"} else w.capitalize() for w in value.strip().split())


def parse_locks_geojson(text: str) -> list[LockDim]:
    data = json.loads(text)
    by_lock: dict[str, dict] = {}
    for feat in data.get("features", []):
        p = feat.get("properties") or {}
        river, no = str(p.get("RIVERCD") or "").strip(), str(p.get("LOCKCD") or "").strip()
        if not river or not no:
            continue
        key = lock_id(river, no)
        coords = (feat.get("geometry") or {}).get("coordinates")
        entry = by_lock.setdefault(key, {"p": p, "coords": coords, "dims": []})
        if entry["coords"] is None and coords:
            entry["coords"] = coords
        length, width = num(p.get("LENGTH")), num(p.get("WIDTH"))
        if length and width:
            entry["dims"].append((length, width))
    rows: list[LockDim] = []
    for key, entry in by_lock.items():
        p, coords = entry["p"], entry["coords"]
        dims = max(entry["dims"]) if entry["dims"] else None
        river_name = _title(p.get("RIVER"))
        rows.append(
            LockDim(
                lock_id=key,
                river_code=str(p["RIVERCD"]).strip(),
                lock_no=str(p["LOCKCD"]).strip().zfill(2),
                river_name=f"{river_name} River"
                if river_name
                and "river" not in river_name.lower()
                and "waterway" not in river_name.lower()
                and "canal" not in river_name.lower()
                else river_name,
                lock_name=_title(p.get("PMSNAME") or p.get("NAVSTR")),
                river_mile=num(p.get("RIVERMI")),
                district=p.get("DISTRICT"),
                division=p.get("DIVISION"),
                state=p.get("STATE"),
                town=p.get("TOWN"),
                chambers=int(p["NOCHMB"]) if p.get("NOCHMB") is not None else None,
                lift_ft=num(p.get("LIFT")),
                chamber_dimensions=f"{dims[0]:.0f} x {dims[1]:.0f} ft" if dims else None,
                year_opened=int(p["YEAROPEN"]) if p.get("YEAROPEN") else None,
                owner=f"code {p['OWNER1']}" if p.get("OWNER1") else None,
                operator=f"code {p['OPER1']}" if p.get("OPER1") else None,
                latitude=coords[1] if coords else None,
                longitude=coords[0] if coords else None,
            )
        )
    return rows
