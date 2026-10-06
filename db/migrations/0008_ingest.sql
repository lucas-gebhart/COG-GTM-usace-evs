-- 0008 (WP5a): ingestion additions on top of WP2's 0004_evs_core.sql.
-- Adds the columns the worker needs on WP2's tables, the per-feed tables WP2 does not define (gauge_fact,
-- ntni_notice, lock_queue, lockage, feed_cache) and widens evs.lock_current with gauge, queue and lockage data.
-- Facts stay append-only with source_as_of (source timestamp) and polled_at / fetched_at (when EVS stored it);
-- every row names its source: live | fixtures | simulated.

ALTER TABLE evs.lock_dim
  ADD COLUMN IF NOT EXISTS geom_source text;                       -- gis | lpms-swapped | none

ALTER TABLE evs.lock_status_fact
  ADD COLUMN IF NOT EXISTS feed_refresh_at timestamptz,            -- stoppage refreshDate or HTTP Date header
  ADD COLUMN IF NOT EXISTS eroc            text,
  ADD COLUMN IF NOT EXISTS ntni_notices    text[] NOT NULL DEFAULT '{}';

ALTER TABLE evs.stoppage
  ADD COLUMN IF NOT EXISTS fetched_at timestamptz NOT NULL DEFAULT now();
CREATE UNIQUE INDEX IF NOT EXISTS stoppage_natural_key
  ON evs.stoppage (lock_id, chamber_no, begin_at, reason_code, source);

ALTER TABLE evs.status_eval
  ADD COLUMN IF NOT EXISTS rule_no integer;                        -- 1..11 from the public data report

ALTER TABLE evs.feed_health
  ADD COLUMN IF NOT EXISTS mode                 text NOT NULL DEFAULT 'live',  -- live | fixtures | simulated
  ADD COLUMN IF NOT EXISTS last_attempt_at      timestamptz,
  ADD COLUMN IF NOT EXISTS http_status          integer,
  ADD COLUMN IF NOT EXISTS rows_parsed          integer,
  ADD COLUMN IF NOT EXISTS consecutive_failures integer NOT NULL DEFAULT 0;

INSERT INTO evs.threshold (key, value, unit, description) VALUES
  ('lpms_failover_hours', 6, 'hours', 'Switch to the labelled simulator after LPMS has failed for this long')
ON CONFLICT (key) DO NOTHING;

-- NOAA NWPS and USGS NWIS readings for the gauge paired with each lock (evs/ingest/gauges.py).
CREATE TABLE IF NOT EXISTS evs.gauge_fact (
  id                 bigserial PRIMARY KEY,
  lock_id            text NOT NULL REFERENCES evs.lock_dim (lock_id),
  provider           text NOT NULL,                                -- noaa | usgs
  station_id         text NOT NULL,                                -- NWPS LID or NWIS site number
  observed_at        timestamptz,
  stage_ft           numeric(8,2),
  flow_cfs           numeric(12,1),
  flood_category     text,                                         -- observed NWPS category
  forecast_category  text,
  forecast_at        timestamptz,
  moderate_stage_ft  numeric(8,2),                                 -- NWPS flood.categories.moderate.stage
  categories         jsonb,                                        -- NWPS action/minor/moderate/major stages
  fetched_at         timestamptz NOT NULL DEFAULT now(),
  source             text NOT NULL
);
CREATE INDEX IF NOT EXISTS gauge_fact_lock_fetched_idx ON evs.gauge_fact (lock_id, fetched_at DESC);

-- Notices to Navigation Interests that name a lock, with their effective window (rule 9).
CREATE TABLE IF NOT EXISTS evs.ntni_notice (
  notice_no      text PRIMARY KEY,
  lock_ids       text[] NOT NULL DEFAULT '{}',
  title          text,
  effective_from timestamptz,
  effective_to   timestamptz,
  fetched_at     timestamptz NOT NULL DEFAULT now(),
  source         text NOT NULL
);

-- Current queue (replaced per lock on every poll) and processed lockages (append-only, keyed by vessel + end time).
CREATE TABLE IF NOT EXISTS evs.lock_queue (
  lock_id       text NOT NULL REFERENCES evs.lock_dim (lock_id),
  vessel_no     text NOT NULL,
  vessel_name   text,
  direction     text,
  num_barges    integer,
  arrival_at    timestamptz,
  sol_at        timestamptz,
  end_of_lockage_at timestamptz,
  mmsi          text,
  fetched_at    timestamptz NOT NULL DEFAULT now(),
  source        text NOT NULL,
  PRIMARY KEY (lock_id, vessel_no, arrival_at)
);
CREATE TABLE IF NOT EXISTS evs.lockage (
  lock_id           text NOT NULL REFERENCES evs.lock_dim (lock_id),
  vessel_no         text NOT NULL,
  vessel_name       text,
  direction         text,
  num_barges        integer,
  number_processed  integer,
  hazard_code       text,
  arrival_at        timestamptz,
  sol_at            timestamptz,
  end_of_lockage_at timestamptz NOT NULL,
  fetched_at        timestamptz NOT NULL DEFAULT now(),
  source            text NOT NULL,
  PRIMARY KEY (lock_id, vessel_no, end_of_lockage_at)
);
CREATE INDEX IF NOT EXISTS lockage_lock_end_idx ON evs.lockage (lock_id, end_of_lockage_at DESC);

-- Last good payload per feed, used when a poll fails (last-good caching).
CREATE TABLE IF NOT EXISTS evs.feed_cache (
  source      text PRIMARY KEY,
  fetched_at  timestamptz NOT NULL,
  payload     jsonb NOT NULL
);

-- Read model for /public/locks: WP2's columns plus gauge, queue, lockage and status inputs.
DROP VIEW IF EXISTS evs.lock_current;
CREATE VIEW evs.lock_current AS
WITH latest_eval AS (
  SELECT DISTINCT ON (lock_id) * FROM evs.status_eval ORDER BY lock_id, evaluated_at DESC
), latest_fact AS (
  SELECT DISTINCT ON (lock_id) * FROM evs.lock_status_fact ORDER BY lock_id, polled_at DESC
), latest_gauge AS (
  SELECT DISTINCT ON (lock_id) * FROM evs.gauge_fact WHERE provider = 'noaa' ORDER BY lock_id, fetched_at DESC
), active_stop AS (
  SELECT lock_id, count(*) AS active_stoppages
  FROM evs.stoppage
  WHERE traffic_stopped AND begin_at <= now() AND (end_at IS NULL OR end_at >= now())
  GROUP BY lock_id
), last_lockage AS (
  SELECT lock_id, max(end_of_lockage_at) AS last_lockage_at FROM evs.lockage GROUP BY lock_id
)
SELECT d.lock_id, d.river_code, d.river_name, d.lock_name, d.lock_no, d.river_mile, d.district, d.division, d.state,
       d.chambers, d.lift_ft, d.chamber_dimensions, d.year_opened, d.owner, d.operator, d.gauge_lid, d.usgs_site,
       ST_Y(d.geom) AS latitude, ST_X(d.geom) AS longitude,
       COALESCE(e.status, 'unknown') AS status,
       COALESCE(e.status_reason, 'No LPMS evaluation for this lock') AS status_reason,
       e.rule_no, e.source_as_of AS as_of, e.source_as_of, e.evaluated_at,
       COALESCE(e.freshness, 'stale') AS freshness,
       COALESCE(e.source, d.source) AS source, e.source AS eval_source,
       COALESCE(e.inputs_used, '{}'::jsonb) AS status_inputs,
       f.polled_at, f.entry_datetime, f.vessels_queued, f.avg_delay_4h_min, f.avg_delay_24h_min, f.upper_gauge_ft,
       g.stage_ft AS gauge_stage_ft, g.flood_category,
       COALESCE(s.active_stoppages, 0)::integer AS active_stoppages,
       l.last_lockage_at
FROM evs.lock_dim d
LEFT JOIN latest_eval e USING (lock_id)
LEFT JOIN latest_fact f USING (lock_id)
LEFT JOIN latest_gauge g USING (lock_id)
LEFT JOIN active_stop s USING (lock_id)
LEFT JOIN last_lockage l USING (lock_id);
