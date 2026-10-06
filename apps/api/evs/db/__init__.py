"""Database access. Async SQLAlchemy engine over asyncpg; plain SQL migrations in /db/migrations."""

from collections.abc import AsyncIterator
from functools import lru_cache

from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.pool import NullPool

from evs.settings import get_settings


@lru_cache
def engine():
    # NullPool: asyncpg connections are bound to the event loop that opened them; FastAPI's TestClient and
    # the SSE generator run on different loops, so pooled connections would be reused across loops.
    # Aurora / RDS Proxy pools server side in GovCloud.
    return create_async_engine(get_settings().database_url, poolclass=NullPool)


@lru_cache
def session_factory() -> async_sessionmaker[AsyncSession]:
    return async_sessionmaker(engine(), expire_on_commit=False)


async def get_session() -> AsyncIterator[AsyncSession]:
    async with session_factory()() as session:
        yield session
