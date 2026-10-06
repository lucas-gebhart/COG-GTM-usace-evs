"""Async SQLAlchemy engine shared by the repositories.

The same `EVS_DATABASE_URL` works against the Compose PostGIS container, Fly Postgres and
Aurora PostgreSQL. Only raw SQL via `text()` is used; there are no ORM models.
"""

from __future__ import annotations

import logging

from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine

from evs.settings import Settings

log = logging.getLogger("evs.db")


def make_engine(settings: Settings) -> AsyncEngine:
    return create_async_engine(
        settings.database_url,
        pool_pre_ping=True,
        pool_size=5,
        max_overflow=5,
        connect_args={"timeout": settings.database_connect_timeout_s},
    )


async def probe(engine: AsyncEngine) -> bool:
    """True when a connection can be opened and the `evs` schema exists."""
    try:
        async with engine.connect() as conn:
            row = await conn.execute(
                text("SELECT 1 FROM information_schema.schemata WHERE schema_name = 'evs'")
            )
            return row.first() is not None
    except Exception as exc:  # noqa: BLE001 - any driver error means "unreachable"
        log.warning("database unreachable (%s): %s", type(exc).__name__, exc)
        return False
