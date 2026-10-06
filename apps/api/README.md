# EVS API (FastAPI)

- `uv sync --extra dev` then `uv run uvicorn evs.main:app --reload`
- `uv run evs migrate` applies `db/migrations/*.sql`
- `uv run evs openapi` regenerates `packages/contract/openapi.json` (the web client types are built from it)
- `uv run pytest`, `uv run ruff check .`

Routers are stubs over `fixtures/*.json` until the work packages land: WP2 (schema and synthetic data), WP3 (SQL-backed handlers), WP5a (ingestion and lock status engine).
