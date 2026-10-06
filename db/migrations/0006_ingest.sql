-- WP5a: public-feed ingestion, status engine output and feed health.
-- Append-only facts keep as_of (source timestamp) and fetched_at (when EVS stored it); every row names its
-- source: live | fixtures | simulated. evs.lock_current is the read model served by /public/locks.
-- WP2 owns the lock dimension; evs.lock_dim is created IF NOT EXISTS so either migration order works.

CREATE TABLE IF NOT EXISTS evs.lock_dim (
  lock_id            text PRIMARY KEY,               -- riverCode + '-' + lockNo, e.g. OH-79
  river_code         text NOT NULL,
  lock_no            text NOT NULL,
  river_name         text,
  lock_name          text,
  eroc               text,
  river_mile         numeric(8,2),
  district           text,
  division           text,
  state              text,
  town               text,
  chambers           integer,                        -- GIS NOCHMB
  lift_ft            numeric(6,1),
  chamber_dimensions text,                           -- "1200 x 110 ft" of the largest chamber
  year_opened        integer,
  owner              text,
  operator           text,
  geom               geometry(Point, 4326),
  geom_source        text,                           -- gis | lpms-swapped | none
  source             text NOT NULL DEFAULT 'live',
  updated_at         timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS lock_dim_geom_idx ON evs.lock_dim USING gist (geom);

CREATE TABLE IF NOT EXISTS evs.threshold (
  key         text PRIMARY KEY,
  value       numeric NOT NULL,
  description text NOT NULL,
  updated_at  timestamptz NOT NULL DEFAULT now()
);
INSERT INTO evs.threshold (key, value, description) VALUES
  ('stale_after_minutes', 120, 'Rule 11: newest input older than this is Stale'),
  ('delay_yellow_minutes', 60, 'Rule 6: 4-hour average delay at or above this is Delayed'),
  ('delay_red_minutes', 240, 'Rule 3: 4-hour average delay at or above this is Closed'),
  ('queue_yellow_vessels', 6, 'Rule 6: pending arrivals at or above this is Delayed'),
  ('lpms_failover_hours', 6, 'Switch to the labelled simulator after LPMS has failed for this long')
ON CONFLICT (key) DO NOTHING;

-- One row per lock per LPMS poll: lock_status_report joined with lock_delay_json.
CREATE TABLE IF NOT EXISTS evs.lock_status_fact (
  id                 bigserial PRIMARY KEY,
  lock_id            text NOT NULL,
  source             text NOT NULL,                  -- live | fixtures | simulated
  source_as_of       timestamptz,                    -- operator entryDatetime (lags hours)
  feed_refresh_at    timestamptz,                    -- stoppage refreshDate or HTTP Date header
  fetched_at         timestamptz NOT NULL DEFAULT now(),
  eroc               text,
  upper_gauge_ft     numeric(8,2),
  lower_gauge_ft     numeric(8,2),
  weather_code       text,
  air_temp_f         numeric(5,1),
  pending_arrivals   integer,
  locking_now        integer,
  locked_up_24h      integer,
  locked_down_24h    integer,
  avg_delay_4h_min   numeric(8,1),
  avg_delay_24h_min  numeric(8,1),
  active_stoppage    boolean,
  ntni_notices       text[] NOT NULL DEFAULT '{}',
  notes              text,
  raw                jsonb
);
CREATE INDEX IF NOT EXISTS lock_status_fact_lock_fetched_idx ON evs.lock_status_fact (lock_id, fetched_at DESC);

-- stall_stoppage_json rows (scheduled and unscheduled closures), one row per stoppage, refreshed each poll.
CREATE TABLE IF NOT EXISTS evs.stoppage (
  id               bigserial PRIMARY KEY,
  lock_id          text NOT NULL,
  chamber_no       text,
  begin_at         timestamptz NOT NULL,
  end_at           timestamptz,                      -- NULL = open ended
  is_scheduled     boolean NOT NULL,
  reason_code      text,
  traffic_stopped  boolean NOT NULL,
  hw_cycles        integer,
  refresh_at       timestamptz,
  fetched_at       timestamptz NOT NULL DEFAULT now(),
  source           text NOT NULL,
  raw              jsonb,
  UNIQUE (lock_id, chamber_no, begin_at, reason_code, source)
);
CREATE INDEX IF NOT EXISTS stoppage_lock_idx ON evs.stoppage (lock_id, begin_at DESC);

-- NOAA NWPS and USGS NWIS readings for the paired gauge of a lock.
CREATE TABLE IF NOT EXISTS evs.gauge_fact (
  id                 bigserial PRIMARY KEY,
  lock_id            text NOT NULL,
  provider           text NOT NULL,                  -- noaa | usgs
  station_id         text NOT NULL,                  -- NWPS LID or USGS site number
  observed_at        timestamptz,
  stage_ft           numeric(8,2),
  flow_cfs           numeric(12,1),
  flood_category     text,                           -- NWPS status.observed.floodCategory
  forecast_category  text,
  forecast_at        timestamptz,
  moderate_stage_ft  numeric(8,2),                   -- NWPS flood.categories.moderate.stage
  categories         jsonb,
  fetched_at         timestamptz NOT NULL DEFAULT now(),
  source             text NOT NULL
);
CREATE INDEX IF NOT EXISTS gauge_fact_lock_fetched_idx ON evs.gauge_fact (lock_id, fetched_at DESC);

-- Notices to Navigation Interests linked from lock_status_report.ntniNoticesLinks (rule 9).
CREATE TABLE IF NOT EXISTS evs.ntni_notice (
  notice_no      text PRIMARY KEY,
  lock_ids       text[] NOT NULL DEFAULT '{}',
  title          text,
  effective_from timestamptz,
  effective_to   timestamptz,
  fetched_at     timestamptz NOT NULL DEFAULT now(),
  source         text NOT NULL
);

-- Vessel queue and recent lockages for the detail panel (per-lock LPMS endpoints).
CREATE TABLE IF NOT EXISTS evs.lock_queue (
  lock_id       text NOT NULL,
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
  lock_id           text NOT NULL,
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

-- Status engine output, append-only; the newest row per lock is the current status.
CREATE TABLE IF NOT EXISTS evs.status_eval (
  id             bigserial PRIMARY KEY,
  lock_id        text NOT NULL,
  evaluated_at   timestamptz NOT NULL DEFAULT now(),
  status         text NOT NULL CHECK (status IN ('operating', 'delayed', 'closed', 'stale', 'unknown')),
  status_reason  text NOT NULL,
  rule_no        integer,                             -- 1..11 from the public data report, NULL when unknown
  as_of          timestamptz,                         -- newest input timestamp
  freshness      text NOT NULL CHECK (freshness IN ('fresh', 'aging', 'stale', 'simulated')),
  source         text NOT NULL,
  inputs_used    jsonb NOT NULL DEFAULT '{}'::jsonb
);
CREATE INDEX IF NOT EXISTS status_eval_lock_time_idx ON evs.status_eval (lock_id, evaluated_at DESC);

-- One row per feed; updated after every attempt.
CREATE TABLE IF NOT EXISTS evs.feed_health (
  source                text PRIMARY KEY,            -- e.g. "LPMS lock_status_report"
  endpoint              text NOT NULL,
  cadence_minutes       integer NOT NULL,
  mode                  text NOT NULL,               -- live | fixtures | simulated
  last_attempt_at       timestamptz,
  last_success_at       timestamptz,
  last_error            text,
  latency_ms            integer,
  http_status           integer,
  rows_parsed           integer,
  consecutive_failures  integer NOT NULL DEFAULT 0,
  status                text NOT NULL CHECK (status IN ('healthy', 'degraded', 'down', 'simulated', 'fixtures')),
  updated_at            timestamptz NOT NULL DEFAULT now()
);

-- Last good payload per feed, used when a poll fails (last-good caching).
CREATE TABLE IF NOT EXISTS evs.feed_cache (
  source      text PRIMARY KEY,
  fetched_at  timestamptz NOT NULL,
  payload     jsonb NOT NULL
);

CREATE OR REPLACE VIEW evs.lock_current AS
WITH latest_eval AS (
  SELECT DISTINCT ON (lock_id) *
  FROM evs.status_eval ORDER BY lock_id, evaluated_at DESC
), latest_fact AS (
  SELECT DISTINCT ON (lock_id) *
  FROM evs.lock_status_fact ORDER BY lock_id, fetched_at DESC
), latest_gauge AS (
  SELECT DISTINCT ON (lock_id) *
  FROM evs.gauge_fact WHERE provider = 'noaa' ORDER BY lock_id, fetched_at DESC
), active_stop AS (
  SELECT lock_id, count(*) AS active_stoppages
  FROM evs.stoppage
  WHERE traffic_stopped AND begin_at <= now() AND (end_at IS NULL OR end_at >= now())
  GROUP BY lock_id
), last_lockage AS (
  SELECT lock_id, max(end_of_lockage_at) AS last_lockage_at FROM evs.lockage GROUP BY lock_id
)
SELECT d.lock_id, d.river_code, d.river_name, d.lock_name, d.lock_no, d.river_mile, d.district, d.chambers,
       ST_Y(d.geom) AS latitude, ST_X(d.geom) AS longitude,
       d.lift_ft, d.chamber_dimensions, d.year_opened, d.owner, d.operator,
       COALESCE(e.status, 'unknown') AS status,
       COALESCE(e.status_reason, 'No status evaluation yet') AS status_reason,
       e.rule_no, e.as_of, e.evaluated_at, COALESCE(e.freshness, 'stale') AS freshness,
       COALESCE(e.source, d.source) AS source, COALESCE(e.inputs_used, '{}'::jsonb) AS status_inputs,
       f.pending_arrivals AS vessels_queued, f.avg_delay_4h_min, f.avg_delay_24h_min, f.upper_gauge_ft,
       g.stage_ft AS gauge_stage_ft, g.flood_category,
       COALESCE(s.active_stoppages, 0) AS active_stoppages,
       l.last_lockage_at
FROM evs.lock_dim d
LEFT JOIN latest_eval e USING (lock_id)
LEFT JOIN latest_fact f USING (lock_id)
LEFT JOIN latest_gauge g USING (lock_id)
LEFT JOIN active_stop s USING (lock_id)
LEFT JOIN last_lockage l USING (lock_id);
