"""CEFMS execution views. Replaces the Dashboard chart regions (page 1) and the
budget IR of the source app; data is synthetic, shaped by ER 37-1-30 vocabulary."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException

from evs.auth import require_viewer
from evs.repositories import Repositories, get_repos
from evs.routers._common import stamp
from evs.schemas.financial import FinancialSummary, ProgramVariance, VarianceByProgram

router = APIRouter(tags=["financial"], dependencies=[Depends(require_viewer)])


@router.get(
    "/financial/summary",
    response_model=FinancialSummary,
    openapi_extra={"x-apex-page": "161", "x-apex-authorization": "Authenticated User"},
)
async def financial_summary(
    repos: Annotated[Repositories, Depends(get_repos)], fiscal_year: int = 2026
) -> FinancialSummary:
    curve = await repos.financial.execution_curve(fiscal_year)
    if not curve:
        raise HTTPException(404, f"No CEFMS execution data for FY{fiscal_year}")
    return FinancialSummary(
        fiscal_year=fiscal_year,
        execution_curve=curve,
        by_appropriation=await repos.financial.by_appropriation(fiscal_year),
        as_of=stamp(repos.financial.as_of),
    )


@router.get(
    "/financial/variance-by-program",
    response_model=VarianceByProgram,
    summary="Obligation variance against plan to date, by program",
    openapi_extra={"x-apex-page": "161", "x-apex-authorization": "Authenticated User"},
)
async def variance_by_program(
    repos: Annotated[Repositories, Depends(get_repos)], fiscal_year: int = 2026
) -> VarianceByProgram:
    """Plan to date is each program's funded amount scaled by the enterprise plan pace at the
    latest CEFMS period (plan_cumulative at that period over the full-year plan)."""
    curve = await repos.financial.execution_curve(fiscal_year)
    plan_total = max((float(r["plan_cumulative"]) for r in curve), default=0.0)
    pace = float(curve[-1]["plan_cumulative"]) / plan_total if curve and plan_total else 1.0
    rows: list[ProgramVariance] = []
    for p in await repos.portfolio.variance_by_program():
        plan_to_date = round(float(p["funded_amount"]) * pace, 2)
        variance = round(float(p["obligated_amount"]) - plan_to_date, 2)
        rows.append(
            ProgramVariance(
                program_code=p["program_code"],
                name=p["name"],
                business_line=p["business_line"],
                division=p["division"],
                funded_amount=p["funded_amount"],
                obligated_amount=p["obligated_amount"],
                plan_to_date=plan_to_date,
                variance_amount=variance,
                variance_pct=round(100 * variance / plan_to_date, 1) if plan_to_date else 0.0,
            )
        )
    rows.sort(key=lambda r: r.variance_pct)
    return VarianceByProgram(fiscal_year=fiscal_year, rows=rows, as_of=stamp(repos.portfolio.as_of))
