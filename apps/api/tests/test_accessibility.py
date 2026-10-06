from fastapi.testclient import TestClient

from evs.main import create_app
from evs.routers.accessibility import ARTIFACTS
from evs.settings import get_settings

client = TestClient(create_app())


def test_readout_matches_schema_and_carries_summary():
    body = client.get("/api/v1/accessibility/readout").json()
    s = body["summary"]
    assert s["criteria_total"] == len(body["criteria"]) == 48
    buckets = ("supports", "partially_supports", "does_not_support", "not_applicable", "not_evaluated")
    assert sum(s[k] for k in buckets) == 48
    assert s["zero_violation_cells"] <= s["cells"] == len(body["routes"])
    assert body["as_of"]["source"] == "fixtures"
    assert {a["name"] for a in body["artifacts"]} == set(ARTIFACTS)
    assert body["statement"]["version"] and body["statement"]["known_issues"]
    allowed = {"planned", "passed", "failed", "partial", "not-evaluated"}
    assert body["manual"] and all(m["status"] in allowed for m in body["manual"])


def test_artifacts_are_served_with_content_types():
    docs = get_settings().a11y_docs_dir
    for name, media in ARTIFACTS.items():
        if not (docs / name).is_file():
            continue
        r = client.get(f"/api/v1/accessibility/artifacts/{name}")
        assert r.status_code == 200, name
        assert r.headers["content-type"].startswith(media.split(";")[0])
        assert name in r.headers["content-disposition"]
        assert len(r.content) > 0


def test_artifacts_allow_list_blocks_everything_else():
    assert client.get("/api/v1/accessibility/artifacts/manual_attestation.yaml").status_code == 404
    assert client.get("/api/v1/accessibility/artifacts/..%2F..%2Fpyproject.toml").status_code == 404
    assert client.get("/api/v1/accessibility/artifacts/README.md").status_code == 404


def test_openapi_lists_artifact_endpoint():
    spec = client.get("/openapi.json").json()
    op = spec["paths"]["/api/v1/accessibility/artifacts/{name}"]["get"]
    assert "application/yaml" in op["responses"]["200"]["content"]
    assert "404" in op["responses"]
