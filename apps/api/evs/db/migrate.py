"""Minimal forward-only SQL migrator (same files run on Docker PostGIS, Fly and Aurora)."""

import os
from pathlib import Path

import psycopg


def default_migrations_dir() -> Path:
    """Repo checkout (apps/api/evs/db -> <root>/db/migrations) or container image (/db/migrations)."""
    here = Path(__file__).resolve()
    candidates = [Path("/db/migrations")]
    if len(here.parents) > 4:
        candidates.insert(0, here.parents[4] / "db" / "migrations")
    for candidate in candidates:
        if candidate.is_dir():
            return candidate
    raise FileNotFoundError("db/migrations not found; set EVS_MIGRATIONS_DIR")


MIGRATIONS_DIR = Path(os.environ.get("EVS_MIGRATIONS_DIR") or default_migrations_dir())


def run(database_url_sync: str, directory: Path = MIGRATIONS_DIR) -> list[str]:
    applied: list[str] = []
    with psycopg.connect(database_url_sync, autocommit=True) as conn:
        conn.execute(
            "CREATE TABLE IF NOT EXISTS schema_migration ("
            "  filename text PRIMARY KEY, applied_at timestamptz NOT NULL DEFAULT now())"
        )
        done = {r[0] for r in conn.execute("SELECT filename FROM schema_migration")}
        for path in sorted(directory.glob("*.sql")):
            if path.name in done:
                continue
            with conn.transaction():
                conn.execute(path.read_text())
                conn.execute("INSERT INTO schema_migration(filename) VALUES (%s)", (path.name,))
            applied.append(path.name)
    return applied
