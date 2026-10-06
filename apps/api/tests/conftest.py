"""Test fixtures.

* `client`: fixtures mode, auth disabled (the default local setup).
* `db_client`: SQL mode against `EVS_TEST_DATABASE_URL` (defaults to the Compose PostGIS). The
  module is skipped when the database is unreachable so `uv run pytest -q` stays green offline;
  set `EVS_REQUIRE_DB=1` (the CI `api-db` job does) to turn that skip into a failure.
"""

from __future__ import annotations

import os
import socket
from collections.abc import Iterator
from urllib.parse import urlparse

import pytest
from fastapi.testclient import TestClient

from evs.settings import get_settings


def make_client(**env: str) -> Iterator[TestClient]:
    old = {k: os.environ.get(k) for k in env}
    os.environ.update(env)
    get_settings.cache_clear()
    from evs.main import create_app

    try:
        with TestClient(create_app()) as c:
            yield c
    finally:
        for k, v in old.items():
            if v is None:
                os.environ.pop(k, None)
            else:
                os.environ[k] = v
        get_settings.cache_clear()


@pytest.fixture
def client() -> Iterator[TestClient]:
    yield from make_client(EVS_DATA_MODE="fixtures", EVS_AUTH_DISABLED="true")


def db_urls() -> tuple[str, str]:
    sync_url = os.environ.get("EVS_TEST_DATABASE_URL", "postgresql://evs:evs@localhost:5432/evs")
    return sync_url, sync_url.replace("postgresql://", "postgresql+asyncpg://", 1)


def db_reachable() -> bool:
    u = urlparse(db_urls()[0])
    try:
        with socket.create_connection((u.hostname or "localhost", u.port or 5432), timeout=1):
            return True
    except OSError:
        return False


def require_db() -> None:
    if not db_reachable():
        if os.environ.get("EVS_REQUIRE_DB"):
            pytest.fail("EVS_REQUIRE_DB is set but the test database is unreachable")
        pytest.skip("test database unreachable; start it with `make up` or docker run postgis/postgis:17-3.5")


@pytest.fixture(scope="session")
def migrated_db() -> tuple[str, str]:
    require_db()
    from evs.db.migrate import run as migrate

    sync_url, async_url = db_urls()
    migrate(sync_url)
    seed_db(sync_url)
    return sync_url, async_url


def seed_db(sync_url: str, reset: bool = False) -> dict[str, int]:
    """WP2's `evs seed` (db/seed/evs_seed): public lock/SRP samples plus the synthetic generators."""
    from evs.cli import _seed_package

    _seed_package()
    from evs_seed.run import seed

    return seed(sync_url, reset_first=reset, log=lambda *_: None)


@pytest.fixture
def db_client(migrated_db: tuple[str, str]) -> Iterator[TestClient]:
    sync_url, async_url = migrated_db
    yield from make_client(
        EVS_DATA_MODE="db",
        EVS_AUTH_DISABLED="true",
        EVS_DATABASE_URL=async_url,
        EVS_DATABASE_URL_SYNC=sync_url,
    )
