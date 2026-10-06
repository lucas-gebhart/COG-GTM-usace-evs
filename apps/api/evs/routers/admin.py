"""Feed health and thresholds.

Requires evs_admin, which maps to the APEX "Administration Rights" authorization scheme (group Administrator).
"""

from datetime import UTC, datetime

from fastapi import APIRouter, Depends

from evs.auth import require_role
from evs.fixtures import load
from evs.schemas.ops import FeedHealthList
from evs.settings import get_settings

router = APIRouter(prefix="/admin", tags=["admin"], dependencies=[Depends(require_role("evs_admin"))])


@router.get(
    "/feeds",
    response_model=FeedHealthList,
    openapi_extra={"x-apex-page": "10000", "x-apex-authorization": "Administration Rights"},
)
def feeds() -> FeedHealthList:
    return FeedHealthList(feeds=load("feeds"), generated_at=datetime.now(UTC))


@router.get(
    "/thresholds",
    openapi_extra={"x-apex-page": "10000", "x-apex-authorization": "Administration Rights"},
)
def thresholds() -> dict:
    s = get_settings()
    return {
        "stale_after_minutes": s.stale_after_minutes,
        "delay_yellow_minutes": s.delay_yellow_minutes,
        "delay_red_minutes": s.delay_red_minutes,
        "queue_yellow_vessels": s.queue_yellow_vessels,
    }
