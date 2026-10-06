"""Repository layer: one object per data domain, in database mode or fixtures mode.

`EVS_DATA_MODE` selects the backing store:

* `auto` (default): probe `EVS_DATABASE_URL` at startup; use SQL when reachable, otherwise log a
  warning and serve fixtures.
* `db`: SQL only. Requests fail with 503 when the database is down.
* `fixtures`: never open a connection (CI unit job, contract generation).

Routers obtain the container with `Depends(get_repos)`.
"""

from __future__ import annotations

import logging
from dataclasses import dataclass
from typing import Literal

from fastapi import FastAPI, Request
from sqlalchemy.ext.asyncio import AsyncEngine

from evs.db.pool import make_engine, probe
from evs.repositories import facilities, financial, ops, portfolio, public, workforce
from evs.repositories.fixture_store import FixtureStore
from evs.settings import Settings, get_settings

log = logging.getLogger("evs.repositories")

Mode = Literal["db", "fixtures"]


@dataclass
class Repositories:
    mode: Mode
    portfolio: portfolio.PortfolioRepo
    financial: financial.FinancialRepo
    workforce: workforce.WorkforceRepo
    facilities: facilities.FacilitiesRepo
    public: public.PublicRepo
    ops: ops.OpsRepo
    engine: AsyncEngine | None = None

    async def close(self) -> None:
        if self.engine is not None:
            await self.engine.dispose()


def fixture_repositories() -> Repositories:
    store = FixtureStore()
    return Repositories(
        mode="fixtures",
        portfolio=portfolio.FixturePortfolioRepo(store),
        financial=financial.FixtureFinancialRepo(store),
        workforce=workforce.FixtureWorkforceRepo(store),
        facilities=facilities.FixtureFacilitiesRepo(store),
        public=public.FixturePublicRepo(store),
        ops=ops.FixtureOpsRepo(store),
    )


def db_repositories(engine: AsyncEngine, settings: Settings) -> Repositories:
    return Repositories(
        mode="db",
        portfolio=portfolio.PgPortfolioRepo(engine),
        financial=financial.PgFinancialRepo(engine),
        workforce=workforce.PgWorkforceRepo(engine),
        facilities=facilities.PgFacilitiesRepo(engine),
        public=public.PgPublicRepo(engine),
        ops=ops.PgOpsRepo(engine, settings),
        engine=engine,
    )


async def build_repositories(settings: Settings) -> Repositories:
    if settings.data_mode == "fixtures":
        log.info("EVS_DATA_MODE=fixtures: serving apps/api/fixtures")
        return fixture_repositories()
    engine = make_engine(settings)
    if await probe(engine):
        log.info("EVS_DATA_MODE=%s: database reachable, serving SQL", settings.data_mode)
        return db_repositories(engine, settings)
    if settings.data_mode == "db":
        log.error(
            "EVS_DATA_MODE=db but %s is unreachable; requests will fail", _redact(settings.database_url)
        )
        return db_repositories(engine, settings)
    await engine.dispose()
    log.warning(
        "EVS_DATA_MODE=auto: database %s unreachable, falling back to fixtures",
        _redact(settings.database_url),
    )
    return fixture_repositories()


def _redact(url: str) -> str:
    if "@" in url:
        scheme, rest = url.split("://", 1)
        return f"{scheme}://***@{rest.split('@', 1)[1]}"
    return url


async def install(app: FastAPI, settings: Settings) -> Repositories:
    repos = await build_repositories(settings)
    app.state.repos = repos
    return repos


async def get_repos(request: Request) -> Repositories:
    """Repositories built by the lifespan; built lazily for TestClient uses without a context manager."""
    repos = getattr(request.app.state, "repos", None)
    if repos is None:
        repos = await install(request.app, get_settings())
    return repos


__all__ = [
    "Repositories",
    "build_repositories",
    "fixture_repositories",
    "db_repositories",
    "get_repos",
    "install",
]
