"""Deterministic seed for the EVS demo database.

Public samples (NDC GIS, LPMS, SRP) are loaded verbatim with their provenance. Internal-system data
(P2, CEFMS, EMS, CMP, BUILDER) is generated from a fixed random seed and scaled from the FY26 O&M
budget justification extract in data/fy26_om_jsheet.csv; every generated row carries
source = 'synthetic'. Entry point: evs_seed.run.seed(database_url, reset=False).
"""

from datetime import UTC, datetime
from pathlib import Path

SEED = 20261006
NOW = datetime(2026, 10, 6, 14, 30, tzinfo=UTC)
FISCAL_YEAR = 2026
DATA = Path(__file__).resolve().parents[1] / "data"
