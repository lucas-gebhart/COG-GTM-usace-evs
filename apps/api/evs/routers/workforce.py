"""EMS labor views. Replaces the People IR (page 74)."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, Response

from evs.auth import require_viewer
from evs.repositories import Repositories, get_repos
from evs.repositories.query import ListQuery, csv_response, list_query
from evs.repositories.workforce import LABOR_COLUMNS
from evs.routers._common import stamp
from evs.schemas.common import Page
from evs.schemas.financial import LaborSummary

router = APIRouter(tags=["workforce"], dependencies=[Depends(require_viewer)])


@router.get(
    "/workforce/labor",
    response_model=LaborSummary,
    summary="EMS labor by district and pay period (APEX People IR)",
    description="Interactive Report parameters as on /projects. Columns: "
    + ", ".join(LABOR_COLUMNS.columns)
    + ".",
    openapi_extra={"x-apex-page": "74", "x-apex-authorization": "Authenticated User"},
    responses={200: {"content": {"text/csv": {}}}},
)
async def labor(
    repos: Annotated[Repositories, Depends(get_repos)],
    q: Annotated[ListQuery, Depends(list_query)],
    fiscal_year: int = 2026,
    district: str | None = None,
    pay_period: str | None = None,
) -> LaborSummary | Response:
    q.with_filter("district", district).with_filter("pay_period", pay_period)
    if q.format == "csv":
        q.limit, q.offset = 500, 0
    rows, total = await repos.workforce.list_labor(fiscal_year, q)
    if q.format == "csv":
        return csv_response(rows, LABOR_COLUMNS.columns, f"labor_fy{fiscal_year}.csv")
    return LaborSummary(
        fiscal_year=fiscal_year,
        rows=rows,
        page=Page(total=total, limit=q.limit, offset=q.offset),
        as_of=stamp(repos.workforce.as_of),
    )
