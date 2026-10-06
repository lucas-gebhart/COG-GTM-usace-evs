from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field

from evs.schemas.common import AsOf

LockStatus = Literal["operating", "delayed", "closed", "stale", "unknown"]


class LockSummary(BaseModel):
    """One row of the live lock table. Geometry comes from the NDC GIS layer, status from LPMS."""

    lock_id: str = Field(description="riverCode + '-' + lockNo, e.g. OH-79")
    river_code: str
    river_name: str
    lock_name: str
    lock_no: str
    river_mile: float | None
    district: str | None
    chambers: int | None
    latitude: float | None
    longitude: float | None
    status: LockStatus
    status_reason: str
    vessels_queued: int | None
    avg_delay_4h_min: float | None
    avg_delay_24h_min: float | None
    last_lockage_at: datetime | None
    gauge_stage_ft: float | None = None
    flood_category: str | None = None
    active_stoppages: int = 0
    as_of: AsOf


class LockList(BaseModel):
    items: list[LockSummary]
    rivers: list[dict[str, str]]
    counts: dict[LockStatus, int]
    as_of: AsOf


class LockDetail(LockSummary):
    lift_ft: float | None = None
    chamber_dimensions: str | None = None
    year_opened: int | None = None
    owner: str | None = None
    operator: str | None = None
    queue: list[dict] = []
    stoppages: list[dict] = []
    recent_lockages: list[dict] = []
    gauges: list[dict] = Field(
        default_factory=list, description="Latest NOAA NWPS and USGS NWIS readings for the lock"
    )
    status_inputs: dict = Field(default_factory=dict, description="inputs_used by the status engine")


class SrpSnapshot(BaseModel):
    year: int
    river_systems: int | None
    dams: int | None
    river_miles: int | None
    floodplain_acres: int | None = None
    source: str
    source_url: str


class SrpSite(BaseModel):
    name: str
    river: str
    state: str
    district: str | None
    nid_id: str | None
    latitude: float | None
    longitude: float | None
    year_joined: int | None
    source_url: str


class SrpCoverage(BaseModel):
    snapshots: list[SrpSnapshot]
    sites: list[SrpSite]
    headline: dict[str, float | int | str]
    as_of: AsOf
