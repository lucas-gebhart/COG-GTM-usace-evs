"""Orchestrates the seed: public samples into evs.*, generated rows into synth.*.

Idempotent: a second run without reset=True is a no-op when synth.program already has rows, so the
Compose api command can run `evs migrate && evs seed` on every start.
"""

from __future__ import annotations

import json
from collections.abc import Iterable
from dataclasses import asdict

import psycopg
from psycopg.types.json import Jsonb

from evs_seed import NOW
from evs_seed.public import feed_health_rows, lock_dims, lpms_baseline, srp_rows
from evs_seed.synth import generate

EVS_TABLES = [
    "evs.status_eval",
    "evs.lock_status_fact",
    "evs.stoppage",
    "evs.feed_health",
    "evs.srp_site",
    "evs.srp_snapshot",
    "evs.lock_dim",
]
SYNTH_TABLES = [
    "synth.ems_labor_log",
    "synth.ems_labor_plan",
    "synth.cmp_contract",
    "synth.cefms_funding",
    "synth.cefms_work_item",
    "synth.p2_milestone",
    "synth.builder_component",
    "synth.p2_project",
    "synth.program",
]
COUNT_TABLES = [
    "evs.lock_dim",
    "evs.lock_status_fact",
    "evs.status_eval",
    "evs.stoppage",
    "evs.feed_health",
    "evs.srp_snapshot",
    "evs.srp_site",
    "evs.threshold",
    *reversed(SYNTH_TABLES),
    "legacy.sp_projects",
    "legacy.sp_tasks",
    "legacy.sp_initiatives",
    "legacy.sp_team_members",
]


def _insert(
    cur: psycopg.Cursor,
    table: str,
    rows: Iterable[dict],
    columns: list[str],
    json_cols: set[str] = frozenset(),
) -> int:
    rows = list(rows)
    if not rows:
        return 0
    sql = f"INSERT INTO {table} ({', '.join(columns)}) VALUES ({', '.join('%s' for _ in columns)})"
    cur.executemany(sql, [[Jsonb(r[c]) if c in json_cols and r[c] is not None else r[c] for c in columns] for r in rows])
    return len(rows)


def already_seeded(conn: psycopg.Connection) -> bool:
    return conn.execute("SELECT count(*) FROM synth.program").fetchone()[0] > 0


def reset(conn: psycopg.Connection) -> None:
    conn.execute("TRUNCATE " + ", ".join(EVS_TABLES + SYNTH_TABLES) + " RESTART IDENTITY CASCADE")


def seed(database_url: str, reset_first: bool = False, log=print) -> dict[str, int]:
    """Run the loaders and generators; returns row counts for every seeded table."""
    with psycopg.connect(database_url) as conn:
        if reset_first:
            reset(conn)
            log("reset: truncated evs.* and synth.* tables")
        elif already_seeded(conn):
            log("seed: database already seeded (use --reset to rebuild)")
            return counts(conn)
        with conn.cursor() as cur:
            cur.execute("SELECT evs.ensure_lock_status_partition(%s)", (NOW,))
            thresholds = {k: float(v) for k, v in cur.execute("SELECT key, value FROM evs.threshold")}
            n = _load_public(cur, thresholds)
            log(f"public: {n['evs.lock_dim']} locks, {n['evs.status_eval']} baseline evaluations, {n['evs.srp_site']} SRP sites")
            m = _load_synth(cur)
            log(
                f"synthetic: {m['synth.program']} programs, {m['synth.p2_project']} projects, {m['synth.cefms_funding']} funding rows, "  # noqa: E501
                f"{m['synth.ems_labor_log']} labor rows, {m['synth.builder_component']} components"
            )
        conn.commit()
        return counts(conn)


def counts(conn: psycopg.Connection) -> dict[str, int]:
    return {t: conn.execute(f"SELECT count(*) FROM {t}").fetchone()[0] for t in COUNT_TABLES}


def _load_public(cur: psycopg.Cursor, thresholds: dict[str, float]) -> dict[str, int]:
    dims = lock_dims()
    facts, evals, stops, extra = lpms_baseline({d["lock_id"] for d in dims}, thresholds)
    dim_cols = [
        "lock_id",
        "river_code",
        "lock_no",
        "lock_name",
        "river_name",
        "ndc_code",
        "eroc",
        "river_mile",
        "chambers",
        "lift_ft",
        "chamber_length_ft",
        "chamber_width_ft",
        "chamber_dimensions",
        "year_opened",
        "district",
        "division",
        "state",
        "town",
        "owner",
        "operator",
        "gauge_lid",
        "usgs_site",
        "source",
        "source_as_of",
    ]
    sql = (
        f"INSERT INTO evs.lock_dim ({', '.join(dim_cols)}, geom) VALUES ({', '.join('%s' for _ in dim_cols)}, "
        "CASE WHEN %s IS NULL THEN NULL ELSE ST_SetSRID(ST_MakePoint(%s, %s), 4326) END)"
    )
    cur.executemany(sql, [[r[c] for c in dim_cols] + [r["lon"], r["lon"], r["lat"]] for r in dims + extra])
    n = {"evs.lock_dim": len(dims) + len(extra)}
    n["evs.lock_status_fact"] = _insert(
        cur,
        "evs.lock_status_fact",
        facts,
        [
            "lock_id",
            "polled_at",
            "source_as_of",
            "entry_datetime",
            "hours_of_operation",
            "weather_code",
            "upper_gauge_ft",
            "lower_gauge_ft",
            "air_temp_f",
            "water_temp_f",
            "vessels_queued",
            "total_locking",
            "locked_up_24h",
            "locked_down_24h",
            "avg_delay_4h_min",
            "avg_delay_24h_min",
            "active_stoppages",
            "notes",
            "raw",
            "source",
        ],
        {"raw"},
    )
    n["evs.status_eval"] = _insert(
        cur,
        "evs.status_eval",
        evals,
        [
            "lock_id",
            "evaluated_at",
            "status",
            "status_reason",
            "inputs_used",
            "source",
            "source_as_of",
            "freshness",
        ],
        {"inputs_used"},
    )
    n["evs.stoppage"] = _insert(
        cur,
        "evs.stoppage",
        stops,
        [
            "lock_id",
            "chamber_no",
            "begin_at",
            "end_at",
            "is_scheduled",
            "traffic_stopped",
            "reason_code",
            "hw_cycles",
            "refresh_at",
            "source",
            "raw",
        ],
        {"raw"},
    )
    n["evs.feed_health"] = _insert(
        cur,
        "evs.feed_health",
        feed_health_rows(),
        ["source", "endpoint", "cadence_minutes", "last_success_at", "last_error", "latency_ms", "status"],
    )
    snapshots, sites, _headline = srp_rows()
    n["evs.srp_snapshot"] = _insert(
        cur,
        "evs.srp_snapshot",
        [{"floodplain_acres": None, **s} for s in snapshots],
        ["year", "river_systems", "dams", "river_miles", "floodplain_acres", "source", "source_url"],
    )
    cur.executemany(
        "INSERT INTO evs.srp_site (name, river, state, district, nid_id, year_joined, geom, source_url) "
        "VALUES (%s, %s, %s, %s, %s, %s, ST_SetSRID(ST_MakePoint(%s, %s), 4326), %s)",
        [
            [
                s["name"],
                s["river"],
                s["state"],
                s["district"],
                s["nid_id"],
                s["year_joined"],
                s["longitude"],
                s["latitude"],
                s["source_url"],
            ]
            for s in sites
        ],
    )
    n["evs.srp_site"] = len(sites)
    return n


def _load_synth(cur: psycopg.Cursor) -> dict[str, int]:
    data = generate()
    n = {}
    n["synth.program"] = _insert(
        cur,
        "synth.program",
        [{"fiscal_year": 2026, **asdict(p)} for p in data.programs],
        [
            "program_code",
            "name",
            "business_line",
            "business_line_code",
            "division",
            "appropriation",
            "fiscal_year",
            "funded_amount",
            "schedule_health",
            "story",
        ],
    )
    proj_cols = [
        "p2_project_no",
        "name",
        "program_code",
        "district",
        "division",
        "state",
        "business_line",
        "phase",
        "pdt_lead",
        "pmp_approved_date",
        "baseline_start",
        "baseline_finish",
        "current_finish",
        "pct_complete",
        "funded_amount",
        "jsheet_amount",
        "jsheet_source",
        "schedule_health",
        "story",
    ]
    n["synth.p2_project"] = _insert(cur, "synth.p2_project", [asdict(p) for p in data.projects], proj_cols)
    n["synth.p2_milestone"] = _insert(
        cur,
        "synth.p2_milestone",
        [{"p2_project_no": p.p2_project_no, **m} for p in data.projects for m in p.milestones],
        ["p2_project_no", "seq", "code", "name", "baseline_date", "forecast_date", "actual_date", "status"],
    )
    n["synth.cefms_work_item"] = _insert(
        cur,
        "synth.cefms_work_item",
        [w for p in data.projects for w in p.work_items],
        [
            "work_item_code",
            "p2_project_no",
            "district",
            "appropriation",
            "description",
            "cost_share_pct",
            "customer_order_no",
        ],
    )
    n["synth.cefms_funding"] = _insert(
        cur,
        "synth.cefms_funding",
        data.funding,
        [
            "work_item_code",
            "appropriation",
            "fiscal_year",
            "fiscal_month",
            "period",
            "plan_obligation",
            "allotment",
            "commitment",
            "obligation",
            "expenditure",
            "disbursement",
        ],
    )
    n["synth.ems_labor_plan"] = _insert(cur, "synth.ems_labor_plan", data.labor_plan, ["district", "pay_period", "hours_plan"])
    n["synth.ems_labor_log"] = _insert(
        cur,
        "synth.ems_labor_log",
        data.labor,
        [
            "employee_id",
            "district",
            "pay_period",
            "pay_period_end",
            "work_item_code",
            "hours_regular",
            "hours_overtime",
            "labor_cost",
            "charge_type",
            "labor_correction_flag",
        ],
    )
    n["synth.cmp_contract"] = _insert(
        cur,
        "synth.cmp_contract",
        data.contracts,
        [
            "contract_no",
            "p2_project_no",
            "contractor",
            "award_date",
            "ntp_date",
            "contract_amount",
            "pct_complete",
            "modifications",
            "contract_status",
            "bcoes_review_date",
        ],
    )
    n["synth.builder_component"] = _insert(
        cur,
        "synth.builder_component",
        data.components,
        [
            "component_id",
            "building_id",
            "installation",
            "district",
            "uniformat_section",
            "component_type",
            "install_year",
            "service_life",
            "last_inspection_date",
            "ci",
            "bci",
            "deficiency_cost",
            "work_plan_year",
            "story",
        ],
    )
    return n


if __name__ == "__main__":
    import sys

    for table, count in seed(sys.argv[1], reset_first="--reset" in sys.argv).items():
        print(f"{table:28s} {count:>8}")
    print(json.dumps({"seeded_at": NOW.isoformat()}))
