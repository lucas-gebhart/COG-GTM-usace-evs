"""BUILDER SMS facility condition (synthetic)."""

from __future__ import annotations

from typing import Any, Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.repositories.query import Columns, ListQuery
from evs.schemas.common import AsOf

FACILITY_COLUMNS = Columns(
    {
        "building_id": "building_id",
        "installation": "installation",
        "district": "district",
        "uniformat_section": "uniformat_section",
        "component_type": "component_type",
        "ci": "ci",
        "bci": "bci",
        "deficiency_cost": "deficiency_cost",
        "work_plan_year": "work_plan_year",
    },
    text_columns={"building_id", "installation", "district", "uniformat_section", "component_type"},
    default_sort="ci,building_id,uniformat_section,component_type",
)

# BUILDER SMS condition index bands used by the histogram and the status chips.
CI_BUCKETS: list[tuple[str, float, float, str]] = [
    ("0 to 39", 0, 39.999, "poor"),
    ("40 to 54", 40, 54.999, "fair"),
    ("55 to 69", 55, 69.999, "fair"),
    ("70 to 84", 70, 84.999, "good"),
    ("85 to 100", 85, 100, "good"),
]


class FacilitiesRepo(Protocol):
    as_of: AsOf

    async def list_condition(self, q: ListQuery) -> tuple[list[dict], int]: ...
    async def ci_distribution(self) -> tuple[list[dict], list[dict]]: ...


def bucketize(rows: list[dict]) -> list[dict]:
    out = []
    for label, lo, hi, band in CI_BUCKETS:
        hit = [r for r in rows if lo <= float(r["ci"]) <= hi]
        out.append(
            {
                "label": label,
                "ci_min": lo,
                "ci_max": round(hi),
                "band": band,
                "count": len(hit),
                "deficiency_cost": float(sum(r["deficiency_cost"] for r in hit)),
            }
        )
    return out


class PgFacilitiesRepo(PgBase):
    as_of = AsOf(source="synthetic")

    async def list_condition(self, q: ListQuery) -> tuple[list[dict], int]:
        params: dict[str, Any] = {}
        where = FACILITY_COLUMNS.where_clause(q, params)
        total = await self.scalar(f"SELECT count(*) FROM {t.BUILDER_CONDITION}{where}", params)
        rows = await self.rows(
            "SELECT building_id, installation, district, uniformat_section, component_type, ci, bci, "
            f"deficiency_cost, work_plan_year FROM {t.BUILDER_CONDITION}{where}"
            f"{FACILITY_COLUMNS.order_clause(q)} LIMIT :limit OFFSET :offset",
            {**params, "limit": q.limit, "offset": q.offset},
        )
        return [clean(r) for r in rows], int(total or 0)

    async def ci_distribution(self) -> tuple[list[dict], list[dict]]:
        rows = await self.rows(f"SELECT ci, deficiency_cost FROM {t.BUILDER_CONDITION}")
        by_inst = await self.rows(
            f"""
            SELECT installation, district, count(*) AS component_count, round(avg(ci)::numeric, 1) AS avg_ci,
                   min(ci) AS min_ci, sum(deficiency_cost) AS deficiency_cost
            FROM {t.BUILDER_CONDITION} GROUP BY installation, district ORDER BY avg_ci ASC, installation
            """
        )
        return bucketize([clean(r) for r in rows]), [clean(r) for r in by_inst]


class FixtureFacilitiesRepo:
    as_of = AsOf(source="synthetic")

    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    async def list_condition(self, q: ListQuery) -> tuple[list[dict], int]:
        return FACILITY_COLUMNS.apply_in_memory(self.store.get("facilities")["rows"], q)

    async def ci_distribution(self) -> tuple[list[dict], list[dict]]:
        rows = self.store.get("facilities")["rows"]
        groups: dict[tuple[str, str], list[dict]] = {}
        for r in rows:
            groups.setdefault((r["installation"], r["district"]), []).append(r)
        by_inst = [
            {
                "installation": inst,
                "district": district,
                "component_count": len(g),
                "avg_ci": round(sum(r["ci"] for r in g) / len(g), 1),
                "min_ci": min(r["ci"] for r in g),
                "deficiency_cost": float(sum(r["deficiency_cost"] for r in g)),
            }
            for (inst, district), g in groups.items()
        ]
        by_inst.sort(key=lambda r: (r["avg_ci"], r["installation"]))
        return bucketize(rows), by_inst
