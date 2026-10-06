from __future__ import annotations

import json
from pathlib import Path

import yaml

from evs_acr import cli
from evs_acr.engine import evaluate_all
from evs_acr.evidence import load_attestation, load_axe_cells, load_lighthouse, load_pa11y, load_smoke
from evs_acr.mapping import load_mapping, tag_to_criterion
from evs_acr.openacr import validate_document

from .conftest import axe_cell

REPO = Path(__file__).resolve().parents[3]
ATTESTATION = REPO / "docs" / "a11y" / "manual_attestation.yaml"


def test_mapping_counts_match_report():
    m = load_mapping()
    methods = [c.method for c in m.criteria]
    assert len(m.criteria) == 48
    assert methods.count("automated") == 19
    assert methods.count("manual") == 24
    assert methods.count("not_applicable") == 5


def test_tag_to_criterion():
    assert tag_to_criterion("wcag143") == "1.4.3"
    assert tag_to_criterion("wcag1410") == "1.4.10"
    assert tag_to_criterion("wcag2a") is None
    assert tag_to_criterion("best-practice") is None


def _evaluate(evidence_dir: Path, attestation: Path | None = None):
    mapping = load_mapping()
    cells = load_axe_cells(evidence_dir / "axe")
    return evaluate_all(
        mapping,
        cells,
        load_lighthouse(evidence_dir / "lighthouse"),
        load_pa11y(evidence_dir / "pa11y.json"),
        load_smoke(evidence_dir / "keyboard", "keyboard"),
        load_smoke(evidence_dir / "reflow", "reflow"),
        load_attestation(attestation),
    )


def test_automated_pass_without_attestation_is_not_evaluated(evidence_dir: Path):
    _run, results = _evaluate(evidence_dir, None)
    by = {r.num: r for r in results}
    # 1.1.1 has axe rules AND a required manual test: clean cells alone never yield supports
    assert by["1.1.1"].adherence == "not-evaluated"
    assert "not yet attested" in by["1.1.1"].notes
    # 2.4.2 and 3.1.1 need no manual test: clean cells are enough
    assert by["2.4.2"].adherence == "supports"
    assert by["3.1.1"].adherence == "supports"
    # manual-only criteria stay not-evaluated
    assert by["1.3.2"].adherence == "not-evaluated"
    # N/A rows carry the reason
    assert by["1.2.1"].adherence == "not-applicable"
    assert "audio" in by["1.2.1"].notes


def test_attestation_unlocks_supports(evidence_dir: Path, tmp_path: Path):
    att = tmp_path / "att.yaml"
    att.write_text(
        yaml.safe_dump(
            {
                "attestations": [
                    {
                        "criterion": "1.1.1",
                        "status": "supports",
                        "tests": ["MT-SR-01"],
                        "tester": "T. Tester",
                        "date": "2026-10-06",
                        "assistive_tech": ["nvda-firefox"],
                        "notes": "Charts expose table alternative.",
                    },
                    {
                        "criterion": "1.3.2",
                        "status": "partially-supports",
                        "tester": "T. Tester",
                        "date": "2026-10-06",
                        "notes": "Gantt reading order differs.",
                    },
                ]
            }
        )
    )
    _run, results = _evaluate(evidence_dir, att)
    by = {r.num: r for r in results}
    assert by["1.1.1"].adherence == "supports"
    assert "T. Tester" in by["1.1.1"].notes
    assert by["1.3.2"].adherence == "partially-supports"


def test_violation_blocks_supports(evidence_dir: Path, tmp_path: Path):
    bad = axe_cell(
        "/projects",
        violations=[
            {"id": "document-title", "impact": "serious", "tags": ["wcag2a", "wcag242"], "nodes": [{}]}
        ],
    )
    (evidence_dir / "axe" / "c.json").write_text(json.dumps(bad))
    minor = axe_cell(
        "/financial",
        violations=[
            {"id": "html-lang-valid", "impact": "minor", "tags": ["wcag2a", "wcag311"], "nodes": [{}]}
        ],
    )
    (evidence_dir / "axe" / "d.json").write_text(json.dumps(minor))
    _run, results = _evaluate(evidence_dir, None)
    by = {r.num: r for r in results}
    assert by["2.4.2"].adherence == "does-not-support"
    assert "document-title (axe, serious) x1" in by["2.4.2"].notes
    assert by["3.1.1"].adherence == "partially-supports"


def test_no_evidence_is_not_evaluated(tmp_path: Path):
    _run, results = _evaluate(tmp_path, None)
    assert all(r.adherence in ("not-evaluated", "not-applicable") for r in results)


def test_lighthouse_and_pa11y_feed_in(evidence_dir: Path):
    lh = evidence_dir / "lighthouse"
    lh.mkdir()
    (lh / "lhr.json").write_text(
        json.dumps(
            {
                "finalDisplayedUrl": "http://x/",
                "fetchTime": "2026-10-06T12:00:00Z",
                "categories": {"accessibility": {"score": 0.97}},
                "audits": {
                    "link-name": {"score": 0, "scoreDisplayMode": "binary"},
                    "image-alt": {"score": 1, "scoreDisplayMode": "binary"},
                },
            }
        )
    )
    (evidence_dir / "pa11y.json").write_text(
        json.dumps(
            {
                "total": 1,
                "passes": 0,
                "errors": 1,
                "results": {"http://x/": [{"code": "button-name", "type": "error", "message": "x"}]},
            }
        )
    )
    run, results = _evaluate(evidence_dir, None)
    by = {r.num: r for r in results}
    assert run.lighthouse_min_score == 0.97
    assert by["2.4.4"].adherence == "does-not-support"
    assert any(v.source == "lighthouse" for v in by["2.4.4"].violations)
    assert any(v.source == "pa11y" for v in by["4.1.2"].violations)


def test_failed_smoke_caps_at_partially(evidence_dir: Path):
    (evidence_dir / "keyboard" / "bad.json").write_text(
        json.dumps(
            {
                "route": "/admin",
                "skipLinkMovesFocusToMain": False,
                "navReached": True,
                "stepsWithoutVisibleFocus": 2,
                "popovers": [],
            }
        )
    )
    _run, results = _evaluate(evidence_dir, None)
    by = {r.num: r for r in results}
    assert by["2.4.1"].adherence == "partially-supports"
    assert "1/2 cells passed" in by["2.4.1"].notes


def test_committed_attestation_is_all_not_evaluated_or_na():
    att = load_attestation(ATTESTATION)
    assert att.attestations
    assert {a.status for a in att.attestations.values()} <= {"not-evaluated", "not-applicable"}


def test_document_validates_and_cli_writes_outputs(evidence_dir: Path, tmp_path: Path, now):
    out = tmp_path / "out"
    readout = tmp_path / "accessibility.json"
    rc = cli.main(
        [
            "--axe-dir",
            str(evidence_dir / "axe"),
            "--keyboard-dir",
            str(evidence_dir / "keyboard"),
            "--reflow-dir",
            str(evidence_dir / "reflow"),
            "--lighthouse-dir",
            str(evidence_dir / "lighthouse"),
            "--pa11y",
            str(evidence_dir / "pa11y.json"),
            "--attestation",
            str(ATTESTATION),
            "--out-dir",
            str(out),
            "--readout",
            str(readout),
            "--now",
            now.isoformat(),
        ]
    )
    assert rc == 0
    doc = yaml.safe_load((out / "evs-openacr.yaml").read_text())
    assert validate_document(doc) == []
    assert doc["report_date"] == "10/6/2026"
    assert len(doc["chapters"]["success_criteria_level_a"]["criteria"]) == 30
    assert len(doc["chapters"]["success_criteria_level_aa"]["criteria"]) == 20
    md = (out / "evs-acr.md").read_text()
    html = (out / "evs-acr.html").read_text()
    for text in (md, html, (out / "evs-openacr.yaml").read_text()):
        assert "\u2014" not in text, "em dash in output"
    assert "Not Evaluated" in html and '<th scope="col">' in html
    data = json.loads(readout.read_text())
    assert data["target"].startswith("WCAG 2.1 AA")
    assert len(data["routes"]) == 2
    assert data["routes"][1]["reduced_motion"] is True
    assert len(data["criteria"]) == 48
    assert {c["method"] for c in data["criteria"]} == {"automated", "manual", "not_applicable"}
    assert {c["chapter"] for c in data["criteria"]} == {
        "success_criteria_level_a",
        "success_criteria_level_aa",
    }
    assert all(c["evidence"] for c in data["criteria"])
    assert len(data["section508"]) == 14
    assert {r["level"] for r in data["section508"]} == {"508"}
    s = data["summary"]
    assert s["criteria_total"] == 48 and s["cells"] == 2 and s["zero_violation_cells"] == 2
    assert (
        s["supports"]
        + s["partially_supports"]
        + s["does_not_support"]
        + s["not_applicable"]
        + s["not_evaluated"]
        == 48
    )
    assert (
        s["routes_tested"] == 2
        and s["viewports"] == ["desktop-1280"]
        and s["themes"] == ["leadership", "light"]
    )
    assert s["keyboard_routes_passed"] == 1 and s["reflow_cells_passed"] == 1
    assert data["versions"]["axe"] == "4.13.0" and data["versions"]["generator"]
    assert [a["name"] for a in data["artifacts"]] == [
        "evs-openacr.yaml",
        "evs-acr.md",
        "evs-acr.html",
        "evs-axe-results.json",
    ]
    assert all(a["href"].startswith("/api/v1/accessibility/artifacts/") for a in data["artifacts"])
    assert data["as_of"]["source"] == "fixtures"
    st = data["statement"]
    assert st["version"] == "0.1.0-demo" and st["scope_routes"] == ["/", "/programs"]
    assert any("2.4.11" in d for d in st["design_rules"])
    assert any("not evaluated" in k for k in st["known_issues"])
    assert len(data["manual"]) == 10
    assert {m["status"] for m in data["manual"]} <= {"planned", "not-evaluated"}
    assert "\u2014" not in json.dumps(data), "em dash in readout"
    bundle = json.loads((out / "evs-axe-results.json").read_text())
    assert len(bundle["cells"]) == 2 and bundle["axe_version"] == "4.13.0"


def test_readout_violation_details_and_manual_status(evidence_dir: Path, tmp_path: Path, now):
    from evs_acr.engine import evaluate_all
    from evs_acr.readout import build_readout

    bad = axe_cell(
        "/projects",
        violations=[
            {
                "id": "document-title",
                "impact": "serious",
                "tags": ["wcag2a", "wcag242"],
                "nodes": [{}, {}],
                "helpUrl": "https://dequeuniversity.com/rules/axe/4.13/document-title",
                "help": "Documents must have <title> element to aid in navigation",
            }
        ],
    )
    (evidence_dir / "axe" / "c.json").write_text(json.dumps(bad))
    att = tmp_path / "att.yaml"
    att.write_text(
        yaml.safe_dump(
            {
                "assistive_technology": [{"id": "nvda-firefox", "name": "NVDA", "version": "2025.1"}],
                "attestations": [
                    {
                        "criterion": "1.1.1",
                        "status": "supports",
                        "tests": ["MT-SR-01"],
                        "tester": "T. Tester",
                        "date": "2026-10-06",
                        "assistive_tech": ["nvda-firefox"],
                    },
                    {
                        "criterion": "2.1.1",
                        "status": "does-not-support",
                        "tests": ["MT-KBD-01"],
                        "tester": "K. Key",
                    },
                    {"criterion": "1.4.10", "status": "not-evaluated", "tests": ["MT-ZOOM-02"]},
                    {"criterion": "302.1", "status": "not-evaluated", "tests": ["MT-SR-01"]},
                ],
            }
        )
    )
    mapping = load_mapping()
    attestation = load_attestation(att)
    cells = load_axe_cells(evidence_dir / "axe")
    run, results = evaluate_all(mapping, cells, [], None, [], [], attestation)
    data = build_readout(
        cells, results, run, now, "WCAG 2.1 AA", "/x", mapping=mapping, attestation=attestation
    )
    cell = next(r for r in data["routes"] if r["route"] == "/projects")
    assert cell["violations"] == 1 and cell["violation_details"][0]["nodes"] == 2
    assert cell["violation_details"][0]["help_url"].endswith("document-title")
    assert data["summary"]["zero_violation_cells"] == 2 and data["summary"]["cells"] == 3
    row = next(c for c in data["criteria"] if c["criterion"] == "2.4.2")
    assert row["status"] == "does-not-support" and row["open_violations"] == 1
    assert any(e["label"] == "axe rule document-title" for e in row["evidence"])
    by = {m["id"]: m for m in data["manual"]}
    assert by["nvda-firefox"]["status"] == "passed" and by["nvda-firefox"]["version"] == "2025.1"
    assert by["nvda-firefox"]["tester"] == "T. Tester" and by["nvda-firefox"]["date"] == "2026-10-06"
    assert by["keyboard-only"]["status"] == "failed"
    assert by["zoom-400"]["status"] == "planned"
    assert by["touch"]["status"] == "not-evaluated"
    assert any("do not support" in k for k in data["statement"]["known_issues"])


def test_strict_mode_fails_while_rows_not_evaluated(evidence_dir: Path, tmp_path: Path, now):
    rc = cli.main(
        [
            "--axe-dir",
            str(evidence_dir / "axe"),
            "--attestation",
            str(ATTESTATION),
            "--out-dir",
            str(tmp_path / "o"),
            "--readout",
            str(tmp_path / "r.json"),
            "--now",
            now.isoformat(),
            "--strict",
        ]
    )
    assert rc == 3


def test_build_document_unknown_status_rejected(tmp_path: Path):
    att = tmp_path / "att.yaml"
    att.write_text(yaml.safe_dump({"attestations": [{"criterion": "1.1.1", "status": "passes"}]}))
    try:
        load_attestation(att)
    except ValueError as e:
        assert "unknown status" in str(e)
    else:
        raise AssertionError("expected ValueError")
