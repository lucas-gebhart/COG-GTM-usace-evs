"""Write endpoints through the PL/SQL ports, and role enforcement (fixtures mode).

Auth is disabled here, so the principal is the demo admin; `test_auth_jwt.py` covers real tokens
and the 401 / 403 matrix.
"""


def _first_project(client):
    return client.get("/api/v1/projects", params={"limit": 1}).json()["items"][0]


def test_project_status_update_writes_history(client):
    p = _first_project(client)
    no = p["p2_project_no"]
    bad = client.put(f"/api/v1/projects/{no}/status", json={"pct_complete": 60})
    assert bad.status_code == 422 and bad.json()["detail"][0]["item"] == "P24_TARGET_COMPLETE"
    ok = client.put(
        f"/api/v1/projects/{no}/status",
        json={
            "pct_complete": 60,
            "current_finish": "2029-01-31",
            "status_scale": "B",
            "note": "re-baselined",
        },
    )
    assert ok.status_code == 200, ok.text
    body = ok.json()
    assert body["project"]["pct_complete"] == 60 and body["kanban"]["column_id"] == 4
    attrs = {e["attribute"] for e in body["history"]}
    assert {"PCT_COMPLETE", "TARGET_COMPLETE", "STATUS_SCALE", "NOTE"} <= attrs
    assert client.get(f"/api/v1/projects/{no}").json()["pct_complete"] == 60
    hist = client.get(f"/api/v1/projects/{no}/history").json()
    assert hist["events"] and hist["events"][0]["changed_by"] == "dev"


def test_kanban_move_and_archive(client):
    no = _first_project(client)["p2_project_no"]
    moved = client.post(f"/api/v1/projects/{no}/kanban/move", params={"column_id": 2}).json()
    assert moved["project"]["pct_complete"] == 30 and moved["kanban"]["column_id"] == 2
    arch = client.post(f"/api/v1/projects/{no}/archive", json={"archived": True, "reason": "demo"})
    assert arch.status_code == 200 and arch.json()["archived"] is True
    assert client.post(f"/api/v1/projects/{no}/archive", json={"archived": True}).status_code == 409
    locked = client.put(f"/api/v1/projects/{no}/status", json={"pct_complete": 40})
    assert locked.status_code == 422 and "Archived" in locked.json()["detail"][0]["message"]
    assert client.post(f"/api/v1/projects/{no}/archive", json={"archived": False}).json()["archived"] is False
    assert client.post("/api/v1/projects/NOPE/kanban/move", params={"column_id": 1}).status_code == 404


def test_milestone_update(client):
    p = _first_project(client)
    no, code = p["p2_project_no"], p["milestones"][-1]["code"]
    bad = client.put(f"/api/v1/projects/{no}/milestones/{code}", json={"status": "complete"})
    assert bad.status_code == 422
    ok = client.put(
        f"/api/v1/projects/{no}/milestones/{code}", json={"actual_date": "2026-01-15", "owner": "M. Chen"}
    )
    assert ok.status_code == 200 and ok.json()["status"] == "complete"
    assert client.put(f"/api/v1/projects/{no}/milestones/NOPE", json={"owner": "x"}).status_code == 404


def test_admin_thresholds_round_trip(client):
    before = client.get("/api/v1/admin/thresholds").json()
    assert before["source"] == "settings"
    new = {**{k: before[k] for k in ("stale_after_minutes", "delay_yellow_minutes", "queue_yellow_vessels")}}
    new["delay_red_minutes"] = before["delay_yellow_minutes"] + 90
    after = client.put("/api/v1/admin/thresholds", json=new).json()
    assert after["delay_red_minutes"] == new["delay_red_minutes"] and after["updated_by"] == "dev"
    assert client.get("/api/v1/admin/thresholds").json()["delay_red_minutes"] == new["delay_red_minutes"]
    bad = {**new, "delay_red_minutes": new["delay_yellow_minutes"]}
    assert client.put("/api/v1/admin/thresholds", json=bad).status_code == 422


def test_openapi_tags_processes_and_schemes(client):
    spec = client.get("/openapi.json").json()
    put = spec["paths"]["/api/v1/projects/{p2_project_no}/status"]["put"]
    assert put["x-apex-page"] == "24" and put["x-apex-process"] == "Process form Project"
    assert put["x-apex-authorization"] == "Contributor"
    assert spec["paths"]["/api/v1/admin/thresholds"]["put"]["x-apex-authorization"] == "Administration Rights"
    assert spec["paths"]["/api/v1/public/locks"]["get"]["x-apex-authorization"] == "none"
    assert "text/csv" in spec["paths"]["/api/v1/projects"]["get"]["responses"]["200"]["content"]
