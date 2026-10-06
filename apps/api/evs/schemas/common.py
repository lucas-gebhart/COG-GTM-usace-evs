from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field

Freshness = Literal["fresh", "aging", "stale", "simulated"]


class AsOf(BaseModel):
    """Every dataset carries both the source timestamp and when EVS fetched it."""

    source_as_of: datetime | None = Field(None, description="Newest timestamp inside the source payload")
    fetched_at: datetime | None = Field(None, description="When the EVS ingestion worker stored it")
    freshness: Freshness = "fresh"
    source: str = Field("fixtures", description="live | fixtures | simulated | synthetic")


class Page(BaseModel):
    total: int
    limit: int
    offset: int


class KpiTile(BaseModel):
    id: str
    label: str
    value: float
    unit: str = ""
    delta: float | None = None
    delta_label: str | None = None
    as_of: AsOf


class KpiList(BaseModel):
    """Enterprise overview tiles (route `/`)."""

    tiles: list[KpiTile]
    as_of: AsOf
