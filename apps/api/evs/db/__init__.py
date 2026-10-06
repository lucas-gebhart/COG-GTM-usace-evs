"""Database access. Async SQLAlchemy engine over asyncpg; plain SQL migrations in /db/migrations."""

from collections.abc import AsyncIterator
from functools import lru_cache

from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from evs.settings import get_settings


@lru_cache
def engine():
    return create_async_engine(get_settings().database_url, pool_pre_ping=True)


@lru_cache
def session_factory() -> async_sessionmaker[AsyncSession]:
    return async_sessionmaker(engine(), expire_on_commit=False)


async def get_session() -> AsyncIterator[AsyncSession]:
    async with session_factory()() as session:
        yield session
