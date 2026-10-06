"""Builds apps/api/fixtures/accessibility.json, the payload behind GET /api/v1/accessibility/readout and the
/accessibility page. Everything the page shows (counts, per-cell results, criterion rows, manual plan status,
tool versions, downloads, statement) is derived here from the evidence so the page never hardcodes a value."""

from __future__ import annotations

from datetime import datetime
from fnmatch import fnmatch
from typing import Any

import yaml

from . import __version__
from .engine import CriterionResult, RunSummary, evaluate_section508
from .evidence import AttestationFile, AxeCell, Violation
from .mapping import DATA, Mapping, catalog_chapters
from .openacr import level_counts

METHOD = {"automated": "automated", "manual": "manual", "not_applicable": "not_applicable"}
ARTIFACTS_BASE = "/api/v1/accessibility/artifacts"
ARTIFACTS: tuple[tuple[str, str, str], ...] = (
    ("evs-openacr.yaml", "OpenACR 2.5 (YAML)", "application/yaml"),
    ("evs-acr.md", "Accessibility Conformance Report (Markdown)", "text/markdown"),
    ("evs-acr.html", "Accessibility Conformance Report (HTML)", "text/html"),
    ("evs-axe-results.json", "axe-core results, every cell (JSON)", "application/json"),
)
CHAPTER_TITLE = {
    "success_criteria_level_a": "WCAG 2.1 Level A",
    "success_criteria_level_aa": "WCAG 2.1 Level AA",
    "functional_performance_criteria": "Revised 508 Chapter 3: Functional performance criteria",
    "support_documentation_and_services": "Revised 508 Chapter 6: Support documentation and services",
}
WCAG_UNDERSTANDING = "https://www.w3.org/WAI/WCAG21/Understanding/"
ACCESS_BOARD = {
    "functional_performance_criteria": "https://www.access-board.gov/ict/#302-functional-performance-criteria",
    "support_documentation_and_services": "https://www.access-board.gov/ict/#602-support-documentation",
}
IMPACTS = ("critical", "serious", "moderate", "minor")


def _iso(dt: datetime | None) -> str | None:
    return dt.isoformat() if dt else None


def _violation(v: Violation) -> dict[str, Any]:
    return {
        "rule": v.rule,
        "impact": v.impact if v.impact in IMPACTS else "unknown",
        "nodes": v.nodes,
        "help_url": v.help_url,
        "help": v.help,
        "source": v.source,
        "where": v.where,
    }


def _cell(c: AxeCell) -> dict[str, Any]:
    return {
        "route": c.route,
        "viewport": c.viewport,
        "theme": c.theme,
        "reduced_motion": c.reduced_motion,
        "violations": len(c.violations),
        "passes": c.passes,
        "incomplete": len(c.incomplete),
        "advisories": len(c.advisories),
        "run_at": c.run_at.isoformat(),
        "violation_details": [_violation(v) for v in c.violations],
        "incomplete_rules": sorted(c.incomplete),
    }


def _evidence_links(
    result: CriterionResult, alt_id: str | None, run: RunSummary, plan_url: str | None
) -> list[dict[str, str]]:
    links: list[dict[str, str]] = []
    if alt_id:
        links.append({"label": f"Understanding {result.num}", "href": f"{WCAG_UNDERSTANDING}{alt_id}"})
    if result.method == "automated" and run.cells:
        links.append(
            {"label": f"axe results, {run.cells} cells", "href": f"{ARTIFACTS_BASE}/evs-axe-results.json"}
        )
    seen: set[str] = set()
    for v in result.violations:
        if v.help_url and v.help_url not in seen:
            seen.add(v.help_url)
            links.append({"label": f"axe rule {v.rule}", "href": v.help_url})
    if result.method == "manual" or (result.method == "automated" and result.manual_note):
        if plan_url:
            links.append({"label": "Manual test plan", "href": plan_url})
    return links


def _chapter_index() -> tuple[dict[str, str], dict[str, str]]:
    chapters = catalog_chapters()
    alt_ids: dict[str, str] = {}
    chapter_of: dict[str, str] = {}
    for chapter_id in CHAPTER_TITLE:
        for entry in chapters[chapter_id]["criteria"]:
            chapter_of[str(entry["id"])] = chapter_id
            if chapter_id.startswith("success_criteria"):
                alt_ids[str(entry["id"])] = entry.get("alt_id", "")
    return alt_ids, chapter_of


def _criterion_rows(
    results: list[CriterionResult],
    run: RunSummary,
    attestation: AttestationFile | None,
    plan_url: str | None,
) -> list[dict[str, Any]]:
    alt_ids, chapter_of = _chapter_index()
    rows: list[dict[str, Any]] = []
    for r in results:
        att = attestation.attestations.get(r.num) if attestation else None
        fallback = "success_criteria_level_a" if r.level == "A" else "success_criteria_level_aa"
        chapter = chapter_of.get(r.num, fallback)
        rows.append(
            {
                "criterion": r.num,
                "name": r.name,
                "level": r.level,
                "chapter": chapter,
                "chapter_title": CHAPTER_TITLE[chapter],
                "method": METHOD[r.method],
                "status": r.adherence,
                "notes": r.short_note,
                "detail": r.notes,
                "automated_cells": r.cells,
                "open_violations": len(r.violations),
                "manual_tests": list(att.tests) if att else [],
                "tester": att.tester if att else None,
                "attested_on": att.date if att else None,
                "evidence": _evidence_links(r, alt_ids.get(r.num), run, plan_url),
            }
        )
    return rows


def _section508_rows(
    mapping: Mapping | None, attestation: AttestationFile | None, plan_url: str | None
) -> list[dict[str, Any]]:
    """Revised 508 Chapter 3 (302.x) and Chapter 6 (602, 603) rows: manual attestation only."""
    if mapping is None or attestation is None:
        return []
    _alt_ids, chapter_of = _chapter_index()
    rows: list[dict[str, Any]] = []
    for row in mapping.section508:
        chapter = chapter_of.get(row.num)
        if chapter is None:
            continue
        level, note = evaluate_section508(row, attestation)
        att = attestation.attestations.get(row.num)
        links = [{"label": "Revised 508 standard", "href": ACCESS_BOARD[chapter]}]
        if plan_url and row.manual_tests:
            links.append({"label": "Manual test plan", "href": plan_url})
        rows.append(
            {
                "criterion": row.num,
                "name": row.name,
                "level": "508",
                "chapter": chapter,
                "chapter_title": CHAPTER_TITLE[chapter],
                "method": "manual" if row.default_level != "not-applicable" else "not_applicable",
                "status": level,
                "notes": note,
                "detail": note,
                "automated_cells": 0,
                "open_violations": 0,
                "manual_tests": list(row.manual_tests),
                "tester": att.tester if att else None,
                "attested_on": att.date if att else None,
                "evidence": links,
            }
        )
    return rows


def load_manual_plan(path: Any = None) -> list[dict[str, Any]]:
    raw = yaml.safe_load((path or DATA / "manual_plan.yaml").read_text())
    return list(raw.get("rows", []))


def _test_matches(test_id: str, patterns: list[str]) -> bool:
    return any(fnmatch(test_id, p) for p in patterns)


def _manual_rows(attestation: AttestationFile | None, plan: list[dict[str, Any]]) -> list[dict[str, Any]]:
    at_versions = {
        str(a.get("id")): str(a.get("version") or "")
        for a in (attestation.assistive_technology if attestation else [])
    }
    rows: list[dict[str, Any]] = []
    for item in plan:
        patterns = [str(t) for t in item.get("tests", [])]
        at_id = item.get("assistive_tech")
        criteria: list[str] = []
        attested: list[Any] = []
        for att in attestation.attestations.values() if attestation else []:
            cites_test = any(_test_matches(t, patterns) for t in att.tests)
            uses_at = bool(at_id) and at_id in att.assistive_tech
            if not (cites_test or uses_at):
                continue
            criteria.append(att.criterion)
            if att.status not in ("not-evaluated", "not-applicable"):
                attested.append(att)
        statuses = {a.status for a in attested}
        if not criteria:
            status = "not-evaluated"
        elif not attested:
            status = "planned"
        elif "does-not-support" in statuses:
            status = "failed"
        elif "partially-supports" in statuses:
            status = "partial"
        else:
            status = "passed"
        testers = sorted({a.tester for a in attested if a.tester})
        dates = sorted(a.date for a in attested if a.date)
        rows.append(
            {
                "id": str(item["id"]),
                "name": str(item["name"]),
                "category": str(item.get("category", "other")),
                "assistive_tech": at_id,
                "version": at_versions.get(str(at_id), "") if at_id else "",
                "tests": patterns,
                "status": status,
                "criteria_total": len(criteria),
                "criteria_attested": len(attested),
                "tester": ", ".join(testers) if testers else None,
                "date": dates[-1] if dates else None,
            }
        )
    return rows


def _known_issues(
    counts: dict[str, int], needs_review: int, manual_rows: list[dict[str, Any]], run: RunSummary
) -> list[str]:
    issues: list[str] = []
    if run.cells == 0:
        issues.append("No axe-core evidence in this build; automated rows are not evaluated.")
    if counts["not-evaluated"]:
        issues.append(
            f"{counts['not-evaluated']} of 48 WCAG 2.1 A/AA criteria are not evaluated: manual attestation outstanding, no claim made."
        )
    if counts["does-not-support"]:
        issues.append(
            f"{counts['does-not-support']} criteria do not support: open critical or serious defects."
        )
    if counts["partially-supports"]:
        issues.append(
            f"{counts['partially-supports']} criteria partially support: open moderate or minor defects."
        )
    if needs_review:
        issues.append(
            f"{needs_review} axe needs-review items (incomplete checks such as contrast over images) await a human decision."
        )
    planned = sum(1 for m in manual_rows if m["status"] == "planned")
    if planned:
        issues.append(
            f"{planned} of {len(manual_rows)} manual test environments are planned and not yet executed."
        )
    failed = [m["name"] for m in manual_rows if m["status"] in ("failed", "partial")]
    if failed:
        issues.append("Manual testing found defects with: " + ", ".join(failed) + ".")
    return issues


def build_axe_bundle(cells: list[AxeCell], run: RunSummary, now: datetime) -> dict[str, Any]:
    """Compact per-cell axe results served as the downloadable JSON bundle."""
    return {
        "generated_at": now.isoformat(),
        "generator": f"evs-acr-gen {__version__}",
        "git_sha": run.git_sha,
        "axe_version": run.axe_version,
        "cells": [
            {**_cell(c), "url": c.url, "advisory_details": [_violation(v) for v in c.advisories]}
            for c in cells
        ],
    }


def build_readout(
    cells: list[AxeCell],
    results: list[CriterionResult],
    run: RunSummary,
    now: datetime,
    target: str,
    acr_download_url: str,
    mapping: Mapping | None = None,
    attestation: AttestationFile | None = None,
    meta: dict[str, Any] | None = None,
    manual_plan: list[dict[str, Any]] | None = None,
) -> dict[str, Any]:
    meta = meta or {}
    plan_url = meta.get("manual_test_plan_url")
    routes = [_cell(c) for c in cells]
    criteria = _criterion_rows(results, run, attestation, plan_url)
    section508 = _section508_rows(mapping, attestation, plan_url)
    manual = _manual_rows(attestation, manual_plan if manual_plan is not None else load_manual_plan())
    counts = level_counts(results)
    needs_review = sum(len(c.incomplete) for c in cells) + (run.pa11y.needs_review if run.pa11y else 0)
    route_paths = sorted({c.route for c in cells})
    product = dict(meta.get("product", {}))
    version = (
        str(attestation.product_version)
        if attestation and attestation.product_version
        else product.get("version", "")
    )
    sha = run.git_sha[:12] if run.git_sha != "unknown" else "unknown"

    summary = {
        "criteria_total": len(results),
        "supports": counts["supports"],
        "partially_supports": counts["partially-supports"],
        "does_not_support": counts["does-not-support"],
        "not_applicable": counts["not-applicable"],
        "not_evaluated": counts["not-evaluated"],
        "routes_tested": run.routes,
        "cells": run.cells,
        "zero_violation_cells": sum(1 for c in cells if not c.violations),
        "viewports": sorted({c.viewport for c in cells}),
        "themes": sorted({c.theme for c in cells}),
        "motion_settings": run.motion_settings,
        "total_violations": run.total_violations,
        "total_advisories": run.total_advisories,
        "needs_review": needs_review,
        "last_run_at": _iso(run.run_at),
        "keyboard_routes_passed": sum(1 for k in run.keyboard if k.passed),
        "keyboard_routes_total": len(run.keyboard),
        "reflow_cells_passed": sum(1 for r in run.reflow if r.passed),
        "reflow_cells_total": len(run.reflow),
        "lighthouse_runs": run.lighthouse_runs,
        "lighthouse_min_score": run.lighthouse_min_score,
        "pa11y_urls": run.pa11y.total if run.pa11y else 0,
        "pa11y_errors": run.pa11y.errors if run.pa11y else 0,
        "manual_passed": sum(1 for m in manual if m["status"] == "passed"),
        "manual_total": len(manual),
    }
    versions = {
        "axe": run.axe_version,
        "pa11y": run.pa11y_version,
        "lighthouse": run.lighthouse_version,
        "generator": __version__,
    }
    artifacts = [
        {"name": name, "label": label, "media_type": media, "href": f"{ARTIFACTS_BASE}/{name}"}
        for name, label, media in ARTIFACTS
    ]
    statement = {
        "product": product.get("name", "Enterprise Visibility Suite (EVS)"),
        "version": version,
        "description": product.get("description", ""),
        "standard": meta.get("standard", "Revised Section 508 (36 CFR Part 1194) and WCAG 2.1 Level AA"),
        "design_rules": list(meta.get("design_rules", [])),
        "scope_routes": route_paths,
        "evaluation_methods": meta.get("evaluation_methods_used", ""),
        "known_issues": _known_issues(counts, needs_review, manual, run),
        "contact": meta.get("feedback", "TBD"),
        "repository": meta.get("repository", ""),
        "legal_disclaimer": meta.get("legal_disclaimer", ""),
        "report_date": now.date().isoformat(),
        "git_sha": sha,
        "demo_notice": "EVS is a demonstration system. This read-out describes the demo build, not a production deployment.",
    }
    return {
        "target": target,
        "routes": routes,
        "criteria": criteria,
        "section508": section508,
        "acr_download_url": acr_download_url,
        "generated_at": now.isoformat(),
        "git_sha": run.git_sha,
        "axe_version": run.axe_version,
        "as_of": {
            "source_as_of": _iso(run.run_at),
            "fetched_at": now.isoformat(),
            "freshness": "fresh",
            "source": "fixtures",
        },
        "summary": summary,
        "versions": versions,
        "manual": manual,
        "artifacts": artifacts,
        "statement": statement,
    }
