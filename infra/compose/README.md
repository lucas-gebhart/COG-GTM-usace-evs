# Local demo stack (Docker Compose)

`make demo` from the repo root builds the images, starts every service, waits for all healthchecks and prints
the URLs. `make down` removes containers and volumes. Copy `.env.example` to `.env` to override anything.

| Service | Image | Port | Health signal |
|---|---|---|---|
| db | `postgis/postgis:17-3.5` | 5432 | `pg_isready` |
| keycloak | `quay.io/keycloak/keycloak:26.4` with `keycloak/evs-realm.json` imported | 8080 | management port 9000 `/health/ready` |
| minio | `minio/minio` (S3 API) | 9000, console 9001 | `mc ready local` |
| api | `apps/api/Dockerfile` (FastAPI, `evs migrate` on start) | 8000 | `GET /api/v1/health` |
| web | `apps/web/Dockerfile` (nginx, React build, PMTiles basemap) | 3000 | `GET /healthz` |

Start order is enforced with `depends_on: condition: service_healthy`: db and keycloak first, then api, then web.
Auth is disabled locally (`EVS_AUTH_DISABLED=true`); the realm ships demo users `demo.viewer`, `demo.pm`,
`demo.admin` (password `demo`) for when WP3 wires the token flow.

## Same images, three places

The same two application images run under Compose, on Fly.io (`infra/fly`) and, in the reference design, on
ECS Fargate in AWS GovCloud (`infra/terraform-govcloud`). Only environment variables change.

| Concern | Local Compose | Fly.io demo | GovCloud IL5 reference (code only) |
|---|---|---|---|
| Web (nginx + React, `/api` proxy, `/tiles` range requests) | `web` container, port 3000 | `usace-evs-web` machine, `/api` to `api.process.usace-evs-api.internal:8000` (the `api` process group only; the bare app name also resolves to the ingest machine) | ECS Fargate `web` service behind ALB + WAFv2, `/api` to Cloud Map `api.<name>.local` |
| API (FastAPI, SSE) | `api` container | `usace-evs-api` process group `api` | ECS Fargate `api` service, ALB path rule `/api/*` |
| Ingest | `uv run evs ingest --once` (dev) | `usace-evs-api` process group `ingest` (`evs ingest --loop`, `--once` fallback every 15 min) | ECS task run by EventBridge Scheduler every 15 minutes |
| Database | `postgis/postgis:17-3.5` volume | `usace-evs-db` (same image, Fly volume, private only) | Aurora PostgreSQL 17 with PostGIS, KMS, Secrets Manager managed password |
| Identity | Keycloak 26 realm `evs` | `usace-evs-keycloak` (same realm import) | Cognito user pool with OIDC federation placeholder for Army ICAM |
| Object storage (raw feed drops) | MinIO bucket | none (feeds cached in Postgres) | S3 bucket with KMS, versioning, 180 day lifecycle |
| Basemap | PMTiles baked into the web image (`tools/basemap/fetch.sh`) | same image | same image; S3 bucket provisioned for a larger extract |
| Secrets | `.env` | Fly secrets | Secrets Manager, injected into tasks by the execution role |
| Logs and metrics | `docker compose logs` | `fly logs` | CloudWatch Logs (KMS), alarms, dashboard |
| TLS termination | none (http://localhost) | Fly edge | ALB with FIPS TLS policy |
| CDN | none | Fly anycast | none: CloudFront is IL2 East/West only and is excluded |
| Feed source | `EVS_FEED_SOURCE=fixtures` | `live` with automatic fallback to cached rows | `live` from inside the boundary via NAT, or `fixtures` on a no-internet enclave |

This is a demo stack. The GovCloud column is a reference architecture expressed in Terraform and validated in
CI; it has not been applied, and an IL5 service listing is not an EVS authorization (see
`infra/terraform-govcloud/README.md`).
