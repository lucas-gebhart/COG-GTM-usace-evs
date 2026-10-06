# USACE Enterprise Visibility Suite (EVS) demo

Oracle APEX to custom-code modernization demo: a React + USWDS front end, FastAPI API and PostgreSQL/PostGIS
data layer that runs identically in Docker Compose, on Fly.io and (by design) on AWS GovCloud IL5 services.
Public value pages use live USACE Lock Performance Monitoring System feeds and Sustainable Rivers Program figures;
internal CEFMS, EMS, P2/CMP and BUILDER data is synthetic.

- Plan and decisions: [docs/PLAN.md](docs/PLAN.md)
- Work packages: [docs/WORKPLAN.md](docs/WORKPLAN.md)
- Research: [docs/research/](docs/research/)

## Run locally

```bash
make up            # postgis, keycloak, minio, api (:8000), web (:3000)
make api           # or run the API with reload outside Docker
make web           # Vite dev server on :5173 proxying /api to :8000
make test
make inventory     # parse the APEX export into legacy/inventory.json, traceability.csv, schema/
make legacy-export # re-download the Oracle APEX Strategic Planner zip (ignored by git) and unzip it
```

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
