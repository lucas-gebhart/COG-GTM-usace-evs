from datetime import date, datetime
from typing import Literal

from pydantic import BaseModel, Field

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


class ProjectMilestone(Milestone):
    """Milestone row joined to its project, for the schedule page (route `/schedule`)."""

    p2_project_no: str
    project_name: str
    program_code: str
    district: str
    slip_days: int | None = None


class MilestoneList(BaseModel):
    items: list[ProjectMilestone]
    page: Page
    as_of: AsOf


class KanbanColumn(BaseModel):
    """Port of the Kanban Board column derivation (APEX page 4 region SQL)."""

    column_id: int
    heading: str
    pct_complete_range: str


class ProjectStatusUpdate(BaseModel):
    """Body of `PUT /projects/{p2_project_no}/status` (APEX page 24 Project form)."""

    pct_complete: int = Field(
        ge=0, le=100, description="Must be a multiple of 10 (sp_projects_pct_complete_ck)"
    )
    phase: str | None = None
    current_finish: date | None = Field(None, description="Target complete; required at 50 percent or more")
    status_scale: str | None = Field(None, min_length=1, max_length=1)
    link_url: str | None = None
    link_name: str | None = None
    note: str | None = None


class ProjectArchiveUpdate(BaseModel):
    """Body of `POST /projects/{p2_project_no}/archive` (APEX pages 47 and 52)."""

    archived: bool
    reason: str | None = None


class MilestoneUpdate(BaseModel):
    """Body of `PUT /projects/{p2_project_no}/milestones/{code}` (APEX page 508 Milestone form)."""

    current_date: date | None = None
    actual_date: date | None = None
    status: Literal["complete", "scheduled", "slipped"] | None = None
    owner: str | None = None
    description: str | None = None


class ProjectHistoryEvent(BaseModel):
    """One row of the change history (APEX page 64 Project Change History, sp_project_history)."""

    id: int | None = None
    p2_project_no: str
    attribute: str
    change_type: Literal["CREATE", "UPDATE", "DELETE", "ARCHIVE", "UNARCHIVE", "VIEW"]
    old_value: str | None = None
    new_value: str | None = None
    changed_on: datetime
    changed_by: str


class ProjectHistoryList(BaseModel):
    p2_project_no: str
    events: list[ProjectHistoryEvent]
    as_of: AsOf


class ProjectStatusResult(BaseModel):
    project: Project
    kanban: KanbanColumn
    archived: bool = False
    history: list[ProjectHistoryEvent]
    as_of: AsOf
