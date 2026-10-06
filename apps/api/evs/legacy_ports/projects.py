"""Project form, archive and change-history logic from the Strategic Planner application.

Source objects (APEX app 7150, Strategic Planner 24.2 starter app):

* Page 24 "Project": processes "Process form Project" (NATIVE_FORM_DML), "add link",
  "default scale_letter and min_pc_for_status"; validations "Link" and
  "target_complete mandatory when >=50% complete".
* Page 3 "Project Details": process "log" (sp_log.log_interaction).
* Page 47 "Archive Project": process "Archive project" (sp_util.archive_project).
* Page 52 "Un-Archive Project": process "unArchive project" (sp_util.un_archive_project).
* Page 64 "Project Change History": reads sp_project_history, which is written by trigger
  sp_projects_biu (install_projects_triggers.sql).
* Table check constraint sp_projects_pct_complete_ck: pct_complete in 0,10,...,100.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import UTC, date, datetime
from typing import Any

# Seed row of sp_project_scales for scale_letter 'A' (install_seed_project_scales.sql).
# EVS keeps one scale; the APEX app lets Administrators define up to five (page 222).
STATUS_SCALE_A: dict[int, str] = {
    0: "Not Feasible",
    10: "Identified",
    20: "Desirable",
    30: "Architecting",
    40: "Specification Approved",
    50: "Active Development",
    60: "Demonstrable",
    70: "In Review",
    80: "Merging",
    90: "Verification",
    100: "Complete",
}
MIN_PC_FOR_STATUS = 30  # sp_project_scales.min_pc_for_status for scale 'A'
TARGET_COMPLETE_REQUIRED_FROM = 50  # page 24 validation "target_complete mandatory when >=50% complete"

# Columns the sp_projects_biu trigger writes to sp_project_history, mapped to EVS project fields.
HISTORY_ATTRIBUTES: dict[str, str] = {
    "pct_complete": "PCT_COMPLETE",
    "current_finish": "TARGET_COMPLETE",
    "status_scale": "STATUS_SCALE",
    "phase": "STATUS",
    "name": "PROJECT",
    "pdt_lead": "OWNER",
}


@dataclass
class ProjectValidationError(Exception):
    """One APEX validation failure; `item` mirrors the page item the message was attached to."""

    message: str
    item: str | None = None
    errors: list[dict[str, str]] = field(default_factory=list)

    def __post_init__(self) -> None:
        if not self.errors:
            self.errors = [{"item": self.item or "", "message": self.message}]
        super().__init__(self.message)


def status_label(pct_complete: int | float, scale: dict[int, str] = STATUS_SCALE_A) -> str:
    """Page 24 item P24_STATUS_SCALE / page 222 "Status Scale": label for a pct_complete bucket.

    Mirrors the `pcNN_label` columns of sp_project_scales for scale 'A'.
    """
    bucket = max(k for k in scale if k <= round_pct(pct_complete))
    return scale[bucket]


def round_pct(pct_complete: int | float) -> int:
    """sp_projects_pct_complete_ck allows only multiples of 10; APEX rejects anything else."""
    value = int(round(float(pct_complete)))
    if value < 0 or value > 100 or value % 10 != 0:
        raise ProjectValidationError(
            "Percent complete must be a multiple of 10 between 0 and 100 (sp_projects_pct_complete_ck).",
            item="P24_PCT_COMPLETE",
        )
    return value


def validate_project_form(form: dict[str, Any]) -> None:
    """Page 24 "Project" validations, evaluated together as APEX does before "Process form Project".

    * "Link" (EXPRESSION): `(:P24_LINK is not null and :P24_LINK_NAME is not null) or
      (:P24_LINK is null and :P24_LINK_NAME is null)`.
    * "target_complete mandatory when >=50% complete" (ITEM_NOT_NULL on P24_TARGET_COMPLETE,
      condition P24_PCT_COMPLETE >= 50).
    * sp_projects_pct_complete_ck check constraint.
    """
    errors: list[dict[str, str]] = []
    try:
        pct = round_pct(form.get("pct_complete", 0))
    except ProjectValidationError as exc:
        errors.extend(exc.errors)
        pct = 0
    link, link_name = form.get("link_url"), form.get("link_name")
    if bool(link) != bool(link_name):
        errors.append(
            {"item": "P24_LINK", "message": "To add a link you must provide the link url and name."}
        )
    if pct >= TARGET_COMPLETE_REQUIRED_FROM and not form.get("current_finish"):
        errors.append(
            {
                "item": "P24_TARGET_COMPLETE",
                "message": "Must provide Target Complete when 50% complete or higher.",
            }
        )
    scale = form.get("status_scale")
    if scale is not None and scale not in {"A", "B", "C", "D", "E"}:
        errors.append({"item": "P24_STATUS_SCALE", "message": "Status scale must be one of A, B, C, D, E."})
    if errors:
        raise ProjectValidationError(errors[0]["message"], errors[0]["item"], errors)


def normalize_tags(tags: str | None) -> str | None:
    """Trigger sp_projects_biu, tags block: upper case, collapse double spaces, then replace a space
    that does not follow a comma with a hyphen so `big data, ml ops` becomes `BIG-DATA, ML-OPS`."""
    if not tags:
        return None
    value = " ".join(tags.strip().upper().split())
    out: list[str] = []
    for i, ch in enumerate(value):
        if i > 1 and ch == " " and value[i - 1] != ",":
            out.append("-")
        else:
            out.append(ch)
    return "".join(out)


def apply_project_status(
    project: dict[str, Any], state: dict[str, Any], form: dict[str, Any]
) -> dict[str, Any]:
    """Page 24 process "Process form Project" (NATIVE_FORM_DML) plus "add link"
    (sp_util.add_project_link) and the defaults applied by trigger sp_projects_biu.

    Returns `{"changes": {...}, "state": {...}}`: `changes` are the project columns that differ
    from the current row (what the DML would write), `state` is the EVS side table that holds the
    APEX-only columns (status_scale, link, note, archived flags).
    """
    validate_project_form(form)
    if state.get("archived"):
        raise ProjectValidationError("Archived projects are read only; un-archive first (page 52).", "P24_ID")
    changes: dict[str, Any] = {}
    pct = round_pct(form["pct_complete"])
    if pct != round(float(project.get("pct_complete") or 0)):
        changes["pct_complete"] = pct
    for key in ("phase", "current_finish"):
        if form.get(key) is not None and _norm(form[key]) != _norm(project.get(key)):
            changes[key] = form[key]
    if "current_finish" in changes and project.get("baseline_finish"):
        baseline = _as_date(project["baseline_finish"])
        changes["schedule_health"] = _schedule_health(_as_date(changes["current_finish"]), baseline)
    new_state = {
        **state,
        "status_scale": form.get("status_scale") or state.get("status_scale") or "A",
        "link_url": form.get("link_url") if "link_url" in form else state.get("link_url"),
        "link_name": form.get("link_name") if "link_name" in form else state.get("link_name"),
        "note": form.get("note") if form.get("note") is not None else state.get("note"),
    }
    return {"changes": changes, "state": new_state}


def archive_project(state: dict[str, Any], app_user: str, now: datetime | None = None) -> dict[str, Any]:
    """Page 47 process "Archive project": sp_util.archive_project(p_project_id, p_app_user) which runs
    `update sp_projects set archived_yn = 'Y', archived_date = sysdate, archived_by = p_app_user`."""
    return {**state, "archived": True, "archived_at": now or datetime.now(UTC), "archived_by": app_user}


def un_archive_project(state: dict[str, Any]) -> dict[str, Any]:
    """Page 52 process "unArchive project": sp_util.un_archive_project(p_project_id) which runs
    `update sp_projects set archived_yn = 'N', archived_date = null`. archived_by is kept, as in APEX."""
    return {**state, "archived": False, "archived_at": None}


def project_history_events(
    p2_project_no: str,
    before: dict[str, Any],
    after_changes: dict[str, Any],
    changed_by: str,
    change_type: str = "UPDATE",
    before_state: dict[str, Any] | None = None,
    after_state: dict[str, Any] | None = None,
) -> list[dict[str, Any]]:
    """Trigger sp_projects_biu, "maintain history" block: one sp_project_history row per changed
    tracked column (INITIATIVE, PROJECT, DESCRIPTION, OWNER, TARGET_COMPLETE, STATUS_SCALE,
    PCT_COMPLETE, STATUS, ...). Page 64 "Project Change History" lists these rows.
    STATUS_SCALE is recorded with scale names, dates as DD-MON-YYYY, like the trigger."""
    events: list[dict[str, Any]] = []
    now = datetime.now(UTC)
    for key, attribute in HISTORY_ATTRIBUTES.items():
        if key in after_changes and _norm(before.get(key)) != _norm(after_changes[key]):
            events.append(
                _event(
                    p2_project_no,
                    attribute,
                    change_type,
                    before.get(key),
                    after_changes[key],
                    changed_by,
                    now,
                )
            )
    if before_state is not None and after_state is not None:
        for key, attribute in (("status_scale", "STATUS_SCALE"), ("link_url", "LINK"), ("note", "NOTE")):
            if _norm(before_state.get(key)) != _norm(after_state.get(key)):
                events.append(
                    _event(
                        p2_project_no,
                        attribute,
                        change_type,
                        before_state.get(key),
                        after_state.get(key),
                        changed_by,
                        now,
                    )
                )
    return events


def _event(
    no: str, attribute: str, change_type: str, old: Any, new: Any, by: str, at: datetime
) -> dict[str, Any]:
    return {
        "p2_project_no": no,
        "attribute": attribute,
        "change_type": change_type,
        "old_value": _fmt(old),
        "new_value": _fmt(new),
        "changed_on": at,
        "changed_by": by,
    }


def _fmt(v: Any) -> str | None:
    if v is None:
        return None
    if isinstance(v, date | datetime):
        return v.strftime("%d-%b-%Y").upper()
    if isinstance(v, str) and len(v) == 10 and v[4] == "-" and v[7] == "-":
        return date.fromisoformat(v).strftime("%d-%b-%Y").upper()
    return str(v)


def _norm(v: Any) -> Any:
    if isinstance(v, date | datetime):
        return v.isoformat()[:10]
    if isinstance(v, float) and v.is_integer():
        return int(v)
    return v


def _as_date(v: Any) -> date:
    return v if isinstance(v, date) else date.fromisoformat(str(v)[:10])


def _schedule_health(current: date, baseline: date) -> str:
    """EVS schedule_health vocabulary (synth generator): late beyond 90 days slip, at_risk beyond 0."""
    slip = (current - baseline).days
    if slip > 90:
        return "late"
    if slip > 0:
        return "at_risk"
    return "on_track"
