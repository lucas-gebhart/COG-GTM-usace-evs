"""EMS labor by district and pay period (synth.v_labor_summary rolls up the per-employee log)."""

from __future__ import annotations

from typing import Any, Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.repositories.query import Columns, ListQuery
from evs.schemas.common import AsOf

LABOR_COLUMNS = Columns(
    {
        "district": "district",
        "pay_period": "pay_period",
        "hours_plan": "hours_plan",
        "hours_regular": "hours_regular",
        "hours_overtime": "hours_overtime",
        "labor_cost": "labor_cost",
    },
    text_columns={"district", "pay_period"},
    default_sort="district,pay_period",
)


class WorkforceRepo(Protocol):
    as_of: AsOf

    async def list_labor(self, fiscal_year: int, q: ListQuery) -> tuple[list[dict], int]: ...


class PgWorkforceRepo(PgBase):
    as_of = AsOf(source="synthetic")

    async def list_labor(self, fiscal_year: int, q: ListQuery) -> tuple[list[dict], int]:
        params: dict[str, Any] = {"fy": fiscal_year}
        where = LABOR_COLUMNS.where_clause(q, params)
        fy = "left(pay_period, 4)::int = :fy"  # pay_period is FY-PP, e.g. 2026-14
        where = f"{where} AND {fy}" if where else f" WHERE {fy}"
        total = await self.scalar(f"SELECT count(*) FROM {t.LABOR_SUMMARY}{where}", params)
        rows = await self.rows(
            "SELECT district, pay_period, hours_plan, hours_regular, hours_overtime, labor_cost "
            f"FROM {t.LABOR_SUMMARY}{where}{LABOR_COLUMNS.order_clause(q)} LIMIT :limit OFFSET :offset",
            {**params, "limit": q.limit, "offset": q.offset},
        )
        return [clean(r) for r in rows], int(total or 0)


class FixtureWorkforceRepo:
    as_of = AsOf(source="synthetic")

    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    async def list_labor(self, fiscal_year: int, q: ListQuery) -> tuple[list[dict], int]:
        doc = self.store.get("labor_summary")
        rows = doc["rows"] if fiscal_year == doc["fiscal_year"] else []
        return LABOR_COLUMNS.apply_in_memory(rows, q)
