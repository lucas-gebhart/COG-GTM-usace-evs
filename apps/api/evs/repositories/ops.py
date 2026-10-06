"""Feed health and status engine thresholds (Administrator scheme)."""

from __future__ import annotations

from datetime import UTC, datetime
from typing import Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.settings import Settings, get_settings

THRESHOLD_KEYS = ("stale_after_minutes", "delay_yellow_minutes", "delay_red_minutes", "queue_yellow_vessels")


class OpsRepo(Protocol):
    async def feeds(self) -> list[dict]: ...
    async def get_thresholds(self) -> dict: ...
    async def put_thresholds(self, values: dict, actor: str) -> dict: ...


def settings_thresholds(s: Settings) -> dict:
    return {k: getattr(s, k) for k in THRESHOLD_KEYS} | {
        "source": "settings",
        "updated_at": None,
        "updated_by": None,
    }


class PgOpsRepo(PgBase):
    def __init__(self, engine, settings: Settings) -> None:  # noqa: ANN001
        super().__init__(engine)
        self.settings = settings

    async def feeds(self) -> list[dict]:
        rows = await self.rows(
            f"SELECT source, endpoint, cadence_minutes, last_success_at, last_error, latency_ms, status "
            f"FROM {t.FEED_HEALTH} ORDER BY cadence_minutes, source"
        )
        return [clean(r) for r in rows]

    async def get_thresholds(self) -> dict:
        rows = await self.rows(f"SELECT key, value, updated_at, updated_by FROM {t.THRESHOLD}")
        out = settings_thresholds(self.settings)
        if rows:
            out["source"] = "db"
            for r in rows:
                if r["key"] in THRESHOLD_KEYS:
                    out[r["key"]] = int(r["value"])
            newest = max(rows, key=lambda r: r["updated_at"])
            out["updated_at"], out["updated_by"] = newest["updated_at"], newest["updated_by"]
        return out

    async def put_thresholds(self, values: dict, actor: str) -> dict:
        await self.execute(
            [
                (
                    f"UPDATE {t.THRESHOLD} SET value = :value, updated_at = now(), updated_by = :actor "
                    "WHERE key = :key",
                    {"key": k, "value": int(values[k]), "actor": actor},
                )
                for k in THRESHOLD_KEYS
            ]
        )
        return await self.get_thresholds()


class FixtureOpsRepo:
    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    async def feeds(self) -> list[dict]:
        return self.store.get("feeds")

    async def get_thresholds(self) -> dict:
        return dict(self.store.thresholds or settings_thresholds(get_settings()))

    async def put_thresholds(self, values: dict, actor: str) -> dict:
        self.store.thresholds = {k: int(values[k]) for k in THRESHOLD_KEYS} | {
            "source": "fixtures",
            "updated_at": datetime.now(UTC),
            "updated_by": actor,
        }
        return dict(self.store.thresholds)
