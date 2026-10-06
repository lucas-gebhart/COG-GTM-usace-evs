"""Load `apps/api/fixtures/*.json` into the synth / evs tables.

WP2 owns the real `evs seed` generators (`db/seed/**`). Until they land this loader fills the
assumed WP2 tables (tests/sql/assumed_wp2_schema.sql) from the same fixtures the fixtures mode
serves, so SQL mode and fixtures mode return the same rows and the database tests have data.
Idempotent: rows are upserted by primary key.
"""

from __future__ import annotations

import json
from pathlib import Path

import psycopg
from psycopg.types.json import Jsonb

from evs.fixtures import load

ASSUMED_SCHEMA = Path(__file__).resolve().parents[2] / "tests" / "sql" / "assumed_wp2_schema.sql"


def _upsert(conn: psycopg.Connection, table: str, rows: list[dict], keys: tuple[str, ...]) -> int:
    if not rows:
        return 0
    cols = list(rows[0].keys())
    quoted = [f'"{c}"' for c in cols]
    sets = ", ".join(f'"{c}" = EXCLUDED."{c}"' for c in cols if c not in keys)
    sql = (
        f"INSERT INTO {table} ({', '.join(quoted)}) VALUES ({', '.join('%s' for _ in cols)}) "
        f"ON CONFLICT ({', '.join(keys)}) DO " + (f"UPDATE SET {sets}" if sets else "NOTHING")
    )
    with conn.cursor() as cur:
        cur.executemany(sql, [tuple(_pg(r[c]) for c in cols) for r in rows])
    return len(rows)


def _pg(v):  # noqa: ANN001, ANN202
    return Jsonb(v) if isinstance(v, (dict, list)) else v


def run(database_url_sync: str, create_assumed_schema: bool = True) -> dict[str, int]:
    counts: dict[str, int] = {}
    with psycopg.connect(database_url_sync, autocommit=True) as conn:
        if create_assumed_schema:
            conn.execute(ASSUMED_SCHEMA.read_text())
        counts["synth.program"] = _upsert(conn, "synth.program", load("programs"), ("program_code",))
        projects = load("projects")
        counts["synth.p2_project"] = _upsert(
            conn,
            "synth.p2_project",
            [{k: v for k, v in p.items() if k != "milestones"} for p in projects],
            ("p2_project_no",),
        )
        milestones = [
            {"p2_project_no": p["p2_project_no"], **m} for p in projects for m in p.get("milestones", [])
        ]
        counts["synth.p2_milestone"] = _upsert(
            conn, "synth.p2_milestone", milestones, ("p2_project_no", "code")
        )
        fin = load("financial_summary")
        fy = fin["fiscal_year"]
        counts["synth.cefms_execution"] = _upsert(
            conn,
            "synth.cefms_execution",
            [{"fiscal_year": fy, **r} for r in fin["execution_curve"]],
            ("fiscal_year", "period"),
        )
        counts["synth.cefms_appropriation"] = _upsert(
            conn,
            "synth.cefms_appropriation",
            [{"fiscal_year": fy, **r} for r in fin["by_appropriation"]],
            ("fiscal_year", "appropriation"),
        )
        labor = load("labor_summary")
        counts["synth.ems_labor_log"] = _upsert(
            conn,
            "synth.ems_labor_log",
            [{"fiscal_year": labor["fiscal_year"], **r} for r in labor["rows"]],
            ("fiscal_year", "district", "pay_period"),
        )
        counts["synth.builder_facility_condition"] = _upsert(
            conn,
            "synth.builder_facility_condition",
            load("facilities")["rows"],
            ("building_id", "uniformat_section", "component_type"),
        )
        locks = load("locks")["items"]
        dim_cols = (
            "lock_id", "river_code", "river_name", "lock_name", "lock_no", "river_mile", "district",
            "chambers", "latitude", "longitude",
        )  # fmt: skip
        counts["evs.lock_dim"] = _upsert(
            conn, "evs.lock_dim", [{c: i.get(c) for c in dim_cols} for i in locks], ("lock_id",)
        )
        conn.execute(
            "UPDATE evs.lock_dim SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326) "
            "WHERE geom IS NULL"
        )
        fact_cols = (
            "status", "status_reason", "vessels_queued", "avg_delay_4h_min", "avg_delay_24h_min",
            "last_lockage_at", "gauge_stage_ft", "flood_category", "active_stoppages",
        )  # fmt: skip
        conn.execute("DELETE FROM evs.lock_status_fact WHERE source = 'fixtures'")
        facts = [
            {"lock_id": i["lock_id"], **{c: i.get(c) for c in fact_cols}, **i["as_of"], "status_inputs": {}}
            for i in locks
        ]
        with conn.cursor() as cur:
            cols = list(facts[0].keys())
            cur.executemany(
                f"INSERT INTO evs.lock_status_fact ({', '.join(cols)}) "
                f"VALUES ({', '.join('%s' for _ in cols)})",
                [tuple(_pg(f[c]) for c in cols) for f in facts],
            )
        counts["evs.lock_status_fact"] = len(facts)
        srp = load("srp")
        snaps = [dict(s) for s in srp["snapshots"]]
        if snaps:
            snaps[-1]["headline"] = srp["headline"]
            snaps[-1]["source_as_of"] = srp["as_of"]["source_as_of"]
            snaps[-1]["fetched_at"] = srp["as_of"]["fetched_at"]
        for s in snaps:
            s.setdefault("headline", None)
            s.setdefault("source_as_of", None)
            s.setdefault("fetched_at", None)
        counts["evs.srp_snapshot"] = _upsert(conn, "evs.srp_snapshot", snaps, ("year",))
        counts["evs.srp_site"] = _upsert(conn, "evs.srp_site", srp["sites"], ("name",))
        counts["evs.feed_health"] = _upsert(conn, "evs.feed_health", load("feeds"), ("source",))
    return counts


if __name__ == "__main__":
    from evs.settings import get_settings

    print(json.dumps(run(get_settings().database_url_sync), indent=2))
