"""Public datasets: lock status (LPMS via the WP5a worker) and SRP coverage (cited public figures).

Lock rows in the database are written by the ingestion worker (`evs.lock_status_fact`, one row per
lock per evaluation). Until WP5a lands, the `evs seed` command loads the fixture snapshot so the
SQL path is exercised; `as_of.source` is taken from the stored row, never hard coded here.
"""

from __future__ import annotations

from typing import Any, Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.schemas.common import AsOf

LOCK_STATUSES = ("operating", "delayed", "closed", "stale", "unknown")


class PublicRepo(Protocol):
    async def list_locks(self, river_code: str | None) -> dict: ...
    async def get_lock(self, lock_id: str) -> dict | None: ...
    async def srp_coverage(self) -> dict: ...


def _lock_payload(items: list[dict]) -> dict:
    rivers = sorted({(i["river_code"], i["river_name"]) for i in items})
    counts = {s: 0 for s in LOCK_STATUSES}
    for i in items:
        counts[i["status"]] = counts.get(i["status"], 0) + 1
    newest = max((i["as_of"]["source_as_of"] for i in items if i["as_of"].get("source_as_of")), default=None)
    fetched = max((i["as_of"]["fetched_at"] for i in items if i["as_of"].get("fetched_at")), default=None)
    freshness = "stale" if any(i["as_of"].get("freshness") == "stale" for i in items) else "fresh"
    source = items[0]["as_of"]["source"] if items else "fixtures"
    return {
        "items": items,
        "rivers": [{"code": c, "name": n} for c, n in rivers],
        "counts": counts,
        "as_of": AsOf(
            source_as_of=newest, fetched_at=fetched, freshness=freshness, source=source
        ).model_dump(),
    }


class PgPublicRepo(PgBase):
    LOCK_SQL = f"""
        SELECT d.lock_id, d.river_code, d.river_name, d.lock_name, d.lock_no, d.river_mile, d.district,
               d.chambers, d.latitude, d.longitude, d.lift_ft, d.chamber_dimensions, d.year_opened, d.owner,
               d.operator, f.status, f.status_reason, f.vessels_queued, f.avg_delay_4h_min,
               f.avg_delay_24h_min, f.last_lockage_at, f.gauge_stage_ft, f.flood_category, f.active_stoppages,
               f.source_as_of, f.fetched_at, f.freshness, f.source, f.status_inputs, f.queue, f.stoppages,
               f.recent_lockages
        FROM {t.LOCK_DIM} d
        LEFT JOIN LATERAL (
            SELECT * FROM {t.LOCK_STATUS} s WHERE s.lock_id = d.lock_id ORDER BY s.fetched_at DESC LIMIT 1
        ) f ON true
    """

    async def list_locks(self, river_code: str | None) -> dict:
        where = " WHERE d.river_code = :rc" if river_code else ""
        rows = await self.rows(
            self.LOCK_SQL + where + " ORDER BY d.river_code, d.river_mile", {"rc": river_code}
        )
        return _lock_payload([_lock_row(r) for r in rows])

    async def get_lock(self, lock_id: str) -> dict | None:
        row = await self.one(self.LOCK_SQL + " WHERE d.lock_id = :id", {"id": lock_id})
        return _lock_row(row) if row else None

    async def srp_coverage(self) -> dict:
        snaps = await self.rows(f"SELECT * FROM {t.SRP_SNAPSHOT} ORDER BY year")
        sites = await self.rows(f"SELECT * FROM {t.SRP_SITE} ORDER BY name")
        snaps = [clean(s) for s in snaps]
        sites = [clean(s) for s in sites]
        latest = snaps[-1] if snaps else {}
        headline = {
            "river_systems": latest.get("river_systems") or len({s["river"] for s in sites}),
            "river_miles": latest.get("river_miles") or 0,
            "dams_and_reservoirs": latest.get("dams") or 0,
            "floodplain_acres": latest.get("floodplain_acres") or 0,
            **{k: v for k, v in (latest.get("headline") or {}).items()},
        }
        as_of = AsOf(
            source_as_of=latest.get("source_as_of"),
            fetched_at=latest.get("fetched_at"),
            source="cited-public",
        )
        return {
            "snapshots": [{k: v for k, v in s.items() if k in SNAPSHOT_KEYS} for s in snaps],
            "sites": [{k: v for k, v in s.items() if k in SITE_KEYS} for s in sites],
            "headline": headline,
            "as_of": as_of.model_dump(),
        }


SNAPSHOT_KEYS = {"year", "river_systems", "dams", "river_miles", "floodplain_acres", "source", "source_url"}
SITE_KEYS = {
    "name",
    "river",
    "state",
    "district",
    "nid_id",
    "latitude",
    "longitude",
    "year_joined",
    "source_url",
}


def _lock_row(r: dict[str, Any]) -> dict:
    r = clean(r)
    status = r.get("status") or "unknown"
    out = {k: v for k, v in r.items() if k not in {"source_as_of", "fetched_at", "freshness", "source"}}
    out.update(
        status=status,
        status_reason=r.get("status_reason") or "No evaluation stored yet",
        active_stoppages=r.get("active_stoppages") or 0,
        queue=r.get("queue") or [],
        stoppages=r.get("stoppages") or [],
        recent_lockages=r.get("recent_lockages") or [],
        status_inputs=r.get("status_inputs") or {},
        as_of=AsOf(
            source_as_of=r.get("source_as_of"),
            fetched_at=r.get("fetched_at"),
            freshness=r.get("freshness") or ("stale" if status == "unknown" else "fresh"),
            source=r.get("source") or "fixtures",
        ).model_dump(),
    )
    return out


class FixturePublicRepo:
    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    async def list_locks(self, river_code: str | None) -> dict:
        data = self.store.get("locks")
        if river_code:
            return _lock_payload([i for i in data["items"] if i["river_code"] == river_code])
        return data

    async def get_lock(self, lock_id: str) -> dict | None:
        return next((i for i in self.store.get("locks")["items"] if i["lock_id"] == lock_id), None)

    async def srp_coverage(self) -> dict:
        return self.store.get("srp")
