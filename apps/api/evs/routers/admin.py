"""Feed health and thresholds. Requires evs_admin (maps to the APEX Administrator authorization scheme).
Reads evs.feed_health and evs.threshold written by `evs ingest`; falls back to fixtures without a database."""

import logging
from datetime import UTC, datetime

from fastapi import APIRouter, Depends
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError

from evs.auth import require_role
from evs.db import engine
from evs.fixtures import load
from evs.schemas.ops import FeedHealth, FeedHealthList
from evs.settings import get_settings

log = logging.getLogger(__name__)
router = APIRouter(prefix="/admin", tags=["admin"], dependencies=[Depends(require_role("evs_admin"))])


@router.get("/feeds", response_model=FeedHealthList, openapi_extra={"x-apex-authorization": "Administrator"})
async def feeds() -> FeedHealthList:
    try:
        async with engine().connect() as conn:
            result = await conn.execute(
                text(
                    "SELECT source, endpoint, cadence_minutes, mode, last_attempt_at, last_success_at, "
                    "last_error, "
                    "latency_ms, http_status, rows_parsed, consecutive_failures, status, updated_at "
                    "FROM evs.feed_health ORDER BY source"
                )
            )
            rows = [dict(r._mapping) for r in result]
    except (SQLAlchemyError, OSError) as exc:
        log.warning("feeds: database unavailable (%s); serving fixtures", exc)
        rows = []
    if not rows:
        return FeedHealthList(feeds=load("feeds"), generated_at=datetime.now(UTC))
    return FeedHealthList(feeds=[FeedHealth(**r) for r in rows], generated_at=datetime.now(UTC))


@router.get("/thresholds")
async def thresholds() -> dict:
    s = get_settings()
    values = {
        "stale_after_minutes": s.stale_after_minutes,
        "delay_yellow_minutes": s.delay_yellow_minutes,
        "delay_red_minutes": s.delay_red_minutes,
        "queue_yellow_vessels": s.queue_yellow_vessels,
        "lpms_failover_hours": s.lpms_failover_hours,
    }
    try:
        async with engine().connect() as conn:
            result = await conn.execute(text("SELECT key, value FROM evs.threshold"))
            for key, value in result:
                values[key] = float(value) if float(value) % 1 else int(value)
    except (SQLAlchemyError, OSError):
        pass
    return values
