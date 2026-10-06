"""Table and view names the repositories read and write.

WP2 owns `db/migrations/0002..0005`: the ora2pg `legacy` schema, the `evs` lock/SRP/feed tables and the
`synth` CEFMS/P2/EMS/BUILDER tables plus the roll-up views the API reads (`v_program_summary`,
`v_project_execution`, `v_labor_summary`, `cefms_execution`, `cefms_appropriation`,
`builder_facility_condition`, `lock_current`). Amounts on programs and projects are derived from
`synth.cefms_funding` through those views, never stored on the row.

WP3 owns `evs.project_state`, `evs.project_history`, `evs.project_interaction_log` and the
`evs.threshold.updated_by` column (`db/migrations/0007_wp3_evs_state.sql`).
"""

PROGRAM = "synth.program"
PROGRAM_SUMMARY = "synth.v_program_summary"
PROJECT = "synth.p2_project"
PROJECT_EXECUTION = "synth.v_project_execution"
MILESTONE = "synth.p2_milestone"
CEFMS_EXECUTION = "synth.cefms_execution"
CEFMS_APPROPRIATION = "synth.cefms_appropriation"
LABOR_SUMMARY = "synth.v_labor_summary"
BUILDER_CONDITION = "synth.builder_facility_condition"

LOCK_CURRENT = "evs.lock_current"
STOPPAGE = "evs.stoppage"
SRP_SNAPSHOT = "evs.srp_snapshot"
SRP_SITE = "evs.srp_site"
FEED_HEALTH = "evs.feed_health"

THRESHOLD = "evs.threshold"
PROJECT_STATE = "evs.project_state"
PROJECT_HISTORY = "evs.project_history"
PROJECT_INTERACTION_LOG = "evs.project_interaction_log"
