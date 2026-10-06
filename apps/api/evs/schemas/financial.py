from datetime import date

from pydantic import BaseModel

from evs.schemas.common import AsOf


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
    as_of: AsOf
