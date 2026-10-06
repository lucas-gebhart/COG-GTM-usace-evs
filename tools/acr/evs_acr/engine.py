"""Turns evidence into one adherence level per criterion, with a notes string that cites the evidence.

Population rule (docs/research/evs_508_and_design_report.md, section 2.3):
  supports            every automated cell passes AND the manual attestation (where required) says supports
  partially-supports  a moderate or minor violation, a failed smoke check, or an attested partial
  does-not-support    a critical or serious violation or an attested failure
  not-applicable      criterion concerns content EVS does not ship
  not-evaluated       evidence missing; never a claim
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime

from .evidence import AttestationFile, AxeCell, LighthouseRun, Pa11yReport, SmokeResult, Violation
from .mapping import LEVEL_RANK, Criterion, Mapping, Section508Row, tag_to_criterion

SEVERE = {"critical", "serious"}


@dataclass
class CriterionResult:
    num: str
    name: str
    level: str  # A | AA
    method: str
    adherence: str
    cells: int
    violations: list[Violation]
    smoke_total: int
    smoke_failed: int
    attestation_status: str | None
    notes: str
    automated_note: str = ""
    manual_note: str = ""
    short_note: str = ""
    sources: list[str] = field(default_factory=list)


@dataclass
class RunSummary:
    cells: int
    routes: int
    viewports: int
    themes: int
    motion_settings: int
    git_sha: str
    axe_version: str
    run_at: datetime | None
    total_violations: int
    total_advisories: int
    lighthouse_runs: int
    lighthouse_min_score: float | None
    lighthouse_failing: int
    pa11y: Pa11yReport | None
    keyboard: list[SmokeResult]
    reflow: list[SmokeResult]
    lighthouse_version: str | None = None
    pa11y_version: str | None = None


def worst(*levels: str) -> str:
    return min(levels, key=lambda lv: LEVEL_RANK[lv])


def summarise_run(
    cells: list[AxeCell],
    lighthouse: list[LighthouseRun],
    pa11y: Pa11yReport | None,
    keyboard: list[SmokeResult],
    reflow: list[SmokeResult],
) -> RunSummary:
    scores = [r.score for r in lighthouse if r.score is not None]
    return RunSummary(
        cells=len(cells),
        routes=len({c.route for c in cells}),
        viewports=len({c.viewport for c in cells}),
        themes=len({c.theme for c in cells}),
        motion_settings=len({c.reduced_motion for c in cells}),
        git_sha=next((c.git_sha for c in cells if c.git_sha != "unknown"), "unknown"),
        axe_version=next((c.axe_version for c in cells if c.axe_version != "unknown"), "unknown"),
        run_at=max((c.run_at for c in cells), default=None),
        total_violations=sum(len(c.violations) for c in cells),
        total_advisories=sum(len(c.advisories) for c in cells),
        lighthouse_runs=len(lighthouse),
        lighthouse_min_score=min(scores) if scores else None,
        lighthouse_failing=sum(len(r.failing_audits) for r in lighthouse),
        pa11y=pa11y,
        keyboard=keyboard,
        reflow=reflow,
        lighthouse_version=next((r.version for r in lighthouse if r.version), None),
        pa11y_version=pa11y.version if pa11y else None,
    )


def _violations_for(
    criterion: Criterion,
    cells: list[AxeCell],
    lighthouse: list[LighthouseRun],
    pa11y: Pa11yReport | None,
    rule_index: dict[str, set[str]],
) -> list[Violation]:
    rules = set(criterion.axe_rules)
    found: list[Violation] = []
    for cell in cells:
        for v in cell.violations:
            by_rule = v.rule in rules
            by_tag = any(tag_to_criterion(t) == criterion.num for t in v.tags)
            if by_rule or by_tag:
                found.append(v)
    for run in lighthouse:
        for audit in run.failing_audits:
            if audit in rules or criterion.num in rule_index.get(audit, set()):
                found.append(
                    Violation(
                        rule=audit, impact="serious", tags=(), nodes=1, source="lighthouse", where=run.url
                    )
                )
    if pa11y:
        for issue in pa11y.issues:
            if issue.rule in rules:
                found.append(issue)
    return found


def _fmt_date(dt: datetime | None) -> str:
    return dt.strftime("%Y-%m-%d %H:%M UTC") if dt else "n/a"


def _automated_note(criterion: Criterion, violations: list[Violation], run: RunSummary) -> str:
    if criterion.method == "not_applicable":
        return ""
    if not criterion.axe_rules:
        return "AUTOMATED: no axe-core rule covers this criterion; evidence is manual."
    if run.cells == 0:
        return f"AUTOMATED: axe rules [{', '.join(criterion.axe_rules)}]; no CI run found, 0 cells."
    sha = run.git_sha[:12] if run.git_sha != "unknown" else "unknown"
    base = (
        f"AUTOMATED: axe rules [{', '.join(criterion.axe_rules)}]; {run.cells} cells "
        f"({run.routes} routes x {run.viewports} viewports x {run.themes} themes x {run.motion_settings} motion settings), "
        f"{len(violations)} violations; axe-core {run.axe_version}; commit {sha}; run {_fmt_date(run.run_at)}."
    )
    if violations:
        by_rule: dict[str, int] = {}
        for v in violations:
            by_rule[f"{v.rule} ({v.source}, {v.impact})"] = (
                by_rule.get(f"{v.rule} ({v.source}, {v.impact})", 0) + 1
            )
        base += " Open: " + "; ".join(f"{k} x{n}" for k, n in sorted(by_rule.items())) + "."
    return base


def _smoke_note(criterion: Criterion, run: RunSummary) -> tuple[str, int, int]:
    if criterion.smoke == "keyboard":
        results = run.keyboard
        what = "keyboard smoke (skip link first, nav then main, visible focus, Escape closes popovers)"
    elif criterion.smoke == "reflow":
        results = run.reflow
        what = "320 px reflow smoke (no horizontal scroll, both themes)"
    else:
        return "", 0, 0
    if not results:
        return f" SMOKE: {what}: no results in this run.", 0, 0
    failed = [r for r in results if not r.passed]
    note = f" SMOKE: {what}: {len(results) - len(failed)}/{len(results)} cells passed"
    if failed:
        note += " (failed: " + ", ".join(r.label for r in failed[:6]) + ")"
    return note + ".", len(results), len(failed)


def _manual_note(
    tests: tuple[str, ...], note: str, attestation_file: AttestationFile, num: str
) -> tuple[str, str | None]:
    att = attestation_file.attestations.get(num)
    if not tests and not att:
        return "MANUAL: none required beyond automation.", None
    ids = ", ".join(tests) if tests else "attestation"
    if att is None or att.status == "not-evaluated":
        extra = f" ({att.notes})" if att and att.notes else ""
        return f"MANUAL: {ids} ({note}) not yet attested{extra}.", att.status if att else None
    who = att.tester or "unnamed tester"
    when = att.date or "undated"
    at = ", ".join(att.assistive_tech) if att.assistive_tech else "no AT recorded"
    text = f"MANUAL: {ids} {att.status} by {who} on {when} with {at}."
    if att.notes:
        text += f" {att.notes}"
    return text, att.status


def evaluate_criterion(
    criterion: Criterion,
    cells: list[AxeCell],
    lighthouse: list[LighthouseRun],
    pa11y: Pa11yReport | None,
    attestation_file: AttestationFile,
    run: RunSummary,
    rule_index: dict[str, set[str]],
) -> CriterionResult:
    att = attestation_file.attestations.get(criterion.num)
    violations = _violations_for(criterion, cells, lighthouse, pa11y, rule_index)
    automated = _automated_note(criterion, violations, run)
    smoke, smoke_total, smoke_failed = _smoke_note(criterion, run)
    manual, att_status = _manual_note(
        criterion.manual_tests, criterion.manual_note, attestation_file, criterion.num
    )

    if criterion.method == "not_applicable":
        adherence = "not-applicable"
        reason = (att.notes if att and att.notes else criterion.na_reason) or "Not applicable."
        notes = f"NOT APPLICABLE: {reason}"
        short = reason
    else:
        if criterion.method == "automated":
            if run.cells == 0:
                auto_level = "not-evaluated"
            elif violations:
                auto_level = (
                    "does-not-support"
                    if any(v.impact in SEVERE for v in violations)
                    else "partially-supports"
                )
            else:
                auto_level = "supports"
        else:
            auto_level = "supports"  # nothing automated to fail; manual decides below
        if smoke_total and smoke_failed:
            auto_level = worst(auto_level, "partially-supports")
        if criterion.manual_tests:
            manual_level = att_status if att_status else "not-evaluated"
        else:
            manual_level = "supports"
        if manual_level == "not-applicable":
            manual_level = "supports" if criterion.method == "automated" else "not-applicable"
        adherence = worst(auto_level, manual_level)
        if criterion.method == "manual" and auto_level == "supports" and manual_level == "not-evaluated":
            adherence = "not-evaluated"
        notes = " ".join(part for part in (automated + smoke, manual) if part)
        if adherence == "not-evaluated":
            short = "Evidence incomplete; no claim made."
        elif adherence == "supports":
            short = "Automated cells pass and manual attestation supports."
        else:
            short = f"{len(violations)} open violations" if violations else "Attested as " + adherence
        notes += " Not a conformance claim until every row carries evidence."

    sources = sorted(
        {v.source for v in violations}
        | ({"axe"} if run.cells else set())
        | ({"attestation"} if att else set())
    )
    return CriterionResult(
        num=criterion.num,
        name=criterion.name,
        level=criterion.level,
        method=criterion.method,
        adherence=adherence,
        cells=run.cells if criterion.method == "automated" else 0,
        violations=violations,
        smoke_total=smoke_total,
        smoke_failed=smoke_failed,
        attestation_status=att_status,
        notes=notes,
        automated_note=automated + smoke,
        manual_note=manual,
        short_note=short,
        sources=sources,
    )


def evaluate_section508(row: Section508Row, attestation_file: AttestationFile) -> tuple[str, str]:
    att = attestation_file.attestations.get(row.num)
    if att and att.status != "not-evaluated":
        who = att.tester or "unnamed tester"
        at = ", ".join(att.assistive_tech) if att.assistive_tech else "no AT recorded"
        note = f"{row.manual_note}. Attested {att.status} by {who} on {att.date or 'undated'} with {at}."
        if att.notes:
            note += f" {att.notes}"
        return att.status, note
    if row.default_level == "not-applicable":
        return "not-applicable", f"Not applicable: {row.manual_note}."
    tests = f" ({', '.join(row.manual_tests)})" if row.manual_tests else ""
    return "not-evaluated", f"{row.manual_note}{tests}. Not yet attested; no claim made."


def evaluate_all(
    mapping: Mapping,
    cells: list[AxeCell],
    lighthouse: list[LighthouseRun],
    pa11y: Pa11yReport | None,
    keyboard: list[SmokeResult],
    reflow: list[SmokeResult],
    attestation_file: AttestationFile,
) -> tuple[RunSummary, list[CriterionResult]]:
    run = summarise_run(cells, lighthouse, pa11y, keyboard, reflow)
    rule_index = mapping.rule_index()
    results = [
        evaluate_criterion(c, cells, lighthouse, pa11y, attestation_file, run, rule_index)
        for c in mapping.criteria
    ]
    return run, results
