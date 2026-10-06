COMPOSE := docker compose -f infra/compose/docker-compose.yml

.PHONY: up down demo logs api web test fixtures contract basemap tf-validate fly-deploy
up:          ; $(COMPOSE) up --build -d
down:        ; $(COMPOSE) down -v
demo:        ## build, start and wait for every healthcheck, then print the URLs
	$(COMPOSE) up --build -d --wait --wait-timeout 600
	@echo
	@echo "EVS demo is up (all healthchecks passed):"
	@echo "  web       http://localhost:3000"
	@echo "  api       http://localhost:8000/api/v1/health   docs http://localhost:8000/docs"
	@echo "  keycloak  http://localhost:8080  (admin / admin; demo.viewer, demo.pm, demo.admin / demo)"
	@echo "  minio     http://localhost:9001  (evs / evs-local-minio)"
	@echo "  postgis   postgresql://evs:evs@localhost:5432/evs"
	@echo "Stop with: make down"
logs:        ; $(COMPOSE) logs -f --tail=100
api:         ; cd apps/api && uv run uvicorn evs.main:app --reload
web:         ; cd apps/web && pnpm dev
test:        ; cd apps/api && uv run pytest -q && cd ../web && pnpm test
fixtures:    ; python3 tools/fixtures/build_api_fixtures.py legacy/data_samples
contract:    ; cd apps/api && uv run evs openapi && cd ../web && pnpm gen:api
basemap:     ; tools/basemap/fetch.sh
tf-validate: ; cd infra/terraform-govcloud && terraform init -backend=false -input=false && terraform validate
fly-deploy:  ; infra/fly/deploy.sh
