"""Feed health and thresholds.

Requires evs_admin, which maps to the APEX "Administration Rights" authorization scheme
(group Administrator).
"""

from __future__ import annotations

from datetime import UTC, datetime
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException

from evs.auth import Principal, require_admin
from evs.repositories import Repositories, get_repos
from evs.schemas.ops import FeedHealthList, Thresholds, ThresholdUpdate

router = APIRouter(prefix="/admin", tags=["admin"], dependencies=[Depends(require_admin)])
ADMIN = {"x-apex-page": "10000", "x-apex-authorization": "Administration Rights"}


@router.get("/feeds", response_model=FeedHealthList, openapi_extra=ADMIN)
async def feeds(repos: Annotated[Repositories, Depends(get_repos)]) -> FeedHealthList:
    return FeedHealthList(feeds=await repos.ops.feeds(), generated_at=datetime.now(UTC))


@router.get("/thresholds", response_model=Thresholds, openapi_extra=ADMIN)
async def thresholds(repos: Annotated[Repositories, Depends(get_repos)]) -> Thresholds:
    return Thresholds(**await repos.ops.get_thresholds())


@router.put(
    "/thresholds", response_model=Thresholds, openapi_extra=ADMIN, summary="Persist status engine thresholds"
)
async def put_thresholds(
    body: ThresholdUpdate,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_admin)],
) -> Thresholds:
    if body.delay_red_minutes <= body.delay_yellow_minutes:
        raise HTTPException(
            422, [{"item": "delay_red_minutes", "message": "Red delay must exceed yellow delay."}]
        )
    return Thresholds(**await repos.ops.put_thresholds(body.model_dump(), principal.subject))
