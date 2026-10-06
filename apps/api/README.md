# EVS API (FastAPI)

- `uv sync --extra dev` then `uv run uvicorn evs.main:app --reload`
- `uv run evs migrate` applies `db/migrations/*.sql`
- `uv run evs seed` loads the public lock/SRP samples and generates the synthetic CEFMS/P2/EMS/BUILDER data
  (`db/seed/evs_seed`, WP2); `uv run evs dump-fixtures` rewrites `fixtures/*.json` from that database
- `uv run evs openapi` regenerates `packages/contract/openapi.json`, then `cd apps/web && pnpm gen:api`
- `uv run pytest -q`, `uv run ruff check .`, `uv run ruff format --check .`

## Data modes

`EVS_DATA_MODE` selects where the routers read from. Response shapes and paths are identical in both modes.

| Mode | Behaviour |
| --- | --- |
| `auto` (default) | Probe `EVS_DATABASE_URL` at startup. If the `evs` schema is reachable serve SQL, otherwise log a warning and serve `fixtures/*.json`. |
| `db` | SQL only. If the database is down requests return 503 instead of silently serving fixtures. Used by the CI `api-db` job and by Compose. |
| `fixtures` | Never touches the database. Writes mutate an in-memory copy of the fixtures for the life of the process. |

Repositories live in `evs/repositories/` (raw SQL through SQLAlchemy `text()`, one `Pg*` and one `Fixture*`
implementation per area). Column filters and sorts only accept names from each repository's whitelist, so no
user input reaches a SQL identifier.

## Interactive Report parameters

`/programs`, `/projects`, `/workforce/labor`, `/facilities/condition` and `/schedule/milestones` accept:

| Parameter | Example | Notes |
| --- | --- | --- |
| `filter` (repeatable) | `filter=pct_complete:gte:50&filter=district:in:LRL,LRN` | ops: `eq ne gt gte lt lte like in` |
| named shortcuts | `district=LRL`, `program_code=LRD-NAV`, `min_pct_complete=50` | same as the matching `filter` |
| `q` | `q=hydropower` | case-insensitive match across the text columns |
| `sort` | `sort=-funded_amount,name` | leading `-` for descending; the default sort is always appended as a tie breaker |
| `limit`, `offset` | `limit=50&offset=100` | `limit` 1 to 500, default 50 |
| `format` | `format=csv` | CSV of the filtered, sorted set (up to 500 rows); JSON otherwise |

Example: `curl "localhost:8000/api/v1/projects?district=LRL&sort=-funded_amount&format=csv"`

## Authorization

Bearer JWT (RS256) verified against the issuer's JWKS; `EVS_AUTH_DISABLED=true` (local default) injects a demo
admin principal. Roles are read from `realm_access.roles` (Keycloak) or `cognito:groups` (Cognito).

| APEX authorization scheme | EVS role | Grants |
| --- | --- | --- |
| Authenticated User | `evs_viewer` | every read endpoint outside `/public/*` |
| Contributor | `evs_pm` | `evs_viewer` plus the project and milestone write endpoints |
| Administration Rights (group Administrator) | `evs_admin` | everything, including `/admin/*` |
| (none) | | `/health`, `/public/*`, `/accessibility/*` |

Missing or invalid token: 401 with `WWW-Authenticate: Bearer`. Valid token without the role: 403.
`tests/test_auth_jwt.py` signs tokens with a throwaway RSA key and serves a fake JWKS to prove the whole chain.

## Endpoints and APEX mapping

All paths are under `/api/v1`. The OpenAPI document carries the same mapping as `x-apex-page`,
`x-apex-process` and `x-apex-authorization` on each operation. Page ids follow WP1's measured inventory.

| Method and path | Source (Strategic Planner page / process) | Role | Data |
| --- | --- | --- | --- |
| `GET /health` | | none | |
| `GET /enterprise/kpis` | page 1 Dashboard badges | viewer | synth + lock status |
| `GET /programs` | page 21 Initiatives IR | viewer | `synth.program` |
| `GET /projects` | page 86 Projects IR | viewer | `synth.p2_project` |
| `GET /projects/{no}` | page 3 Project Details (`log` process writes the interaction log) | viewer | `synth.p2_project`, `synth.p2_milestone`, `evs.project_state` |
| `PUT /projects/{no}/status` | page 24 Project form, `Process form Project`, validations `Link URL and name`, `Target complete`, trigger `sp_projects_biu` | pm | `synth.p2_project`, `evs.project_state`, `evs.project_history` |
| `POST /projects/{no}/kanban/move?column_id=` | page 4 Kanban Board, dynamic action `Drop Item` | pm | same |
| `POST /projects/{no}/archive` | page 47 `Archive project` (`sp_util.archive_project`), page 52 `unArchive project` | pm | `evs.project_state`, `evs.project_history` |
| `PUT /projects/{no}/milestones/{code}` | page 508 Milestone form, validations `Completed milestones need a date / an owner` | pm | `synth.p2_milestone`, `evs.project_history` |
| `GET /projects/{no}/history` | page 64 Project Change History (`sp_project_history`) | viewer | `evs.project_history` |
| `GET /schedule/milestones?status=slipped` | page 4 Kanban (late lane) | viewer | `synth.p2_milestone` |
| `GET /financial/summary` | page 161 | viewer | `synth.cefms_execution`, `synth.cefms_appropriation` |
| `GET /financial/variance-by-program` | page 161 | viewer | `synth.program`, `synth.cefms_execution` |
| `GET /workforce/labor` | page 74 People IR | viewer | `synth.ems_labor_log` |
| `GET /facilities/condition` | new in EVS (BUILDER SMS) | viewer | `synth.builder_facility_condition` |
| `GET /facilities/ci-distribution` | new in EVS | viewer | same |
| `GET /public/locks`, `GET /public/locks/{id}`, `GET /public/locks/stream/events` | new in EVS (LPMS, NDC, NOAA, USGS); WP5a router | none | `evs.lock_current`, `evs.stoppage`, `evs.lock_queue`, `evs.lockage`, `evs.gauge_fact` |
| `GET /public/srp/coverage` | new in EVS (cited public figures) | none | `evs.srp_snapshot`, `evs.srp_site` |
| `GET /admin/feeds` | page 10000 (Administration Rights) | admin | `evs.feed_health` |
| `GET /admin/thresholds`, `PUT /admin/thresholds` | page 10000 (Administration Rights) | admin | `evs.threshold` |

The PL/SQL ports behind the write endpoints are in `evs/legacy_ports/` (`projects.py`, `milestones.py`,
`kanban.py`); each function's docstring names the APEX page and process it replaces. They are pure functions
over dicts so `tests/test_legacy_ports.py` covers them without HTTP or a database.

## Schema ownership

- `db/migrations/0002..0005` (WP2): `legacy.*` (ora2pg), `evs.lock_dim`, `evs.lock_status_fact` (raw polls),
  `evs.status_eval` (status engine output), `evs.stoppage`, `evs.srp_*`, `evs.feed_health`, `evs.threshold` and
  `synth.*`. The repositories read the roll-up views rather than the base tables where amounts are derived:
  `synth.v_program_summary`, `synth.v_project_execution` (obligated and expended from `synth.cefms_funding`),
  `synth.v_labor_summary` (per-employee `ems_labor_log` plus `ems_labor_plan`), `synth.cefms_execution`,
  `synth.cefms_appropriation`, `synth.builder_facility_condition` and `evs.lock_current`.
  `synth.p2_milestone.forecast_date` is exposed as `current_date` (the P2 name) in the API.
- `db/migrations/0007_wp3_evs_state.sql` (this package): `evs.project_state`, `evs.project_history`,
  `evs.project_interaction_log` and the `evs.threshold.updated_by` column. These hold the APEX-only state
  (archive flag, status scale, link, note, history) that has no home in the P2-shaped `synth.p2_project`.
- Writes go to base tables only: `synth.p2_project` (`pct_complete`, `current_finish`, `schedule_health`),
  `synth.p2_milestone`, `evs.threshold` and the WP3 tables above.

## Tests

- `uv run pytest -q` with no database: fixtures mode, auth tests and the PL/SQL port tests run; `tests/test_db.py`
  is skipped.
- With PostGIS up (`make up`, or `docker run -p 5432:5432 -e POSTGRES_USER=evs -e POSTGRES_PASSWORD=evs -e POSTGRES_DB=evs postgis/postgis:17-3.5`):
  `tests/test_db.py` migrates, seeds, and checks that SQL mode returns the same rows as fixtures mode, that writes
  persist, and that CSV export works. `EVS_REQUIRE_DB=1` turns the skip into a failure (used in CI).
