"""Programs, projects, milestones, project state and change history."""

from __future__ import annotations

import copy
from datetime import UTC, datetime
from typing import Any, Protocol

from evs.repositories import tables as t
from evs.repositories._sql import PgBase, clean
from evs.repositories.fixture_store import FixtureStore
from evs.repositories.query import Columns, ListQuery
from evs.schemas.common import AsOf

PROGRAM_COLUMNS = Columns(
    {
        "program_code": "program_code",
        "name": "name",
        "business_line": "business_line",
        "division": "division",
        "funded_amount": "funded_amount",
        "obligated_amount": "obligated_amount",
        "expended_amount": "expended_amount",
        "variance_pct": "variance_pct",
        "project_count": "project_count",
        "schedule_health": "schedule_health",
    },
    text_columns={"program_code", "name", "business_line", "division", "schedule_health"},
    default_sort="program_code",
)

PROJECT_COLUMNS = Columns(
    {
        "p2_project_no": "p.p2_project_no",
        "name": "p.name",
        "program_code": "p.program_code",
        "district": "p.district",
        "division": "p.division",
        "business_line": "p.business_line",
        "phase": "p.phase",
        "pdt_lead": "p.pdt_lead",
        "baseline_finish": "p.baseline_finish",
        "current_finish": "p.current_finish",
        "pct_complete": "p.pct_complete",
        "funded_amount": "p.funded_amount",
        "obligated_amount": "p.obligated_amount",
        "expended_amount": "p.expended_amount",
        "schedule_health": "p.schedule_health",
    },
    text_columns={
        "p2_project_no",
        "name",
        "program_code",
        "district",
        "division",
        "business_line",
        "phase",
        "pdt_lead",
        "schedule_health",
    },
    default_sort="p2_project_no",
)

MILESTONE_COLUMNS = Columns(
    {
        "p2_project_no": "m.p2_project_no",
        "project_name": "p.name",
        "program_code": "p.program_code",
        "district": "p.district",
        "code": "m.code",
        "name": "m.name",
        "baseline_date": "m.baseline_date",
        "current_date": 'm."current_date"',
        "actual_date": "m.actual_date",
        "status": "m.status",
        "slip_days": '(m."current_date" - m.baseline_date)',
    },
    text_columns={"p2_project_no", "project_name", "program_code", "district", "code", "name", "status"},
    default_sort="-slip_days,current_date,p2_project_no,code",
)

MILESTONE_FIELDS = (
    "code",
    "name",
    "baseline_date",
    "current_date",
    "actual_date",
    "status",
    "owner",
    "description",
)
PROJECT_STATE_FIELDS = (
    "archived",
    "archived_at",
    "archived_by",
    "status_scale",
    "link_url",
    "link_name",
    "note",
)


class PortfolioRepo(Protocol):
    as_of: AsOf

    async def list_programs(self, q: ListQuery) -> tuple[list[dict], int]: ...
    async def list_projects(self, q: ListQuery) -> tuple[list[dict], int]: ...
    async def get_project(self, p2_project_no: str) -> dict | None: ...
    async def list_milestones(self, q: ListQuery) -> tuple[list[dict], int]: ...
    async def get_state(self, p2_project_no: str) -> dict: ...
    async def update_project(
        self, p2_project_no: str, changes: dict, state: dict, events: list[dict]
    ) -> None: ...
    async def update_milestone(
        self, p2_project_no: str, code: str, changes: dict, events: list[dict]
    ) -> None: ...
    async def history(self, p2_project_no: str) -> list[dict]: ...
    async def log_interaction(self, p2_project_no: str, actor: str, kind: str) -> None: ...
    async def kpi_rollup(self) -> dict: ...
    async def variance_by_program(self) -> list[dict]: ...


# --------------------------------------------------------------------------- Postgres


class PgPortfolioRepo(PgBase):
    as_of = AsOf(source="synthetic")

    async def list_programs(self, q: ListQuery) -> tuple[list[dict], int]:
        params: dict[str, Any] = {}
        where = PROGRAM_COLUMNS.where_clause(q, params)
        total = await self.scalar(f"SELECT count(*) FROM {t.PROGRAM}{where}", params)
        rows = await self.rows(
            f"SELECT * FROM {t.PROGRAM}{where}{PROGRAM_COLUMNS.order_clause(q)} LIMIT :limit OFFSET :offset",
            {**params, "limit": q.limit, "offset": q.offset},
        )
        return [clean(r) for r in rows], int(total or 0)

    async def list_projects(self, q: ListQuery) -> tuple[list[dict], int]:
        params: dict[str, Any] = {}
        where = PROJECT_COLUMNS.where_clause(q, params)
        total = await self.scalar(f"SELECT count(*) FROM {t.PROJECT} p{where}", params)
        rows = await self.rows(
            f"SELECT p.* FROM {t.PROJECT} p{where}{PROJECT_COLUMNS.order_clause(q)} "
            "LIMIT :limit OFFSET :offset",
            {**params, "limit": q.limit, "offset": q.offset},
        )
        rows = [clean(r) for r in rows]
        if rows:
            ids = [r["p2_project_no"] for r in rows]
            ms = await self.rows(
                f"SELECT * FROM {t.MILESTONE} m WHERE m.p2_project_no = ANY(:ids) "
                'ORDER BY m.p2_project_no, m."current_date"',
                {"ids": ids},
            )
            by_project: dict[str, list[dict]] = {}
            for m in ms:
                by_project.setdefault(m["p2_project_no"], []).append(clean(m))
            for r in rows:
                r["milestones"] = by_project.get(r["p2_project_no"], [])
        return rows, int(total or 0)

    async def get_project(self, p2_project_no: str) -> dict | None:
        row = await self.one(
            f"SELECT p.* FROM {t.PROJECT} p WHERE p.p2_project_no = :no", {"no": p2_project_no}
        )
        if row is None:
            return None
        row = clean(row)
        ms = await self.rows(
            f'SELECT * FROM {t.MILESTONE} m WHERE m.p2_project_no = :no ORDER BY m."current_date"',
            {"no": p2_project_no},
        )
        row["milestones"] = [clean(m) for m in ms]
        return row

    async def list_milestones(self, q: ListQuery) -> tuple[list[dict], int]:
        params: dict[str, Any] = {}
        where = MILESTONE_COLUMNS.where_clause(q, params)
        base = f"FROM {t.MILESTONE} m JOIN {t.PROJECT} p ON p.p2_project_no = m.p2_project_no{where}"
        total = await self.scalar(f"SELECT count(*) {base}", params)
        rows = await self.rows(
            "SELECT m.*, p.name AS project_name, p.program_code, p.district, "
            f'(m."current_date" - m.baseline_date) AS slip_days {base}{MILESTONE_COLUMNS.order_clause(q)} '
            "LIMIT :limit OFFSET :offset",
            {**params, "limit": q.limit, "offset": q.offset},
        )
        return [clean(r) for r in rows], int(total or 0)

    async def get_state(self, p2_project_no: str) -> dict:
        row = await self.one(
            f"SELECT * FROM {t.PROJECT_STATE} WHERE p2_project_no = :no", {"no": p2_project_no}
        )
        return clean(row) if row else _default_state(p2_project_no)

    async def update_project(
        self, p2_project_no: str, changes: dict, state: dict, events: list[dict]
    ) -> None:
        stmts: list[tuple[str, dict]] = []
        if changes:
            sets = ", ".join(f'"{k}" = :{k}' for k in changes)
            stmts.append(
                (f"UPDATE {t.PROJECT} SET {sets} WHERE p2_project_no = :no", {**changes, "no": p2_project_no})
            )
        stmts.append(
            (
                f"INSERT INTO {t.PROJECT_STATE} (p2_project_no, archived, archived_at, archived_by, "
                "status_scale, link_url, link_name, note, updated_at) VALUES (:no, :archived, :archived_at, "
                ":archived_by, :status_scale, :link_url, :link_name, :note, now()) "
                "ON CONFLICT (p2_project_no) DO UPDATE SET archived = EXCLUDED.archived, "
                "archived_at = EXCLUDED.archived_at, archived_by = EXCLUDED.archived_by, "
                "status_scale = EXCLUDED.status_scale, link_url = EXCLUDED.link_url, "
                "link_name = EXCLUDED.link_name, note = EXCLUDED.note, updated_at = now()",
                {"no": p2_project_no, **{k: state.get(k) for k in PROJECT_STATE_FIELDS}},
            )
        )
        stmts.extend(_history_inserts(events))
        await self.execute(stmts)

    async def update_milestone(
        self, p2_project_no: str, code: str, changes: dict, events: list[dict]
    ) -> None:
        stmts: list[tuple[str, dict]] = []
        if changes:
            sets = ", ".join(f'"{k}" = :{k}' for k in changes)
            stmts.append(
                (
                    f"UPDATE {t.MILESTONE} SET {sets} WHERE p2_project_no = :no AND code = :code",
                    {**changes, "no": p2_project_no, "code": code},
                )
            )
        stmts.extend(_history_inserts(events))
        await self.execute(stmts)

    async def history(self, p2_project_no: str) -> list[dict]:
        rows = await self.rows(
            f"SELECT * FROM {t.PROJECT_HISTORY} WHERE p2_project_no = :no "
            "ORDER BY changed_on DESC, id DESC LIMIT 200",
            {"no": p2_project_no},
        )
        return [clean(r) for r in rows]

    async def log_interaction(self, p2_project_no: str, actor: str, kind: str) -> None:
        await self.execute(
            [
                (
                    f"INSERT INTO {t.PROJECT_INTERACTION_LOG} (p2_project_no, actor, kind) "
                    "VALUES (:no, :actor, :kind)",
                    {"no": p2_project_no, "actor": actor, "kind": kind},
                )
            ]
        )

    async def kpi_rollup(self) -> dict:
        row = await self.one(
            f"""
            SELECT count(*) AS projects,
                   count(*) FILTER (WHERE p.schedule_health = 'late') AS late_projects,
                   count(*) FILTER (WHERE p.schedule_health = 'at_risk') AS at_risk_projects,
                   coalesce(sum(p.funded_amount), 0) AS funded_amount,
                   coalesce(sum(p.obligated_amount), 0) AS obligated_amount,
                   coalesce(sum(p.expended_amount), 0) AS expended_amount,
                   (SELECT count(*) FROM {t.MILESTONE} m WHERE m.status = 'slipped') AS slipped_milestones,
                   (SELECT count(*) FROM {t.PROGRAM}) AS programs
            FROM {t.PROJECT} p
            """
        )
        return clean(row or {})

    async def variance_by_program(self) -> list[dict]:
        rows = await self.rows(f"SELECT * FROM {t.PROGRAM} ORDER BY program_code")
        return [clean(r) for r in rows]


HISTORY_KEYS = ("p2_project_no", "attribute", "change_type", "old_value", "new_value", "changed_by")


def _history_inserts(events: list[dict]) -> list[tuple[str, dict]]:
    return [
        (
            f"INSERT INTO {t.PROJECT_HISTORY} (p2_project_no, attribute, change_type, old_value, new_value, "
            "changed_by) VALUES (:p2_project_no, :attribute, :change_type, :old_value, :new_value, "
            ":changed_by)",
            {
                k: e.get(k)
                for k in ("p2_project_no", "attribute", "change_type", "old_value", "new_value", "changed_by")
            },
        )
        for e in events
    ]


def _default_state(p2_project_no: str) -> dict:
    return {
        "p2_project_no": p2_project_no,
        "archived": False,
        "archived_at": None,
        "archived_by": None,
        "status_scale": "A",
        "link_url": None,
        "link_name": None,
        "note": None,
    }


# --------------------------------------------------------------------------- Fixtures


class FixturePortfolioRepo:
    as_of = AsOf(source="synthetic")

    def __init__(self, store: FixtureStore) -> None:
        self.store = store

    def _projects(self) -> list[dict]:
        return self.store.get("projects")

    async def list_programs(self, q: ListQuery) -> tuple[list[dict], int]:
        return PROGRAM_COLUMNS.apply_in_memory(self.store.get("programs"), q)

    async def list_projects(self, q: ListQuery) -> tuple[list[dict], int]:
        return PROJECT_COLUMNS.apply_in_memory(self._projects(), q)

    async def get_project(self, p2_project_no: str) -> dict | None:
        return next((copy.deepcopy(p) for p in self._projects() if p["p2_project_no"] == p2_project_no), None)

    async def list_milestones(self, q: ListQuery) -> tuple[list[dict], int]:
        rows = []
        for p in self._projects():
            for m in p.get("milestones", []):
                slip = None
                if m.get("baseline_date") and m.get("current_date"):
                    slip = (
                        datetime.fromisoformat(m["current_date"]) - datetime.fromisoformat(m["baseline_date"])
                    ).days
                rows.append(
                    {
                        **m,
                        "p2_project_no": p["p2_project_no"],
                        "project_name": p["name"],
                        "program_code": p["program_code"],
                        "district": p["district"],
                        "slip_days": slip,
                    }
                )
        return MILESTONE_COLUMNS.apply_in_memory(rows, q)

    async def get_state(self, p2_project_no: str) -> dict:
        return copy.deepcopy(self.store.project_state.get(p2_project_no) or _default_state(p2_project_no))

    async def update_project(
        self, p2_project_no: str, changes: dict, state: dict, events: list[dict]
    ) -> None:
        for p in self._projects():
            if p["p2_project_no"] == p2_project_no:
                p.update({k: _jsonable(v) for k, v in changes.items()})
        self.store.project_state[p2_project_no] = {"p2_project_no": p2_project_no, **state}
        self._append_history(events)

    async def update_milestone(
        self, p2_project_no: str, code: str, changes: dict, events: list[dict]
    ) -> None:
        for p in self._projects():
            if p["p2_project_no"] == p2_project_no:
                for m in p.get("milestones", []):
                    if m["code"] == code:
                        m.update({k: _jsonable(v) for k, v in changes.items()})
        self._append_history(events)

    async def history(self, p2_project_no: str) -> list[dict]:
        return [e for e in reversed(self.store.history) if e["p2_project_no"] == p2_project_no][:200]

    async def log_interaction(self, p2_project_no: str, actor: str, kind: str) -> None:
        self.store.interactions.append(
            {"p2_project_no": p2_project_no, "actor": actor, "kind": kind, "at": datetime.now(UTC)}
        )

    async def kpi_rollup(self) -> dict:
        ps = self._projects()
        return {
            "projects": len(ps),
            "late_projects": sum(p["schedule_health"] == "late" for p in ps),
            "at_risk_projects": sum(p["schedule_health"] == "at_risk" for p in ps),
            "funded_amount": sum(p["funded_amount"] for p in ps),
            "obligated_amount": sum(p["obligated_amount"] for p in ps),
            "expended_amount": sum(p["expended_amount"] for p in ps),
            "slipped_milestones": sum(m["status"] == "slipped" for p in ps for m in p.get("milestones", [])),
            "programs": len(self.store.get("programs")),
        }

    async def variance_by_program(self) -> list[dict]:
        return sorted(self.store.get("programs"), key=lambda r: r["program_code"])

    def _append_history(self, events: list[dict]) -> None:
        for e in events:
            row = {"id": len(self.store.history) + 1, "changed_on": datetime.now(UTC), **e}
            self.store.history.append(row)


def _jsonable(v: Any) -> Any:
    return v.isoformat() if hasattr(v, "isoformat") else v
