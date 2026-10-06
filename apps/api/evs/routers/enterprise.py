"""Enterprise overview tiles (route `/`). Replaces the Dashboard (page 1) badge regions."""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends

from evs.auth import require_viewer
from evs.repositories import Repositories, get_repos
from evs.routers._common import stamp
from evs.schemas.common import AsOf, KpiList, KpiTile

router = APIRouter(tags=["enterprise"], dependencies=[Depends(require_viewer)])


@router.get(
    "/enterprise/kpis",
    response_model=KpiList,
    summary="Enterprise KPI tiles",
    openapi_extra={"x-apex-page": "1", "x-apex-authorization": "Authenticated User"},
)
async def kpis(repos: Annotated[Repositories, Depends(get_repos)]) -> KpiList:
    roll = await repos.portfolio.kpi_rollup()
    synthetic = stamp(repos.portfolio.as_of)
    buckets, _ = await repos.facilities.ci_distribution()
    components = sum(b["count"] for b in buckets) or 1
    poor = sum(b["count"] for b in buckets if b["band"] == "poor")
    locks = await repos.public.list_locks(None)
    lock_as_of = AsOf(**locks["as_of"]) if isinstance(locks["as_of"], dict) else locks["as_of"]
    funded = float(roll.get("funded_amount") or 0)
    obligated = float(roll.get("obligated_amount") or 0)
    tiles = [
        KpiTile(id="programs", label="Programs", value=roll["programs"], as_of=synthetic),
        KpiTile(id="projects", label="Active projects", value=roll["projects"], as_of=synthetic),
        KpiTile(
            id="obligation_rate",
            label="Obligated vs funded",
            value=round(100 * obligated / funded, 1) if funded else 0,
            unit="%",
            delta_label=f"${obligated / 1e6:,.0f}M of ${funded / 1e6:,.0f}M",
            as_of=synthetic,
        ),
        KpiTile(
            id="late_projects",
            label="Projects late or at risk",
            value=roll["late_projects"] + roll["at_risk_projects"],
            delta=roll["late_projects"],
            delta_label=f"{roll['late_projects']} late",
            as_of=synthetic,
        ),
        KpiTile(
            id="slipped_milestones",
            label="Slipped milestones",
            value=roll["slipped_milestones"],
            as_of=synthetic,
        ),
        KpiTile(
            id="facilities_poor",
            label="Components in poor condition",
            value=round(100 * poor / components, 1),
            unit="%",
            delta_label=f"{poor} of {components} BUILDER components under CI 40",
            as_of=stamp(repos.facilities.as_of),
        ),
        KpiTile(
            id="locks_operating",
            label="Locks operating",
            value=locks["counts"].get("operating", 0),
            delta=locks["counts"].get("closed", 0),
            delta_label=f"{locks['counts'].get('delayed', 0)} delayed, {locks['counts'].get('closed', 0)} closed",  # noqa: E501
            as_of=lock_as_of,
        ),
    ]
    return KpiList(tiles=tiles, as_of=synthetic)
