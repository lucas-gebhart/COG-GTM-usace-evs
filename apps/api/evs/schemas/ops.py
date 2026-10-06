from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field

from evs.schemas.common import AsOf


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


ConformanceStatus = Literal[
    "supports", "partially-supports", "does-not-support", "not-applicable", "not-evaluated"
]
Chapter = Literal[
    "success_criteria_level_a",
    "success_criteria_level_aa",
    "functional_performance_criteria",
    "support_documentation_and_services",
]


class AxeViolation(BaseModel):
    rule: str
    impact: Literal["critical", "serious", "moderate", "minor", "unknown"]
    nodes: int
    help_url: str = ""
    help: str = ""
    source: Literal["axe", "lighthouse", "pa11y"] = "axe"
    where: str = ""


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
    """One axe-core run: route x viewport x theme x reduced-motion cell."""

    route: str
    viewport: str
    theme: str
    reduced_motion: bool = False
    violations: int
    passes: int
    incomplete: int
    advisories: int = 0
    run_at: datetime
    violation_details: list[AxeViolation] = Field(default_factory=list)
    incomplete_rules: list[str] = Field(default_factory=list)


class EvidenceLink(BaseModel):
    label: str
    href: str


class CriterionStatus(BaseModel):
    criterion: str
    name: str
    level: Literal["A", "AA", "508"]
    chapter: Chapter
    chapter_title: str
    method: Literal["automated", "manual", "not_applicable"]
    status: ConformanceStatus
    notes: str = ""
    detail: str = Field("", description="Full OpenACR note for the row")
    automated_cells: int = 0
    open_violations: int = 0
    manual_tests: list[str] = Field(
        default_factory=list, description="MT-* ids from docs/a11y/MANUAL_TEST_PLAN.md"
    )
    tester: str | None = None
    attested_on: str | None = None
    evidence: list[EvidenceLink] = Field(default_factory=list)


class ReadoutSummary(BaseModel):
    criteria_total: int
    supports: int
    partially_supports: int
    does_not_support: int
    not_applicable: int
    not_evaluated: int
    routes_tested: int
    cells: int
    zero_violation_cells: int
    viewports: list[str]
    themes: list[str]
    motion_settings: int
    total_violations: int
    total_advisories: int
    needs_review: int = Field(0, description="axe incomplete checks plus pa11y needs-review items")
    last_run_at: datetime | None = None
    keyboard_routes_passed: int = 0
    keyboard_routes_total: int = 0
    reflow_cells_passed: int = 0
    reflow_cells_total: int = 0
    lighthouse_runs: int = 0
    lighthouse_min_score: float | None = None
    pa11y_urls: int = 0
    pa11y_errors: int = 0
    manual_passed: int = 0
    manual_total: int = 0


class ToolVersions(BaseModel):
    axe: str
    pa11y: str | None = None
    lighthouse: str | None = None
    generator: str


class ManualTestRow(BaseModel):
    """One assistive technology or input condition from the manual test plan."""

    id: str
    name: str
    category: Literal["screen_reader", "keyboard", "zoom", "contrast", "motion", "touch", "forms", "other"]
    assistive_tech: str | None = None
    version: str = ""
    tests: list[str]
    status: Literal["planned", "passed", "failed", "partial", "not-evaluated"]
    criteria_total: int
    criteria_attested: int
    tester: str | None = None
    date: str | None = None


class ArtifactLink(BaseModel):
    name: str
    label: str
    media_type: str
    href: str


class ConformanceStatement(BaseModel):
    product: str
    version: str
    description: str = ""
    standard: str
    design_rules: list[str]
    scope_routes: list[str]
    evaluation_methods: str
    known_issues: list[str]
    contact: str
    repository: str = ""
    legal_disclaimer: str = ""
    report_date: str
    git_sha: str
    demo_notice: str


class AccessibilityReadout(BaseModel):
    """Generated by evs-acr-gen (tools/acr); never edited by hand."""

    target: str
    routes: list[AxeRouteResult]
    criteria: list[CriterionStatus] = Field(description="WCAG 2.1 A and AA rows (48)")
    section508: list[CriterionStatus] = Field(
        default_factory=list, description="Revised 508 FPC and support rows"
    )
    acr_download_url: str
    generated_at: datetime
    git_sha: str = "unknown"
    axe_version: str = "unknown"
    as_of: AsOf
    summary: ReadoutSummary
    versions: ToolVersions
    manual: list[ManualTestRow]
    artifacts: list[ArtifactLink]
    statement: ConformanceStatement
