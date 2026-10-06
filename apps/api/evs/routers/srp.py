"""Sustainable Rivers Program coverage (public). Figures are cited to HEC, IWR and TNC pages."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends

from evs.repositories import Repositories, get_repos
from evs.schemas.public import SrpCoverage

router = APIRouter(prefix="/public/srp", tags=["public-srp"])


@router.get("/coverage", response_model=SrpCoverage, openapi_extra={"x-apex-authorization": "none"})
async def coverage(repos: Annotated[Repositories, Depends(get_repos)]) -> SrpCoverage:
    return SrpCoverage(**await repos.public.srp_coverage())
