"""Public datasets: lock status (LPMS via the WP5a worker) and SRP coverage (cited public figures).

Lock rows come from WP2's `evs.lock_current` view over `evs.lock_dim`, `evs.status_eval` and
`evs.lock_status_fact`; `evs seed` loads the captured LPMS baseline (source = fixtures) until the
WP5a worker writes live evaluations. `as_of.source` is taken from the stored row, never hard coded.
"""

from __future__ import annotations

import json
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
    """Reads `evs.lock_current` (WP2 view: dimension + latest status_eval + latest raw poll).

    Only locks with an evaluation are listed, matching `evs dump-fixtures`; `fetched_at` is the
    evaluation time and `source` the evaluation source (fixtures | live | simulated).
    """

    LOCK_SQL = f"""
        SELECT c.lock_id, c.river_code, c.river_name, c.lock_name, c.lock_no, c.river_mile, c.district,
               c.chambers, c.latitude, c.longitude, c.lift_ft, c.chamber_dimensions, c.year_opened, c.owner,
               c.operator, c.status, c.status_reason, c.vessels_queued, c.avg_delay_4h_min,
               c.avg_delay_24h_min, NULL::timestamptz AS last_lockage_at, c.gauge_stage_ft,
               NULL::text AS flood_category, c.active_stoppages, c.source_as_of,
               c.evaluated_at AS fetched_at, c.freshness, c.eval_source AS source,
               c.inputs_used AS status_inputs
        FROM {t.LOCK_CURRENT} c
        WHERE c.evaluated_at IS NOT NULL
    """
    STOPPAGE_SQL = f"""
        SELECT chamber_no, begin_at, end_at, is_scheduled, traffic_stopped, reason_code, hw_cycles
        FROM {t.STOPPAGE} WHERE lock_id = :id AND traffic_stopped AND (end_at IS NULL OR end_at > now())
        ORDER BY begin_at DESC LIMIT 20
    """

    async def list_locks(self, river_code: str | None) -> dict:
        where = " AND c.river_code = :rc" if river_code else ""
        rows = await self.rows(
            self.LOCK_SQL + where + " ORDER BY c.river_code, c.river_mile NULLS LAST, c.lock_no",
            {"rc": river_code},
        )
        return _lock_payload([_lock_row(r) for r in rows])

    async def get_lock(self, lock_id: str) -> dict | None:
        row = await self.one(self.LOCK_SQL + " AND c.lock_id = :id", {"id": lock_id})
        if row is None:
            return None
        out = _lock_row(row)
        out["stoppages"] = [clean(s) for s in await self.rows(self.STOPPAGE_SQL, {"id": lock_id})]
        return out

    async def srp_coverage(self) -> dict:
        snaps = await self.rows(
            "SELECT year, river_systems, dams, river_miles, floodplain_acres, source, source_url, headline, "
            f"source_as_of, fetched_at FROM {t.SRP_SNAPSHOT} ORDER BY year"
        )
        sites = await self.rows(
            "SELECT name, river, state, district, nid_id, latitude, longitude, year_joined, source_url "
            f"FROM {t.SRP_SITE} ORDER BY year_joined, name"
        )
        snaps = [clean(s) for s in snaps]
        sites = [clean(s) for s in sites]
        latest = snaps[-1] if snaps else {}
        headline = {
            "river_systems": latest.get("river_systems") or len({s["river"] for s in sites}),
            "river_miles": latest.get("river_miles") or 0,
            "dams_and_reservoirs": latest.get("dams") or 0,
            "floodplain_acres": latest.get("floodplain_acres") or 0,
            **{k: v for k, v in (_json(latest.get("headline")) or {}).items()},
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


def _json(v: Any) -> Any:
    """asyncpg hands jsonb back decoded; the text() path can still yield a string."""
    return json.loads(v) if isinstance(v, str) else v


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
        status_inputs=_json(r.get("status_inputs")) or {},
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
