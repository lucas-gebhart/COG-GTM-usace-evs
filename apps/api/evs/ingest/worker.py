"""Ingestion worker: poll the public feeds, persist facts with as-of metadata, evaluate the 11 status rules,
record feed health and NOTIFY the API. One class, three cycles (gis daily, gauges 30 min, lpms 15 min).

Modes (EVS_FEED_SOURCE): live polls the public endpoints; fixtures replays legacy/data_samples; simulated runs
the labelled Markov simulator. Live switches itself to simulated after LPMS has failed for
lpms_failover_hours.
"""

import json
import logging
import os
import time
from dataclasses import dataclass
from datetime import UTC, datetime, timedelta
from pathlib import Path

import psycopg
from psycopg.types.json import Jsonb

from evs.ingest import gis, lpms, noaa, ntni, usgs
from evs.ingest.archive import RawArchive
from evs.ingest.gauges import BY_LOCK, USGS_SITES
from evs.ingest.http import FeedClient, FetchResult
from evs.ingest.simulator import simulate_cycle
from evs.ingest.status_engine import StatusInputs, StatusResult, Thresholds, evaluate
from evs.settings import Settings

log = logging.getLogger(__name__)
CADENCE = {"lpms": 15, "gauges": 30, "gis": 1440}
LPMS_STATUS, LPMS_DELAY, LPMS_STOP = (
    "LPMS lock_status_report",
    "LPMS lock_delay_json",
    "LPMS stall_stoppage_json",
)
LPMS_QUEUE, LPMS_TRAFFIC, LPMS_NTNI = "LPMS lock_queue_json", "LPMS traffic_report", "NTNI notices"
GIS_LOCKS, NOAA_GAUGES, USGS_IV, SIMULATOR = "NDC GIS Locks", "NOAA NWPS gauges", "USGS NWIS IV", "Simulator"
FIXTURES = {
    LPMS_STATUS: "lpms/lock_status_report_ALL.json",
    LPMS_DELAY: "lpms/lock_delay.json",
    LPMS_STOP: "lpms/stall_stoppage.json",
    GIS_LOCKS: "gis/usace_locks_full.geojson",
    NOAA_GAUGES: "noaa/gauges_bbox.json",
    USGS_IV: "usgs/iv_03303280.json",
}


def default_samples_dir() -> Path:
    for candidate in (
        Path(__file__).resolve().parents[4] / "legacy" / "data_samples",
        Path("/legacy/data_samples"),
    ):
        if candidate.is_dir():
            return candidate
    return Path("legacy/data_samples")


@dataclass
class Fetched:
    text: str | None
    fetched_at: datetime
    server_date: datetime | None
    from_cache: bool
    result: FetchResult | None
    error: str | None = None

    @property
    def ok(self) -> bool:
        return self.text is not None


class IngestWorker:
    def __init__(self, settings: Settings, conn: psycopg.Connection | None = None) -> None:
        self.settings = settings
        self.mode = settings.feed_source
        self.conn = conn or psycopg.connect(settings.database_url_sync, autocommit=True)
        self.client = FeedClient(settings.http_timeout_s, settings.http_retries, settings.ingest_user_agent)
        self.archive = (
            RawArchive(
                settings.s3_endpoint,
                settings.s3_bucket,
                settings.s3_access_key,
                settings.s3_secret_key,
                settings.s3_region,
            )
            if self.mode == "live"
            else None
        )
        self.samples = Path(
            settings.samples_dir or os.environ.get("EVS_SAMPLES_DIR") or default_samples_dir()
        )
        self.lpms_urls = lpms.LpmsEndpoints(settings.lpms_base_url)
        self.thresholds = self._load_thresholds()

    # ---------------------------------------------------------------- infrastructure
    def _load_thresholds(self) -> Thresholds:
        base = Thresholds.from_settings(self.settings)
        try:
            rows = dict(self.conn.execute("SELECT key, value FROM evs.threshold").fetchall())
        except psycopg.Error:
            return base
        return base.with_overrides({k: float(v) for k, v in rows.items()})

    def fixture(self, name: str) -> Fetched:
        path = self.samples / name
        now = datetime.now(UTC)
        if not path.exists():
            return Fetched(None, now, None, False, None, f"no fixture {name}")
        return Fetched(path.read_text(), now, None, False, None)

    def fetch(
        self,
        source: str,
        url: str,
        archive_key: str | None = None,
        fixture: str | None = None,
        timeout: float | None = None,
    ) -> Fetched:
        """Live GET with raw archival and last-good fallback, or fixture replay."""
        if self.mode != "live":
            return self.fixture(fixture or FIXTURES.get(source, ""))
        res = self.client.get(url, timeout=timeout)
        if res.text and self.archive and archive_key:
            self.archive.put(RawArchive.key(*archive_key.split("/", 1), res.fetched_at), res.text)
        if res.ok:
            self.conn.execute(
                "INSERT INTO evs.feed_cache (source, fetched_at, payload) VALUES (%s, %s, %s) "
                "ON CONFLICT (source) DO UPDATE SET fetched_at = EXCLUDED.fetched_at, "
                "payload = EXCLUDED.payload",
                (
                    source,
                    res.fetched_at,
                    Jsonb(
                        {
                            "url": url,
                            "text": res.text,
                            "server_date": res.server_date.isoformat() if res.server_date else None,
                        }
                    ),
                ),
            )
            return Fetched(res.text, res.fetched_at, res.server_date, False, res)
        cached = self.conn.execute(
            "SELECT fetched_at, payload FROM evs.feed_cache WHERE source = %s", (source,)
        ).fetchone()
        if cached:
            log.warning("%s failed (%s); using last good payload from %s", source, res.error, cached[0])
            sd = cached[1].get("server_date")
            return Fetched(
                cached[1]["text"], cached[0], datetime.fromisoformat(sd) if sd else None, True, res, res.error
            )
        return Fetched(None, res.fetched_at, None, False, res, res.error)

    def health(
        self,
        source: str,
        endpoint: str,
        cadence: int,
        fetched: Fetched | None,
        rows: int | None,
        error: str | None = None,
        mode: str | None = None,
        status: str | None = None,
    ) -> None:
        mode = mode or self.mode
        res = fetched.result if fetched else None
        err = error or (fetched.error if fetched else None)
        ok = fetched.ok and not fetched.from_cache if fetched else err is None
        if status is None:
            if mode == "fixtures":
                status = "fixtures"
            elif mode == "simulated":
                status = "simulated"
            elif ok:
                status = "healthy"
            elif fetched is not None and fetched.ok:
                status = "degraded"
            else:
                status = "down"
        self.conn.execute(
            """
            INSERT INTO evs.feed_health (source, endpoint, cadence_minutes, mode, last_attempt_at,
                                         last_success_at, last_error, latency_ms, http_status, rows_parsed,
                                         consecutive_failures, status)
            VALUES (%(s)s, %(e)s, %(c)s, %(m)s, now(), CASE WHEN %(ok)s THEN now() END, %(err)s, %(lat)s,
                    %(http)s,
                    %(rows)s, CASE WHEN %(ok)s THEN 0 ELSE 1 END, %(st)s)
            ON CONFLICT (source) DO UPDATE SET
              endpoint = EXCLUDED.endpoint, cadence_minutes = EXCLUDED.cadence_minutes, mode = EXCLUDED.mode,
              last_attempt_at = now(),
              last_success_at = COALESCE(EXCLUDED.last_success_at, evs.feed_health.last_success_at),
              last_error = EXCLUDED.last_error, latency_ms = EXCLUDED.latency_ms,
              http_status = EXCLUDED.http_status,
              rows_parsed = COALESCE(EXCLUDED.rows_parsed, evs.feed_health.rows_parsed),
              consecutive_failures = CASE WHEN %(ok)s THEN 0
                                          ELSE evs.feed_health.consecutive_failures + 1 END,
              status = EXCLUDED.status, updated_at = now()
            """,
            {
                "s": source,
                "e": endpoint,
                "c": cadence,
                "m": mode,
                "ok": bool(ok),
                "err": err,
                "lat": res.latency_ms if res else None,
                "http": res.status_code if res else None,
                "rows": rows,
                "st": status,
            },
        )

    def last_success(self, source: str) -> datetime | None:
        row = self.conn.execute(
            "SELECT last_success_at FROM evs.feed_health WHERE source = %s", (source,)
        ).fetchone()
        return row[0] if row else None

    def lpms_failed_for(self) -> timedelta | None:
        row = self.conn.execute(
            "SELECT last_success_at, last_attempt_at, consecutive_failures FROM evs.feed_health "
            "WHERE source = %s",
            (LPMS_STATUS,),
        ).fetchone()
        if not row or not row[2]:
            return None
        anchor = row[0] or (row[1] - timedelta(hours=self.settings.lpms_failover_hours))
        return datetime.now(UTC) - anchor

    # ---------------------------------------------------------------- GIS (daily)
    def run_gis(self) -> int:
        fetched = self.fetch(GIS_LOCKS, self.settings.gis_locks_url, "gis/locks")
        rows: list[gis.LockDim] = []
        error = None
        if fetched.ok:
            try:
                rows = gis.parse_locks_geojson(fetched.text)
            except (ValueError, KeyError) as exc:
                error = f"parse: {exc}"
        self.health(GIS_LOCKS, self.settings.gis_locks_url, CADENCE["gis"], fetched, len(rows) or None, error)
        for d in rows:
            self.upsert_lock_dim(d, source=self.mode if self.mode != "live" else "live")
        return len(rows)

    def upsert_lock_dim(self, d: gis.LockDim, source: str, keep_geom: bool = False) -> None:
        self.conn.execute(
            """
            INSERT INTO evs.lock_dim (lock_id, river_code, lock_no, river_name, lock_name, river_mile,
                                      district, division, state, town, chambers, lift_ft, chamber_dimensions,
                                      year_opened, owner, operator,
                                      geom, geom_source, source)
            VALUES (%(id)s, %(rc)s, %(no)s, %(rn)s, COALESCE(%(ln)s, %(id)s), %(mi)s, %(di)s, %(dv)s, %(st)s,
                    %(tw)s, %(ch)s, %(lf)s,
                    %(cd)s, %(yr)s, %(ow)s, %(op)s,
                    CASE WHEN %(lat)s::float8 IS NULL THEN NULL
                         ELSE ST_SetSRID(ST_MakePoint(%(lon)s::float8, %(lat)s::float8), 4326) END,
                    %(gs)s, %(src)s)
            ON CONFLICT (lock_id) DO UPDATE SET
              river_name = COALESCE(EXCLUDED.river_name, evs.lock_dim.river_name),
              lock_name = COALESCE(EXCLUDED.lock_name, evs.lock_dim.lock_name),
              river_mile = COALESCE(EXCLUDED.river_mile, evs.lock_dim.river_mile),
              district = COALESCE(EXCLUDED.district, evs.lock_dim.district),
              division = COALESCE(EXCLUDED.division, evs.lock_dim.division),
              state = COALESCE(EXCLUDED.state, evs.lock_dim.state),
              town = COALESCE(EXCLUDED.town, evs.lock_dim.town),
              chambers = COALESCE(EXCLUDED.chambers, evs.lock_dim.chambers),
              lift_ft = COALESCE(EXCLUDED.lift_ft, evs.lock_dim.lift_ft),
              chamber_dimensions = COALESCE(EXCLUDED.chamber_dimensions, evs.lock_dim.chamber_dimensions),
              year_opened = COALESCE(EXCLUDED.year_opened, evs.lock_dim.year_opened),
              owner = COALESCE(EXCLUDED.owner, evs.lock_dim.owner),
              operator = COALESCE(EXCLUDED.operator, evs.lock_dim.operator),
              geom = CASE WHEN %(keep)s AND evs.lock_dim.geom IS NOT NULL THEN evs.lock_dim.geom
                          ELSE COALESCE(EXCLUDED.geom, evs.lock_dim.geom) END,
              geom_source = CASE WHEN %(keep)s AND evs.lock_dim.geom IS NOT NULL THEN evs.lock_dim.geom_source
                                 ELSE COALESCE(EXCLUDED.geom_source, evs.lock_dim.geom_source) END,
              source = EXCLUDED.source, updated_at = now()
            """,
            {
                "id": d.lock_id,
                "rc": d.river_code,
                "no": d.lock_no,
                "rn": d.river_name,
                "ln": d.lock_name,
                "mi": d.river_mile,
                "di": d.district,
                "dv": d.division,
                "st": d.state,
                "tw": d.town,
                "ch": d.chambers,
                "lf": d.lift_ft,
                "cd": d.chamber_dimensions,
                "yr": d.year_opened,
                "ow": d.owner,
                "op": d.operator,
                "lat": d.latitude,
                "lon": d.longitude,
                "gs": d.geom_source if d.latitude is not None else None,
                "src": source,
                "keep": keep_geom,
            },
        )

    def lock_dims(self) -> dict[str, dict]:
        cur = self.conn.execute(
            "SELECT lock_id, river_code, lock_no, river_name, lock_name, district, chambers, ST_Y(geom), "
            "ST_X(geom), eroc "
            "FROM evs.lock_dim"
        )
        cols = [
            "lock_id",
            "river_code",
            "lock_no",
            "river_name",
            "lock_name",
            "district",
            "chambers",
            "latitude",
            "longitude",
            "eroc",
        ]
        return {r[0]: dict(zip(cols, r, strict=True)) for r in cur.fetchall()}

    def river_names(self) -> dict[str, str]:
        names: dict[str, str] = {}
        path = self.samples / "lpms/lookup_river_codes.json"
        if path.exists():
            for row in lpms.parse_lookup_csv(path.read_text()):
                if row.get("RIVER_CODE"):
                    names[row["RIVER_CODE"]] = row.get("RIVER_NAME", "").title()
        return names

    # ---------------------------------------------------------------- gauges (30 min)
    def run_gauges(self) -> dict[str, int]:
        now = datetime.now(UTC)
        source = "live" if self.mode == "live" else self.mode
        counts = {"noaa": 0, "usgs": 0, "noaa_detail": 0}
        pairings = [p for p in BY_LOCK.values() if p.lid]
        url = noaa.region_url(self.settings.noaa_base_url)
        # The regional list is about 7 MB and NWPS streams it slowly; give it a longer read timeout.
        fetched = self.fetch(
            NOAA_GAUGES, url, "noaa/gauges", timeout=max(self.settings.http_timeout_s, 120.0)
        )
        gauges: dict[str, noaa.NwpsGauge] = {}
        error = None
        if fetched.ok:
            try:
                gauges = noaa.parse_gauge_list(fetched.text)
            except (ValueError, KeyError) as exc:
                error = f"parse: {exc}"
        if self.mode != "live":
            for path in sorted(self.samples.glob("noaa/gauge_*.json")):
                try:
                    g = noaa.parse_gauge(path.read_text())
                    gauges[g.lid] = g
                except (ValueError, KeyError):
                    continue
        known_categories = self.known_categories()
        if self.mode == "live" and gauges:
            due = [p.lid for p in pairings if p.lid in gauges and p.lid not in known_categories]
            for lid in sorted(set(due))[: self.settings.noaa_detail_budget]:
                det = self.fetch(
                    f"NOAA NWPS gauge {lid}",
                    noaa.gauge_url(self.settings.noaa_base_url, lid),
                    f"noaa/gauge_{lid}",
                )
                if det.ok:
                    try:
                        gauges[lid].categories = noaa.parse_gauge(det.text).categories
                        counts["noaa_detail"] += 1
                    except (ValueError, KeyError):
                        pass
        for p in pairings:
            g = gauges.get(p.lid)
            if g is None:
                continue
            cats = (
                g.categories
                or known_categories.get(p.lid)
                or ({"moderate": p.moderate_stage_ft} if p.moderate_stage_ft else {})
            )
            self.conn.execute(
                """
                INSERT INTO evs.gauge_fact (lock_id, provider, station_id, observed_at, stage_ft, flow_cfs,
                                            flood_category, forecast_category, forecast_at, moderate_stage_ft,
                                            categories, fetched_at, source)
                VALUES (%s, 'noaa', %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    p.lock_id,
                    p.lid,
                    g.observed_at,
                    g.stage_ft,
                    g.flow_kcfs * 1000 if g.flow_kcfs is not None else None,
                    g.flood_category,
                    g.forecast_category,
                    g.forecast_at,
                    cats.get("moderate"),
                    Jsonb(cats),
                    fetched.fetched_at,
                    source,
                ),
            )
            counts["noaa"] += 1
        self.health(NOAA_GAUGES, url, CADENCE["gauges"], fetched, counts["noaa"] or None, error)

        sites = list(USGS_SITES)
        readings: dict[str, usgs.UsgsReading] = {}
        usgs_fetched: Fetched | None = None
        error = None
        for i in range(0, max(len(sites), 1), usgs.MAX_SITES_PER_CALL):
            chunk = sites[i : i + usgs.MAX_SITES_PER_CALL]
            if not chunk:
                break
            usgs_fetched = self.fetch(USGS_IV, usgs.iv_url(self.settings.usgs_iv_url, chunk), "usgs/iv")
            if usgs_fetched.ok:
                try:
                    readings.update(usgs.parse_iv(usgs_fetched.text))
                except (ValueError, KeyError) as exc:
                    error = f"parse: {exc}"
            if self.mode != "live":
                break
        for p in BY_LOCK.values():
            r = readings.get(p.usgs_site) if p.usgs_site else None
            if r is None:
                continue
            self.conn.execute(
                "INSERT INTO evs.gauge_fact (lock_id, provider, station_id, observed_at, stage_ft, flow_cfs, "
                "fetched_at, source) "
                "VALUES (%s, 'usgs', %s, %s, %s, %s, %s, %s)",
                (
                    p.lock_id,
                    p.usgs_site,
                    r.observed_at,
                    r.gage_height_ft,
                    r.discharge_cfs,
                    usgs_fetched.fetched_at if usgs_fetched else now,
                    source,
                ),
            )
            counts["usgs"] += 1
        self.health(
            USGS_IV, self.settings.usgs_iv_url, CADENCE["gauges"], usgs_fetched, counts["usgs"] or None, error
        )
        return counts

    def known_categories(self) -> dict[str, dict]:
        cur = self.conn.execute(
            "SELECT DISTINCT ON (station_id) station_id, categories FROM evs.gauge_fact "
            "WHERE provider = 'noaa' AND categories IS NOT NULL AND categories <> '{}'::jsonb "
            "ORDER BY station_id, fetched_at DESC"
        )
        return {r[0]: r[1] for r in cur.fetchall()}

    def latest_gauges(
        self, max_age_hours: int = 12
    ) -> dict[str, dict[str, noaa.NwpsGauge | usgs.UsgsReading]]:
        cur = self.conn.execute(
            """
            SELECT DISTINCT ON (lock_id, provider) lock_id, provider, station_id, observed_at, stage_ft,
                   flow_cfs,
                   flood_category, forecast_category, forecast_at, categories
            FROM evs.gauge_fact WHERE fetched_at > now() - make_interval(hours => %s)
            ORDER BY lock_id, provider, fetched_at DESC
            """,
            (max_age_hours,),
        )
        out: dict[str, dict] = {}
        for lock_id, provider, station, obs, stage, flow, cat, fcat, fat, cats in cur.fetchall():
            if provider == "noaa":
                out.setdefault(lock_id, {})["noaa"] = noaa.NwpsGauge(
                    station,
                    None,
                    None,
                    obs,
                    float(stage) if stage is not None else None,
                    float(flow) / 1000 if flow is not None else None,
                    cat,
                    fcat,
                    fat,
                    None,
                    {k: float(v) for k, v in (cats or {}).items()},
                )
            else:
                out.setdefault(lock_id, {})["usgs"] = usgs.UsgsReading(
                    station,
                    None,
                    obs,
                    float(stage) if stage is not None else None,
                    float(flow) if flow is not None else None,
                    True,
                )
        return out

    # ---------------------------------------------------------------- LPMS (15 min)
    def run_lpms(self) -> dict:
        now = datetime.now(UTC)
        mode = self.mode
        failed = self.lpms_failed_for() if mode == "live" else None
        if failed is not None and failed >= timedelta(hours=self.settings.lpms_failover_hours):
            log.warning("LPMS has failed for %s; switching this cycle to the labelled simulator", failed)
            mode = "simulated"
        dims = self.lock_dims()
        if mode == "simulated":
            return self.run_simulated(
                now, dims, reason=f"LPMS failed for {failed}" if failed else "EVS_FEED_SOURCE=simulated"
            )

        f_status = self.fetch(LPMS_STATUS, self.lpms_urls.lock_status, "lpms/lock_status_report")
        f_delay = self.fetch(LPMS_DELAY, self.lpms_urls.lock_delay, "lpms/lock_delay_json")
        f_stop = self.fetch(LPMS_STOP, self.lpms_urls.stall_stoppage, "lpms/stall_stoppage_json")
        status_rows, delay_rows, stoppages = [], [], []
        errors: dict[str, str | None] = {}
        for key, f, parser, target in (
            (LPMS_STATUS, f_status, lpms.parse_lock_status, status_rows),
            (LPMS_DELAY, f_delay, lpms.parse_lock_delay, delay_rows),
            (LPMS_STOP, f_stop, lpms.parse_stoppages, stoppages),
        ):
            errors[key] = None
            if f.ok:
                try:
                    target.extend(parser(f.text))
                except (ValueError, KeyError) as exc:
                    errors[key] = f"parse: {type(exc).__name__}: {exc}"[:300]
        self.health(
            LPMS_STATUS,
            self.lpms_urls.lock_status,
            CADENCE["lpms"],
            f_status,
            len(status_rows) or None,
            errors[LPMS_STATUS],
        )
        self.health(
            LPMS_DELAY,
            self.lpms_urls.lock_delay,
            CADENCE["lpms"],
            f_delay,
            len(delay_rows) or None,
            errors[LPMS_DELAY],
        )
        self.health(
            LPMS_STOP,
            self.lpms_urls.stall_stoppage,
            CADENCE["lpms"],
            f_stop,
            len(stoppages) or None,
            errors[LPMS_STOP],
        )
        if not status_rows and not stoppages:
            log.error("LPMS cycle produced no rows; keeping previous status")
            return {"mode": mode, "locks": 0, "status_rows": 0, "stoppages": 0, "error": f_status.error}

        feed_refresh = lpms.newest_refresh(stoppages) or f_status.server_date or f_stop.server_date
        source = "live" if mode == "live" else mode
        eval_now = now
        if mode == "fixtures":
            anchor = feed_refresh or max((r.entry_at for r in status_rows if r.entry_at), default=now)
            eval_now = anchor + timedelta(minutes=5)
        self.ensure_dims(status_rows, dims, stoppages)
        dims = self.lock_dims()
        notices = self.refresh_notices(status_rows, source)
        queue_counts, lockage_counts = self.run_queue_and_traffic(status_rows, source)
        self.persist_facts(status_rows, delay_rows, stoppages, feed_refresh, f_status.fetched_at, source)
        return self.evaluate_all(
            status_rows,
            delay_rows,
            stoppages,
            dims,
            notices,
            feed_refresh,
            eval_now,
            source,
            {"queue_rows": queue_counts, "lockage_rows": lockage_counts, "feed_refresh_at": feed_refresh},
        )

    def ensure_dims(
        self,
        status_rows: list[lpms.LockStatusRow],
        dims: dict[str, dict],
        stoppages: list[lpms.StoppageRow] | None = None,
    ) -> None:
        """Locks that report to LPMS but are missing from the GIS layer get a lock_dim row from the status
        feed (swapped LPMS coordinates, geom_source lpms-swapped); stoppage-only locks get a row without
        geometry."""
        names = self.river_names()
        source = self.mode if self.mode != "live" else "live"
        for r in status_rows:
            if r.lock_id in dims and dims[r.lock_id]["latitude"] is not None:
                if dims[r.lock_id].get("eroc") != r.eroc and r.eroc:
                    self.conn.execute(
                        "UPDATE evs.lock_dim SET eroc = %s WHERE lock_id = %s", (r.eroc, r.lock_id)
                    )
                continue
            d = gis.LockDim(
                r.lock_id,
                r.river_code,
                r.lock_no,
                names.get(r.river_code, r.river_code),
                r.lock_name,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                r.latitude,
                r.longitude,
                geom_source="lpms-swapped",
            )
            self.upsert_lock_dim(d, source=source, keep_geom=True)
            if r.eroc:
                self.conn.execute("UPDATE evs.lock_dim SET eroc = %s WHERE lock_id = %s", (r.eroc, r.lock_id))
        seen = set(dims) | {r.lock_id for r in status_rows}
        for s in stoppages or []:
            if s.lock_id in seen:
                continue
            seen.add(s.lock_id)
            river, no = s.lock_id.split("-", 1)
            d = gis.LockDim(
                s.lock_id,
                river,
                no,
                names.get(river, river),
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                geom_source="none",
            )
            self.upsert_lock_dim(d, source=source, keep_geom=True)

    def refresh_notices(self, status_rows: list[lpms.LockStatusRow], source: str) -> list[ntni.NtniNotice]:
        wanted = sorted({n for r in status_rows for n in r.ntni_notices})
        cur = self.conn.execute(
            "SELECT notice_no, lock_ids, title, effective_from, effective_to, fetched_at FROM evs.ntni_notice"
        )
        known = {r[0]: r for r in cur.fetchall()}
        fetched_any: Fetched | None = None
        parsed = 0
        for no in wanted:
            k = known.get(no)
            if k and k[5] > datetime.now(UTC) - timedelta(hours=24):
                continue
            f = self.fetch(
                f"NTNI notice {no}",
                ntni.notice_url(self.settings.ntni_base_url, no),
                f"ntni/notice_{no}",
                fixture=f"ntni/notice_{no}.html",
            )
            fetched_any = f
            if not f.ok:
                continue
            n = ntni.parse_notice(f.text, no)
            # The notice page may list more locks than the status row that linked it; include the linker.
            linkers = [r.lock_id for r in status_rows if no in r.ntni_notices]
            lock_ids = sorted(set(n.lock_ids) | set(linkers))
            self.conn.execute(
                "INSERT INTO evs.ntni_notice (notice_no, lock_ids, title, effective_from, effective_to, "
                "fetched_at, source) VALUES (%s, %s, %s, %s, %s, now(), %s) "
                "ON CONFLICT (notice_no) DO UPDATE SET lock_ids = EXCLUDED.lock_ids, title = EXCLUDED.title, "
                "effective_from = EXCLUDED.effective_from, effective_to = EXCLUDED.effective_to, "
                "fetched_at = now(), source = EXCLUDED.source",
                (no, lock_ids, n.title, n.effective_from, n.effective_to, source),
            )
            parsed += 1
        if wanted:
            self.health(LPMS_NTNI, self.settings.ntni_base_url, CADENCE["lpms"], fetched_any, parsed or None)
        cur = self.conn.execute(
            "SELECT notice_no, lock_ids, title, effective_from, effective_to FROM evs.ntni_notice"
        )
        return [ntni.NtniNotice(r[0], list(r[1]), r[2], r[3], r[4]) for r in cur.fetchall()]

    def run_queue_and_traffic(self, status_rows: list[lpms.LockStatusRow], source: str) -> tuple[int, int]:
        rows = (
            status_rows
            if not self.settings.lpms_detail_locks
            else status_rows[: self.settings.lpms_detail_locks]
        )
        q_total, t_total = 0, 0
        last_q: Fetched | None = None
        last_t: Fetched | None = None
        q_err = t_err = None
        for r in rows:
            river, no = r.river_code, r.lock_no.lstrip("0") or "0"
            tag = f"{river}{r.lock_no}"
            fq = self.fetch(
                f"{LPMS_QUEUE} {r.lock_id}",
                self.lpms_urls.lock_queue(river, no),
                f"lpms/lock_queue_{tag}",
                fixture=f"lpms/lock_queue_{tag}.json",
            )
            ft = self.fetch(
                f"{LPMS_TRAFFIC} {r.lock_id}",
                self.lpms_urls.traffic(river, no),
                f"lpms/traffic_{tag}",
                fixture=f"lpms/traffic_{tag}.json",
            )
            if fq.result or fq.ok:
                last_q = fq
            if ft.result or ft.ok:
                last_t = ft
            if fq.ok:
                try:
                    q = lpms.parse_queue(fq.text, r.lock_id)
                    self.conn.execute("DELETE FROM evs.lock_queue WHERE lock_id = %s", (r.lock_id,))
                    with self.conn.cursor() as cur:
                        cur.executemany(
                            "INSERT INTO evs.lock_queue (lock_id, vessel_no, vessel_name, direction, "
                            "num_barges, arrival_at, sol_at, end_of_lockage_at, mmsi, fetched_at, source) "
                            "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                            [
                                (
                                    x.lock_id,
                                    x.vessel_no,
                                    x.vessel_name,
                                    x.direction,
                                    x.num_barges,
                                    x.arrival_at,
                                    x.sol_at,
                                    x.end_of_lockage_at,
                                    x.mmsi,
                                    fq.fetched_at,
                                    source,
                                )
                                for x in q
                                if x.end_of_lockage_at is None
                            ],
                        )
                    q_total += sum(1 for x in q if x.end_of_lockage_at is None)
                except (ValueError, KeyError) as exc:
                    q_err = f"parse {r.lock_id}: {exc}"[:300]
            elif fq.error and "no fixture" not in fq.error:
                q_err = fq.error
            if ft.ok:
                try:
                    t = lpms.parse_traffic(ft.text, r.lock_id)
                    with self.conn.cursor() as cur:
                        cur.executemany(
                            "INSERT INTO evs.lockage (lock_id, vessel_no, vessel_name, direction, "
                            "num_barges, number_processed, "
                            "hazard_code, arrival_at, sol_at, end_of_lockage_at, fetched_at, source) "
                            "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING",
                            [
                                (
                                    x.lock_id,
                                    x.vessel_no,
                                    x.vessel_name,
                                    x.direction,
                                    x.num_barges,
                                    x.number_processed,
                                    x.hazard_code,
                                    x.arrival_at,
                                    x.sol_at,
                                    x.end_of_lockage_at,
                                    ft.fetched_at,
                                    source,
                                )
                                for x in t
                            ],
                        )
                    t_total += len(t)
                except (ValueError, KeyError) as exc:
                    t_err = f"parse {r.lock_id}: {exc}"[:300]
            elif ft.error and "no fixture" not in ft.error:
                t_err = ft.error
            if self.mode == "live":
                time.sleep(0.2)
        self.health(
            LPMS_QUEUE,
            self.lpms_urls.lock_queue("<river>", "<lock>"),
            CADENCE["lpms"],
            last_q,
            q_total,
            q_err,
        )
        self.health(
            LPMS_TRAFFIC, self.lpms_urls.traffic("<river>", "<lock>"), CADENCE["lpms"], last_t, t_total, t_err
        )
        return q_total, t_total

    def persist_facts(self, status_rows, delay_rows, stoppages, feed_refresh, fetched_at, source) -> None:
        delay_by = {d.lock_id: d for d in delay_rows}
        with self.conn.cursor() as cur:
            cur.execute("SELECT evs.ensure_lock_status_partition(%s)", (fetched_at,))
            cur.executemany(
                """
                INSERT INTO evs.lock_status_fact (lock_id, source, source_as_of, feed_refresh_at, polled_at,
                    eroc, upper_gauge_ft, lower_gauge_ft, weather_code, air_temp_f, vessels_queued,
                    total_locking, locked_up_24h, locked_down_24h,
                    avg_delay_4h_min, avg_delay_24h_min, active_stoppages, ntni_notices, notes, raw)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
                """,
                [
                    (
                        r.lock_id,
                        source,
                        r.entry_at,
                        feed_refresh,
                        fetched_at,
                        r.eroc,
                        r.upper_gauge_ft,
                        r.lower_gauge_ft,
                        r.weather_code,
                        r.air_temp_f,
                        r.pending_arrivals,
                        r.locking_now,
                        r.locked_up_24h,
                        r.locked_down_24h,
                        (
                            delay_by[r.lock_id].delay_4h_min
                            if r.lock_id in delay_by and delay_by[r.lock_id].delay_4h_min is not None
                            else r.avg_delay_4h_min
                        ),
                        delay_by[r.lock_id].delay_24h_min if r.lock_id in delay_by else None,
                        None if r.active_stoppage is None else int(r.active_stoppage),
                        r.ntni_notices,
                        r.notes,
                        Jsonb(r.raw),
                    )
                    for r in status_rows
                ],
            )
            cur.executemany(
                """
                INSERT INTO evs.stoppage (lock_id, chamber_no, begin_at, end_at, is_scheduled, reason_code,
                                          traffic_stopped,
                                          hw_cycles, refresh_at, fetched_at, source, raw)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
                ON CONFLICT (lock_id, chamber_no, begin_at, reason_code, source) DO UPDATE SET
                  end_at = EXCLUDED.end_at,
                  is_scheduled = EXCLUDED.is_scheduled, traffic_stopped = EXCLUDED.traffic_stopped,
                  hw_cycles = EXCLUDED.hw_cycles, refresh_at = EXCLUDED.refresh_at,
                  fetched_at = EXCLUDED.fetched_at,
                  raw = EXCLUDED.raw
                """,
                [
                    (
                        s.lock_id,
                        s.chamber_no or "",
                        s.begin_at,
                        s.end_at,
                        s.is_scheduled,
                        s.reason_code or "",
                        s.traffic_stopped,
                        s.hw_cycles,
                        s.refresh_at,
                        fetched_at,
                        source,
                        Jsonb(s.raw),
                    )
                    for s in stoppages
                    if s.begin_at
                ],
            )
        if source == "simulated":
            # stoppages the simulator no longer reports are closed so the active count follows the chain
            open_locks = list({s.lock_id for s in stoppages}) or ["-"]
            for lock_id in open_locks:
                self.conn.execute(
                    "UPDATE evs.stoppage SET end_at = now() WHERE source = 'simulated' AND end_at IS NULL "
                    "AND lock_id = %s "
                    "AND begin_at <> ALL(%s)",
                    (lock_id, [s.begin_at for s in stoppages if s.lock_id == lock_id]),
                )
            self.conn.execute(
                "UPDATE evs.stoppage SET end_at = now() WHERE source = 'simulated' AND end_at IS NULL "
                "AND lock_id <> ALL(%s)",
                (open_locks,),
            )

    def previous_statuses(self) -> dict[str, str]:
        cur = self.conn.execute("SELECT lock_id, status FROM evs.lock_current")
        return {r[0]: r[1] for r in cur.fetchall()}

    def evaluate_all(
        self, status_rows, delay_rows, stoppages, dims, notices, feed_refresh, eval_now, source, extra
    ) -> dict:
        delay_by = {d.lock_id: d for d in delay_rows}
        status_by = {r.lock_id: r for r in status_rows}
        stops_by: dict[str, list[lpms.StoppageRow]] = {}
        for s in stoppages:
            stops_by.setdefault(s.lock_id, []).append(s)
        gauges = self.latest_gauges()
        previous = self.previous_statuses()
        counts: dict[str, int] = {}
        changed: list[str] = []
        evaluated_at = datetime.now(UTC)
        results: dict[str, StatusResult] = {}
        for lock_id in sorted(set(dims) | set(status_by) | set(stops_by)):
            dim = dims.get(lock_id, {})
            row, stops = status_by.get(lock_id), stops_by.get(lock_id, [])
            if row is None and not stops:
                res = StatusResult(
                    "unknown",
                    "Lock does not report to the LPMS status feed",
                    None,
                    None,
                    "stale",
                    {"source": source, "evaluated_at": evaluated_at.isoformat()},
                )
            else:
                inp = StatusInputs(
                    lock_id=lock_id,
                    now=eval_now,
                    status_row=row,
                    delay_4h_min=delay_by[lock_id].delay_4h_min if lock_id in delay_by else None,
                    delay_24h_min=delay_by[lock_id].delay_24h_min if lock_id in delay_by else None,
                    stoppages=stops,
                    chambers=dim.get("chambers"),
                    noaa=gauges.get(lock_id, {}).get("noaa"),
                    usgs=gauges.get(lock_id, {}).get("usgs"),
                    notices=[n for n in notices if lock_id in n.lock_ids],
                    feed_refresh_at=feed_refresh,
                    previous_status=previous.get(lock_id),
                    source=source,
                )
                res = evaluate(inp, self.thresholds)
            results[lock_id] = res
            counts[res.status] = counts.get(res.status, 0) + 1
            if previous.get(lock_id) != res.status:
                changed.append(lock_id)
        with self.conn.cursor() as cur:
            cur.executemany(
                "INSERT INTO evs.status_eval (lock_id, evaluated_at, status, status_reason, rule_no, "
                "source_as_of, freshness, source, "
                "inputs_used) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                [
                    (
                        lid,
                        evaluated_at,
                        r.status,
                        r.status_reason,
                        r.rule_no,
                        r.as_of,
                        r.freshness,
                        source,
                        Jsonb(r.inputs_used),
                    )
                    for lid, r in results.items()
                ],
            )
        payload = {
            "at": evaluated_at.isoformat(),
            "source": source,
            "counts": counts,
            "changed": changed[:60],
            "changed_total": len(changed),
            "as_of": (feed_refresh or eval_now).isoformat(),
        }
        self.conn.execute("SELECT pg_notify('evs_locks', %s)", (json.dumps(payload),))
        summary = {
            "mode": source,
            "locks": len(results),
            "status_rows": len(status_rows),
            "stoppages": len(stoppages),
            "counts": counts,
            "changed": len(changed),
            "evaluated_at": evaluated_at,
            **extra,
        }
        log.info("lpms cycle: %s", summary)
        return summary

    # ---------------------------------------------------------------- simulator
    def run_simulated(self, now: datetime, dims: dict[str, dict], reason: str) -> dict:
        if not dims:
            self.run_gis_from_fixture_if_empty()
            dims = self.lock_dims()
        locks = [
            gis.LockDim(
                d["lock_id"],
                d["river_code"],
                d["lock_no"],
                d["river_name"],
                d["lock_name"],
                None,
                d["district"],
                None,
                None,
                None,
                d["chambers"],
                None,
                None,
                None,
                None,
                None,
                d["latitude"],
                d["longitude"],
            )
            for d in dims.values()
        ]
        reasons = self.reason_codes()
        status_rows, delay_rows, stoppages = simulate_cycle(locks, now, self.settings.simulator_seed, reasons)
        self.persist_facts(status_rows, delay_rows, stoppages, now, now, "simulated")
        for src, ep in (
            (LPMS_STATUS, self.lpms_urls.lock_status),
            (LPMS_DELAY, self.lpms_urls.lock_delay),
            (LPMS_STOP, self.lpms_urls.stall_stoppage),
        ):
            if self.mode == "simulated":
                self.health(src, ep, CADENCE["lpms"], None, None, None, mode="simulated", status="simulated")
        self.health(
            SIMULATOR,
            f"markov seed={self.settings.simulator_seed}",
            CADENCE["lpms"],
            None,
            len(status_rows),
            None,
            mode="simulated",
            status="simulated",
        )
        self.conn.execute("UPDATE evs.feed_health SET last_error = %s WHERE source = %s", (reason, SIMULATOR))
        log.info("simulator cycle (%s): %d locks", reason, len(status_rows))
        return self.evaluate_all(
            status_rows, delay_rows, stoppages, dims, [], now, now, "simulated", {"simulator_reason": reason}
        )

    def run_gis_from_fixture_if_empty(self) -> None:
        f = self.fixture(FIXTURES[GIS_LOCKS])
        if f.ok:
            for d in gis.parse_locks_geojson(f.text):
                self.upsert_lock_dim(d, source=self.mode)

    def reason_codes(self) -> list[str]:
        path = self.samples / "lpms/lookup_stoppage_reason_codes.json"
        codes = lpms.parse_reason_codes(path.read_text()) if path.exists() else []
        return codes or ["Maintenance", "High Water", "Debris", "Equipment Failure"]

    # ---------------------------------------------------------------- scheduling
    def run_once(self) -> dict:
        summary: dict = {"mode": self.mode, "started_at": datetime.now(UTC)}
        for name, fn in (("gis", self.run_gis), ("gauges", self.run_gauges), ("lpms", self.run_lpms)):
            try:
                summary[name] = fn()
            except Exception as exc:  # noqa: BLE001
                log.exception("%s cycle failed", name)
                summary[name] = {"error": f"{type(exc).__name__}: {exc}"}
        summary["finished_at"] = datetime.now(UTC)
        return summary

    def due(self, source: str, cadence_minutes: int) -> bool:
        last = self.last_success(source)
        return last is None or last < datetime.now(UTC) - timedelta(minutes=cadence_minutes)

    def run_loop(self, poll_seconds: int | None = None) -> None:
        """LPMS every EVS_INGEST_INTERVAL_SECONDS (900 s), gauges 30 min, GIS daily; ticks each minute."""
        cadence = dict(CADENCE, lpms=max(1, self.settings.ingest_interval_seconds // 60))
        poll_seconds = poll_seconds or min(60, self.settings.ingest_interval_seconds)
        log.info("ingest loop: mode=%s lpms=%dm gauges=%dm gis=%dm", self.mode, *cadence.values())
        while True:
            for name, source, fn in (
                ("gis", GIS_LOCKS, self.run_gis),
                ("gauges", NOAA_GAUGES, self.run_gauges),
                ("lpms", LPMS_STATUS, self.run_lpms),
            ):
                if self.due(source, cadence[name]) or (
                    name == "lpms" and self.mode == "simulated" and self.due(SIMULATOR, cadence["lpms"])
                ):
                    try:
                        fn()
                    except Exception:  # noqa: BLE001
                        log.exception("%s cycle failed", name)
            time.sleep(poll_seconds)
