"""CEFMS execution views. Replaces the Dashboard chart regions (page 1) and the
budget IR of the source app; data is synthetic, shaped by ER 37-1-30 vocabulary."""

from fastapi import APIRouter, Depends

from evs.auth import current_principal
from evs.fixtures import load
from evs.schemas.financial import FinancialSummary

router = APIRouter(tags=["financial"], dependencies=[Depends(current_principal)])


@router.get("/financial/summary", response_model=FinancialSummary, openapi_extra={"x-apex-page": "1"})
def financial_summary(fiscal_year: int = 2026) -> FinancialSummary:
    return FinancialSummary(**load("financial_summary"))
