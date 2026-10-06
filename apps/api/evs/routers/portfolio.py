"""Programs and projects. Replaces APEX Initiatives IR (page 21), Projects IR (page 86),
Project Details (page 3) and the Project form (page 24) of the Strategic Planner source app.

List endpoints accept the Interactive Report style parameters documented in
`evs.repositories.query` (`filter=column:op:value`, `q`, `sort`, `limit`, `offset`, `format=csv`).
"""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query, Response

from evs.auth import Principal, require_viewer
from evs.repositories import Repositories, get_repos
from evs.repositories.portfolio import PROGRAM_COLUMNS, PROJECT_COLUMNS
from evs.repositories.query import ListQuery, csv_response, list_query
from evs.routers._common import stamp
from evs.schemas.common import Page
from evs.schemas.portfolio import ProgramList, Project, ProjectList

router = APIRouter(tags=["portfolio"], dependencies=[Depends(require_viewer)])

IR_PARAMS = (
    "Interactive Report parameters: repeatable `filter=column:op:value` "
    "(op: eq, ne, gt, gte, lt, lte, like, in), "
    "`q` full text, `sort=-col,col2`, `limit`, `offset`, `format=csv`."
)


@router.get(
    "/programs",
    response_model=ProgramList,
    summary="Programs (APEX Initiatives IR)",
    description=f"{IR_PARAMS} Columns: {', '.join(PROGRAM_COLUMNS.columns)}.",
    openapi_extra={"x-apex-page": "21", "x-apex-authorization": "Authenticated User"},
    responses={200: {"description": "JSON body; text/csv (same columns) when format=csv"}},
)
async def list_programs(
    repos: Annotated[Repositories, Depends(get_repos)],
    q: Annotated[ListQuery, Depends(list_query)],
    division: str | None = None,
    business_line: str | None = None,
    schedule_health: str | None = None,
) -> ProgramList | Response:
    q.with_filter("division", division).with_filter("business_line", business_line)
    q.with_filter("schedule_health", schedule_health)
    if q.format == "csv":
        q.limit, q.offset = 500, 0
    rows, total = await repos.portfolio.list_programs(q)
    if q.format == "csv":
        return csv_response(rows, PROGRAM_COLUMNS.columns, "programs.csv")
    return ProgramList(
        items=rows, page=Page(total=total, limit=q.limit, offset=q.offset), as_of=stamp(repos.portfolio.as_of)
    )


@router.get(
    "/projects",
    response_model=ProjectList,
    summary="Projects (APEX Projects IR)",
    description=f"{IR_PARAMS} Columns: {', '.join(PROJECT_COLUMNS.columns)}.",
    openapi_extra={"x-apex-page": "86", "x-apex-authorization": "Authenticated User"},
    responses={200: {"description": "JSON body; text/csv (same columns) when format=csv"}},
)
async def list_projects(
    repos: Annotated[Repositories, Depends(get_repos)],
    q: Annotated[ListQuery, Depends(list_query)],
    program_code: str | None = None,
    district: str | None = None,
    division: str | None = None,
    business_line: str | None = None,
    phase: str | None = None,
    schedule_health: str | None = None,
    min_pct_complete: float | None = Query(None, ge=0, le=100),
) -> ProjectList | Response:
    q.with_filter("program_code", program_code).with_filter("district", district).with_filter(
        "division", division
    )
    q.with_filter("business_line", business_line).with_filter("phase", phase)
    q.with_filter("schedule_health", schedule_health)
    if min_pct_complete is not None:
        q.with_filter("pct_complete", str(min_pct_complete), "gte")
    if q.format == "csv":
        q.limit, q.offset = 500, 0
    rows, total = await repos.portfolio.list_projects(q)
    if q.format == "csv":
        return csv_response(rows, PROJECT_COLUMNS.columns, "projects.csv")
    return ProjectList(
        items=rows, page=Page(total=total, limit=q.limit, offset=q.offset), as_of=stamp(repos.portfolio.as_of)
    )


@router.get(
    "/projects/{p2_project_no}",
    response_model=Project,
    summary="Project detail (APEX Project Details)",
    openapi_extra={"x-apex-page": "3", "x-apex-process": "log", "x-apex-authorization": "Authenticated User"},
)
async def get_project(
    p2_project_no: str,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_viewer)],
) -> Project:
    row = await repos.portfolio.get_project(p2_project_no)
    if row is None:
        raise HTTPException(404, f"Project {p2_project_no} not found")
    await repos.portfolio.log_interaction(p2_project_no, principal.subject, "project_details")
    return Project(**row)
