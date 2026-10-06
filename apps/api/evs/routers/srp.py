"""Sustainable Rivers Program coverage (public). Figures are cited to HEC, IWR and TNC pages."""

from fastapi import APIRouter

from evs.fixtures import load
from evs.schemas.public import SrpCoverage

router = APIRouter(prefix="/public/srp", tags=["public-srp"])


@router.get("/coverage", response_model=SrpCoverage)
def coverage() -> SrpCoverage:
    return SrpCoverage(**load("srp"))
