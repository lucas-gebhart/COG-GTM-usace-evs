"""SQL mode against PostGIS: migrations, seed, repositories and writes.

Skipped when no database is reachable (see conftest.require_db); the CI `api-db` job sets
EVS_REQUIRE_DB=1 so the skip becomes a failure there.
"""

from __future__ import annotations

import csv
import io

import psycopg
import pytest
from conftest import seed_db

from evs.repositories.portfolio import PROJECT_COLUMNS
from evs.repositories.query import ListQuery, parse_sort

pytestmark = pytest.mark.db


def test_migrations_and_seed_are_idempotent(migrated_db):
    sync_url, _ = migrated_db
    from evs.db.migrate import run as migrate

    assert migrate(sync_url) == []
    counts = seed_db(sync_url)
    assert counts["synth.p2_project"] == 120 and counts["evs.lock_dim"] == 234
    assert counts["evs.status_eval"] == 77 and counts["synth.ems_labor_log"] == 4550
    with psycopg.connect(sync_url) as conn:
        names = {r[0] for r in conn.execute("SELECT filename FROM public.schema_migration")}
        assert {"0001_extensions.sql", "0005_synth.sql", "0007_wp3_evs_state.sql"} <= names
        assert conn.execute("SELECT count(*) FROM evs.threshold").fetchone()[0] == 4


def test_db_mode_matches_fixtures_mode(db_client, client):
    for path, params in (
        ("/api/v1/projects", {"district": "LRL", "sort": "-funded_amount", "limit": 20}),
        ("/api/v1/programs", {"sort": "program_code"}),
        ("/api/v1/workforce/labor", {"district": "LRL", "sort": "pay_period"}),
        ("/api/v1/facilities/condition", {"sort": "-ci", "limit": 25}),
        ("/api/v1/schedule/milestones", {"status": "slipped"}),
    ):
        a, b = db_client.get(path, params=params).json(), client.get(path, params=params).json()
        key = "items" if "items" in a else "rows"
        assert a["page"]["total"] == b["page"]["total"], path
        assert [_strip(r) for r in a[key]] == [_strip(r) for r in b[key]], path
        assert a["as_of"]["source"] == "synthetic"


def test_db_csv_and_filters(db_client):
    r = db_client.get(
        "/api/v1/projects", params={"district": "LRL", "sort": "-funded_amount", "format": "csv"}
    )
    rows = list(csv.DictReader(io.StringIO(r.text)))
    assert rows and all(x["district"] == "LRL" for x in rows)
    body = db_client.get("/api/v1/projects", params=[("filter", "pct_complete:gte:50"), ("q", "LRL")]).json()
    assert all(p["pct_complete"] >= 50 for p in body["items"])
    assert db_client.get("/api/v1/projects", params={"sort": "nope"}).status_code == 422


def test_db_aggregates_and_public(db_client):
    kpis = {t["id"]: t for t in db_client.get("/api/v1/enterprise/kpis").json()["tiles"]}
    assert kpis["projects"]["value"] == 120 and kpis["locks_operating"]["value"] == 57
    dist = db_client.get("/api/v1/facilities/ci-distribution").json()
    assert sum(b["count"] for b in dist["buckets"]) == 215
    locks = db_client.get("/api/v1/public/locks", params={"river_code": "OH"}).json()
    assert locks["items"] and all(i["river_code"] == "OH" for i in locks["items"])
    one = db_client.get(f"/api/v1/public/locks/{locks['items'][0]['lock_id']}").json()
    assert one["as_of"]["source"] == "fixtures" and one["status_inputs"]
    assert db_client.get("/api/v1/public/locks").json()["counts"] == locks_fixture_counts()
    srp = db_client.get("/api/v1/public/srp/coverage").json()
    assert srp["snapshots"] and srp["sites"] and srp["as_of"]["source"] == "cited-public"
    assert db_client.get("/api/v1/admin/feeds").json()["feeds"]


def test_db_writes_persist(db_client, migrated_db):
    sync_url, _ = migrated_db
    no = db_client.get("/api/v1/projects", params={"limit": 1, "sort": "-p2_project_no"}).json()["items"][0][
        "p2_project_no"
    ]
    res = db_client.put(
        f"/api/v1/projects/{no}/status",
        json={"pct_complete": 70, "current_finish": "2030-03-01", "link_url": "https://x", "link_name": "x"},
    )
    assert res.status_code == 200, res.text
    assert res.json()["project"]["pct_complete"] == 70 and res.json()["kanban"]["column_id"] == 4
    code = res.json()["project"]["milestones"][0]["code"]
    ms = db_client.put(
        f"/api/v1/projects/{no}/milestones/{code}", json={"actual_date": "2026-02-01", "owner": "PM"}
    )
    assert ms.status_code == 200 and ms.json()["status"] == "complete"
    arch = db_client.post(f"/api/v1/projects/{no}/archive", json={"archived": True})
    assert arch.json()["archived"] is True
    thr = db_client.put(
        "/api/v1/admin/thresholds",
        json={
            "stale_after_minutes": 90,
            "delay_yellow_minutes": 45,
            "delay_red_minutes": 200,
            "queue_yellow_vessels": 4,
        },
    ).json()
    assert thr["source"] == "db" and thr["updated_by"] == "dev"
    with psycopg.connect(sync_url) as conn:
        assert (
            conn.execute(
                "SELECT pct_complete FROM synth.p2_project WHERE p2_project_no = %s", (no,)
            ).fetchone()[0]
            == 70
        )
        assert conn.execute(
            "SELECT archived FROM evs.project_state WHERE p2_project_no = %s", (no,)
        ).fetchone()[0]
        attrs = {
            r[0]
            for r in conn.execute("SELECT attribute FROM evs.project_history WHERE p2_project_no = %s", (no,))
        }
        assert {"PCT_COMPLETE", "TARGET_COMPLETE", "LINK", "ARCHIVED_YN"} <= attrs
        assert (
            conn.execute("SELECT value FROM evs.threshold WHERE key = 'delay_red_minutes'").fetchone()[0]
            == 200
        )
        assert conn.execute("SELECT count(*) FROM evs.project_interaction_log").fetchone()[0] >= 1
        # restore so the parity test stays valid on re-runs (WP2's seed only reloads after a reset)
        conn.execute("UPDATE evs.project_state SET archived = false WHERE p2_project_no = %s", (no,))
        conn.execute(
            "UPDATE evs.threshold SET value = CASE key WHEN 'stale_after_minutes' THEN 120 "
            "WHEN 'delay_yellow_minutes' THEN 60 WHEN 'delay_red_minutes' THEN 240 ELSE 6 END, "
            "updated_by = 'migration'"
        )
        conn.commit()
    seed_db(sync_url, reset=True)


def test_sql_where_clause_is_parameterised():
    q = ListQuery(sort=parse_sort("-funded_amount"))
    q.with_filter("district", "LRL").with_filter("pct_complete", "50", "gte").with_filter(
        "name", "x' OR 1=1", "like"
    )
    params: dict = {}
    where = PROJECT_COLUMNS.where_clause(q, params)
    assert "OR 1=1" not in where and params["f2"] == "%x' OR 1=1%"
    assert where.startswith(" WHERE ")
    expected = " ORDER BY p.funded_amount DESC NULLS LAST, p.p2_project_no ASC NULLS LAST"
    assert PROJECT_COLUMNS.order_clause(q) == expected


def locks_fixture_counts() -> dict:
    import json
    from pathlib import Path

    return json.loads((Path(__file__).resolve().parents[1] / "fixtures" / "locks.json").read_text())["counts"]


def _strip(row: dict) -> dict:
    return {k: (round(v, 2) if isinstance(v, float) else v) for k, v in row.items() if k != "milestones"}
