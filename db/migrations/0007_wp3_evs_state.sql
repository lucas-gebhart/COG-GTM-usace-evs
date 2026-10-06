-- WP3: EVS-native tables for the APEX Strategic Planner slice that has no P2/CEFMS counterpart.
-- 0002..0005 (WP2) create legacy.* and synth.*; 0006 (WP5a) creates the feed tables.

-- Status engine thresholds editable from /admin (APEX Administrator scheme). Defaults mirror evs/settings.py.
CREATE TABLE IF NOT EXISTS evs.threshold (
    key         text PRIMARY KEY,
    value       integer NOT NULL CHECK (value > 0),
    updated_at  timestamptz NOT NULL DEFAULT now(),
    updated_by  text NOT NULL DEFAULT 'migration'
);
INSERT INTO evs.threshold (key, value) VALUES
    ('stale_after_minutes', 120),
    ('delay_yellow_minutes', 60),
    ('delay_red_minutes', 240),
    ('queue_yellow_vessels', 6)
ON CONFLICT (key) DO NOTHING;

-- APEX-only project columns (sp_projects.status_scale, archived_yn, archived_date, archived_by,
-- sp_project_links) kept beside the P2 project row instead of altering synth.p2_project.
CREATE TABLE IF NOT EXISTS evs.project_state (
    p2_project_no  text PRIMARY KEY,
    archived       boolean NOT NULL DEFAULT false,
    archived_at    timestamptz,
    archived_by    text,
    status_scale   char(1) NOT NULL DEFAULT 'A' CHECK (status_scale IN ('A','B','C','D','E')),
    link_url       text,
    link_name      text,
    note           text,
    updated_at     timestamptz NOT NULL DEFAULT now()
);

-- sp_project_history (written by trigger sp_projects_biu, read by APEX page 64).
CREATE TABLE IF NOT EXISTS evs.project_history (
    id             bigserial PRIMARY KEY,
    p2_project_no  text NOT NULL,
    attribute      text NOT NULL,
    change_type    text NOT NULL CHECK (change_type IN ('CREATE','UPDATE','DELETE','ARCHIVE','UNARCHIVE','VIEW')),
    old_value      text,
    new_value      text,
    changed_on     timestamptz NOT NULL DEFAULT now(),
    changed_by     text NOT NULL
);
CREATE INDEX IF NOT EXISTS project_history_project_idx ON evs.project_history (p2_project_no, changed_on DESC);

-- sp_proj_interactions_log (sp_log.log_interaction, the "log" process on pages 3, 24, 47, 508).
CREATE TABLE IF NOT EXISTS evs.project_interaction_log (
    id             bigserial PRIMARY KEY,
    p2_project_no  text NOT NULL,
    actor          text NOT NULL,
    kind           text NOT NULL,
    page_rendered  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS project_interaction_actor_idx ON evs.project_interaction_log (actor, page_rendered DESC);
