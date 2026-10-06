"""One fixtures-mode `evs ingest --once` cycle against the Compose PostGIS, then the DB-backed API and SSE
stream. Skipped when no database is reachable (CI runs the unit tests only; `make up` then `uv run pytest`
runs this)."""

import asyncio
import json

import psycopg
import pytest
from fastapi.testclient import TestClient

from evs.settings import get_settings


def _db_available() -> bool:
    try:
        with psycopg.connect(get_settings().database_url_sync, connect_timeout=2):
            return True
    except psycopg.Error:
        return False


pytestmark = pytest.mark.skipif(not _db_available(), reason="PostGIS not reachable (run `make up`)")


@pytest.fixture(scope="module")
def cycle():
    from evs.db.migrate import run
    from evs.ingest.worker import IngestWorker

    settings = get_settings().model_copy(update={"feed_source": "fixtures"})
    run(settings.database_url_sync)
    worker = IngestWorker(settings)
    summary = worker.run_once()
    yield worker, summary
    worker.conn.close()


def test_once_populates_lock_current(cycle):
    worker, summary = cycle
    assert summary["gis"] == 232
    assert summary["lpms"]["status_rows"] == 77 and summary["lpms"]["stoppages"] == 22
    rows = worker.conn.execute("SELECT status, count(*) FROM evs.lock_current GROUP BY status").fetchall()
    counts = dict(rows)
    assert counts.get("operating", 0) > 0 and counts.get("closed", 0) > 0 and counts.get("delayed", 0) > 0
    olmsted = worker.conn.execute(
        "SELECT status, rule_no, source, freshness, latitude, longitude FROM evs.lock_current "
        "WHERE lock_id = 'OH-79'"
    ).fetchone()
    assert olmsted[0] == "closed" and olmsted[1] == 3 and olmsted[2] == "fixtures" and olmsted[3] == "fresh"
    assert 37 < float(olmsted[4]) < 38 and -90 < float(olmsted[5]) < -88  # GIS geometry, not swapped LPMS
    health = dict(worker.conn.execute("SELECT source, status FROM evs.feed_health").fetchall())
    assert health["LPMS lock_status_report"] == "fixtures" and health["LPMS lock_delay_json"] == "fixtures"


def test_api_reads_lock_current(cycle):
    from evs.main import create_app

    client = TestClient(create_app())
    data = client.get("/api/v1/public/locks").json()
    assert len(data["items"]) >= 232 and data["as_of"]["source"] == "fixtures"
    detail = client.get("/api/v1/public/locks/OH-79").json()
    assert detail["status"] == "closed" and detail["queue"] and detail["recent_lockages"]
    assert detail["status_inputs"]["rule_no"] == 3 and detail["stoppages"][0]["active"] is True
    feeds = client.get("/api/v1/admin/feeds").json()["feeds"]
    assert {f["source"] for f in feeds} >= {"LPMS lock_status_report", "NDC GIS Locks", "NOAA NWPS gauges"}
    assert all(f["status"] == "fixtures" for f in feeds if f["source"] != "Simulator")


async def test_sse_stream_emits_snapshot_and_notify(cycle):
    from evs.routers.locks import lock_events

    worker, _ = cycle
    events = lock_events(queue_timeout=10)
    first = await events.__anext__()
    assert first["event"] == "locks"
    snapshot = json.loads(first["data"])
    assert snapshot["counts"]["closed"] > 0 and snapshot["as_of"]["source"] == "fixtures"

    payload = {
        "at": "2026-10-06T16:00:00+00:00",
        "source": "fixtures",
        "counts": {"closed": 1},
        "changed": ["OH-79"],
        "changed_total": 1,
        "as_of": "2026-10-06T14:26:17+00:00",
    }
    await asyncio.sleep(0.2)
    worker.conn.execute("SELECT pg_notify('evs_locks', %s)", (json.dumps(payload),))
    second = await asyncio.wait_for(events.__anext__(), timeout=10)
    assert second["event"] == "locks" and json.loads(second["data"])["changed"] == 1
    third = await asyncio.wait_for(events.__anext__(), timeout=10)
    assert third["event"] == "lock" and third["id"] == "OH-79"
    assert json.loads(third["data"])["status"] == "closed"
    await events.aclose()
