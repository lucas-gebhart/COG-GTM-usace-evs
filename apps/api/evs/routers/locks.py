"""Public lock status (no auth): live table, map data, per-lock detail, SSE stream.
Rows come from evs.lock_current (written by `evs ingest`); the stream relays PostgreSQL NOTIFY evs_locks.
When the database is unreachable or empty (CI, first boot) the handlers fall back to the labelled fixtures."""

import asyncio
import json
import logging
from collections.abc import AsyncIterator
from datetime import UTC, datetime
from decimal import Decimal
from typing import Any

import asyncpg
from fastapi import APIRouter, HTTPException
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from sse_starlette.sse import EventSourceResponse

from evs.db import engine
from evs.fixtures import load
from evs.schemas.common import AsOf
from evs.schemas.public import LockDetail, LockList, LockSummary
from evs.settings import get_settings

log = logging.getLogger(__name__)
router = APIRouter(prefix="/public/locks", tags=["public-locks"])
STATUSES = ("operating", "delayed", "closed", "stale", "unknown")
SUMMARY_SQL = """
SELECT lock_id, river_code, river_name, lock_name, lock_no, river_mile, district, chambers, latitude,
       longitude, status, status_reason, vessels_queued, avg_delay_4h_min, avg_delay_24h_min, last_lockage_at,
       gauge_stage_ft,
       flood_category, active_stoppages, as_of, evaluated_at, freshness, source, lift_ft, chamber_dimensions,
       year_opened, owner, operator, status_inputs
FROM evs.lock_current
"""


def _num(v: Any) -> float | None:
    return float(v) if isinstance(v, Decimal | int | float) else None


def _plain(row: dict) -> dict:
    out = {}
    for k, v in row.items():
        if isinstance(v, Decimal):
            out[k] = float(v)
        elif isinstance(v, datetime):
            out[k] = v.isoformat()
        else:
            out[k] = v
    return out


def _as_of(row: dict) -> AsOf:
    return AsOf(
        source_as_of=row.get("as_of"),
        fetched_at=row.get("evaluated_at"),
        freshness=row.get("freshness") or "stale",
        source=row.get("source") or "live",
    )


def _summary(row: dict) -> LockSummary:
    return LockSummary(
        lock_id=row["lock_id"],
        river_code=row["river_code"],
        river_name=row["river_name"] or row["river_code"],
        lock_name=row["lock_name"] or row["lock_id"],
        lock_no=row["lock_no"],
        river_mile=_num(row["river_mile"]),
        district=row["district"],
        chambers=row["chambers"],
        latitude=_num(row["latitude"]),
        longitude=_num(row["longitude"]),
        status=row["status"],
        status_reason=row["status_reason"],
        vessels_queued=row["vessels_queued"],
        avg_delay_4h_min=_num(row["avg_delay_4h_min"]),
        avg_delay_24h_min=_num(row["avg_delay_24h_min"]),
        last_lockage_at=row["last_lockage_at"],
        gauge_stage_ft=_num(row["gauge_stage_ft"]),
        flood_category=row["flood_category"],
        active_stoppages=row["active_stoppages"] or 0,
        as_of=_as_of(row),
    )


async def _rows(sql: str, **params: Any) -> list[dict]:
    async with engine().connect() as conn:
        result = await conn.execute(text(sql), params)
        return [dict(r._mapping) for r in result]


def _list_as_of(rows: list[dict]) -> AsOf:
    newest = max(
        (r for r in rows if r.get("evaluated_at")),
        key=lambda r: (r.get("as_of") is not None, r["evaluated_at"]),
        default=None,
    )
    if newest is None:
        return AsOf(source_as_of=None, fetched_at=None, freshness="stale", source="live")
    return AsOf(
        source_as_of=max((r["as_of"] for r in rows if r.get("as_of")), default=None),
        fetched_at=newest["evaluated_at"],
        freshness=newest["freshness"],
        source=newest["source"],
    )


def _build_list(rows: list[dict], river_code: str | None) -> LockList:
    items = [_summary(r) for r in rows if not river_code or r["river_code"] == river_code]
    counts = {s: 0 for s in STATUSES}
    for item in items:
        counts[item.status] += 1
    rivers = sorted({(r["river_code"], r["river_name"] or r["river_code"]) for r in rows})
    return LockList(
        items=items,
        rivers=[{"code": c, "name": n} for c, n in rivers],
        counts=counts,
        as_of=_list_as_of(rows),
    )


def _fixture_list(river_code: str | None) -> LockList:
    data = load("locks")
    if river_code:
        data = {**data, "items": [i for i in data["items"] if i["river_code"] == river_code]}
    return LockList(**data)


@router.get("", response_model=LockList)
async def list_locks(river_code: str | None = None, reporting_only: bool = False) -> LockList:
    """All locks in evs.lock_current. `reporting_only` drops locks absent from the LPMS status feed."""
    try:
        rows = await _rows(SUMMARY_SQL + " ORDER BY river_code, lock_no")
    except (SQLAlchemyError, OSError) as exc:
        log.warning("locks: database unavailable (%s); serving fixtures", exc)
        return _fixture_list(river_code)
    if not rows:
        return _fixture_list(river_code)
    if reporting_only:
        rows = [r for r in rows if r["status"] != "unknown"]
    return _build_list(rows, river_code)


@router.get("/{lock_id}", response_model=LockDetail)
async def get_lock(lock_id: str) -> LockDetail:
    try:
        rows = await _rows(SUMMARY_SQL + " WHERE lock_id = :lock_id", lock_id=lock_id)
    except (SQLAlchemyError, OSError) as exc:
        log.warning("lock %s: database unavailable (%s); serving fixtures", lock_id, exc)
        rows = []
        for item in load("locks")["items"]:
            if item["lock_id"] == lock_id:
                return LockDetail(**item)
    if not rows:
        raise HTTPException(404, f"Lock {lock_id} not found")
    row = rows[0]
    queue = await _rows(
        "SELECT vessel_no, vessel_name, direction, num_barges, arrival_at, sol_at, mmsi, fetched_at, source "
        "FROM evs.lock_queue WHERE lock_id = :lock_id ORDER BY arrival_at NULLS LAST",
        lock_id=lock_id,
    )
    stoppages = await _rows(
        "SELECT chamber_no, begin_at, end_at, is_scheduled, reason_code, traffic_stopped, hw_cycles, "
        "refresh_at, source, "
        "(begin_at <= now() AND (end_at IS NULL OR end_at >= now())) AS active "
        "FROM evs.stoppage WHERE lock_id = :lock_id "
        "AND (end_at IS NULL OR end_at > now() - interval '90 days') "
        "ORDER BY begin_at DESC LIMIT 25",
        lock_id=lock_id,
    )
    lockages = await _rows(
        "SELECT vessel_no, vessel_name, direction, num_barges, number_processed, hazard_code, arrival_at, "
        "sol_at, end_of_lockage_at, source FROM evs.lockage WHERE lock_id = :lock_id "
        "ORDER BY end_of_lockage_at DESC LIMIT 25",
        lock_id=lock_id,
    )
    gauges = await _rows(
        "SELECT DISTINCT ON (provider) provider, station_id, observed_at, stage_ft, flow_cfs, "
        "flood_category, "
        "forecast_category, forecast_at, moderate_stage_ft, categories, fetched_at, source "
        "FROM evs.gauge_fact WHERE lock_id = :lock_id ORDER BY provider, fetched_at DESC",
        lock_id=lock_id,
    )
    summary = _summary(row)
    return LockDetail(
        **summary.model_dump(),
        lift_ft=_num(row["lift_ft"]),
        chamber_dimensions=row["chamber_dimensions"],
        year_opened=row["year_opened"],
        owner=row["owner"],
        operator=row["operator"],
        queue=[_plain(q) for q in queue],
        stoppages=[_plain(s) for s in stoppages],
        recent_lockages=[_plain(x) for x in lockages],
        gauges=[_plain(g) for g in gauges],
        status_inputs=row["status_inputs"] or {},
    )


async def _snapshot_event() -> dict:
    rows = await _rows(SUMMARY_SQL)
    data = _build_list(rows, None) if rows else _fixture_list(None)
    return {
        "event": "locks",
        "data": json.dumps(
            {"counts": data.counts, "as_of": data.as_of.model_dump(mode="json"), "total": len(data.items)}
        ),
    }


async def _fixture_events() -> AsyncIterator[dict]:
    while True:
        payload = load("locks")
        yield {
            "event": "locks",
            "data": json.dumps(
                {"counts": payload["counts"], "as_of": payload["as_of"], "total": len(payload["items"])}
            ),
        }
        await asyncio.sleep(30)


async def lock_events(queue_timeout: float = 30.0) -> AsyncIterator[dict]:
    """Snapshot on connect, then one `locks` event (counts + as_of) and one `lock` event per changed lock for
    every NOTIFY evs_locks the ingestion worker sends. Falls back to the fixture snapshot when there is no
    database."""
    settings = get_settings()
    try:
        conn = await asyncpg.connect(settings.database_url_sync, timeout=5)
    except (OSError, asyncpg.PostgresError, TimeoutError) as exc:
        log.warning("locks stream: database unavailable (%s); streaming fixtures", exc)
        async for event in _fixture_events():
            yield event
        return
    notifications: asyncio.Queue[str] = asyncio.Queue()

    def on_notify(_conn, _pid, _channel, payload: str) -> None:
        notifications.put_nowait(payload)

    await conn.add_listener("evs_locks", on_notify)
    try:
        yield await _snapshot_event()
        while True:
            try:
                raw = await asyncio.wait_for(notifications.get(), timeout=queue_timeout)
            except TimeoutError:
                yield {"comment": f"keepalive {datetime.now(UTC).isoformat()}"}
                continue
            try:
                note = json.loads(raw)
            except ValueError:
                continue
            as_of = {
                "source_as_of": note.get("as_of"),
                "fetched_at": note.get("at"),
                "freshness": "simulated" if note.get("source") == "simulated" else "fresh",
                "source": note.get("source", "live"),
            }
            yield {
                "event": "locks",
                "data": json.dumps(
                    {
                        "counts": note.get("counts", {}),
                        "as_of": as_of,
                        "changed": note.get("changed_total", 0),
                    }
                ),
            }
            changed = note.get("changed") or []
            if changed:
                rows = await _rows(SUMMARY_SQL + " WHERE lock_id = ANY(:ids)", ids=changed)
                for row in rows:
                    yield {"event": "lock", "id": row["lock_id"], "data": _summary(row).model_dump_json()}
    finally:
        await conn.close()


@router.get("/stream/events")
async def stream() -> EventSourceResponse:
    return EventSourceResponse(lock_events())
