from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field


class FeedHealth(BaseModel):
    source: str
    endpoint: str
    cadence_minutes: int
    last_success_at: datetime | None
    last_error: str | None
    latency_ms: int | None
    status: Literal["healthy", "degraded", "down", "simulated", "fixtures"]
    mode: Literal["live", "fixtures", "simulated"] | None = None
    last_attempt_at: datetime | None = None
    http_status: int | None = None
    rows_parsed: int | None = None
    consecutive_failures: int = 0
    updated_at: datetime | None = None


class FeedHealthList(BaseModel):
    feeds: list[FeedHealth]
    generated_at: datetime


class ThresholdUpdate(BaseModel):
    """Status engine thresholds editable on `/admin` (APEX Administrator scheme)."""

    stale_after_minutes: int = Field(ge=1, le=1440)
    delay_yellow_minutes: int = Field(ge=1, le=1440)
    delay_red_minutes: int = Field(ge=1, le=2880)
    queue_yellow_vessels: int = Field(ge=1, le=100)
    lpms_failover_hours: int | None = Field(default=None, ge=1, le=168)  # WP5a; unchanged when omitted


class Thresholds(ThresholdUpdate):
    lpms_failover_hours: int
    source: Literal["settings", "db", "fixtures"] = "settings"
    updated_at: datetime | None = None
    updated_by: str | None = None


class AxeRouteResult(BaseModel):
    route: str
    viewport: str
    theme: str
    reduced_motion: bool = False
    violations: int
    passes: int
    incomplete: int
    run_at: datetime


class CriterionStatus(BaseModel):
    criterion: str
    name: str
    level: Literal["A", "AA"]
    method: Literal["automated", "manual", "not_applicable"]
    status: Literal["supports", "partially-supports", "does-not-support", "not-applicable", "not-evaluated"]
    notes: str = ""


class AccessibilityReadout(BaseModel):
    target: str
    routes: list[AxeRouteResult]
    criteria: list[CriterionStatus]
    acr_download_url: str
    generated_at: datetime
