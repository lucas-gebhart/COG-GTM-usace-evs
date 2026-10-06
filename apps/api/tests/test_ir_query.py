"""Interactive Report style filters, sort, pagination and CSV in fixtures mode."""

import csv
import io

import pytest


def test_filter_sort_csv_projects(client):
    r = client.get("/api/v1/projects", params={"district": "LRL", "sort": "-funded_amount", "format": "csv"})
    assert r.status_code == 200
    assert r.headers["content-type"].startswith("text/csv")
    rows = list(csv.DictReader(io.StringIO(r.text)))
    assert rows and all(row["district"] == "LRL" for row in rows)
    funded = [float(row["funded_amount"]) for row in rows]
    assert funded == sorted(funded, reverse=True)


def test_filter_operators_and_pagination(client):
    body = client.get(
        "/api/v1/projects", params={"filter": "pct_complete:gte:50", "limit": 5, "offset": 5}
    ).json()
    assert body["page"]["limit"] == 5 and body["page"]["offset"] == 5
    assert all(p["pct_complete"] >= 50 for p in body["items"])
    like = client.get("/api/v1/projects", params=[("filter", "name:like:navigation"), ("limit", "3")]).json()
    assert like["items"] and all("navigation" in p["name"].lower() for p in like["items"])
    multi = client.get("/api/v1/projects", params=[("filter", "district:in:LRL,LRN")]).json()
    assert {p["district"] for p in multi["items"]} <= {"LRL", "LRN"}
    search = client.get("/api/v1/projects", params={"q": "LRL"}).json()
    assert search["page"]["total"] >= 1


def test_bad_column_or_op_is_422(client):
    assert client.get("/api/v1/projects", params={"sort": "drop_table"}).status_code == 422
    assert client.get("/api/v1/projects", params={"filter": "name:between:x"}).status_code == 422


@pytest.mark.parametrize(
    ("path", "sort_key"),
    [
        ("/api/v1/programs", "funded_amount"),
        ("/api/v1/workforce/labor", "labor_cost"),
        ("/api/v1/facilities/condition", "ci"),
    ],
)
def test_other_lists_sort_and_csv(client, path, sort_key):
    body = client.get(path, params={"sort": f"-{sort_key}", "limit": 10}).json()
    rows = body.get("items") or body.get("rows")
    values = [r[sort_key] for r in rows]
    assert values == sorted(values, reverse=True)
    assert body["as_of"]["source"] == "synthetic"
    r = client.get(path, params={"format": "csv"})
    assert r.status_code == 200 and r.text.splitlines()[0].split(",")[0]


def test_aggregates(client):
    kpis = client.get("/api/v1/enterprise/kpis").json()
    assert {t["id"] for t in kpis["tiles"]} >= {
        "programs",
        "projects",
        "slipped_milestones",
        "locks_operating",
    }
    var = client.get("/api/v1/financial/variance-by-program").json()
    assert var["rows"] and {"variance_amount", "plan_to_date"} <= set(var["rows"][0])
    slipped = client.get("/api/v1/schedule/milestones", params={"status": "slipped"}).json()
    assert slipped["items"] and all(m["status"] == "slipped" for m in slipped["items"])
    assert slipped["items"][0]["slip_days"] >= slipped["items"][-1]["slip_days"]
    dist = client.get("/api/v1/facilities/ci-distribution").json()
    assert sum(b["count"] for b in dist["buckets"]) == 160 and dist["by_installation"]
