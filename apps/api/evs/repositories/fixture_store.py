"""Mutable in-memory copy of `fixtures/*.json` used in fixtures mode.

Write endpoints work without a database (state lives for the process lifetime) so the demo
and the fixtures test suite can exercise the PL/SQL ports end to end.
"""

from __future__ import annotations

import copy
from typing import Any

from evs.fixtures import load


class FixtureStore:
    def __init__(self) -> None:
        self._data: dict[str, Any] = {}
        self.project_state: dict[str, dict[str, Any]] = {}
        self.history: list[dict[str, Any]] = []
        self.interactions: list[dict[str, Any]] = []
        self.thresholds: dict[str, Any] | None = None

    def get(self, name: str) -> Any:
        if name not in self._data:
            self._data[name] = copy.deepcopy(load(name))
        return self._data[name]
