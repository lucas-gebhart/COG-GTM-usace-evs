"""Build the structured inventory of an APEX split export."""

from __future__ import annotations

import re
from collections import Counter
from pathlib import Path
from typing import Any

from apex_inventory.plsql import Call, parse_file

SCHEMA_OBJECT_RE = re.compile(r"\b(sp_[a-z0-9_]+)\b", re.I)
SUBST_RE = re.compile(r"&([A-Z0-9_]+)\.")
PLSQL_PROCESS_TYPES = {"NATIVE_PLSQL"}
SQL_REGION_TYPES = {
    "NATIVE_IR",
    "NATIVE_SQL_REPORT",
    "NATIVE_CARDS",
    "NATIVE_JET_CHART",
    "NATIVE_IG",
    "NATIVE_MAP_REGION",
    "NATIVE_CALENDAR",
    "NATIVE_TREE",
}

# Default values of the SP_APP_NOMENCLATURE table (install_seed_nomenclature.sql). Region and page
# titles in the export reference these through &NOMENCLATURE_X. substitutions.
NOMENCLATURE_DEFAULTS = {
    "NOMENCLATURE_STRATEGIC_PLANNER": "Our Strategic Planner",
    "NOMENCLATURE_AREA": "Area",
    "NOMENCLATURE_AREAS": "Areas",
    "NOMENCLATURE_INITIATIVE": "Initiative",
    "NOMENCLATURE_INITIATIVES": "Initiatives",
    "NOMENCLATURE_PROJECT": "Project",
    "NOMENCLATURE_PROJECTS": "Projects",
    "NOMENCLATURE_USER": "Person",
    "NOMENCLATURE_USERS": "People",
    "APP_NAME": "Strategic Planner",
}


def resolve_substitutions(value: Any) -> Any:
    if not isinstance(value, str):
        return value

    def repl(m: re.Match[str]) -> str:
        return NOMENCLATURE_DEFAULTS.get(m.group(1), m.group(0))

    return SUBST_RE.sub(repl, value)


def schema_objects(*sources: Any) -> list[str]:
    found: set[str] = set()
    for src in sources:
        if isinstance(src, str):
            found.update(x.lower() for x in SCHEMA_OBJECT_RE.findall(src))
    return sorted(found)


def _sid(value: Any) -> str | None:
    return None if value is None else str(value)


def _page_number_from_file(path: Path) -> int | None:
    m = re.search(r"page_(\d+)\.sql$", path.name)
    return int(m.group(1)) if m else None


class InventoryBuilder:
    def __init__(self, export_dir: Path):
        self.export_dir = Path(export_dir)
        self.app_dir = self._locate_application_dir(self.export_dir)
        self.pages: list[dict] = []
        self.regions: list[dict] = []
        self.reports: list[dict] = []
        self.charts: list[dict] = []
        self.items: list[dict] = []
        self.buttons: list[dict] = []
        self.processes: list[dict] = []
        self.validations: list[dict] = []
        self.computations: list[dict] = []
        self.branches: list[dict] = []
        self.dynamic_actions: list[dict] = []
        self.lovs: list[dict] = []
        self.authz: list[dict] = []
        self.page_groups: dict[str, str] = {}
        self.application: dict[str, Any] = {}
        self._authz_by_id: dict[str, dict] = {}
        self._lov_by_id: dict[str, dict] = {}
        self._region_by_id: dict[str, dict] = {}
        self._report_by_id: dict[str, dict] = {}
        self._chart_by_id: dict[str, dict] = {}
        self._da_by_id: dict[str, dict] = {}
        self.call_counts: Counter[str] = Counter()

    @staticmethod
    def _locate_application_dir(export_dir: Path) -> Path:
        candidates = [export_dir / "application", export_dir]
        candidates += [p / "application" for p in export_dir.glob("f*") if p.is_dir()]
        for c in candidates:
            if (c / "pages").is_dir():
                return c
        raise FileNotFoundError(f"no application/pages directory under {export_dir}")

    # ---- shared components -------------------------------------------------------------------
    def _parse_application(self) -> None:
        path = self.app_dir / "create_application.sql"
        if not path.exists():
            return
        for call in parse_file(path, self.export_dir):
            self.call_counts[call.qualified] += 1
            if call.name == "component_begin":
                self.application["app_id"] = call.get("p_default_application_id")
                self.application["workspace_id"] = call.get("p_default_workspace_id")
                self.application["apex_version"] = call.get("p_release")
                self.application["default_owner"] = call.get("p_default_owner")
            elif call.name == "create_flow":
                self.application["name"] = call.get("p_name")
                self.application["alias"] = call.get("p_alias")
                self.application["version"] = call.get("p_flow_version")
                self.application["authentication_id"] = _sid(call.get("p_authentication_id"))
                self.application["theme_id"] = call.get("p_theme_id")
                self.application["home_url"] = call.get("p_home_url")

    def _parse_page_groups(self) -> None:
        path = self.app_dir / "pages" / "page_groups.sql"
        if not path.exists():
            return
        for call in parse_file(path, self.export_dir):
            self.call_counts[call.qualified] += 1
            if call.name == "create_page_group":
                self.page_groups[str(call.get("p_id"))] = call.get("p_group_name")

    def _parse_authorizations(self) -> None:
        for path in sorted(
            (self.app_dir / "shared_components" / "security" / "authorizations").glob("*.sql")
        ):
            for call in parse_file(path, self.export_dir):
                self.call_counts[call.qualified] += 1
                if call.name != "create_security_scheme":
                    continue
                rec = {
                    "id": call.id(),
                    "name": call.get("p_name"),
                    "scheme_type": call.get("p_scheme_type"),
                    "attribute": call.get("p_attribute_01"),
                    "error_message": call.get("p_error_message"),
                    "caching": call.get("p_caching"),
                    "file": call.file,
                    "used_by": [],
                }
                self.authz.append(rec)
                self._authz_by_id[rec["id"]] = rec

    def _parse_lovs(self) -> None:
        for path in sorted((self.app_dir / "shared_components" / "user_interface" / "lovs").glob("*.sql")):
            current: dict | None = None
            for call in parse_file(path, self.export_dir):
                self.call_counts[call.qualified] += 1
                if call.name == "create_list_of_values":
                    current = {
                        "id": call.id(),
                        "name": call.get("p_lov_name"),
                        "source_type": call.get("p_source_type")
                        or ("STATIC" if call.get("p_lov_query") is None else "SQL"),
                        "query": call.get("p_lov_query"),
                        "static_values": 0,
                        "columns": 0,
                        "schema_objects": schema_objects(call.get("p_lov_query")),
                        "file": call.file,
                        "line": call.line,
                    }
                    self.lovs.append(current)
                    self._lov_by_id[current["id"]] = current
                elif call.name == "create_static_lov_data" and current:
                    current["static_values"] += 1
                elif call.name == "create_list_of_values_cols" and current:
                    current["columns"] += 1

    # ---- pages --------------------------------------------------------------------------------
    def _authz_ref(self, call: Call, kind: str, component_id: str | None, page: int | None) -> str | None:
        for key in ("p_required_role", "p_security_scheme", "p_detail_link_auth_scheme"):
            value = call.get(key)
            if value is None:
                continue
            scheme = self._authz_by_id.get(str(value))
            if scheme is not None:
                scheme["used_by"].append({"kind": kind, "id": component_id, "page": page})
                return scheme["name"]
            if isinstance(value, str) and value.startswith("MUST_NOT_BE_PUBLIC_USER"):
                return value
            return str(value)
        return None

    def _parse_page_file(self, path: Path) -> None:
        page_no_from_name = _page_number_from_file(path)
        page: dict | None = None
        current_region: dict | None = None
        current_report: dict | None = None
        counts: Counter[str] = Counter()

        for call in parse_file(path, self.export_dir):
            self.call_counts[call.qualified] += 1
            n = call.name
            if n == "create_page":
                page = {
                    "page": call.get("p_id") if call.get("p_id") is not None else page_no_from_name,
                    "name": call.get("p_name"),
                    "display_name": resolve_substitutions(call.get("p_name")),
                    "title": call.get("p_step_title"),
                    "display_title": resolve_substitutions(call.get("p_step_title")),
                    "alias": call.get("p_alias"),
                    "mode": call.get("p_page_mode") or "NORMAL",
                    "page_group": self.page_groups.get(_sid(call.get("p_group_id"))),
                    "authorization": None,
                    "page_template": _sid(call.get("p_step_template")),
                    "navigation_list_id": _sid(call.get("p_nav_list_id")),
                    "file": call.file,
                    "counts": {},
                }
                page["authorization"] = self._authz_ref(call, "page", str(page["page"]), page["page"])
                self.pages.append(page)
                continue

            page_no = page["page"] if page else page_no_from_name

            if n in ("create_page_plug", "create_report_region"):
                is_classic = n == "create_report_region"
                source_type = call.get("p_source_type") if is_classic else call.get("p_plug_source_type")
                source = call.get("p_source") if is_classic else call.get("p_plug_source")
                query_type = call.get("p_query_type")
                if source_type is None:
                    source_type = "NATIVE_SQL_REPORT" if is_classic else "STATIC"
                table = call.get("p_query_table")
                has_sql = query_type == "SQL" or (source_type in SQL_REGION_TYPES and isinstance(source, str))
                region = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_plug_name") if not is_classic else call.get("p_name"),
                    "display_name": resolve_substitutions(
                        call.get("p_plug_name") if not is_classic else call.get("p_name")
                    ),
                    "sequence": call.get("p_plug_display_sequence")
                    if not is_classic
                    else call.get("p_display_sequence"),
                    "parent_region_id": _sid(call.get("p_parent_plug_id")),
                    "source_type": source_type,
                    "query_type": query_type,
                    "display_point": call.get("p_plug_display_point") or call.get("p_display_point"),
                    "sql": source if has_sql else None,
                    "table": table,
                    "source": None
                    if has_sql
                    else (source if isinstance(source, str) and len(source) < 2000 else None),
                    "schema_objects": schema_objects(source if has_sql else None, table),
                    "authorization": None,
                    "lazy_loading": bool(call.get("p_lazy_loading")),
                    "call": n,
                    "file": call.file,
                    "line": call.line,
                }
                region["authorization"] = self._authz_ref(call, "region", region["id"], page_no)
                self.regions.append(region)
                self._region_by_id[region["id"]] = region
                current_region = region
                counts["regions"] += 1
                if has_sql:
                    counts["sql_regions"] += 1
            elif n == "create_worksheet":
                region = self._region_by_id.get(_sid(call.get("p_region_id"))) or current_region
                report = {
                    "id": call.id(),
                    "page": page_no,
                    "region_id": region["id"] if region else None,
                    "region_name": region["display_name"] if region else None,
                    "name": call.get("p_name"),
                    "max_row_count": call.get("p_max_row_count"),
                    "download_formats": call.get("p_download_formats"),
                    "allow_save_rpt_public": call.get("p_allow_save_rpt_public"),
                    "detail_link": call.get("p_detail_link"),
                    "columns": [],
                    "saved_reports": 0,
                    "sql": region["sql"] if region else None,
                    "table": region["table"] if region else None,
                    "schema_objects": region["schema_objects"] if region else [],
                    "authorization": None,
                    "file": call.file,
                    "line": call.line,
                }
                report["authorization"] = self._authz_ref(call, "report", report["id"], page_no)
                self.reports.append(report)
                self._report_by_id[report["id"]] = report
                current_report = report
                counts["reports"] += 1
            elif n == "create_worksheet_column":
                report = self._report_by_id.get(_sid(call.get("p_worksheet_id"))) or current_report
                if report is not None:
                    report["columns"].append(
                        {
                            "id": call.id(),
                            "alias": call.get("p_db_column_name"),
                            "heading": resolve_substitutions(call.get("p_column_label")),
                            "type": call.get("p_column_type"),
                            "display_order": call.get("p_display_order"),
                            "format_mask": call.get("p_format_mask"),
                            "lov_id": _sid(call.get("p_rpt_named_lov")),
                        }
                    )
                    counts["report_columns"] += 1
            elif n == "create_worksheet_rpt":
                report = self._report_by_id.get(_sid(call.get("p_worksheet_id"))) or current_report
                if report is not None:
                    report["saved_reports"] += 1
            elif n == "create_report_columns":
                counts["classic_report_columns"] += 1
            elif n == "create_jet_chart":
                region_id = _sid(call.get("p_region_id"))
                region = self._region_by_id.get(region_id) or current_region
                chart = {
                    "id": call.id(),
                    "page": page_no,
                    "region_id": region_id,
                    "region_name": region["display_name"] if region else None,
                    "chart_type": call.get("p_chart_type"),
                    "orientation": call.get("p_orientation"),
                    "stack": call.get("p_stack"),
                    "title": call.get("p_title"),
                    "legend_rendered": call.get("p_legend_rendered"),
                    "series": [],
                    "file": call.file,
                    "line": call.line,
                }
                self.charts.append(chart)
                self._chart_by_id[chart["id"]] = chart
                counts["charts"] += 1
            elif n == "create_jet_chart_series":
                chart = self._chart_by_id.get(_sid(call.get("p_chart_id")))
                if chart is not None:
                    sql = call.get("p_data_source")
                    region = self._region_by_id.get(chart["region_id"] or "")
                    if region is not None:
                        region["schema_objects"] = sorted(
                            set(region["schema_objects"]) | set(schema_objects(sql))
                        )
                    chart["series"].append(
                        {
                            "id": call.id(),
                            "name": call.get("p_name"),
                            "data_source_type": call.get("p_data_source_type"),
                            "sql": sql,
                            "schema_objects": schema_objects(sql),
                            "items_value": call.get("p_items_value_column_name"),
                            "items_label": call.get("p_items_label_column_name"),
                            "series_name_column": call.get("p_series_name_column_name"),
                            "color": call.get("p_color"),
                        }
                    )
                    counts["chart_series"] += 1
            elif n == "create_page_item":
                lov_ref = call.get("p_lov")
                named_lov = None
                if isinstance(lov_ref, str) and re.fullmatch(r"\.\d+\.", lov_ref):
                    lov = self._lov_by_id.get(lov_ref.strip("."))
                    named_lov = lov["name"] if lov else lov_ref
                    lov_ref = None
                elif isinstance(lov_ref, str) and len(lov_ref) > 2000:
                    lov_ref = lov_ref[:2000]
                item = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_name"),
                    "region_id": _sid(call.get("p_item_plug_id")),
                    "sequence": call.get("p_item_sequence"),
                    "display_as": call.get("p_display_as"),
                    "prompt": resolve_substitutions(call.get("p_prompt")),
                    "source_type": call.get("p_source_type"),
                    "source": call.get("p_source") if isinstance(call.get("p_source"), str) else None,
                    "data_type": call.get("p_source_data_type"),
                    "is_required": bool(call.get("p_is_required")),
                    "protection_level": call.get("p_protection_level"),
                    "named_lov": named_lov,
                    "lov": lov_ref,
                    "schema_objects": schema_objects(call.get("p_source"), lov_ref),
                    "authorization": None,
                    "file": call.file,
                    "line": call.line,
                }
                item["authorization"] = self._authz_ref(call, "item", item["id"], page_no)
                self.items.append(item)
                counts["items"] += 1
            elif n == "create_page_button":
                button = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_button_name"),
                    "label": resolve_substitutions(call.get("p_button_image_alt")),
                    "region_id": _sid(call.get("p_button_plug_id")),
                    "action": call.get("p_button_action"),
                    "redirect_url": call.get("p_button_redirect_url"),
                    "authorization": None,
                }
                button["authorization"] = self._authz_ref(call, "button", button["id"], page_no)
                self.buttons.append(button)
                counts["buttons"] += 1
            elif n == "create_page_process":
                ptype = call.get("p_process_type")
                body = call.get("p_process_sql_clob")
                if body is None and ptype == "NATIVE_PLSQL":
                    body = call.get("p_attribute_01")
                proc = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_process_name"),
                    "sequence": call.get("p_process_sequence"),
                    "point": call.get("p_process_point"),
                    "type": ptype,
                    "region_id": _sid(call.get("p_region_id")),
                    "when_button_id": _sid(call.get("p_process_when_button_id")),
                    "when_type": call.get("p_process_when_type"),
                    "when": call.get("p_process_when"),
                    "language": call.get("p_process_sql_clob_language"),
                    "plsql": body if isinstance(body, str) else None,
                    "success_message": resolve_substitutions(call.get("p_process_success_message")),
                    "error_message": resolve_substitutions(call.get("p_error_display_location")),
                    "schema_objects": schema_objects(body),
                    "authorization": None,
                    "file": call.file,
                    "line": call.line,
                }
                proc["authorization"] = self._authz_ref(call, "process", proc["id"], page_no)
                self.processes.append(proc)
                counts["processes"] += 1
                if ptype in PLSQL_PROCESS_TYPES:
                    counts["plsql_processes"] += 1
            elif n == "create_page_validation":
                val = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_validation_name"),
                    "sequence": call.get("p_validation_sequence"),
                    "type": call.get("p_validation_type"),
                    "item": call.get("p_associated_item") or call.get("p_validation_item"),
                    "expression": call.get("p_validation"),
                    "language": call.get("p_validation_language"),
                    "error_message": resolve_substitutions(call.get("p_error_message")),
                    "when_button_id": _sid(call.get("p_when_button_id")),
                    "when_type": call.get("p_validation_condition_type")
                    or call.get("p_validation_when_type"),
                    "schema_objects": schema_objects(call.get("p_validation")),
                    "file": call.file,
                    "line": call.line,
                }
                self.validations.append(val)
                counts["validations"] += 1
            elif n == "create_page_computation":
                comp = {
                    "id": call.id(),
                    "page": page_no,
                    "item": call.get("p_computation_item"),
                    "sequence": call.get("p_computation_sequence"),
                    "point": call.get("p_computation_point"),
                    "type": call.get("p_computation_type"),
                    "expression": call.get("p_computation"),
                    "language": call.get("p_computation_language"),
                    "when_type": call.get("p_compute_when_type"),
                    "when": call.get("p_compute_when"),
                    "schema_objects": schema_objects(call.get("p_computation")),
                    "file": call.file,
                    "line": call.line,
                }
                self.computations.append(comp)
                counts["computations"] += 1
            elif n == "create_page_branch":
                self.branches.append(
                    {
                        "id": call.id(),
                        "page": page_no,
                        "point": call.get("p_branch_point"),
                        "type": call.get("p_branch_type"),
                        "action": call.get("p_branch_action"),
                        "when_button_id": _sid(call.get("p_branch_when_button_id")),
                    }
                )
                counts["branches"] += 1
            elif n == "create_page_da_event":
                da = {
                    "id": call.id(),
                    "page": page_no,
                    "name": call.get("p_name"),
                    "sequence": call.get("p_event_sequence"),
                    "event": call.get("p_bind_event_type"),
                    "triggering_element_type": call.get("p_triggering_element_type"),
                    "triggering_region_id": _sid(call.get("p_triggering_region_id")),
                    "triggering_button_id": _sid(call.get("p_triggering_button_id")),
                    "triggering_element": call.get("p_triggering_element"),
                    "condition_type": call.get("p_triggering_condition_type"),
                    "actions": [],
                    "authorization": None,
                    "file": call.file,
                    "line": call.line,
                }
                da["authorization"] = self._authz_ref(call, "dynamic_action", da["id"], page_no)
                self.dynamic_actions.append(da)
                self._da_by_id[da["id"]] = da
                counts["dynamic_actions"] += 1
            elif n == "create_page_da_action":
                da = self._da_by_id.get(_sid(call.get("p_event_id")))
                if da is not None:
                    action_type = call.get("p_action")
                    code = call.get("p_attribute_01") if isinstance(call.get("p_attribute_01"), str) else None
                    action = {
                        "id": call.id(),
                        "sequence": call.get("p_action_sequence"),
                        "action": action_type,
                        "event_result": call.get("p_event_result"),
                        "affected_elements_type": call.get("p_affected_elements_type"),
                        "affected_region_id": _sid(call.get("p_affected_region_id")),
                        "affected_elements": call.get("p_affected_elements"),
                        "plsql": code if action_type == "NATIVE_EXECUTE_PLSQL_CODE" else None,
                        "javascript": code if action_type == "NATIVE_JAVASCRIPT_CODE" else None,
                        "schema_objects": schema_objects(code)
                        if action_type == "NATIVE_EXECUTE_PLSQL_CODE"
                        else [],
                    }
                    da["actions"].append(action)
                    counts["da_actions"] += 1

        if page is None and page_no_from_name is not None:
            page = {
                "page": page_no_from_name,
                "name": None,
                "display_name": None,
                "title": None,
                "display_title": None,
                "alias": None,
                "mode": "NORMAL",
                "page_group": None,
                "authorization": None,
                "page_template": None,
                "navigation_list_id": None,
                "file": str(path.relative_to(self.export_dir)),
                "counts": {},
            }
            self.pages.append(page)
        if page is not None:
            page["counts"] = dict(sorted(counts.items()))

    # ---- summary ------------------------------------------------------------------------------
    def summary(self) -> dict[str, Any]:
        plsql_processes = [p for p in self.processes if p["type"] in PLSQL_PROCESS_TYPES]
        sql_regions = [r for r in self.regions if r["sql"]]
        da_actions = sum(len(d["actions"]) for d in self.dynamic_actions)
        objects: set[str] = set()
        for coll in (
            self.regions,
            self.reports,
            self.items,
            self.processes,
            self.validations,
            self.computations,
            self.lovs,
        ):
            for rec in coll:
                objects.update(rec.get("schema_objects", []))
        for chart in self.charts:
            for s in chart["series"]:
                objects.update(s["schema_objects"])
        for da in self.dynamic_actions:
            for a in da["actions"]:
                objects.update(a["schema_objects"])
        return {
            "pages": len(self.pages),
            "pages_by_mode": dict(Counter(p["mode"] for p in self.pages)),
            "page_groups": len(self.page_groups),
            "regions": len(self.regions),
            "regions_by_type": dict(Counter(r["source_type"] for r in self.regions).most_common()),
            "regions_with_sql": len(sql_regions),
            "regions_with_table_source": sum(1 for r in self.regions if r["table"]),
            "interactive_reports": len(self.reports),
            "interactive_report_columns": sum(len(r["columns"]) for r in self.reports),
            "interactive_report_saved_reports": sum(r["saved_reports"] for r in self.reports),
            "classic_reports": sum(1 for r in self.regions if r["call"] == "create_report_region"),
            "charts": len(self.charts),
            "chart_series": sum(len(c["series"]) for c in self.charts),
            "items": len(self.items),
            "items_by_display": dict(Counter(i["display_as"] for i in self.items).most_common(12)),
            "buttons": len(self.buttons),
            "processes": len(self.processes),
            "plsql_processes": len(plsql_processes),
            "processes_by_type": dict(Counter(p["type"] for p in self.processes).most_common()),
            "validations": len(self.validations),
            "computations": len(self.computations),
            "branches": len(self.branches),
            "dynamic_actions": len(self.dynamic_actions),
            "dynamic_action_actions": da_actions,
            "da_actions_by_type": dict(
                Counter(a["action"] for d in self.dynamic_actions for a in d["actions"]).most_common()
            ),
            "lovs": len(self.lovs),
            "lovs_by_source": dict(Counter(lov["source_type"] for lov in self.lovs)),
            "authorization_schemes": len(self.authz),
            "authorization_references": sum(len(a["used_by"]) for a in self.authz),
            "schema_objects_referenced": sorted(objects),
            "schema_objects_referenced_count": len(objects),
            "plsql_lines": sum(len(p["plsql"].splitlines()) for p in plsql_processes if p["plsql"]),
            "sql_lines": sum(len(r["sql"].splitlines()) for r in sql_regions),
        }

    def build(self) -> dict[str, Any]:
        self._parse_application()
        self._parse_page_groups()
        self._parse_authorizations()
        self._parse_lovs()
        for path in sorted((self.app_dir / "pages").glob("page_*.sql")):
            self._parse_page_file(path)
        self.pages.sort(key=lambda p: p["page"])
        return {
            "application": self.application,
            "source": {
                "export_dir": str(self.export_dir),
                "application_dir": str(self.app_dir.relative_to(self.export_dir)),
                "page_files": len(list((self.app_dir / "pages").glob("page_*.sql"))),
            },
            "summary": self.summary(),
            "call_counts": dict(sorted(self.call_counts.items())),
            "pages": self.pages,
            "regions": self.regions,
            "reports": self.reports,
            "charts": self.charts,
            "items": self.items,
            "buttons": self.buttons,
            "processes": self.processes,
            "validations": self.validations,
            "computations": self.computations,
            "branches": self.branches,
            "dynamic_actions": self.dynamic_actions,
            "lovs": self.lovs,
            "authz": self.authz,
        }


def build_inventory(export_dir: Path | str) -> dict[str, Any]:
    return InventoryBuilder(Path(export_dir)).build()
