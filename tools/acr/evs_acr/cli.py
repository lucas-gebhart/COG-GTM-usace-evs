"""evs-acr-gen: merge CI accessibility evidence and the manual attestation into an OpenACR."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import UTC, datetime
from pathlib import Path

import yaml

from . import __version__
from .engine import evaluate_all
from .evidence import load_attestation, load_axe_cells, load_lighthouse, load_pa11y, load_smoke
from .mapping import DATA, load_mapping
from .openacr import build_document, dump_yaml, level_counts, validate_document
from .readout import build_axe_bundle, build_readout
from .render import render_html, render_markdown

REPO_ROOT = Path(__file__).resolve().parents[3]
TARGET = "WCAG 2.1 AA (Revised Section 508)"


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    p = argparse.ArgumentParser(prog="evs-acr-gen", description=__doc__)
    results = REPO_ROOT / "apps" / "web" / "a11y-results"
    p.add_argument(
        "--axe-dir", type=Path, default=results / "axe", help="per-cell axe JSON from e2e/a11y.spec.ts"
    )
    p.add_argument("--keyboard-dir", type=Path, default=results / "keyboard")
    p.add_argument("--reflow-dir", type=Path, default=results / "reflow")
    p.add_argument(
        "--lighthouse-dir",
        type=Path,
        default=results / "lighthouse",
        help="Lighthouse CI filesystem upload dir",
    )
    p.add_argument("--pa11y", type=Path, default=results / "pa11y.json", help="pa11y-ci JSON report")
    p.add_argument(
        "--attestation", type=Path, default=REPO_ROOT / "docs" / "a11y" / "manual_attestation.yaml"
    )
    p.add_argument("--meta", type=Path, default=DATA / "report_meta.yaml")
    p.add_argument("--out-dir", type=Path, default=REPO_ROOT / "docs" / "a11y")
    p.add_argument(
        "--readout", type=Path, default=REPO_ROOT / "apps" / "api" / "fixtures" / "accessibility.json"
    )
    p.add_argument("--acr-url", default="/acr/evs-openacr.yaml", help="download URL recorded in the readout")
    p.add_argument("--now", default=None, help="ISO timestamp override (deterministic output for tests)")
    p.add_argument("--report-version", type=int, default=1)
    p.add_argument(
        "--strict",
        action="store_true",
        help="exit 3 if any WCAG A/AA row is still not-evaluated (release gate)",
    )
    p.add_argument(
        "--fail-on-violations",
        action="store_true",
        help="exit 4 if any criterion is does-not-support or partially-supports",
    )
    p.add_argument("--version", action="version", version=f"evs-acr-gen {__version__}")
    return p.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    now = datetime.fromisoformat(args.now) if args.now else datetime.now(UTC)
    if now.tzinfo is None:
        now = now.replace(tzinfo=UTC)

    mapping = load_mapping()
    meta = yaml.safe_load(args.meta.read_text())
    cells = load_axe_cells(args.axe_dir)
    keyboard = load_smoke(args.keyboard_dir, "keyboard")
    reflow = load_smoke(args.reflow_dir, "reflow")
    lighthouse = load_lighthouse(args.lighthouse_dir)
    pa11y = load_pa11y(args.pa11y)
    attestation = load_attestation(args.attestation)

    run, results = evaluate_all(mapping, cells, lighthouse, pa11y, keyboard, reflow, attestation)
    doc = build_document(meta, mapping, results, run, attestation, now, version=args.report_version)
    problems = validate_document(doc)
    if problems:
        for problem in problems:
            print(f"invalid: {problem}", file=sys.stderr)
        return 2

    args.out_dir.mkdir(parents=True, exist_ok=True)
    (args.out_dir / "evs-openacr.yaml").write_text(dump_yaml(doc))
    (args.out_dir / "evs-acr.md").write_text(render_markdown(doc, results, run))
    (args.out_dir / "evs-acr.html").write_text(render_html(doc, results, run))
    args.readout.parent.mkdir(parents=True, exist_ok=True)
    (args.out_dir / "evs-axe-results.json").write_text(
        json.dumps(build_axe_bundle(cells, run, now), indent=1) + "\n"
    )
    readout = build_readout(
        cells, results, run, now, TARGET, args.acr_url, mapping=mapping, attestation=attestation, meta=meta
    )
    args.readout.write_text(json.dumps(readout, indent=1) + "\n")

    counts = level_counts(results)
    print(
        f"evs-acr-gen: {run.cells} axe cells, {run.total_violations} violations, {len(lighthouse)} Lighthouse runs, "
        f"pa11y {'yes' if pa11y else 'no'}, {len(keyboard)} keyboard routes, {len(reflow)} reflow cells; "
        + ", ".join(f"{v} {k}" for k, v in counts.items())
    )
    print(f"wrote {args.out_dir / 'evs-openacr.yaml'}, .md, .html, evs-axe-results.json and {args.readout}")

    if args.fail_on_violations and (counts["does-not-support"] or counts["partially-supports"]):
        print("evs-acr-gen: open violations or partial rows present", file=sys.stderr)
        return 4
    if args.strict and counts["not-evaluated"]:
        print(
            f"evs-acr-gen: {counts['not-evaluated']} rows still not-evaluated (strict mode)", file=sys.stderr
        )
        return 3
    return 0


if __name__ == "__main__":
    sys.exit(main())
