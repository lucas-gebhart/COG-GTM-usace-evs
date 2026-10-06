"""Public lock status (no auth): live table, map data, per-lock detail, SSE stream.
Source: LPMS ORDS feeds + NDC Locks GIS + NOAA/USGS gauges, evaluated by the status engine."""

from __future__ import annotations

import asyncio
import json
from collections.abc import AsyncIterator
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException
from sse_starlette.sse import EventSourceResponse

from evs.repositories import Repositories, get_repos
from evs.schemas.public import LockDetail, LockList

router = APIRouter(prefix="/public/locks", tags=["public-locks"])


@router.get("", response_model=LockList, openapi_extra={"x-apex-authorization": "none"})
async def list_locks(
    repos: Annotated[Repositories, Depends(get_repos)], river_code: str | None = None
) -> LockList:
    return LockList(**await repos.public.list_locks(river_code))


@router.get("/{lock_id}", response_model=LockDetail, openapi_extra={"x-apex-authorization": "none"})
async def get_lock(lock_id: str, repos: Annotated[Repositories, Depends(get_repos)]) -> LockDetail:
    item = await repos.public.get_lock(lock_id)
    if item is None:
        raise HTTPException(404, f"Lock {lock_id} not found")
    return LockDetail(**item)


async def _events(repos: Repositories) -> AsyncIterator[dict]:
    """Stub stream: re-sends the current snapshot every 30 s. WP5a replaces this with
    PostgreSQL LISTEN/NOTIFY from the ingestion worker."""
    while True:
        payload = await repos.public.list_locks(None)
        yield {
            "event": "locks",
            "data": json.dumps({"counts": payload["counts"], "as_of": payload["as_of"]}, default=str),
        }
        await asyncio.sleep(30)


@router.get("/stream/events", openapi_extra={"x-apex-authorization": "none"})
async def stream(repos: Annotated[Repositories, Depends(get_repos)]) -> EventSourceResponse:
    return EventSourceResponse(_events(repos))
