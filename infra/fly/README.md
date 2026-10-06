# Fly.io demo deployment

Public demo of the same images that `make demo` runs locally. Org `personal`, region `iad`.

| App | Image | Public URL | Private address |
|---|---|---|---|
| `usace-evs-web` | `apps/web/Dockerfile` (nginx, React, PMTiles) | https://usace-evs-web.fly.dev | |
| `usace-evs-api` | `apps/api/Dockerfile`, process groups `api` and `ingest` (`evs ingest --loop`, falls back to `--once` every 15 min until WP5a lands) | https://usace-evs-api.fly.dev/api/v1/health | `api.process.usace-evs-api.internal:8000` (the `api` process group only; the bare app name also resolves to the ingest machine) |
| `usace-evs-db` | `postgis/postgis:17-3.5` with a 10 GB volume | none (private only) | `usace-evs-db.internal:5432` |
| `usace-evs-keycloak` | `quay.io/keycloak/keycloak:26.4` + realm import (`keycloak/Dockerfile`) | https://usace-evs-keycloak.fly.dev/realms/evs | |

The work package asked for `evs-web`, `evs-api`, `evs-db`, `evs-keycloak`; those names are taken on Fly (app
names are global), so every app carries the `usace-` prefix. `evs-ingest` is the `ingest` process group of
`usace-evs-api` rather than a separate app: same image, same secrets, one fewer app to keep in sync.

nginx in `usace-evs-web` proxies `/api/` to `http://api.process.usace-evs-api.internal:8000` over the Fly private 6PN
Two Fly specifics are baked into `infra/fly/api/fly.toml` and `infra/fly/web/fly.toml`: the `api.process.` prefix limits the hostname to the `api` process group (the bare app name also resolves to the ingest machine, which has no listener on 8000), and the `api` process opens a dual-stack socket before exec'ing uvicorn because 6PN is IPv6 only while Fly health checks and fly-proxy arrive over IPv4.
network (`DNS_RESOLVER=[fdaa::3]`), so the browser only ever talks to the web app. `/tiles/usace.pmtiles` is
served from the web image with `Accept-Ranges: bytes`.

## Deploy

```
export FLY_API_TOKEN=...          # or `fly auth login`
infra/fly/deploy.sh               # db, keycloak, api, web in that order
infra/fly/deploy.sh api web       # subset
```

`deploy.sh` creates the apps and volumes if they do not exist, generates secrets that are missing (and never
prints them), then runs `fly deploy` with `--primary-region iad` for each target. Secrets:

| App | Secret | Set by |
|---|---|---|
| `usace-evs-db` | `POSTGRES_PASSWORD` | generated with `openssl rand` |
| `usace-evs-api` | `EVS_DATABASE_URL`, `EVS_DATABASE_URL_SYNC` | derived from the DB password, host `usace-evs-db.internal` |
| `usace-evs-keycloak` | `KC_BOOTSTRAP_ADMIN_PASSWORD` | generated; Fly secrets are write-only, reset it with `fly secrets set` if needed |

The API release command runs `evs migrate` and then `evs seed` (tolerated as missing until WP2 lands the seed
command) on every deploy. `EVS_FEED_SOURCE=live` with automatic fallback to cached rows, `EVS_AUTH_DISABLED=true`
until WP3 wires the token flow (`EVS_OIDC_ISSUER` already points at the Keycloak realm).

## GitHub Actions

`.github/workflows/deploy-fly.yml` runs on `workflow_dispatch` (optional `targets` input) and on pushes to
`main`, but only when the repository secret `FLY_API_TOKEN` exists. To add it:

1. Create a deploy token: `fly tokens create org -o personal` (or one `fly tokens create deploy -a <app>` per app
   and join them with commas).
2. GitHub repo, Settings, Secrets and variables, Actions, New repository secret, name `FLY_API_TOKEN`.
3. Optionally create an environment named `fly` with required reviewers; the job targets that environment.

Without the secret the workflow skips the deploy job and says so in the job summary.

## Database choice

`postgis/postgis:17-3.5` is deployed as a plain Fly app with a volume rather than Fly Postgres. Fly Postgres
(the unmanaged flex image) also ships PostGIS and `CREATE EXTENSION postgis` works there, but it is a different
image from the one Compose and the Terraform parameter notes describe, so parity wins. Trade-off: one machine,
no automatic failover, nightly `fly volumes snapshots` only. Fine for a demo; the GovCloud design uses Aurora.

## Keycloak

`start-dev --import-realm` with `KC_HOSTNAME=https://usace-evs-keycloak.fly.dev`, `KC_PROXY_HEADERS=xforwarded`
and the H2 dev database on a 1 GB volume. The realm import is the same `infra/compose/keycloak/evs-realm.json`,
which includes `https://usace-evs-web.fly.dev` in the client redirect URIs and web origins. Production mode with
a Postgres backend is a two line change once WP3 needs it.

## Sizing and cost (Fly list prices, October 2026, always on)

| App | Machine | RAM | Approx. per month (USD) |
|---|---|---|---|
| `usace-evs-web` | shared-cpu-1x | 512 MB | 3.19 |
| `usace-evs-api` (api + ingest machines) | 2 x shared-cpu-1x | 1 GB each | 2 x 5.70 |
| `usace-evs-db` | shared-cpu-1x | 1 GB | 5.70 + 10 GB volume 1.50 |
| `usace-evs-keycloak` | shared-cpu-1x | 1 GB | 5.70 + 1 GB volume 0.15 |
| **Total** | | | **about 28, plus egress** |

Machines are configured `auto_stop_machines = false` so the demo URL answers immediately; turning on auto stop
for web and keycloak halves that figure.
