from pathlib import Path

import pytest

FIXTURES = Path(__file__).parent / "fixtures"
REPO_ROOT = Path(__file__).resolve().parents[3]
FULL_EXPORT = REPO_ROOT / "legacy" / "strategic-planner" / "f7150"


@pytest.fixture(scope="session")
def mini_export() -> Path:
    return FIXTURES / "mini_export"


@pytest.fixture(scope="session")
def mini_mapping() -> Path:
    return FIXTURES / "mini_mapping.json"


@pytest.fixture(scope="session")
def full_export() -> Path:
    if not (FULL_EXPORT / "application" / "pages").is_dir():
        pytest.skip("full Strategic Planner export not present (run make legacy-export)")
    return FULL_EXPORT
