#!/usr/bin/env bash
# Deploy the EVS demo to Fly.io (org personal, region iad). Idempotent: creates apps, volumes and secrets
# only when missing, then deploys in dependency order: db -> keycloak -> api (+ingest) -> web.
#
#   infra/fly/deploy.sh            deploy everything
#   infra/fly/deploy.sh api web    deploy a subset (db keycloak api web)
#
# Requires: flyctl, FLY_API_TOKEN (or `fly auth login`). Run from any directory; the script cd's to the repo root
# so the Docker build context is the same one Compose uses. Secrets are generated here and stored only in Fly:
#   usace-evs-db        POSTGRES_PASSWORD
#   usace-evs-api       EVS_DATABASE_URL, EVS_DATABASE_URL_SYNC
#   usace-evs-keycloak  KC_BOOTSTRAP_ADMIN_PASSWORD
# To reuse an existing database password (for example after the API app was recreated) export EVS_DB_PASSWORD.
set -euo pipefail

ORG="${FLY_ORG:-personal}"
REGION="${FLY_REGION:-iad}"
PREFIX="${EVS_FLY_PREFIX:-usace-evs}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

APPS=("$@")
if [ ${#APPS[@]} -eq 0 ]; then APPS=(db keycloak api web); fi

log() { printf '\n==> %s\n' "$*"; }

ensure_app() {
  local app="$1"
  if ! fly apps list --json | python3 -c "import json,sys; sys.exit(0 if any(a['Name']=='$app' for a in json.load(sys.stdin)) else 1)"; then
    log "creating app $app in org $ORG"
    fly apps create "$app" --org "$ORG"
  fi
}

ensure_volume() {
  local app="$1" name="$2" size="$3"
  if [ "$(fly volumes list -a "$app" --json | python3 -c "import json,sys; print(len([v for v in json.load(sys.stdin) if v['name']=='$name']))")" = "0" ]; then
    log "creating volume $name ($size GB) for $app in $REGION"
    fly volumes create "$name" -a "$app" --region "$REGION" --size "$size" --yes
  fi
}

has_secret() {
  local app="$1" key="$2"
  fly secrets list -a "$app" --json | python3 -c "import json,sys; sys.exit(0 if any(s['name']=='$key' for s in json.load(sys.stdin)) else 1)"
}

deploy() {
  local app="$1" config="$2"; shift 2
  log "deploying $app"
  fly deploy --config "$config" --app "$app" --primary-region "$REGION" --yes "$@" .
}

ensure_db_password() {
  if has_secret "$PREFIX-db" POSTGRES_PASSWORD && has_secret "$PREFIX-api" EVS_DATABASE_URL; then
    return
  fi
  if [ -z "${EVS_DB_PASSWORD:-}" ]; then
    if has_secret "$PREFIX-db" POSTGRES_PASSWORD || has_secret "$PREFIX-api" EVS_DATABASE_URL; then
      echo "One of the apps already has a database password and the other does not." >&2
      echo "Export EVS_DB_PASSWORD with the existing value (or unset both secrets) and rerun." >&2
      exit 1
    fi
    EVS_DB_PASSWORD="$(openssl rand -hex 24)"
    log "generated a new database password (stored only as Fly secrets)"
  fi
  local host="$PREFIX-db.internal"
  fly secrets set -a "$PREFIX-db" --stage "POSTGRES_PASSWORD=$EVS_DB_PASSWORD" >/dev/null
  fly secrets set -a "$PREFIX-api" --stage \
    "EVS_DATABASE_URL=postgresql+asyncpg://evs:$EVS_DB_PASSWORD@$host:5432/evs" \
    "EVS_DATABASE_URL_SYNC=postgresql://evs:$EVS_DB_PASSWORD@$host:5432/evs" >/dev/null
}

for target in "${APPS[@]}"; do
  case "$target" in
    db)
      ensure_app "$PREFIX-db"
      ensure_app "$PREFIX-api"
      ensure_volume "$PREFIX-db" pgdata 10
      ensure_db_password
      deploy "$PREFIX-db" infra/fly/db/fly.toml --ha=false
      ;;
    keycloak)
      ensure_app "$PREFIX-keycloak"
      ensure_volume "$PREFIX-keycloak" kcdata 1
      if ! has_secret "$PREFIX-keycloak" KC_BOOTSTRAP_ADMIN_PASSWORD; then
        log "generating Keycloak admin password (read it back with: fly ssh console -a $PREFIX-keycloak -C 'printenv KC_BOOTSTRAP_ADMIN_PASSWORD')"
        fly secrets set -a "$PREFIX-keycloak" --stage "KC_BOOTSTRAP_ADMIN_PASSWORD=$(openssl rand -base64 18)" >/dev/null
      fi
      deploy "$PREFIX-keycloak" infra/fly/keycloak/fly.toml --ha=false
      ;;
    api)
      ensure_app "$PREFIX-api"
      ensure_db_password
      deploy "$PREFIX-api" infra/fly/api/fly.toml --ha=false
      ;;
    web)
      ensure_app "$PREFIX-web"
      deploy "$PREFIX-web" infra/fly/web/fly.toml --ha=false
      ;;
    *) echo "unknown target $target (db keycloak api web)" >&2; exit 1 ;;
  esac
done

log "done"
echo "web      https://$PREFIX-web.fly.dev"
echo "api      https://$PREFIX-api.fly.dev/api/v1/health"
echo "keycloak https://$PREFIX-keycloak.fly.dev/realms/evs"
echo "db       $PREFIX-db.internal:5432 (private network only)"
