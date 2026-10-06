"""apps/api/fixtures/accessibility.json in the shape of evs.schemas.ops.AccessibilityReadout."""

from __future__ import annotations

from datetime import datetime
from typing import Any

from .engine import CriterionResult, RunSummary
from .evidence import AxeCell

METHOD = {"automated": "automated", "manual": "manual", "not_applicable": "not_applicable"}


def build_readout(
    cells: list[AxeCell],
    results: list[CriterionResult],
    run: RunSummary,
    now: datetime,
    target: str,
    acr_download_url: str,
) -> dict[str, Any]:
    routes = [
        {
            "route": c.route,
            "viewport": c.viewport,
            "theme": c.theme,
            "reduced_motion": c.reduced_motion,
            "violations": len(c.violations),
            "passes": c.passes,
            "incomplete": len(c.incomplete),
            "run_at": c.run_at.isoformat(),
        }
        for c in cells
    ]
    criteria = [
        {
            "criterion": r.num,
            "name": r.name,
            "level": r.level,
            "method": METHOD[r.method],
            "status": r.adherence,
            "notes": r.short_note,
        }
        for r in results
    ]
    return {
        "target": target,
        "routes": routes,
        "criteria": criteria,
        "acr_download_url": acr_download_url,
        "generated_at": now.isoformat(),
        "git_sha": run.git_sha,
        "axe_version": run.axe_version,
    }
