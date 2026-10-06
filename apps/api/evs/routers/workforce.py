"""EMS labor views. Replaces the People IR (page 40)."""

from fastapi import APIRouter, Depends

from evs.auth import current_principal
from evs.fixtures import load
from evs.schemas.financial import LaborSummary

router = APIRouter(tags=["workforce"], dependencies=[Depends(current_principal)])


@router.get("/workforce/labor", response_model=LaborSummary, openapi_extra={"x-apex-page": "40"})
def labor(fiscal_year: int = 2026) -> LaborSummary:
    return LaborSummary(**load("labor_summary"))
