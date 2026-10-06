"""BUILDER SMS facility condition views (new in EVS; no APEX origin)."""

from fastapi import APIRouter, Depends

from evs.auth import current_principal
from evs.fixtures import load
from evs.schemas.financial import FacilitySummary

router = APIRouter(tags=["facilities"], dependencies=[Depends(current_principal)])


@router.get("/facilities/condition", response_model=FacilitySummary)
def condition() -> FacilitySummary:
    return FacilitySummary(**load("facilities"))
