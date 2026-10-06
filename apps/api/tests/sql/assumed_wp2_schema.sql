-- Tables WP3 expects from WP2 (db/migrations/0002..0005) and WP5a (0006), created here so the
-- api-db test job runs before those migrations land. Column names follow apps/api/evs/schemas/.
-- Everything is IF NOT EXISTS so running it after the real migrations is a no-op.

CREATE TABLE IF NOT EXISTS synth.program (
    program_code text PRIMARY KEY, name text NOT NULL, business_line text NOT NULL, division text NOT NULL,
    funded_amount numeric NOT NULL, obligated_amount numeric NOT NULL, expended_amount numeric NOT NULL,
    variance_pct numeric NOT NULL, project_count integer NOT NULL, schedule_health text NOT NULL
);
CREATE TABLE IF NOT EXISTS synth.p2_project (
    p2_project_no text PRIMARY KEY, name text NOT NULL, program_code text NOT NULL, district text NOT NULL,
    division text NOT NULL, business_line text NOT NULL, phase text NOT NULL, pdt_lead text NOT NULL,
    baseline_finish date, current_finish date, pct_complete numeric NOT NULL, funded_amount numeric NOT NULL,
    obligated_amount numeric NOT NULL, expended_amount numeric NOT NULL, schedule_health text NOT NULL
);
CREATE TABLE IF NOT EXISTS synth.p2_milestone (
    p2_project_no text NOT NULL, code text NOT NULL, name text NOT NULL, baseline_date date, "current_date" date,
    actual_date date, status text NOT NULL, owner text, description text, status_last_changed_on timestamptz,
    PRIMARY KEY (p2_project_no, code)
);
CREATE TABLE IF NOT EXISTS synth.cefms_execution (
    fiscal_year integer NOT NULL, period date NOT NULL, plan_cumulative numeric NOT NULL,
    obligated_cumulative numeric NOT NULL, expended_cumulative numeric NOT NULL, PRIMARY KEY (fiscal_year, period)
);
CREATE TABLE IF NOT EXISTS synth.cefms_appropriation (
    fiscal_year integer NOT NULL, appropriation text NOT NULL, title text NOT NULL, allotted numeric NOT NULL,
    committed numeric NOT NULL, obligated numeric NOT NULL, expended numeric NOT NULL, expiring_fy integer,
    PRIMARY KEY (fiscal_year, appropriation)
);
CREATE TABLE IF NOT EXISTS synth.ems_labor_log (
    fiscal_year integer NOT NULL, district text NOT NULL, pay_period text NOT NULL, hours_plan numeric NOT NULL,
    hours_regular numeric NOT NULL, hours_overtime numeric NOT NULL, labor_cost numeric NOT NULL,
    PRIMARY KEY (fiscal_year, district, pay_period)
);
CREATE TABLE IF NOT EXISTS synth.builder_facility_condition (
    building_id text NOT NULL, installation text NOT NULL, district text NOT NULL, uniformat_section text NOT NULL,
    component_type text NOT NULL, ci numeric NOT NULL, bci numeric NOT NULL, deficiency_cost numeric NOT NULL,
    work_plan_year integer NOT NULL, PRIMARY KEY (building_id, uniformat_section, component_type)
);
CREATE TABLE IF NOT EXISTS evs.lock_dim (
    lock_id text PRIMARY KEY, river_code text NOT NULL, river_name text NOT NULL, lock_name text NOT NULL,
    lock_no text NOT NULL, river_mile numeric, district text, chambers integer, latitude double precision,
    longitude double precision, lift_ft numeric, chamber_dimensions text, year_opened integer, owner text,
    operator text, geom geometry(Point, 4326)
);
CREATE TABLE IF NOT EXISTS evs.lock_status_fact (
    id bigserial PRIMARY KEY, lock_id text NOT NULL REFERENCES evs.lock_dim (lock_id), status text NOT NULL,
    status_reason text NOT NULL, vessels_queued integer, avg_delay_4h_min numeric, avg_delay_24h_min numeric,
    last_lockage_at timestamptz, gauge_stage_ft numeric, flood_category text, active_stoppages integer NOT NULL DEFAULT 0,
    source_as_of timestamptz, fetched_at timestamptz NOT NULL DEFAULT now(), freshness text NOT NULL DEFAULT 'fresh',
    source text NOT NULL, status_inputs jsonb, queue jsonb, stoppages jsonb, recent_lockages jsonb
);
CREATE INDEX IF NOT EXISTS lock_status_fact_lock_idx ON evs.lock_status_fact (lock_id, fetched_at DESC);
CREATE TABLE IF NOT EXISTS evs.srp_snapshot (
    year integer PRIMARY KEY, river_systems integer, dams integer, river_miles integer, floodplain_acres integer,
    source text NOT NULL, source_url text NOT NULL, headline jsonb, source_as_of timestamptz, fetched_at timestamptz
);
CREATE TABLE IF NOT EXISTS evs.srp_site (
    name text PRIMARY KEY, river text NOT NULL, state text NOT NULL, district text, nid_id text,
    latitude double precision, longitude double precision, year_joined integer, source_url text NOT NULL
);
CREATE TABLE IF NOT EXISTS evs.feed_health (
    source text PRIMARY KEY, endpoint text NOT NULL, cadence_minutes integer NOT NULL, last_success_at timestamptz,
    last_error text, latency_ms integer, status text NOT NULL
);
