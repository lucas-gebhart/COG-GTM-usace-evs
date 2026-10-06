# USACE Enterprise Visibility Suite (EVS) demo

Oracle APEX to custom-code modernization demo: a React + USWDS front end, FastAPI API and PostgreSQL/PostGIS
data layer that runs identically in Docker Compose, on Fly.io and (by design) on AWS GovCloud IL5 services.
Public value pages use live USACE Lock Performance Monitoring System feeds and Sustainable Rivers Program figures;
internal CEFMS, EMS, P2/CMP and BUILDER data is synthetic.

- Hosted demo: https://usace-evs-web.fly.dev (API health: https://usace-evs-api.fly.dev/api/v1/health)
- Demo script: [docs/RUN_OF_SHOW.md](docs/RUN_OF_SHOW.md)
- Plan and decisions: [docs/PLAN.md](docs/PLAN.md)
- Work packages: [docs/WORKPLAN.md](docs/WORKPLAN.md)
- Research: [docs/research/](docs/research/)
- Public-feed ingestion and lock status engine: [docs/ingest.md](docs/ingest.md)
- APEX to EVS migration pipeline and traceability: [docs/MIGRATION_PIPELINE.md](docs/MIGRATION_PIPELINE.md)
- Section 508 evidence: `/accessibility` in the app, [docs/a11y/](docs/a11y/)
- Deployment: [infra/compose/README.md](infra/compose/README.md), [infra/fly/README.md](infra/fly/README.md), [infra/terraform-govcloud/README.md](infra/terraform-govcloud/README.md)

## Run locally

```bash
make up            # postgis, keycloak, minio, api (:8000), web (:3000)
make api           # or run the API with reload outside Docker
make web           # Vite dev server on :5173 proxying /api to :8000
make test
make inventory     # parse the APEX export into legacy/inventory.json, traceability.csv, schema/
make legacy-export # re-download the Oracle APEX Strategic Planner zip (ignored by git) and unzip it
```

Lock status comes from the public-feed worker (`cd apps/api && uv run evs ingest --once`, or the `ingest` Compose
service). `EVS_FEED_SOURCE=live` polls LPMS, NDC GIS, NOAA NWPS and USGS NWIS; `fixtures` (the default) replays
`legacy/data_samples`; `simulated` runs the labelled Markov simulator. See [docs/ingest.md](docs/ingest.md).

## Pages

| Route | Source | APEX page |
|---|---|---|
| `/` Enterprise overview, `/programs`, `/projects`, `/projects/:p2`, `/financial`, `/workforce`, `/schedule`, `/facilities` | synthetic CEFMS, P2/CMP, EMS, BUILDER | 1, 21, 86, 3, 161, 74, 4, none |
| `/admin` feed health and status engine thresholds (role `evs_admin`) | live feed telemetry | 10000 |
| `/public/locks`, `/public/locks/:id` | live LPMS, NDC GIS, NOAA, USGS | none |
| `/public/srp` | cited public SRP figures | none |
| `/accessibility` | CI axe, Lighthouse, reflow artifacts, OpenACR | none |

Roles: with `EVS_AUTH_DISABLED=true` (Compose, Fly) the header role switcher sends `X-Evs-Demo-Role`; with
Keycloak enabled the same roles come from the bearer token (`evs_viewer`, `evs_pm`, `evs_admin`).

## Layout

```
apps/api         FastAPI service, ingestion workers, status engine, CLI (uv)
apps/web         Vite + React 19 + USWDS, Playwright + axe
db/migrations    plain SQL, applied by `evs migrate` (same files for Docker, Fly, Aurora)
db/seed          public sample loaders, synthetic data generators, `evs seed` and `evs dump-fixtures`
packages/contract/openapi.json   API contract; web types generated from it
legacy/          APEX export (strategic-planner/f7150), mapping.json, inventory.json, traceability.csv, data samples
tools/apex-inventory/  stdlib Python parser for the APEX export (see docs/MIGRATION_PIPELINE.md)
tools/           apex-inventory parser, fixture builder (db/synth), ACR generator
infra/           compose, fly, terraform-govcloud
docs/            plan, work packages, research reports, run of show
```
