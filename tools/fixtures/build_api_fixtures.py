"""Build apps/api/fixtures/*.json.

Lock rows come from real LPMS + NDC GIS samples captured 2026-10-06 (data_samples/),
everything else is seeded synthetic data shaped by CEFMS / P2 / EMS / BUILDER vocabulary.
Run: python tools/fixtures/build_api_fixtures.py [path/to/data_samples]
"""

import glob
import json
import random
import sys
from datetime import UTC, date, datetime, timedelta
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "apps" / "api" / "fixtures"
SAMPLES = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "legacy" / "data_samples"
rng = random.Random(20261006)
NOW = datetime(2026, 10, 6, 14, 30, tzinfo=UTC)
AS_OF = {"source_as_of": NOW.isoformat(), "fetched_at": NOW.isoformat(), "freshness": "fresh", "source": "synthetic"}

DISTRICTS = ["LRL", "LRN", "LRP", "LRH", "MVS", "MVR", "MVP", "SWT", "SWL", "NWP", "NWW", "SAJ", "SAM", "NAB"]
DIVISIONS = {"LR": "LRD", "MV": "MVD", "SW": "SWD", "NW": "NWD", "SA": "SAD", "NA": "NAD"}
BUSINESS_LINES = ["Navigation", "Flood Risk Management", "Hydropower", "Environment", "Recreation", "Water Supply"]
PHASES = ["Feasibility", "PED", "Construction", "O&M"]
PDT = ["J. Alvarez", "M. Chen", "R. Okafor", "S. Patel", "T. Nguyen", "K. Brooks", "D. Romero", "L. Haddad"]
APPROPS = [
    ("96X3121", "Investigations"), ("96X3122", "Construction"), ("96X3123", "Operation and Maintenance"),
    ("96X3112", "Mississippi River and Tributaries"), ("96X4902", "Revolving Fund"),
]


def programs_and_projects():
    programs, projects = [], []
    for i, bl in enumerate(BUSINESS_LINES):
        for div in ["LRD", "MVD", "SWD"]:
            code = f"{div}-{bl[:3].upper()}"
            funded = rng.uniform(40, 400) * 1e6
            obligated = funded * rng.uniform(0.45, 0.95)
            expended = obligated * rng.uniform(0.6, 0.98)
            n = rng.randint(3, 9)
            programs.append({
                "program_code": code, "name": f"{div} {bl}", "business_line": bl, "division": div,
                "funded_amount": round(funded), "obligated_amount": round(obligated),
                "expended_amount": round(expended), "variance_pct": round((obligated / funded - 0.78) * 100, 1),
                "project_count": n, "schedule_health": rng.choice(["on_track", "on_track", "at_risk", "late"]),
            })
            for j in range(n):
                dist = rng.choice([d for d in DISTRICTS if d[:2] == div[:2]])
                base = date(2027, 1, 1) + timedelta(days=rng.randint(0, 900))
                slip = rng.choice([0, 0, 0, 30, 90, 180, 365])
                pf = funded / n
                po = pf * rng.uniform(0.3, 0.98)
                milestones = []
                for k, (mc, mn) in enumerate([("FCSA", "Feasibility Cost Share Agreement"), ("CHIEF", "Chief's Report"),
                                                ("PPA", "Project Partnership Agreement"), ("AWARD", "Construction Award"),
                                                ("BCOES", "BCOES Certification")]):
                    b = base - timedelta(days=(5 - k) * 240)
                    done = b < date(2026, 10, 6)
                    milestones.append({"code": mc, "name": mn, "baseline_date": b.isoformat(),
                                       "current_date": (b + timedelta(days=slip if not done else 0)).isoformat(),
                                       "actual_date": b.isoformat() if done else None,
                                       "status": "complete" if done else ("slipped" if slip else "scheduled")})
                projects.append({
                    "p2_project_no": f"{rng.randint(100000, 499999)}", "name": f"{dist} {bl} Project {j + 1}",
                    "program_code": code, "district": dist, "division": div, "business_line": bl,
                    "phase": rng.choice(PHASES), "pdt_lead": rng.choice(PDT),
                    "baseline_finish": base.isoformat(), "current_finish": (base + timedelta(days=slip)).isoformat(),
                    "pct_complete": round(rng.uniform(5, 98), 1), "funded_amount": round(pf),
                    "obligated_amount": round(po), "expended_amount": round(po * rng.uniform(0.5, 0.98)),
                    "schedule_health": "on_track" if slip == 0 else ("at_risk" if slip <= 90 else "late"),
                    "milestones": milestones,
                })
    return programs, projects


def financial():
    curve, plan, obl, exp = [], 0.0, 0.0, 0.0
    total = 2.4e9
    for m in range(12):
        period = date(2025, 10, 1) + timedelta(days=31 * m)
        plan = total * (m + 1) / 12
        obl += total / 12 * rng.uniform(0.7, 1.15) if m < 10 else 0
        exp += total / 12 * rng.uniform(0.55, 1.0) if m < 10 else 0
        curve.append({"period": period.replace(day=1).isoformat(), "plan_cumulative": round(plan),
                      "obligated_cumulative": round(obl), "expended_cumulative": round(exp)})
    rows = []
    for code, title in APPROPS:
        allot = rng.uniform(150, 900) * 1e6
        com = allot * rng.uniform(0.8, 0.98)
        ob = com * rng.uniform(0.8, 0.98)
        rows.append({"appropriation": code, "title": title, "allotted": round(allot), "committed": round(com),
                     "obligated": round(ob), "expended": round(ob * rng.uniform(0.6, 0.95)),
                     "expiring_fy": 2026 if code == "96X3121" else None})
    return {"fiscal_year": 2026, "execution_curve": curve, "by_appropriation": rows, "as_of": AS_OF}


def labor():
    rows = []
    for d in DISTRICTS[:8]:
        for pp in range(1, 21):
            plan = rng.uniform(5000, 12000)
            reg = plan * rng.uniform(0.85, 1.05)
            ot = reg * rng.uniform(0.02, 0.12)
            rows.append({"district": d, "pay_period": f"2026-{pp:02d}", "hours_plan": round(plan), "hours_regular": round(reg),
                         "hours_overtime": round(ot), "labor_cost": round((reg + ot * 1.5) * 68.4)})
    return {"fiscal_year": 2026, "rows": rows, "as_of": AS_OF}


def facilities():
    rows = []
    sections = [("D30", "HVAC"), ("D50", "Electrical"), ("B30", "Roofing"), ("D20", "Plumbing"), ("C30", "Interior Finishes"), ("B20", "Exterior Enclosure")]
    for i in range(160):
        d = rng.choice(DISTRICTS)
        sec, comp = rng.choice(sections)
        ci = max(10, min(100, rng.gauss(72, 16)))
        rows.append({"building_id": f"{d}-{1000 + i}", "installation": f"{d} Lock & Dam Complex {i % 7 + 1}", "district": d,
                     "uniformat_section": sec, "component_type": comp, "ci": round(ci, 1), "bci": round(min(100, ci + rng.uniform(-8, 8)), 1),
                     "deficiency_cost": round((100 - ci) * rng.uniform(4000, 22000)), "work_plan_year": rng.choice([2026, 2027, 2028, 2029])})
    return {"rows": rows, "as_of": AS_OF}


RIVER_NAMES = {"OH": "Ohio River", "MI": "Mississippi River", "IL": "Illinois Waterway", "TN": "Tennessee River", "CU": "Cumberland River",
               "AR": "Arkansas River (MKARNS)", "AG": "Allegheny River", "MO": "Monongahela River", "GI": "Gulf Intracoastal Waterway",
               "KA": "Kanawha River", "GR": "Green River", "BS": "Black Warrior-Tombigbee", "TT": "Tennessee-Tombigbee", "RR": "Red River",
               "CH": "Columbia River", "SN": "Snake River", "KY": "Kentucky River", "OU": "Ouachita River", "AT": "Atchafalaya", "WH": "White River"}


def locks():
    status_rows = json.load(open(SAMPLES / "lpms" / "lock_status_report_ALL.json"))
    delays = {(d["riverCode"], d["lockNumber"]): d for d in json.load(open(SAMPLES / "lpms" / "lock_delay_fixed.json"))}
    stoppages = json.load(open(SAMPLES / "lpms" / "stall_stoppage.json"))
    gis = {}
    for path in glob.glob(str(SAMPLES / "gis" / "*.geojson")):
        for f in json.load(open(path))["features"]:
            p = f["properties"]
            key = (p.get("RIVERCD") or p.get("RIVER_CODE"), str(p.get("LOCKCD") or p.get("LOCK_NO") or "").lstrip("0"))
            gis.setdefault(key, {"props": p, "coords": f["geometry"]["coordinates"] if f.get("geometry") else None})

    def num(v):
        try:
            return float(str(v).strip())
        except (TypeError, ValueError):
            return None

    items, counts = [], {"operating": 0, "delayed": 0, "closed": 0, "stale": 0, "unknown": 0}
    for r in status_rows:
        key = (r["riverCode"], str(r["lockNo"]).lstrip("0"))
        d = delays.get((r["riverCode"], str(r["lockNo"]).lstrip("0"))) or delays.get((r["riverCode"], r["lockNo"]))
        d4 = num(d["fourHourAverageDelayInMinutes"]) if d else num(r.get("average4HourDelay"))
        d24 = num(d["twentyFourHourAverageDelayInMinutes"]) if d else None
        active = [s for s in stoppages if s["riverCode"] == r["riverCode"] and str(s["lockNumber"]).lstrip("0") == key[1]
                  and s.get("trafficStopped") == "Y"]
        entry = datetime.fromisoformat(r["entryDatetime"]).replace(tzinfo=UTC)
        # Feed refresh (stoppage payload refreshDate, 15-min cadence) is the newest input; the
        # operator-entered entryDatetime lags by hours and is kept as a secondary signal.
        refresh = datetime.strptime(stoppages[0]["refreshDate"], "%m/%d/%Y %H:%M:%S GMT").replace(tzinfo=UTC)
        newest = max(entry, refresh)
        age_min = (NOW - newest).total_seconds() / 60
        queue = r.get("totalPendingArrivals") or 0
        g = gis.get(key, {})
        chambers = (g.get("props") or {}).get("NOCHMB")
        if active and (any(s["isScheduled"] == "No" for s in active) or chambers == 1):
            status, reason = "closed", f"Traffic stopped: {active[0]['reasonCode']}"
        elif d4 is not None and d4 >= 240:
            status, reason = "closed", f"4-hour average delay {d4:.0f} min"
        elif active or (d4 is not None and d4 >= 60) or queue >= 6:
            status, reason = "delayed", (f"Scheduled stoppage: {active[0]['reasonCode']}" if active else
                                         f"4-hour delay {d4 or 0:.0f} min, {queue} vessels queued")
        elif age_min > 120:
            status, reason = "stale", f"Last operator entry {age_min / 60:.1f} h ago"
        else:
            status, reason = "operating", "No active stoppage, queue below threshold"
        counts[status] += 1
        # LPMS swaps latitude/longitude; GIS geometry is authoritative when present.
        lon, lat = (g["coords"] if g.get("coords") else (r["latitude"], r["longitude"]))
        items.append({
            "lock_id": f"{r['riverCode']}-{r['lockNo']}", "river_code": r["riverCode"],
            "river_name": RIVER_NAMES.get(r["riverCode"], r["riverCode"]), "lock_name": r["lockName"].title(),
            "lock_no": str(r["lockNo"]), "river_mile": num((g.get("props") or {}).get("RIVERMI")),
            "district": (g.get("props") or {}).get("DISTRICT"), "chambers": chambers,
            "latitude": lat, "longitude": lon, "status": status, "status_reason": reason,
            "vessels_queued": queue, "avg_delay_4h_min": d4, "avg_delay_24h_min": d24,
            "last_lockage_at": None, "gauge_stage_ft": num(r.get("upperGauge")), "flood_category": None,
            "active_stoppages": len(active),
            "as_of": {"source_as_of": newest.isoformat(), "fetched_at": NOW.isoformat(),
                      "freshness": "stale" if age_min > 120 else ("aging" if age_min > 15 else "fresh"), "source": "fixtures"},
        })
    rivers = sorted({(i["river_code"], i["river_name"]) for i in items})
    return {"items": items, "rivers": [{"code": c, "name": n} for c, n in rivers], "counts": counts,
            "as_of": {"source_as_of": max(i["as_of"]["source_as_of"] for i in items), "fetched_at": NOW.isoformat(),
                      "freshness": "fresh", "source": "fixtures"}}


def srp():
    hec = "https://www.hec.usace.army.mil/sustainablerivers/history/"
    tnc = "https://www.nature.org/en-us/about-us/where-we-work/united-states/sustainable-rivers-project/"
    iwr = "https://www.iwr.usace.army.mil/Missions/Environment/Sustainable-Rivers-Program/"
    snapshots = [
        {"year": 2002, "river_systems": 8, "dams": None, "river_miles": None, "source": "HEC SRP history", "source_url": hec},
        {"year": 2019, "river_systems": 16, "dams": 66, "river_miles": 5111, "source": "TNC SRP 2019", "source_url": tnc},
        {"year": 2020, "river_systems": 30, "dams": None, "river_miles": None, "source": "HEC SRP history", "source_url": hec},
        {"year": 2024, "river_systems": 50, "dams": None, "river_miles": None, "source": "HEC SRP history (50+ teams, 27 districts)", "source_url": hec},
        {"year": 2026, "river_systems": 65, "dams": 100, "river_miles": 14500, "floodplain_acres": 150000, "source": "HEC/IWR (60+ systems, 14,000 mi) and TNC (65 rivers, ~15,000 mi, 100+ dams)", "source_url": iwr},
    ]
    sites = [
        ("Green River", "Green River", "KY", "LRL", 37.2, -86.1, 2002), ("Savannah River", "Savannah River", "GA", "SAS", 33.6, -82.2, 2002),
        ("Bill Williams River", "Bill Williams River", "AZ", "SPL", 34.3, -114.1, 2002), ("Willamette River", "Willamette River", "OR", "NWP", 44.4, -122.6, 2002),
        ("Big Cypress Bayou", "Big Cypress Bayou", "TX", "SWF", 32.7, -94.5, 2002), ("Roanoke River", "Roanoke River", "NC", "SAW", 36.5, -77.8, 2002),
        ("Connecticut River", "Connecticut River", "VT", "NAE", 43.3, -72.4, 2010), ("Kansas River", "Kansas River", "KS", "NWK", 39.1, -96.1, 2016),
        ("Osage River", "Osage River", "MO", "NWK", 38.2, -92.6, 2016), ("Cumberland River", "Cumberland River", "TN", "LRN", 36.3, -85.0, 2018),
        ("Ouachita River", "Ouachita River", "AR", "MVK", 34.5, -93.2, 2018), ("Russian River", "Russian River", "CA", "SPN", 38.6, -123.0, 2018),
        ("Chattahoochee River", "Chattahoochee River", "GA", "SAM", 34.2, -84.0, 2018), ("Apalachicola River", "Apalachicola River", "FL", "SAM", 30.7, -84.9, 2018),
        ("Middle Fork Willamette", "Willamette River", "OR", "NWP", 43.9, -122.8, 2010), ("Sacramento River", "Sacramento River", "CA", "SPK", 40.7, -122.4, 2018),
        ("Rio Grande", "Rio Grande", "NM", "SPA", 36.7, -106.2, 2018), ("Trinity River", "Trinity River", "TX", "SWF", 32.9, -96.8, 2020),
        ("Pearl River", "Pearl River", "MS", "MVK", 32.3, -90.2, 2020), ("Missouri River", "Missouri River", "MT", "NWO", 48.0, -106.4, 2020),
        ("Alabama River", "Alabama River", "AL", "SAM", 32.3, -86.8, 2020), ("Youghiogheny River", "Youghiogheny River", "PA", "LRP", 39.8, -79.4, 2022),
        ("Allegheny River", "Allegheny River", "PA", "LRP", 41.8, -79.0, 2022), ("Des Moines River", "Des Moines River", "IA", "MVR", 41.6, -93.6, 2022),
    ]
    return {"snapshots": snapshots,
            "sites": [{"name": n, "river": r, "state": s, "district": d, "nid_id": None, "latitude": la, "longitude": lo,
                       "year_joined": y, "source_url": "https://www.hec.usace.army.mil/sustainablerivers/sites/"} for n, r, s, d, la, lo, y in sites],
            "headline": {"river_systems": 65, "river_miles": 14500, "dams_and_reservoirs": 100, "floodplain_acres": 150000,
                         "npv_usd_m_low": 243, "npv_usd_m_high": 265, "bcr_low": 12.6, "bcr_high": 13.7},
            "as_of": {"source_as_of": "2026-10-06T00:00:00+00:00", "fetched_at": NOW.isoformat(), "freshness": "fresh", "source": "cited-public"}}


def accessibility():
    routes = ["/", "/programs", "/projects/123456", "/financial", "/workforce", "/schedule", "/facilities", "/public/srp", "/public/locks", "/accessibility", "/admin"]
    results = [{"route": r, "viewport": v, "theme": t, "violations": 0, "passes": 0, "incomplete": 0, "run_at": NOW.isoformat()}
               for r in routes for v in ["mobile-360", "desktop-1280"] for t in ["light", "leadership-dark"]]
    criteria = [{"criterion": "1.1.1", "name": "Non-text Content", "level": "A", "method": "automated", "status": "not-evaluated"},
                {"criterion": "1.4.3", "name": "Contrast (Minimum)", "level": "AA", "method": "automated", "status": "not-evaluated"},
                {"criterion": "1.4.10", "name": "Reflow", "level": "AA", "method": "manual", "status": "not-evaluated"},
                {"criterion": "2.1.1", "name": "Keyboard", "level": "A", "method": "manual", "status": "not-evaluated"},
                {"criterion": "4.1.3", "name": "Status Messages", "level": "AA", "method": "manual", "status": "not-evaluated"}]
    return {"target": "WCAG 2.1 AA (Revised Section 508)", "routes": results, "criteria": criteria,
            "acr_download_url": "/acr/evs-openacr.yaml", "generated_at": NOW.isoformat()}


def feeds():
    return [
        {"source": "LPMS lock_status_report", "endpoint": "https://ndc.ops.usace.army.mil/ords/lpms/json/lock_status_report?in_river_codes=ALL", "cadence_minutes": 15, "last_success_at": NOW.isoformat(), "last_error": None, "latency_ms": 840, "status": "fixtures"},
        {"source": "LPMS lock_delay_json", "endpoint": "https://ndc.ops.usace.army.mil/ords/lpms/lock_delay_json", "cadence_minutes": 15, "last_success_at": NOW.isoformat(), "last_error": "Invalid JSON repaired before parse", "latency_ms": 610, "status": "fixtures"},
        {"source": "LPMS stall_stoppage_json", "endpoint": "https://ndc.ops.usace.army.mil/ords/lpms/stall_stoppage_json", "cadence_minutes": 15, "last_success_at": NOW.isoformat(), "last_error": None, "latency_ms": 590, "status": "fixtures"},
        {"source": "NDC Locks FeatureServer", "endpoint": "https://services7.arcgis.com/n1YM8pTrFmm7L4hs/ArcGIS/rest/services/Locks/FeatureServer/0", "cadence_minutes": 1440, "last_success_at": NOW.isoformat(), "last_error": None, "latency_ms": 1200, "status": "fixtures"},
        {"source": "NOAA NWPS gauges", "endpoint": "https://api.water.noaa.gov/nwps/v1/gauges/{lid}", "cadence_minutes": 30, "last_success_at": None, "last_error": None, "latency_ms": None, "status": "fixtures"},
        {"source": "USGS NWIS IV", "endpoint": "https://waterservices.usgs.gov/nwis/iv/", "cadence_minutes": 30, "last_success_at": None, "last_error": None, "latency_ms": None, "status": "fixtures"},
    ]


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    programs, projects = programs_and_projects()
    data = {"programs": programs, "projects": projects, "financial_summary": financial(), "labor_summary": labor(),
            "facilities": facilities(), "locks": locks(), "srp": srp(), "accessibility": accessibility(), "feeds": feeds()}
    for name, payload in data.items():
        (OUT / f"{name}.json").write_text(json.dumps(payload, indent=1) + "\n")
        print(name, len(payload) if isinstance(payload, list) else "ok")


if __name__ == "__main__":
    main()
