COMPOSE := docker compose -f infra/compose/docker-compose.yml

.PHONY: up down demo logs api web test fixtures contract basemap tf-validate fly-deploy inventory legacy-export inventory-test
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
fixtures:    ; cd apps/api && uv run evs dump-fixtures
contract:    ; cd apps/api && uv run evs openapi && cd ../web && pnpm gen:api
basemap:     ; tools/basemap/fetch.sh
tf-validate: ; cd infra/terraform-govcloud && terraform init -backend=false -input=false && terraform validate
fly-deploy:  ; infra/fly/deploy.sh

APEX_EXPORT_URL = https://raw.githubusercontent.com/oracle/apex/24.2/starter-apps/strategic-planner/strategic-planner.zip
APEX_EXPORT_DIR = legacy/strategic-planner/f7150

legacy-export:  ## re-download and unzip the Oracle APEX Strategic Planner export (zip stays untracked)
	curl -fsSL -o legacy/strategic-planner/strategic-planner.zip $(APEX_EXPORT_URL)
	cd legacy/strategic-planner && rm -rf f7150 && unzip -q strategic-planner.zip

inventory:  ## parse the APEX export into legacy/inventory.json, traceability.csv, schema/ and page tables
	PYTHONPATH=tools/apex-inventory python3 -m apex_inventory $(APEX_EXPORT_DIR) \
	  --mapping legacy/mapping.json \
	  --out legacy/inventory.json \
	  --trace legacy/traceability.csv \
	  --schema-out legacy/strategic-planner/schema \
	  --pages-md legacy/strategic-planner/screenshots/pages.md \
	  --summary

inventory-test:
	cd tools/apex-inventory && python3 -m pytest -q
