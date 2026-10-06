"""BUILDER SMS facility condition views (new in EVS; no APEX origin)."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, Query, Response

from evs.auth import require_viewer
from evs.repositories import Repositories, get_repos
from evs.repositories.facilities import FACILITY_COLUMNS
from evs.repositories.query import ListQuery, csv_response, list_query
from evs.routers._common import stamp
from evs.schemas.common import Page
from evs.schemas.financial import CiDistribution, FacilitySummary

router = APIRouter(tags=["facilities"], dependencies=[Depends(require_viewer)])


@router.get(
    "/facilities/condition",
    response_model=FacilitySummary,
    summary="BUILDER component condition rows",
    description="Interactive Report parameters as on /projects. Columns: "
    + ", ".join(FACILITY_COLUMNS.columns)
    + ".",
    openapi_extra={"x-apex-authorization": "Authenticated User"},
    responses={200: {"content": {"text/csv": {}}}},
)
async def condition(
    repos: Annotated[Repositories, Depends(get_repos)],
    q: Annotated[ListQuery, Depends(list_query)],
    district: str | None = None,
    installation: str | None = None,
    component_type: str | None = None,
    max_ci: float | None = Query(None, ge=0, le=100, description="Only components at or below this CI"),
) -> FacilitySummary | Response:
    q.with_filter("district", district).with_filter("installation", installation)
    q.with_filter("component_type", component_type)
    if max_ci is not None:
        q.with_filter("ci", str(max_ci), "lte")
    if q.format == "csv":
        q.limit, q.offset = 500, 0
    rows, total = await repos.facilities.list_condition(q)
    if q.format == "csv":
        return csv_response(rows, FACILITY_COLUMNS.columns, "facility_condition.csv")
    return FacilitySummary(
        rows=rows, page=Page(total=total, limit=q.limit, offset=q.offset), as_of=stamp(repos.facilities.as_of)
    )


@router.get(
    "/facilities/ci-distribution",
    response_model=CiDistribution,
    summary="Condition index histogram and worst installations",
    openapi_extra={"x-apex-authorization": "Authenticated User"},
)
async def ci_distribution(repos: Annotated[Repositories, Depends(get_repos)]) -> CiDistribution:
    buckets, by_installation = await repos.facilities.ci_distribution()
    return CiDistribution(
        buckets=buckets, by_installation=by_installation, as_of=stamp(repos.facilities.as_of)
    )
