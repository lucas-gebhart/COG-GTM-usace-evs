"""CEFMS execution (synthetic): cumulative curve, appropriations, variance by program."""

from __future__ import annotations

from typing import Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.schemas.common import AsOf


class FinancialRepo(Protocol):
    as_of: AsOf

    async def execution_curve(self, fiscal_year: int) -> list[dict]: ...
    async def by_appropriation(self, fiscal_year: int) -> list[dict]: ...
    async def fiscal_years(self) -> list[int]: ...


class PgFinancialRepo(PgBase):
    as_of = AsOf(source="synthetic")

    async def execution_curve(self, fiscal_year: int) -> list[dict]:
        rows = await self.rows(
            "SELECT period, plan_cumulative, obligated_cumulative, expended_cumulative "
            f"FROM {t.CEFMS_EXECUTION} WHERE fiscal_year = :fy ORDER BY period",
            {"fy": fiscal_year},
        )
        return [clean(r) for r in rows]

    async def by_appropriation(self, fiscal_year: int) -> list[dict]:
        rows = await self.rows(
            "SELECT appropriation, title, allotted, committed, obligated, expended, expiring_fy "
            f"FROM {t.CEFMS_APPROPRIATION} WHERE fiscal_year = :fy ORDER BY appropriation",
            {"fy": fiscal_year},
        )
        return [clean(r) for r in rows]

    async def fiscal_years(self) -> list[int]:
        rows = await self.rows(f"SELECT DISTINCT fiscal_year FROM {t.CEFMS_EXECUTION} ORDER BY 1")
        return [int(r["fiscal_year"]) for r in rows]


class FixtureFinancialRepo:
    as_of = AsOf(source="synthetic")

    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    def _doc(self) -> dict:
        return self.store.get("financial_summary")

    async def execution_curve(self, fiscal_year: int) -> list[dict]:
        return self._doc()["execution_curve"] if fiscal_year == self._doc()["fiscal_year"] else []

    async def by_appropriation(self, fiscal_year: int) -> list[dict]:
        return self._doc()["by_appropriation"] if fiscal_year == self._doc()["fiscal_year"] else []

    async def fiscal_years(self) -> list[int]:
        return [int(self._doc()["fiscal_year"])]
