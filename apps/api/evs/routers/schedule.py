"""Schedule page: milestones across projects with slip in days (route `/schedule`).
Replaces the Kanban Board (page 4) and task lists of the source app for the P2 milestone set."""

from __future__ import annotations

from typing import Annotated, Literal

from fastapi import APIRouter, Depends, Response

from evs.auth import require_viewer
from evs.repositories import Repositories, get_repos
from evs.repositories.portfolio import MILESTONE_COLUMNS
from evs.repositories.query import ListQuery, csv_response, list_query
from evs.routers._common import stamp
from evs.schemas.common import Page
from evs.schemas.portfolio import MilestoneList

router = APIRouter(tags=["schedule"], dependencies=[Depends(require_viewer)])


@router.get(
    "/schedule/milestones",
    response_model=MilestoneList,
    summary="Milestones with slip (status=slipped for the late list)",
    openapi_extra={"x-apex-page": "4", "x-apex-authorization": "Authenticated User"},
    responses={200: {"description": "JSON body; text/csv (same columns) when format=csv"}},
)
async def milestones(
    repos: Annotated[Repositories, Depends(get_repos)],
    q: Annotated[ListQuery, Depends(list_query)],
    status: Literal["complete", "scheduled", "slipped"] | None = None,
    district: str | None = None,
    program_code: str | None = None,
    p2_project_no: str | None = None,
) -> MilestoneList | Response:
    q.with_filter("status", status).with_filter("district", district).with_filter(
        "program_code", program_code
    )
    q.with_filter("p2_project_no", p2_project_no)
    if q.format == "csv":
        q.limit, q.offset = 500, 0
    rows, total = await repos.portfolio.list_milestones(q)
    if q.format == "csv":
        return csv_response(rows, MILESTONE_COLUMNS.columns, "milestones.csv")
    return MilestoneList(
        items=rows, page=Page(total=total, limit=q.limit, offset=q.offset), as_of=stamp(repos.portfolio.as_of)
    )
