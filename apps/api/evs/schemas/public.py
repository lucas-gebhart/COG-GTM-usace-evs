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
    division: str | None = Field(default=None, description="USACE division code, e.g. LRD")
    state: str | None = None
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


class StatusHistoryPoint(BaseModel):
    """One status engine evaluation, newest last; the detail panel draws the 24-hour history from these."""

    evaluated_at: datetime
    status: LockStatus
    status_reason: str
    rule_no: int | None = None
    source: str
    freshness: str


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
    history: list[StatusHistoryPoint] = Field(
        default_factory=list, description="Status evaluations from the last 24 hours, oldest first"
    )
    ntni_notices: list[dict] = Field(
        default_factory=list, description="Notices to Navigation Interests that name this lock"
    )


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


class SrpCitation(BaseModel):
    """Provenance for one headline figure. The UI shows source and year next to every number."""

    figure: str = Field(description="Key in `headline`, e.g. river_systems")
    label: str
    value_text: str = Field(description="The figure as the source states it, e.g. 'nearly 15,000 miles'")
    source: str
    source_url: str
    year: int
    note: str | None = None


class SrpCoverage(BaseModel):
    snapshots: list[SrpSnapshot]
    sites: list[SrpSite]
    headline: dict[str, float | int | str]
    citations: list[SrpCitation] = Field(default_factory=list)
    as_of: AsOf
