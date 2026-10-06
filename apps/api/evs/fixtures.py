"""Fixture loader. Stub routers serve these until WP3 wires the database."""

import json
from functools import lru_cache
from pathlib import Path
from typing import Any

FIXTURE_DIR = Path(__file__).resolve().parents[1] / "fixtures"


@lru_cache
def load(name: str) -> Any:
    path = FIXTURE_DIR / f"{name}.json"
    with path.open() as f:
        return json.load(f)
