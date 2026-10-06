.PHONY: up down api web test fixtures contract
up:        ; docker compose -f infra/compose/docker-compose.yml up --build -d
down:      ; docker compose -f infra/compose/docker-compose.yml down -v
api:       ; cd apps/api && uv run uvicorn evs.main:app --reload
web:       ; cd apps/web && pnpm dev
test:      ; cd apps/api && uv run pytest -q && cd ../web && pnpm test
fixtures:  ; python3 tools/fixtures/build_api_fixtures.py legacy/data_samples
contract:  ; cd apps/api && uv run evs openapi && cd ../web && pnpm gen:api
