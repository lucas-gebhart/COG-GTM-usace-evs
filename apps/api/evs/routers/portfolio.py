"""Programs and projects. Replaces APEX Initiatives IR (page 20), Projects IR (page 30)
and Project Details form (page 31) of the Strategic Planner source app."""

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query

from evs.auth import Principal, current_principal
from evs.fixtures import load
from evs.schemas.common import AsOf, Page
from evs.schemas.portfolio import ProgramList, Project, ProjectList

router = APIRouter(tags=["portfolio"], dependencies=[Depends(current_principal)])


def _paginate(items: list, limit: int, offset: int):
    return items[offset : offset + limit], Page(total=len(items), limit=limit, offset=offset)


@router.get("/programs", response_model=ProgramList, openapi_extra={"x-apex-page": "21"})
def list_programs(limit: int = Query(50, le=500), offset: int = 0) -> ProgramList:
    items, page = _paginate(load("programs"), limit, offset)
    return ProgramList(items=items, page=page, as_of=AsOf(source="synthetic"))


@router.get("/projects", response_model=ProjectList, openapi_extra={"x-apex-page": "86"})
def list_projects(
    program_code: str | None = None,
    district: str | None = None,
    limit: int = Query(50, le=500),
    offset: int = 0,
) -> ProjectList:
    rows = load("projects")
    if program_code:
        rows = [r for r in rows if r["program_code"] == program_code]
    if district:
        rows = [r for r in rows if r["district"] == district]
    items, page = _paginate(rows, limit, offset)
    return ProjectList(items=items, page=page, as_of=AsOf(source="synthetic"))


@router.get("/projects/{p2_project_no}", response_model=Project, openapi_extra={"x-apex-page": "3"})
def get_project(p2_project_no: str, principal: Annotated[Principal, Depends(current_principal)]) -> Project:
    for row in load("projects"):
        if row["p2_project_no"] == p2_project_no:
            return Project(**row)
    raise HTTPException(404, f"Project {p2_project_no} not found")
