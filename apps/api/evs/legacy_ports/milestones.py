"""Milestone (sp_tasks) form logic.

Source: APEX page 508 "Milestone": process "Process form" (NATIVE_FORM_DML) and validations
"when milestone complete, must provide date" (ITEM_NOT_NULL on P508_TARGET_COMPLETE) and
"when milestone complete, must provide owner" (ITEM_NOT_NULL on P508_OWNER_ID). Both fire when
P508_STATUS_ID is the Completed status. The milestone "delete" process is intentionally not
ported: EVS milestones are P2 schedule rows and are never deleted from the API.
"""

from __future__ import annotations

from datetime import UTC, date, datetime
from typing import Any

from evs.legacy_ports.projects import ProjectValidationError, _as_date, _norm


def validate_milestone(form: dict[str, Any], current: dict[str, Any]) -> None:
    """Page 508 validations, evaluated together. `form` holds the submitted items, `current` the
    stored row so partial updates are validated against the merged state."""
    merged = {**current, **{k: v for k, v in form.items() if v is not None}}
    errors: list[dict[str, str]] = []
    if merged.get("status") == "complete":
        if not merged.get("actual_date"):
            errors.append(
                {"item": "P508_TARGET_COMPLETE", "message": "When milestone is completed, must provide date."}
            )
        if not merged.get("owner"):
            errors.append(
                {"item": "P508_OWNER_ID", "message": "When milestone is completed, must provide owner."}
            )
    if merged.get("actual_date") and _as_date(merged["actual_date"]) > date.today():
        errors.append({"item": "P508_TARGET_COMPLETE", "message": "Actual date cannot be in the future."})
    if errors:
        raise ProjectValidationError(errors[0]["message"], errors[0]["item"], errors)


def apply_milestone_update(current: dict[str, Any], form: dict[str, Any]) -> dict[str, Any]:
    """Page 508 process "Process form" (DML on sp_tasks) with the P2 schedule semantics EVS adds:

    * setting `actual_date` marks the milestone complete (status derived, like P508_STATUS_ID);
    * a `current_date` later than `baseline_date` marks it slipped, otherwise scheduled;
    * `status_last_changed_on` (P508_STATUS_LAST_CHANGED_ON) is stamped when status changes.
    """
    validate_milestone(form, current)
    changes: dict[str, Any] = {}
    for key in ("current_date", "actual_date", "owner", "description"):
        if form.get(key) is not None and _norm(form[key]) != _norm(current.get(key)):
            changes[key] = form[key]
    merged = {**current, **changes}
    if form.get("status") == "complete" or merged.get("actual_date"):
        status = "complete"
    elif (
        merged.get("baseline_date")
        and merged.get("current_date")
        and (_as_date(merged["current_date"]) > _as_date(merged["baseline_date"]))
    ):
        status = "slipped"
    else:
        status = form.get("status") or "scheduled"
    if status != current.get("status"):
        changes["status"] = status
        changes["status_last_changed_on"] = datetime.now(UTC)
    return changes
