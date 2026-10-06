"""Public lock status (no auth): live table, map data, per-lock detail, SSE stream.
Source: LPMS ORDS feeds + NDC Locks GIS + NOAA/USGS gauges, evaluated by the status engine."""

import asyncio
import json
from collections.abc import AsyncIterator

from fastapi import APIRouter, HTTPException
from sse_starlette.sse import EventSourceResponse

from evs.fixtures import load
from evs.schemas.public import LockDetail, LockList

router = APIRouter(prefix="/public/locks", tags=["public-locks"])


@router.get("", response_model=LockList)
def list_locks(river_code: str | None = None) -> LockList:
    data = load("locks")
    if river_code:
        data = {**data, "items": [i for i in data["items"] if i["river_code"] == river_code]}
    return LockList(**data)


@router.get("/{lock_id}", response_model=LockDetail)
def get_lock(lock_id: str) -> LockDetail:
    for item in load("locks")["items"]:
        if item["lock_id"] == lock_id:
            return LockDetail(**item)
    raise HTTPException(404, f"Lock {lock_id} not found")


async def _events() -> AsyncIterator[dict]:
    """Stub stream: re-sends the fixture snapshot every 30 s. WP5a replaces this with
    PostgreSQL LISTEN/NOTIFY from the ingestion worker."""
    while True:
        payload = load("locks")
        yield {"event": "locks", "data": json.dumps({"counts": payload["counts"], "as_of": payload["as_of"]})}
        await asyncio.sleep(30)


@router.get("/stream/events")
async def stream() -> EventSourceResponse:
    return EventSourceResponse(_events())
