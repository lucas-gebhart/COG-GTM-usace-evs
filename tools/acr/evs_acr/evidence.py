"""Loaders for the automated evidence (axe cells, keyboard and reflow smoke, Lighthouse, pa11y) and the
manual attestation file. Every loader tolerates a missing input and returns an empty collection, so the
generator can run with partial evidence and report rows as not-evaluated."""

from __future__ import annotations

import json
import re
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Any

import yaml

from .mapping import LEVELS

_HTMLCS = re.compile(r"^WCAG2A{1,3}\.Principle\d\.Guideline\d_\d\.(\d)_(\d)_(\d{1,2})")


@dataclass
class Violation:
    rule: str
    impact: str
    tags: tuple[str, ...]
    nodes: int
    source: str  # axe | lighthouse | pa11y
    where: str  # cell or URL
    help_url: str = ""
    help: str = ""


@dataclass
class AxeCell:
    route: str
    url: str
    viewport: str
    theme: str
    reduced_motion: bool
    run_at: datetime
    git_sha: str
    axe_version: str
    violations: list[Violation]
    advisories: list[Violation]
    incomplete: list[str]
    passes: int
    passed_rules: set[str]
    inapplicable: set[str]

    @property
    def label(self) -> str:
        motion = "reduce" if self.reduced_motion else "no-preference"
        return f"{self.route} @ {self.viewport}, {self.theme}, motion={motion}"


@dataclass
class SmokeResult:
    kind: str  # keyboard | reflow
    route: str
    label: str
    passed: bool
    details: dict[str, Any]
    run_at: datetime | None


@dataclass
class LighthouseRun:
    url: str
    score: float | None
    failing_audits: list[str]
    fetched_at: datetime | None
    version: str | None = None


@dataclass
class Pa11yReport:
    total: int
    passes: int
    errors: int
    issues: list[Violation]
    urls: list[str]
    needs_review: int = 0
    version: str | None = None


@dataclass
class Attestation:
    criterion: str
    status: str
    tests: tuple[str, ...] = ()
    tester: str | None = None
    date: str | None = None
    assistive_tech: tuple[str, ...] = ()
    notes: str = ""


@dataclass
class AttestationFile:
    product_version: str | None
    testers: list[dict[str, Any]]
    assistive_technology: list[dict[str, Any]]
    attestations: dict[str, Attestation] = field(default_factory=dict)


def _dt(value: Any) -> datetime | None:
    if not value:
        return None
    try:
        return datetime.fromisoformat(str(value).replace("Z", "+00:00"))
    except ValueError:
        return None


def _violation(v: dict[str, Any], source: str, where: str) -> Violation:
    return Violation(
        rule=v.get("id", "unknown"),
        impact=v.get("impact") or "unknown",
        tags=tuple(v.get("tags", [])),
        nodes=len(v.get("nodes", [])),
        source=source,
        where=where,
        help_url=str(v.get("helpUrl") or ""),
        help=str(v.get("help") or ""),
    )


def load_axe_cells(directory: Path | None) -> list[AxeCell]:
    if not directory or not directory.is_dir():
        return []
    cells: list[AxeCell] = []
    for path in sorted(directory.glob("*.json")):
        raw = json.loads(path.read_text())
        label = f"{raw.get('route')} @ {raw.get('viewport')}, {raw.get('theme')}"
        cells.append(
            AxeCell(
                route=raw.get("route", "?"),
                url=raw.get("url", raw.get("route", "?")),
                viewport=raw.get("viewport", "?"),
                theme=raw.get("theme", "light"),
                reduced_motion=bool(raw.get("reducedMotion", False)),
                run_at=_dt(raw.get("runAt")) or datetime.fromtimestamp(path.stat().st_mtime).astimezone(),
                git_sha=raw.get("gitSha", "unknown"),
                axe_version=raw.get("axeVersion", "unknown"),
                violations=[_violation(v, "axe", label) for v in raw.get("violations", [])],
                advisories=[_violation(v, "axe", label) for v in raw.get("advisories", [])],
                incomplete=[i.get("id", "unknown") for i in raw.get("incomplete", [])],
                passes=len(raw.get("passes", [])),
                passed_rules={p.get("id") for p in raw.get("passes", []) if p.get("id")},
                inapplicable=set(raw.get("inapplicable", [])),
            )
        )
    return cells


def load_smoke(directory: Path | None, kind: str) -> list[SmokeResult]:
    if not directory or not directory.is_dir():
        return []
    results: list[SmokeResult] = []
    for path in sorted(directory.glob("*.json")):
        raw = json.loads(path.read_text())
        if kind == "keyboard":
            passed = bool(raw.get("skipLinkMovesFocusToMain")) and bool(raw.get("navReached"))
            passed = passed and raw.get("stepsWithoutVisibleFocus", 0) == 0
            passed = passed and all(
                p.get("closedOnEscape") and p.get("focusRestored")
                for p in raw.get("popovers", [])
                if p.get("opened")
            )
            label = str(raw.get("route"))
        else:
            passed = bool(raw.get("pass"))
            label = f"{raw.get('route')} [{raw.get('theme')}]"
        results.append(
            SmokeResult(
                kind=kind,
                route=str(raw.get("route")),
                label=label,
                passed=passed,
                details=raw,
                run_at=_dt(raw.get("runAt")),
            )
        )
    return results


def load_lighthouse(directory: Path | None) -> list[LighthouseRun]:
    """Reads Lighthouse CI filesystem uploads (manifest.json + LHR JSON) or bare LHR files."""
    if not directory or not directory.is_dir():
        return []
    runs: list[LighthouseRun] = []
    manifest = directory / "manifest.json"
    lhr_paths: list[Path]
    if manifest.exists():
        entries = json.loads(manifest.read_text())
        lhr_paths = [
            Path(e["jsonPath"]) if Path(e["jsonPath"]).is_absolute() else directory / e["jsonPath"]
            for e in entries
        ]
    else:
        lhr_paths = [p for p in directory.glob("*.json") if p.name != "manifest.json"]
    for path in lhr_paths:
        if not path.exists():
            continue
        lhr = json.loads(path.read_text())
        if "audits" not in lhr:
            continue
        cat = (lhr.get("categories") or {}).get("accessibility") or {}
        failing = sorted(
            audit_id
            for audit_id, audit in lhr["audits"].items()
            if audit.get("score") == 0 and audit.get("scoreDisplayMode") in ("binary", "numeric")
        )
        runs.append(
            LighthouseRun(
                url=lhr.get("finalDisplayedUrl") or lhr.get("requestedUrl", "?"),
                score=cat.get("score"),
                failing_audits=failing,
                fetched_at=_dt(lhr.get("fetchTime")),
                version=lhr.get("lighthouseVersion"),
            )
        )
    return runs


def pa11y_code_to_rule(code: str) -> tuple[str | None, str | None]:
    """Returns (axe rule id, WCAG criterion) for a pa11y issue code. htmlcs codes encode the criterion."""
    m = _HTMLCS.match(code)
    if m:
        return None, f"{m.group(1)}.{m.group(2)}.{int(m.group(3))}"
    return code, None


def load_pa11y(path: Path | None) -> Pa11yReport | None:
    """pa11y-ci JSON. `error` items are violations; `warning` items flagged needsFurtherReview (axe incomplete,
    see levelCapWhenNeedsReview in .pa11yci.cjs) are counted as needs-review and never as violations."""
    if not path or not path.exists():
        return None
    try:
        raw = json.loads(path.read_text())
    except json.JSONDecodeError:
        return None
    issues: list[Violation] = []
    needs_review = 0
    results = raw.get("results", {})
    for url, items in results.items():
        for item in items or []:
            extras = item.get("runnerExtras") or {}
            if extras.get("needsFurtherReview"):
                needs_review += 1
                continue
            if item.get("type", "error") != "error":
                continue
            rule, _criterion = pa11y_code_to_rule(str(item.get("code", "")))
            impact = extras.get("impact") or "serious"
            issues.append(
                Violation(
                    rule=rule or str(item.get("code")),
                    impact=impact,
                    tags=(),
                    nodes=1,
                    source="pa11y",
                    where=url,
                )
            )
    return Pa11yReport(
        total=int(raw.get("total", len(results))),
        passes=int(raw.get("passes", 0)),
        errors=len(issues),
        issues=issues,
        urls=list(results),
        needs_review=needs_review,
        version=raw.get("pa11yVersion"),
    )


def load_attestation(path: Path | None) -> AttestationFile:
    if not path or not path.exists():
        return AttestationFile(product_version=None, testers=[], assistive_technology=[])
    raw = yaml.safe_load(path.read_text()) or {}
    attestations: dict[str, Attestation] = {}
    for entry in raw.get("attestations", []) or []:
        status = str(entry.get("status", "not-evaluated"))
        if status not in LEVELS:
            raise ValueError(
                f"attestation for {entry.get('criterion')} has unknown status {status!r}; expected one of {LEVELS}"
            )
        num = str(entry["criterion"])
        attestations[num] = Attestation(
            criterion=num,
            status=status,
            tests=tuple(entry.get("tests", []) or []),
            tester=entry.get("tester") or None,
            date=str(entry["date"]) if entry.get("date") else None,
            assistive_tech=tuple(entry.get("assistive_tech", []) or []),
            notes=str(entry.get("notes") or ""),
        )
    return AttestationFile(
        product_version=raw.get("product_version"),
        testers=list(raw.get("testers", []) or []),
        assistive_technology=list(raw.get("assistive_technology", []) or []),
        attestations=attestations,
    )
