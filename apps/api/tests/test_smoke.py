"""Smoke tests in fixtures mode (no database needed). `client` comes from conftest."""


def test_health(client):
    r = client.get("/api/v1/health")
    assert r.status_code == 200 and r.json()["status"] == "ok"


def test_programs_and_projects_fixtures(client):
    assert client.get("/api/v1/programs").json()["page"]["total"] >= 1
    projects = client.get("/api/v1/projects").json()
    first = projects["items"][0]["p2_project_no"]
    assert client.get(f"/api/v1/projects/{first}").status_code == 200
    assert client.get("/api/v1/projects/NOPE").status_code == 404


def test_public_endpoints_need_no_auth(client):
    locks = client.get("/api/v1/public/locks").json()
    assert {"operating", "delayed", "closed", "stale"} <= set(locks["counts"])
    assert client.get("/api/v1/public/srp/coverage").json()["snapshots"]


def test_openapi_has_apex_traceability(client):
    spec = client.get("/openapi.json").json()
    assert spec["openapi"].startswith("3.1")
    assert spec["paths"]["/api/v1/programs"]["get"]["x-apex-page"] == "21"


def test_fixtures_mode_is_reported(client):
    assert client.app.state.repos.mode == "fixtures"
