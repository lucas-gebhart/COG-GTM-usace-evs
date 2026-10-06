.PHONY: up down api web test fixtures contract inventory legacy-export inventory-test
up:        ; docker compose -f infra/compose/docker-compose.yml up --build -d
down:      ; docker compose -f infra/compose/docker-compose.yml down -v
api:       ; cd apps/api && uv run uvicorn evs.main:app --reload
web:       ; cd apps/web && pnpm dev
test:      ; cd apps/api && uv run pytest -q && cd ../web && pnpm test
fixtures:  ; python3 tools/fixtures/build_api_fixtures.py legacy/data_samples
contract:  ; cd apps/api && uv run evs openapi && cd ../web && pnpm gen:api

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
