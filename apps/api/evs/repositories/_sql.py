"""Small helpers shared by the Postgres repositories."""

from __future__ import annotations

import logging
from typing import Any

from fastapi import HTTPException, status
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError, OperationalError
from sqlalchemy.ext.asyncio import AsyncEngine

log = logging.getLogger("evs.repositories")


class PgBase:
    def __init__(self, engine: AsyncEngine) -> None:
        self.engine = engine

    async def rows(self, sql: str, params: dict[str, Any] | None = None) -> list[dict[str, Any]]:
        try:
            async with self.engine.connect() as conn:
                result = await conn.execute(text(sql), params or {})
                return [dict(r) for r in result.mappings().all()]
        except (OperationalError, OSError, DBAPIError) as exc:
            log.warning("query failed (%s): %s", type(exc).__name__, exc)
            raise HTTPException(status.HTTP_503_SERVICE_UNAVAILABLE, "database unavailable") from exc

    async def one(self, sql: str, params: dict[str, Any] | None = None) -> dict[str, Any] | None:
        out = await self.rows(sql, params)
        return out[0] if out else None

    async def scalar(self, sql: str, params: dict[str, Any] | None = None) -> Any:
        row = await self.one(sql, params)
        return next(iter(row.values())) if row else None

    async def execute(self, statements: list[tuple[str, dict[str, Any]]]) -> list[dict[str, Any]]:
        """Run statements in one transaction; returns rows of the last statement."""
        try:
            async with self.engine.begin() as conn:
                last: list[dict[str, Any]] = []
                for sql, params in statements:
                    result = await conn.execute(text(sql), params)
                    last = [dict(r) for r in result.mappings().all()] if result.returns_rows else []
                return last
        except (OperationalError, OSError, DBAPIError) as exc:
            log.warning("query failed (%s): %s", type(exc).__name__, exc)
            raise HTTPException(status.HTTP_503_SERVICE_UNAVAILABLE, "database unavailable") from exc


def num(v: Any) -> Any:
    """asyncpg returns Decimal for numeric columns; Pydantic accepts them but JSON wants floats."""
    from decimal import Decimal

    return float(v) if isinstance(v, Decimal) else v


def clean(row: dict[str, Any]) -> dict[str, Any]:
    return {k: num(v) for k, v in row.items()}
