"""Python ports of the Oracle APEX Strategic Planner PL/SQL behind the migration slice.

Each function's docstring cites the APEX page and process (or trigger / package procedure) it
replaces, as listed in `legacy/inventory.json` (WP1) and the exported `f7150` application.
The ports are pure functions over dictionaries so they can be unit tested without a database;
the routers in `evs/routers/projects_write.py` persist their results through the repositories.
"""

from evs.legacy_ports.kanban import KANBAN_COLUMNS, kanban_column, pct_for_column
from evs.legacy_ports.milestones import apply_milestone_update, validate_milestone
from evs.legacy_ports.projects import (
    STATUS_SCALE_A,
    ProjectValidationError,
    apply_project_status,
    archive_project,
    normalize_tags,
    project_history_events,
    status_label,
    un_archive_project,
    validate_project_form,
)

__all__ = [
    "KANBAN_COLUMNS",
    "STATUS_SCALE_A",
    "ProjectValidationError",
    "apply_milestone_update",
    "apply_project_status",
    "archive_project",
    "kanban_column",
    "normalize_tags",
    "pct_for_column",
    "project_history_events",
    "status_label",
    "un_archive_project",
    "validate_milestone",
    "validate_project_form",
]
