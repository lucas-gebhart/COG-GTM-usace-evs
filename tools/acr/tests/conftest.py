from __future__ import annotations

import json
from datetime import UTC, datetime
from pathlib import Path

import pytest


def axe_cell(
    route: str,
    viewport: str = "desktop-1280",
    theme: str = "light",
    reduced: bool = False,
    violations: list[dict] | None = None,
) -> dict:
    return {
        "route": route,
        "url": f"http://localhost:4173{route}",
        "title": "Test | EVS",
        "viewport": viewport,
        "width": 1280,
        "height": 800,
        "theme": theme,
        "reducedMotion": reduced,
        "runAt": "2026-10-06T12:00:00+00:00",
        "gitSha": "abcdef1234567890",
        "axeVersion": "4.13.0",
        "violations": violations or [],
        "advisories": [],
        "incomplete": [],
        "passes": [{"id": "document-title"}, {"id": "html-has-lang"}, {"id": "button-name"}],
        "inapplicable": ["blink"],
    }


@pytest.fixture
def evidence_dir(tmp_path: Path) -> Path:
    axe = tmp_path / "axe"
    axe.mkdir()
    (axe / "a.json").write_text(json.dumps(axe_cell("/")))
    (axe / "b.json").write_text(json.dumps(axe_cell("/programs", theme="leadership", reduced=True)))
    kb = tmp_path / "keyboard"
    kb.mkdir()
    (kb / "root.json").write_text(
        json.dumps(
            {
                "route": "/",
                "runAt": "2026-10-06T12:00:00+00:00",
                "skipLinkMovesFocusToMain": True,
                "navReached": True,
                "stepsWithoutVisibleFocus": 0,
                "popovers": [],
            }
        )
    )
    rf = tmp_path / "reflow"
    rf.mkdir()
    (rf / "root.json").write_text(
        json.dumps({"route": "/", "theme": "light", "runAt": "2026-10-06T12:00:00+00:00", "pass": True})
    )
    return tmp_path


@pytest.fixture
def now() -> datetime:
    return datetime(2026, 10, 6, 12, 30, tzinfo=UTC)
