from datetime import UTC, datetime
from typing import Literal

from pydantic import BaseModel, Field, model_validator

Freshness = Literal["fresh", "aging", "stale", "simulated"]


class AsOf(BaseModel):
    """Every dataset carries both the source timestamp and when EVS fetched it."""

    source_as_of: datetime | None = Field(None, description="Newest timestamp inside the source payload")
    fetched_at: datetime | None = Field(None, description="When the EVS ingestion worker stored it")
    freshness: Freshness = "fresh"
    source: str = Field("fixtures", description="live | fixtures | simulated | synthetic")

    @model_validator(mode="after")
    def _stamp_generated_sources(self) -> "AsOf":
        """Synthetic and fixture rows have no upstream feed: the request time is their source time."""
        if self.source in {"synthetic", "fixtures"}:
            self.fetched_at = self.fetched_at or datetime.now(UTC)
            self.source_as_of = self.source_as_of or self.fetched_at
        return self


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
