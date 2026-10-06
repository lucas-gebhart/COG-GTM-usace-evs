"""Builds the OpenACR document (schema openacr-0.1.0, catalog 2.5 WCAG 2.1 + 508) from evaluated criteria."""

from __future__ import annotations

from datetime import datetime
from typing import Any

import yaml

from .engine import CriterionResult, RunSummary, evaluate_section508
from .evidence import AttestationFile
from .mapping import LEVELS, Mapping, catalog_chapters, load_catalog

NOT_APPLICABLE_COMPONENT = "EVS is a web application; this component is not applicable."


class _Dumper(yaml.SafeDumper):
    pass


def _str_presenter(dumper: yaml.SafeDumper, data: str) -> yaml.ScalarNode:
    if len(data) > 100 or "\n" in data:
        return dumper.represent_scalar("tag:yaml.org,2002:str", data, style=">")
    return dumper.represent_scalar("tag:yaml.org,2002:str", data)


_Dumper.add_representer(str, _str_presenter)


def _us_date(dt: datetime) -> str:
    return f"{dt.month}/{dt.day}/{dt.year}"


def _web_component(level: str, notes: str) -> dict[str, Any]:
    return {"name": "web", "adherence": {"level": level, "notes": notes}}


def _na_component(name: str) -> dict[str, Any]:
    return {"name": name, "adherence": {"level": "not-applicable", "notes": NOT_APPLICABLE_COMPONENT}}


def _wcag_row(num: str, components: list[str], level: str, notes: str) -> dict[str, Any]:
    comps = [_web_component(level, notes)] + [_na_component(c) for c in components if c != "web"]
    return {"num": num, "components": comps}


def _none_row(num: str, level: str, notes: str) -> dict[str, Any]:
    return {"num": num, "components": [{"name": "none", "adherence": {"level": level, "notes": notes}}]}


def build_document(
    meta: dict[str, Any],
    mapping: Mapping,
    results: list[CriterionResult],
    run: RunSummary,
    attestation_file: AttestationFile,
    now: datetime,
    version: int = 1,
) -> dict[str, Any]:
    chapters = catalog_chapters()
    by_num = {r.num: r for r in results}
    doc_chapters: dict[str, Any] = {}

    for chapter_id in ("success_criteria_level_a", "success_criteria_level_aa"):
        rows = []
        for entry in chapters[chapter_id]["criteria"]:
            num = str(entry["id"])
            result = by_num.get(num)
            if result is None:
                rows.append(
                    _wcag_row(
                        num, entry["components"], "not-evaluated", "No mapping entry; evidence not collected."
                    )
                )
            else:
                rows.append(_wcag_row(num, entry["components"], result.adherence, result.notes))
        doc_chapters[chapter_id] = {"notes": mapping.chapter_notes.get(chapter_id, ""), "criteria": rows}

    aaa_rows = [
        {"num": str(e["id"]), "components": [_web_component("not-evaluated", "AAA not targeted.")]}
        for e in chapters["success_criteria_level_aaa"]["criteria"]
    ]
    doc_chapters["success_criteria_level_aaa"] = {
        "notes": mapping.chapter_notes.get("success_criteria_level_aaa", ""),
        "criteria": aaa_rows,
    }

    s508 = {r.num: r for r in mapping.section508}
    fpc_rows = []
    for entry in chapters["functional_performance_criteria"]["criteria"]:
        num = str(entry["id"])
        row = s508.get(num)
        if row is None:
            fpc_rows.append(_none_row(num, "not-evaluated", "No mapping entry."))
        else:
            level, note = evaluate_section508(row, attestation_file)
            fpc_rows.append(_none_row(num, level, note))
    doc_chapters["functional_performance_criteria"] = {
        "notes": mapping.chapter_notes.get("functional_performance_criteria", ""),
        "criteria": fpc_rows,
    }

    doc_chapters["hardware"] = {
        "notes": mapping.chapter_notes.get("hardware", ""),
        "criteria": [
            _none_row(str(e["id"]), "not-applicable", "Not applicable. Web application only.")
            for e in chapters["hardware"]["criteria"]
        ],
    }
    doc_chapters["software"] = {
        "notes": mapping.chapter_notes.get("software", ""),
        "criteria": [
            _none_row(
                str(e["id"]),
                "not-applicable",
                "Not applicable. See chapter note (VPAT 2.5 Chapter 5 web content guidance).",
            )
            for e in chapters["software"]["criteria"]
        ],
    }
    support_rows = []
    for entry in chapters["support_documentation_and_services"]["criteria"]:
        num = str(entry["id"])
        row = s508.get(num)
        if row is None:
            support_rows.append(_none_row(num, "not-evaluated", "No mapping entry."))
        else:
            level, note = evaluate_section508(row, attestation_file)
            support_rows.append(_none_row(num, level, note))
    doc_chapters["support_documentation_and_services"] = {
        "notes": mapping.chapter_notes.get("support_documentation_and_services", ""),
        "criteria": support_rows,
    }

    sha = run.git_sha[:12] if run.git_sha != "unknown" else "unknown"
    product = dict(meta["product"])
    if attestation_file.product_version:
        product["version"] = str(attestation_file.product_version)
    counts = level_counts(results)
    notes = (
        f"{meta['notes']} Evidence in this build: {run.cells} axe cells, {run.total_violations} gating violations, "
        f"{run.lighthouse_runs} Lighthouse runs, {len(run.keyboard)} keyboard smoke routes, {len(run.reflow)} reflow cells, "
        f"{sum(1 for a in attestation_file.attestations.values() if a.status != 'not-evaluated')} attested rows; commit {sha}. "
        f"WCAG 2.1 A/AA rows: {counts['supports']} supports, {counts['partially-supports']} partially supports, "
        f"{counts['does-not-support']} does not support, {counts['not-applicable']} not applicable, {counts['not-evaluated']} not evaluated."
    )
    return {
        "title": meta["title"],
        "product": product,
        "author": meta["author"],
        "vendor": meta["vendor"],
        "report_date": _us_date(now),
        "last_modified_date": _us_date(now),
        "version": version,
        "notes": notes,
        "evaluation_methods_used": meta["evaluation_methods_used"],
        "legal_disclaimer": meta["legal_disclaimer"],
        "repository": meta["repository"],
        "feedback": meta["feedback"],
        "license": meta["license"],
        "related_openacrs": [],
        "chapters": doc_chapters,
    }


def level_counts(results: list[CriterionResult]) -> dict[str, int]:
    counts = dict.fromkeys(LEVELS, 0)
    for r in results:
        counts[r.adherence] += 1
    return counts


def dump_yaml(doc: dict[str, Any]) -> str:
    header = (
        "# EVS OpenACR (VPAT 2.5 WCAG 2.1 + Revised Section 508 edition). Generated by evs-acr-gen; do not edit by hand.\n"
        "# Catalog: https://github.com/GSA/openacr/blob/main/catalog/2.5-edition-wcag-2.1-508-en.yaml\n"
        "# Schema:  https://github.com/GSA/openacr/blob/main/schema/openacr-0.1.0.json\n"
        "# Validate: npx @openacr/openacr validate -f docs/a11y/evs-openacr.yaml -c tools/acr/evs_acr/data/catalog-2.5-edition-wcag-2.1-508-en.yaml\n"
    )
    return header + yaml.dump(doc, Dumper=_Dumper, sort_keys=False, allow_unicode=True, width=110)


def validate_document(doc: dict[str, Any]) -> list[str]:
    """Structural checks mirroring what `openacr validate` enforces: required keys, known levels, catalog
    coverage and component names. Returns a list of problems (empty when valid)."""
    problems: list[str] = []
    for key in (
        "title",
        "product",
        "author",
        "vendor",
        "report_date",
        "last_modified_date",
        "version",
        "notes",
        "evaluation_methods_used",
        "legal_disclaimer",
        "repository",
        "feedback",
        "license",
        "chapters",
    ):
        if key not in doc:
            problems.append(f"missing top-level key {key}")
    catalog = load_catalog()
    for chapter in catalog["chapters"]:
        cid = chapter["id"]
        if cid not in doc.get("chapters", {}):
            problems.append(f"missing chapter {cid}")
            continue
        rows = {str(r["num"]): r for r in doc["chapters"][cid].get("criteria", [])}
        for entry in chapter["criteria"]:
            num = str(entry["id"])
            row = rows.get(num)
            if row is None:
                problems.append(f"{cid}: missing criterion {num}")
                continue
            names = [c["name"] for c in row["components"]]
            for name in names:
                if name not in entry["components"]:
                    problems.append(f"{cid} {num}: component {name} not in catalog")
            for comp in row["components"]:
                level = comp["adherence"]["level"]
                if level not in LEVELS:
                    problems.append(f"{cid} {num} {comp['name']}: unknown level {level}")
        extra = set(rows) - {str(e["id"]) for e in chapter["criteria"]}
        for num in sorted(extra):
            problems.append(f"{cid}: criterion {num} not in catalog")
    return problems
