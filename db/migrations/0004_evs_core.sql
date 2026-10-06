-- 0004: EVS-native tables (schema evs). Column names follow apps/api/evs/schemas/public.py.
-- Public inputs: NDC Locks GIS layer (lock_dim), LPMS lock_status_report / lock_delay / stall_stoppage
-- (lock_status_fact, stoppage), status engine output (status_eval), SRP figures (srp_*).

CREATE TABLE evs.lock_dim (
    lock_id             text PRIMARY KEY,              -- river_code || '-' || lock_no, e.g. OH-79
    river_code          text NOT NULL,
    lock_no             text NOT NULL,
    lock_name           text NOT NULL,
    river_name          text,
    ndc_code            text,
    eroc                text,
    river_mile          numeric(8,2),
    chambers            integer,
    lift_ft             numeric(6,1),
    chamber_length_ft   numeric(7,1),
    chamber_width_ft    numeric(6,1),
    chamber_dimensions  text,
    year_opened         integer,
    district            text,
    division            text,
    state               text,
    town                text,
    owner               text,
    operator            text,
    geom                geometry(Point, 4326),
    latitude            double precision GENERATED ALWAYS AS (ST_Y(geom)) STORED,
    longitude           double precision GENERATED ALWAYS AS (ST_X(geom)) STORED,
    gauge_lid           text,                          -- NOAA NWPS gauge id (WP5a joins stage)
    usgs_site           text,                          -- USGS NWIS site number
    source              text NOT NULL DEFAULT 'ndc-gis',
    source_as_of        timestamptz,
    updated_at          timestamptz NOT NULL DEFAULT now(),
    UNIQUE (river_code, lock_no)
);
CREATE INDEX lock_dim_geom_gix ON evs.lock_dim USING gist (geom);
CREATE INDEX lock_dim_river_idx ON evs.lock_dim (river_code, river_mile);
CREATE INDEX lock_dim_district_idx ON evs.lock_dim (district);

-- Raw inputs per poll, one row per lock per ingestion cycle. Partitioned by month on polled_at.
CREATE TABLE evs.lock_status_fact (
    fact_id             bigint GENERATED ALWAYS AS IDENTITY,
    lock_id             text NOT NULL REFERENCES evs.lock_dim (lock_id),
    polled_at           timestamptz NOT NULL,
    source_as_of        timestamptz,
    entry_datetime      timestamptz,
    hours_of_operation  text,
    weather_code        text,
    upper_gauge_ft      numeric(8,2),
    lower_gauge_ft      numeric(8,2),
    air_temp_f          numeric(5,1),
    water_temp_f        numeric(5,1),
    vessels_queued      integer,
    total_locking       integer,
    locked_up_24h       integer,
    locked_down_24h     integer,
    avg_delay_4h_min    numeric(8,1),
    avg_delay_24h_min   numeric(8,1),
    active_stoppages    integer,
    notes               text,
    raw                 jsonb,
    source              text NOT NULL,                 -- live | fixtures | simulated
    PRIMARY KEY (fact_id, polled_at)
) PARTITION BY RANGE (polled_at);
CREATE INDEX lock_status_fact_lock_idx ON evs.lock_status_fact (lock_id, polled_at DESC);

CREATE OR REPLACE FUNCTION evs.ensure_lock_status_partition(p_ts timestamptz) RETURNS text
LANGUAGE plpgsql AS $$
DECLARE
    v_start date := date_trunc('month', p_ts)::date;
    v_name  text := format('lock_status_fact_%s', to_char(v_start, 'YYYYMM'));
BEGIN
    IF to_regclass('evs.' || v_name) IS NULL THEN
        EXECUTE format('CREATE TABLE evs.%I PARTITION OF evs.lock_status_fact FOR VALUES FROM (%L) TO (%L)',
                       v_name, v_start, v_start + interval '1 month');
    END IF;
    RETURN v_name;
END $$;
SELECT evs.ensure_lock_status_partition(m) FROM generate_series('2026-09-01'::timestamptz, '2027-03-01', interval '1 month') AS m;

-- Status engine output. One row per evaluation; evs.lock_current picks the latest per lock.
CREATE TABLE evs.status_eval (
    eval_id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lock_id         text NOT NULL REFERENCES evs.lock_dim (lock_id),
    evaluated_at    timestamptz NOT NULL,
    status          text NOT NULL CHECK (status IN ('operating', 'delayed', 'closed', 'stale', 'unknown')),
    status_reason   text NOT NULL,
    inputs_used     jsonb NOT NULL DEFAULT '{}'::jsonb,
    source          text NOT NULL,                     -- live | fixtures | simulated
    source_as_of    timestamptz,
    freshness       text NOT NULL DEFAULT 'fresh' CHECK (freshness IN ('fresh', 'aging', 'stale', 'simulated'))
);
CREATE INDEX status_eval_latest_idx ON evs.status_eval (lock_id, evaluated_at DESC);
CREATE INDEX status_eval_time_idx ON evs.status_eval (evaluated_at DESC);

CREATE TABLE evs.stoppage (
    stoppage_id     bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lock_id         text NOT NULL REFERENCES evs.lock_dim (lock_id),
    chamber_no      text,
    begin_at        timestamptz NOT NULL,
    end_at          timestamptz,
    is_scheduled    boolean NOT NULL DEFAULT false,
    traffic_stopped boolean NOT NULL DEFAULT false,
    reason_code     text,
    hw_cycles       integer,
    refresh_at      timestamptz,
    source          text NOT NULL,
    raw             jsonb
);
CREATE INDEX stoppage_lock_idx ON evs.stoppage (lock_id, begin_at DESC);
CREATE INDEX stoppage_open_idx ON evs.stoppage (lock_id) WHERE traffic_stopped;

CREATE TABLE evs.feed_health (
    source          text PRIMARY KEY,
    endpoint        text NOT NULL,
    cadence_minutes integer NOT NULL,
    last_success_at timestamptz,
    last_error      text,
    latency_ms      integer,
    status          text NOT NULL CHECK (status IN ('healthy', 'degraded', 'down', 'simulated', 'fixtures')),
    updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE evs.srp_snapshot (
    year             integer PRIMARY KEY,
    river_systems    integer,
    dams             integer,
    river_miles      integer,
    floodplain_acres integer,
    source           text NOT NULL,
    source_url       text NOT NULL,
    headline         jsonb,
    source_as_of     timestamptz,
    fetched_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE evs.srp_site (
    site_id      integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         text NOT NULL,
    river        text NOT NULL,
    state        text NOT NULL,
    district     text,
    nid_id       text,
    year_joined  integer,
    geom         geometry(Point, 4326),
    latitude     double precision GENERATED ALWAYS AS (ST_Y(geom)) STORED,
    longitude    double precision GENERATED ALWAYS AS (ST_X(geom)) STORED,
    source_url   text NOT NULL,
    UNIQUE (name, river)
);
CREATE INDEX srp_site_geom_gix ON evs.srp_site USING gist (geom);

-- Status engine thresholds (admin editable; defaults mirror evs.settings).
CREATE TABLE evs.threshold (
    key         text PRIMARY KEY,
    value       numeric NOT NULL,
    unit        text NOT NULL,
    description text NOT NULL,
    updated_at  timestamptz NOT NULL DEFAULT now()
);
INSERT INTO evs.threshold (key, value, unit, description) VALUES
    ('stale_after_minutes', 120, 'minutes', 'Newest LPMS input older than this marks the lock Stale'),
    ('delay_yellow_minutes', 60, 'minutes', '4-hour average delay at or above this is Delayed'),
    ('delay_red_minutes', 240, 'minutes', '4-hour average delay at or above this is Closed'),
    ('queue_yellow_vessels', 6, 'vessels', 'Pending arrivals at or above this is Delayed');

-- Latest evaluation per lock joined to the dimension and the latest raw poll.
CREATE VIEW evs.lock_current AS
SELECT d.lock_id, d.river_code, d.river_name, d.lock_name, d.lock_no, d.river_mile, d.district, d.division, d.state,
       d.chambers, d.lift_ft, d.chamber_dimensions, d.year_opened, d.owner, d.operator, d.gauge_lid, d.usgs_site,
       ST_Y(d.geom) AS latitude, ST_X(d.geom) AS longitude,
       coalesce(e.status, 'unknown') AS status,
       coalesce(e.status_reason, 'No LPMS evaluation for this lock') AS status_reason,
       e.evaluated_at, e.inputs_used, e.source AS eval_source, e.source_as_of, e.freshness,
       f.polled_at, f.vessels_queued, f.avg_delay_4h_min, f.avg_delay_24h_min, f.upper_gauge_ft AS gauge_stage_ft,
       f.entry_datetime,
       (SELECT count(*) FROM evs.stoppage s
         WHERE s.lock_id = d.lock_id AND s.traffic_stopped
           AND s.begin_at <= coalesce(e.evaluated_at, now())
           AND (s.end_at IS NULL OR s.end_at > coalesce(e.evaluated_at, now())))::integer AS active_stoppages
FROM evs.lock_dim d
LEFT JOIN LATERAL (SELECT * FROM evs.status_eval x WHERE x.lock_id = d.lock_id ORDER BY x.evaluated_at DESC LIMIT 1) e ON true
LEFT JOIN LATERAL (SELECT * FROM evs.lock_status_fact y WHERE y.lock_id = d.lock_id ORDER BY y.polled_at DESC LIMIT 1) f ON true;
