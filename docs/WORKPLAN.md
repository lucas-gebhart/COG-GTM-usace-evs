# EVS build work packages

Each WP is one child session and one PR into `main`. Interfaces between WPs are fixed by WP0:
`packages/contract/openapi.json` (regenerated with `uv run evs openapi`), route list in `apps/web/src/app/routes.ts`,
schemas `evs`/`legacy`/`synth` in `db/migrations/0001_extensions.sql`, and `evs/schemas/*.py` Pydantic models.

| WP | Scope | Owns (paths) | Depends on |
|---|---|---|---|
| WP0 | Monorepo scaffold, API stubs over fixtures, web shell, Compose, Keycloak realm, CI | everything initial | none |
| WP1 | `tools/apex-inventory` parser over the Strategic Planner export; `legacy/strategic-planner/` split export + screenshots; `legacy/inventory.json`, `legacy/traceability.csv` | `tools/apex-inventory/**`, `legacy/strategic-planner/**`, `legacy/*.csv|json` | WP0 |
| WP2 | ora2pg run on the SP_ schema into `legacy`; `synth` schema migrations; generators for CEFMS/EMS/P2/BUILDER seeded from FY26 J-sheets; SRP and lock dimension tables; `evs seed` command | `db/migrations/00[2-5]*.sql`, `db/seed/**`, `evs/cli.py` seed command | WP0 |
| WP3 | SQL-backed handlers replacing fixture routers; PL/SQL process ports; role checks per APEX authz scheme; tests against Compose PostGIS | `apps/api/evs/routers/**`, `apps/api/evs/repositories/**`, `apps/api/tests/**` | WP0, WP2 schema (coordinate via migrations) |
| WP4a | Web shell: `<Figure>` chart wrapper, `<DataTable>` (TanStack + USWDS, card mode under 640 px), as-of badge, status chip, leadership theme toggle, Storybook + axe, MSW mock mode | `apps/web/src/components/**`, `apps/web/src/styles/**`, `apps/web/.storybook/**` | WP0 |
| WP4b | Internal pages 1-7 on the real API | `apps/web/src/pages/{Enterprise,Programs,Projects,ProjectDetail,Financial,Workforce,Schedule,Facilities}*` | WP3, WP4a |
| WP5a | Ingestion worker: LPMS/GIS/NOAA/USGS adapters, 11-rule status engine, simulator fallback, feed health table, LISTEN/NOTIFY to SSE | `apps/api/evs/ingest/**`, `db/migrations/006*.sql`, `evs/routers/locks.py` stream | WP0 |
| WP5b | Public pages: lock table + MapLibre map + detail panel + SSE; SRP page | `apps/web/src/pages/{Locks,Srp}*`, `apps/web/public/tiles/**` | WP4a, WP5a |
| WP6a | a11y CI matrix (routes x viewport x theme), pa11y-ci, Lighthouse, manual test plan, `tools/acr/` OpenACR generator | `.github/workflows/ci.yml` a11y job, `apps/web/e2e/**`, `tools/acr/**`, `docs/a11y/**` | WP0 |
| WP6b | `/accessibility` page consuming CI artefacts; ACR download | `apps/web/src/pages/Accessibility*`, `evs/routers/accessibility.py` | WP6a, WP4a |
| WP7 | Fly.io deployment (web, api, ingest, postgis, keycloak), Terraform for GovCloud (code only), Compose hardening | `infra/fly/**`, `infra/terraform-govcloud/**`, `infra/compose/**` | WP0 |
| WP8 | Integration, run-of-show, recording, README | `docs/RUN_OF_SHOW.md`, `README.md` | all |

Rules for every WP: no em dashes in docs; status never by colour alone; every dataset response carries `as_of`;
simulated or synthetic rows are labelled; `uv run ruff check`, `uv run pytest`, `pnpm lint && pnpm typecheck && pnpm test` pass before the PR.
