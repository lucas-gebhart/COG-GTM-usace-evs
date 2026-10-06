"""Derive the lock -> NOAA NWPS LID / USGS site pairing table (apps/api/evs/ingest/gauges.py).

Method, in order, for every lock on the Ohio (OH), Mississippi (MI), Illinois (IL), Tennessee (TN) and
Cumberland (CU) rivers in legacy/data_samples/gis/usace_locks_full.geojson:
  1. Candidate gauges come from one NWPS list call over the inland waterway bounding box
     (GET https://api.water.noaa.gov/nwps/v1/gauges?bbox...&srid=EPSG_4326) and are restricted to gauges
     whose name contains the lock's river (Illinois also accepts Des Plaines and Chicago Sanitary and Ship Canal).
  2. Prefer a gauge whose name shares a word with the lock name (for example "Cannelton", "Smithland",
     "Markland") within 25 km of the GIS lock point; the NWS names most lock gauges after the lock.
  3. Otherwise take the nearest same-river gauge within 10 km (usually the town the lock sits in).
  4. Fetch the chosen gauge detail (GET gauges/{LID}) for the NWS-published USGS site id and flood categories;
     keep only numeric USGS ids. Detail calls are paced to stay under the NWPS limit of 10 per 5 minutes.
Locks with no gauge within 10 km are listed with lid=None so the status engine skips hydrology for them.
Run: python tools/gauges/derive_gauge_pairings.py > apps/api/evs/ingest/gauges.py
"""

import json
import math
import re
import sys
import time
from pathlib import Path

import httpx

ROOT = Path(__file__).resolve().parents[2]
GIS = ROOT / "legacy" / "data_samples" / "gis" / "usace_locks_full.geojson"
RIVERS = {
    "OH": ("ohio river",),
    "MI": ("mississippi river",),
    "IL": ("illinois river", "des plaines river", "chicago sanitary", "illinois waterway"),
    "TN": ("tennessee river",),
    "CU": ("cumberland river",),
}
NWPS = "https://api.water.noaa.gov/nwps/v1"
UA = "EVS-demo/0.1 (USACE EVS ingestion; +https://github.com/lucas-gebhart/COG-GTM-usace-evs)"
REGION = "bbox.xmin=-98&bbox.ymin=28.5&bbox.xmax=-77&bbox.ymax=47&srid=EPSG_4326"
MAX_KM = 25.0
NEAREST_KM = 10.0
PACE_S = 32
STOP = {"lock", "locks", "and", "dam", "the", "l", "d", "ld", "at", "river", "upper", "lower", "old", "new", "no"}


def haversine_km(lat1, lon1, lat2, lon2):
    r = 6371.0
    p1, p2 = math.radians(lat1), math.radians(lat2)
    dphi, dl = math.radians(lat2 - lat1), math.radians(lon2 - lon1)
    a = math.sin(dphi / 2) ** 2 + math.cos(p1) * math.cos(p2) * math.sin(dl / 2) ** 2
    return 2 * r * math.asin(math.sqrt(a))


def tokens(name: str) -> set[str]:
    return {w for w in re.findall(r"[a-z]+", name.lower()) if w not in STOP and len(w) > 2}


def get(client: httpx.Client, url: str) -> dict:
    for attempt in range(6):
        resp = client.get(url)
        if resp.status_code == 429:
            print(f"# 429 on {url}, waiting", file=sys.stderr)
            time.sleep(60)
            continue
        resp.raise_for_status()
        return resp.json()
    raise RuntimeError(f"gave up on {url}")


def main() -> None:
    feats = json.loads(GIS.read_text())["features"]
    locks: dict[str, dict] = {}
    for f in feats:
        p = f["properties"]
        if p.get("RIVERCD") in RIVERS and f.get("geometry"):
            lid = f"{p['RIVERCD']}-{str(p['LOCKCD']).zfill(2)}"
            locks.setdefault(lid, {"name": p.get("PMSNAME") or p.get("NAVSTR") or "", "river": p["RIVERCD"],
                                   "lon": f["geometry"]["coordinates"][0], "lat": f["geometry"]["coordinates"][1]})
    client = httpx.Client(timeout=90, headers={"User-Agent": UA})
    cache = Path("/tmp/nwps_region.json")
    if cache.exists() and time.time() - cache.stat().st_mtime < 86400:
        gauges = json.loads(cache.read_text())["gauges"]
    else:
        data = get(client, f"{NWPS}/gauges?{REGION}")
        cache.write_text(json.dumps(data))
        gauges = data["gauges"]
    print(f"# {len(gauges)} NWPS gauges in region", file=sys.stderr)

    chosen: dict[str, tuple[str | None, float | None, str]] = {}
    for lock_id in sorted(locks):
        lk = locks[lock_id]
        cands = []
        for g in gauges:
            name = (g.get("name") or "").lower()
            if not any(r in name for r in RIVERS[lk["river"]]):
                continue
            km = haversine_km(lk["lat"], lk["lon"], g["latitude"], g["longitude"])
            if km <= MAX_KM:
                cands.append((km, g))
        cands.sort(key=lambda c: c[0])
        pick, method = None, "no NWPS gauge on the same river within 10 km"
        lock_tokens = tokens(lk["name"])
        for km, g in cands:
            if lock_tokens & tokens(g["name"]):
                pick, method = (g, km), f"name match within {MAX_KM:.0f} km"
                break
        if pick is None and cands and cands[0][0] <= NEAREST_KM:
            pick, method = (cands[0][1], cands[0][0]), f"nearest same-river gauge within {NEAREST_KM:.0f} km"
        chosen[lock_id] = (pick[0]["lid"] if pick else None, pick[1] if pick else None, method)
        print(f"# {lock_id}: {chosen[lock_id]}", file=sys.stderr)

    details: dict[str, dict] = {}
    for lid in sorted({c[0] for c in chosen.values() if c[0]}):
        details[lid] = get(client, f"{NWPS}/gauges/{lid}")
        print(f"# detail {lid}: usgs={details[lid].get('usgsId')}", file=sys.stderr)
        time.sleep(PACE_S)

    out = ['"""Lock to gauge pairings. GENERATED by tools/gauges/derive_gauge_pairings.py; see that file for the',
           'derivation method. Edit the generator, not this file."""', "", "from dataclasses import dataclass", "", "",
           "@dataclass(frozen=True)", "class GaugePairing:", "    lock_id: str", "    lid: str | None",
           "    usgs_site: str | None", "    gauge_name: str | None", "    distance_km: float | None",
           "    method: str", "    moderate_stage_ft: float | None = None", "", "",
           "PAIRINGS: tuple[GaugePairing, ...] = ("]
    for lock_id in sorted(chosen):
        lid, km, method = chosen[lock_id]
        d = details.get(lid) if lid else None
        usgs = str(d.get("usgsId")) if d and str(d.get("usgsId") or "").isdigit() else None
        mod = ((d or {}).get("flood") or {}).get("categories", {}).get("moderate", {}).get("stage") if d else None
        mod = None if mod in (None, -999) else mod
        name = json.dumps((d or {}).get("name")) if d else "None"
        out.append(f"    GaugePairing({lock_id!r}, {lid!r}, {usgs!r}, {name}, "
                   f"{round(km, 1) if km is not None else None!r}, {method!r}, {mod!r}),")
    out += [")", "BY_LOCK: dict[str, GaugePairing] = {p.lock_id: p for p in PAIRINGS}",
            "NOAA_LIDS: tuple[str, ...] = tuple(sorted({p.lid for p in PAIRINGS if p.lid}))",
            "USGS_SITES: tuple[str, ...] = tuple(sorted({p.usgs_site for p in PAIRINGS if p.usgs_site}))", ""]
    print("\n".join(out))


if __name__ == "__main__":
    main()
