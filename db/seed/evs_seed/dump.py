"""Write apps/api/fixtures/*.json from the seeded database so fixtures mode matches database mode.

The JSON shapes are the API response models in apps/api/evs/schemas. accessibility.json is not
database-backed (axe results from the web test run) and is left untouched.
"""

from __future__ import annotations

import json
from datetime import date, datetime
from decimal import Decimal
from pathlib import Path

import psycopg
from psycopg.rows import dict_row

from evs_seed import FISCAL_YEAR, NOW
from evs_seed.public import srp_rows
from evs_seed.synth import APPROPRIATIONS

SYNTH_AS_OF = {
    "source_as_of": NOW.isoformat(),
    "fetched_at": NOW.isoformat(),
    "freshness": "fresh",
    "source": "synthetic",
}


def _plain(v):
    if isinstance(v, Decimal):
        return int(v) if v == v.to_integral_value() else float(v)
    if isinstance(v, datetime | date):
        return v.isoformat()
    return v


def _rows(conn: psycopg.Connection, sql: str, *params) -> list[dict]:
    with conn.cursor(row_factory=dict_row) as cur:
        return [{k: _plain(v) for k, v in r.items()} for r in cur.execute(sql, params)]


def programs(conn) -> list[dict]:
    return _rows(
        conn,
        """
        SELECT program_code, name, business_line, division, funded_amount, obligated_amount, expended_amount,
               variance_pct, project_count, schedule_health
        FROM synth.v_program_summary ORDER BY program_code""",
    )


def projects(conn) -> list[dict]:
    rows = _rows(
        conn,
        """
        SELECT p.p2_project_no, p.name, p.program_code, p.district, p.division, p.business_line, p.phase, p.pdt_lead,
               p.baseline_finish, p.current_finish, p.pct_complete, p.funded_amount,
               coalesce(x.obligated_amount, 0) AS obligated_amount, coalesce(x.expended_amount, 0) AS expended_amount,
               p.schedule_health
        FROM synth.p2_project p LEFT JOIN synth.v_project_execution x USING (p2_project_no)
        ORDER BY p.program_code, p.funded_amount DESC""",
    )
    ms = _rows(
        conn,
        """
        SELECT p2_project_no, code, name, baseline_date, forecast_date AS current_date, actual_date, status
        FROM synth.p2_milestone ORDER BY p2_project_no, seq""",
    )
    by_project: dict[str, list[dict]] = {}
    for m in ms:
        by_project.setdefault(m.pop("p2_project_no"), []).append(m)
    for r in rows:
        r["milestones"] = by_project.get(r["p2_project_no"], [])
    return rows


def financial_summary(conn) -> dict:
    curve = _rows(
        conn,
        "SELECT period, plan_cumulative, obligated_cumulative, expended_cumulative FROM synth.v_execution_curve "
        "WHERE fiscal_year = %s ORDER BY period",
        FISCAL_YEAR,
    )
    approps = _rows(
        conn,
        "SELECT appropriation, allotted, committed, obligated, expended FROM synth.v_appropriation_summary "
        "WHERE fiscal_year = %s ORDER BY appropriation",
        FISCAL_YEAR,
    )
    for a in approps:
        a["title"] = APPROPRIATIONS[a["appropriation"]]
        a["expiring_fy"] = FISCAL_YEAR if a["appropriation"] == "96X3121" else None
    return {
        "fiscal_year": FISCAL_YEAR,
        "execution_curve": curve,
        "by_appropriation": approps,
        "as_of": SYNTH_AS_OF,
    }


def labor_summary(conn) -> dict:
    rows = _rows(
        conn,
        "SELECT district, pay_period, hours_plan, hours_regular, hours_overtime, labor_cost FROM synth.v_labor_summary "
        "ORDER BY district, pay_period",
    )
    return {"fiscal_year": FISCAL_YEAR, "rows": rows, "as_of": SYNTH_AS_OF}


def facilities(conn) -> dict:
    rows = _rows(
        conn,
        "SELECT building_id, installation, district, uniformat_section, component_type, ci, bci, deficiency_cost, "
        "work_plan_year FROM synth.builder_component ORDER BY installation, building_id, component_id",
    )
    return {"rows": rows, "as_of": SYNTH_AS_OF}


def locks(conn) -> dict:
    """Locks with a baseline evaluation (the LPMS-reporting set), shaped like LockList."""
    rows = _rows(
        conn,
        """
        SELECT lock_id, river_code, river_name, lock_name, lock_no, river_mile, district, chambers, latitude, longitude,
               status, status_reason, vessels_queued, avg_delay_4h_min, avg_delay_24h_min, NULL::timestamptz AS last_lockage_at,
               gauge_stage_ft, NULL::text AS flood_category, active_stoppages, source_as_of, eval_source, freshness,
               lift_ft, chamber_dimensions, year_opened, owner, operator, inputs_used
        FROM evs.lock_current WHERE evaluated_at IS NOT NULL ORDER BY river_code, river_mile NULLS LAST, lock_no""",
    )
    items = []
    counts = {"operating": 0, "delayed": 0, "closed": 0, "stale": 0, "unknown": 0}
    for r in rows:
        counts[r["status"]] += 1
        as_of = {
            "source_as_of": r.pop("source_as_of"),
            "fetched_at": NOW.isoformat(),
            "freshness": r.pop("freshness"),
            "source": r.pop("eval_source"),
        }
        r["status_inputs"] = r.pop("inputs_used") or {}
        items.append({**r, "as_of": as_of})
    rivers = sorted({(i["river_code"], i["river_name"]) for i in items})
    return {
        "items": items,
        "rivers": [{"code": c, "name": n} for c, n in rivers],
        "counts": counts,
        "as_of": {
            "source_as_of": max(i["as_of"]["source_as_of"] for i in items),
            "fetched_at": NOW.isoformat(),
            "freshness": "fresh",
            "source": "fixtures",
        },
    }


def srp(conn) -> dict:
    snapshots = _rows(
        conn,
        "SELECT year, river_systems, dams, river_miles, floodplain_acres, source, source_url FROM evs.srp_snapshot ORDER BY year",
    )
    sites = _rows(
        conn,
        "SELECT name, river, state, district, nid_id, ST_Y(geom) AS latitude, ST_X(geom) AS longitude, year_joined, "
        "source_url FROM evs.srp_site ORDER BY year_joined, name",
    )
    _, _, headline = srp_rows()
    return {
        "snapshots": snapshots,
        "sites": sites,
        "headline": headline,
        "as_of": {
            "source_as_of": "2026-10-06T00:00:00+00:00",
            "fetched_at": NOW.isoformat(),
            "freshness": "fresh",
            "source": "cited-public",
        },
    }


def feeds(conn) -> list[dict]:
    return _rows(
        conn,
        "SELECT source, endpoint, cadence_minutes, last_success_at, last_error, latency_ms, status FROM evs.feed_health "
        "ORDER BY cadence_minutes, source",
    )


def dump(database_url: str, out_dir: Path, log=print) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    written = []
    with psycopg.connect(database_url) as conn:
        for name, fn in (
            ("programs", programs),
            ("projects", projects),
            ("financial_summary", financial_summary),
            ("labor_summary", labor_summary),
            ("facilities", facilities),
            ("locks", locks),
            ("srp", srp),
            ("feeds", feeds),
        ):
            path = out_dir / f"{name}.json"
            path.write_text(json.dumps(fn(conn), indent=1, default=_plain) + "\n")
            written.append(path)
            log(f"wrote {path}")
    return written
