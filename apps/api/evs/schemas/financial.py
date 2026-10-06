from datetime import date
from typing import Literal

from pydantic import BaseModel

from evs.schemas.common import AsOf, Page


class ExecutionPoint(BaseModel):
    period: date
    plan_cumulative: float
    obligated_cumulative: float
    expended_cumulative: float


class AppropriationRow(BaseModel):
    appropriation: str
    title: str
    allotted: float
    committed: float
    obligated: float
    expended: float
    expiring_fy: int | None = None


class FinancialSummary(BaseModel):
    fiscal_year: int
    execution_curve: list[ExecutionPoint]
    by_appropriation: list[AppropriationRow]
    as_of: AsOf


class LaborRow(BaseModel):
    district: str
    pay_period: str
    hours_plan: float
    hours_regular: float
    hours_overtime: float
    labor_cost: float


class LaborSummary(BaseModel):
    fiscal_year: int
    rows: list[LaborRow]
    page: Page | None = None
    as_of: AsOf


class FacilityRow(BaseModel):
    building_id: str
    installation: str
    district: str
    uniformat_section: str
    component_type: str
    ci: float
    bci: float
    deficiency_cost: float
    work_plan_year: int


class FacilitySummary(BaseModel):
    rows: list[FacilityRow]
    page: Page | None = None
    as_of: AsOf


class ProgramVariance(BaseModel):
    program_code: str
    name: str
    business_line: str
    division: str
    funded_amount: float
    obligated_amount: float
    plan_to_date: float
    variance_amount: float
    variance_pct: float


class VarianceByProgram(BaseModel):
    """Diverging variance bars on `/programs` and `/financial`."""

    fiscal_year: int
    rows: list[ProgramVariance]
    as_of: AsOf


class CiBucket(BaseModel):
    label: str
    ci_min: float
    ci_max: float
    band: Literal["good", "fair", "poor"]
    count: int
    deficiency_cost: float


class CiByInstallation(BaseModel):
    installation: str
    district: str
    component_count: int
    avg_ci: float
    min_ci: float
    deficiency_cost: float


class CiDistribution(BaseModel):
    """Histogram with BUILDER threshold bands (good 70 to 100, fair 40 to 69, poor 0 to 39)."""

    buckets: list[CiBucket]
    by_installation: list[CiByInstallation]
    as_of: AsOf
