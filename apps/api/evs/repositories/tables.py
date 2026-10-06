"""Table names the repositories read and write.

WP2 owns `db/migrations/0002..0005` (ora2pg `legacy` schema, `synth` CEFMS/EMS/P2/BUILDER tables,
SRP and lock dimensions). Its migrations were not on `main` when WP3 was written, so the names
below follow WP2's prompt and the Pydantic models in `evs/schemas/`. `tests/sql/assumed_wp2_schema.sql`
creates the same tables for the database test job. Reconcile here if WP2 lands different names.

WP3 owns the `evs.threshold`, `evs.project_state`, `evs.project_history` and
`evs.project_interaction_log` tables (`db/migrations/0007_wp3_evs_state.sql`).
"""

PROGRAM = "synth.program"
PROJECT = "synth.p2_project"
MILESTONE = "synth.p2_milestone"
CEFMS_EXECUTION = "synth.cefms_execution"
CEFMS_APPROPRIATION = "synth.cefms_appropriation"
EMS_LABOR_LOG = "synth.ems_labor_log"
BUILDER_CONDITION = "synth.builder_facility_condition"

LOCK_DIM = "evs.lock_dim"
LOCK_STATUS = "evs.lock_status_fact"
SRP_SNAPSHOT = "evs.srp_snapshot"
SRP_SITE = "evs.srp_site"
FEED_HEALTH = "evs.feed_health"

THRESHOLD = "evs.threshold"
PROJECT_STATE = "evs.project_state"
PROJECT_HISTORY = "evs.project_history"
PROJECT_INTERACTION_LOG = "evs.project_interaction_log"
