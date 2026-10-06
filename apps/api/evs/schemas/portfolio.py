from datetime import date
from typing import Literal

from pydantic import BaseModel

from evs.schemas.common import AsOf, Page

Appropriation = Literal["96X3121", "96X3122", "96X3123", "96X3112", "96X4902"]
ScheduleHealth = Literal["on_track", "at_risk", "late"]


class Program(BaseModel):
    program_code: str
    name: str
    business_line: str
    division: str
    funded_amount: float
    obligated_amount: float
    expended_amount: float
    variance_pct: float
    project_count: int
    schedule_health: ScheduleHealth


class ProgramList(BaseModel):
    items: list[Program]
    page: Page
    as_of: AsOf


class Milestone(BaseModel):
    code: str
    name: str
    baseline_date: date | None
    current_date: date | None
    actual_date: date | None
    status: Literal["complete", "scheduled", "slipped"]


class Project(BaseModel):
    p2_project_no: str
    name: str
    program_code: str
    district: str
    division: str
    business_line: str
    phase: str
    pdt_lead: str
    baseline_finish: date | None
    current_finish: date | None
    pct_complete: float
    funded_amount: float
    obligated_amount: float
    expended_amount: float
    schedule_health: ScheduleHealth
    milestones: list[Milestone] = []


class ProjectList(BaseModel):
    items: list[Project]
    page: Page
    as_of: AsOf
