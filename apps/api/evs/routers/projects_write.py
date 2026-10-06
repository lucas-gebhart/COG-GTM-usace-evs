"""Write endpoints for the Strategic Planner slice (Contributor scheme -> evs_pm).

Each handler calls the PL/SQL port in `evs.legacy_ports` and persists the result through the
portfolio repository: project status (page 24 form, page 4 Kanban drop), archive / un-archive
(pages 47 and 52), milestone form (page 508) and change history (page 64).
"""

from __future__ import annotations

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query

from evs.auth import Principal, require_pm, require_viewer
from evs.legacy_ports import (
    ProjectValidationError,
    apply_milestone_update,
    apply_project_status,
    archive_project,
    kanban_column,
    pct_for_column,
    project_history_events,
    un_archive_project,
)
from evs.repositories import Repositories, get_repos
from evs.routers._common import apex_validation_error, stamp
from evs.schemas.portfolio import (
    KanbanColumn,
    Milestone,
    MilestoneUpdate,
    Project,
    ProjectArchiveUpdate,
    ProjectHistoryList,
    ProjectStatusResult,
    ProjectStatusUpdate,
)

router = APIRouter(tags=["portfolio"])

PM = {"x-apex-authorization": "Contributor"}


async def _load(repos: Repositories, p2_project_no: str) -> tuple[dict, dict]:
    project = await repos.portfolio.get_project(p2_project_no)
    if project is None:
        raise HTTPException(404, f"Project {p2_project_no} not found")
    return project, await repos.portfolio.get_state(p2_project_no)


async def _result(repos: Repositories, p2_project_no: str) -> ProjectStatusResult:
    project, state = await _load(repos, p2_project_no)
    return ProjectStatusResult(
        project=Project(**project),
        kanban=KanbanColumn(**kanban_column(project["pct_complete"])),
        archived=bool(state.get("archived")),
        history=await repos.portfolio.history(p2_project_no),
        as_of=stamp(repos.portfolio.as_of),
    )


@router.put(
    "/projects/{p2_project_no}/status",
    response_model=ProjectStatusResult,
    summary="Update project status (APEX Project form)",
    openapi_extra={"x-apex-page": "24", "x-apex-process": "Process form Project", **PM},
)
async def put_project_status(
    p2_project_no: str,
    body: ProjectStatusUpdate,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_pm)],
) -> ProjectStatusResult:
    project, state = await _load(repos, p2_project_no)
    try:
        out = apply_project_status(project, state, body.model_dump(exclude_unset=True))
    except ProjectValidationError as exc:
        raise apex_validation_error(exc) from exc
    events = project_history_events(
        p2_project_no, project, out["changes"], principal.subject, "UPDATE", state, out["state"]
    )
    await repos.portfolio.update_project(p2_project_no, out["changes"], out["state"], events)
    await repos.portfolio.log_interaction(p2_project_no, principal.subject, "project_form")
    return await _result(repos, p2_project_no)


@router.post(
    "/projects/{p2_project_no}/kanban/move",
    response_model=ProjectStatusResult,
    summary="Move a Kanban card (APEX Kanban Board drop)",
    openapi_extra={"x-apex-page": "4", "x-apex-process": "Drop Item", **PM},
)
async def kanban_move(
    p2_project_no: str,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_pm)],
    column_id: int = Query(ge=1, le=5, description="Target Kanban column (1 to 5)"),
) -> ProjectStatusResult:
    project, state = await _load(repos, p2_project_no)
    form = {"pct_complete": pct_for_column(column_id), "current_finish": project.get("current_finish")}
    try:
        out = apply_project_status(project, state, form)
    except ProjectValidationError as exc:
        raise apex_validation_error(exc) from exc
    events = project_history_events(p2_project_no, project, out["changes"], principal.subject)
    await repos.portfolio.update_project(p2_project_no, out["changes"], out["state"], events)
    return await _result(repos, p2_project_no)


@router.post(
    "/projects/{p2_project_no}/archive",
    response_model=ProjectStatusResult,
    summary="Archive or un-archive a project",
    openapi_extra={
        "x-apex-page": "47",
        "x-apex-process": "Archive project; unArchive project (page 52)",
        **PM,
    },
)
async def archive(
    p2_project_no: str,
    body: ProjectArchiveUpdate,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_pm)],
) -> ProjectStatusResult:
    _, state = await _load(repos, p2_project_no)
    if body.archived == bool(state.get("archived")):
        raise HTTPException(
            409, f"Project {p2_project_no} is already {'archived' if body.archived else 'active'}"
        )
    new_state = archive_project(state, principal.subject) if body.archived else un_archive_project(state)
    events = [
        {
            "p2_project_no": p2_project_no,
            "attribute": "ARCHIVED_YN",
            "change_type": "ARCHIVE" if body.archived else "UNARCHIVE",
            "old_value": "Y" if state.get("archived") else "N",
            "new_value": "Y" if body.archived else "N",
            "changed_by": principal.subject,
        }
    ]
    if body.reason:
        events[0]["new_value"] = f"{events[0]['new_value']} ({body.reason})"
    await repos.portfolio.update_project(p2_project_no, {}, new_state, events)
    await repos.portfolio.log_interaction(
        p2_project_no, principal.subject, "archive" if body.archived else "unarchive"
    )
    return await _result(repos, p2_project_no)


@router.put(
    "/projects/{p2_project_no}/milestones/{code}",
    response_model=Milestone,
    summary="Update a milestone (APEX Milestone form)",
    openapi_extra={"x-apex-page": "508", "x-apex-process": "Process form", **PM},
)
async def put_milestone(
    p2_project_no: str,
    code: str,
    body: MilestoneUpdate,
    repos: Annotated[Repositories, Depends(get_repos)],
    principal: Annotated[Principal, Depends(require_pm)],
) -> Milestone:
    project, state = await _load(repos, p2_project_no)
    if state.get("archived"):
        raise HTTPException(409, f"Project {p2_project_no} is archived")
    current = next((m for m in project.get("milestones", []) if m["code"] == code), None)
    if current is None:
        raise HTTPException(404, f"Milestone {code} not found on project {p2_project_no}")
    try:
        changes = apply_milestone_update(current, body.model_dump(exclude_unset=True))
    except ProjectValidationError as exc:
        raise apex_validation_error(exc) from exc
    events = [
        {
            "p2_project_no": p2_project_no,
            "attribute": f"MILESTONE_{code}_{k.upper()}",
            "change_type": "UPDATE",
            "old_value": _s(current.get(k)),
            "new_value": _s(v),
            "changed_by": principal.subject,
        }
        for k, v in changes.items()
        if k != "status_last_changed_on"
    ]
    await repos.portfolio.update_milestone(p2_project_no, code, changes, events)
    await repos.portfolio.log_interaction(p2_project_no, principal.subject, "milestone_form")
    project = await repos.portfolio.get_project(p2_project_no)
    return Milestone(**next(m for m in project["milestones"] if m["code"] == code))


@router.get(
    "/projects/{p2_project_no}/history",
    response_model=ProjectHistoryList,
    summary="Project change history",
    openapi_extra={"x-apex-page": "64", "x-apex-authorization": "Authenticated User"},
)
async def history(
    p2_project_no: str,
    repos: Annotated[Repositories, Depends(get_repos)],
    _: Annotated[Principal, Depends(require_viewer)],
) -> ProjectHistoryList:
    await _load(repos, p2_project_no)
    return ProjectHistoryList(
        p2_project_no=p2_project_no,
        events=await repos.portfolio.history(p2_project_no),
        as_of=stamp(repos.portfolio.as_of),
    )


def _s(v: object) -> str | None:
    return None if v is None else (v.isoformat() if hasattr(v, "isoformat") else str(v))
