import { HttpResponse, http, type HttpHandler } from "msw";
import { fixtures, syntheticAsOf, thresholds } from "./fixtures";
import type { Schemas } from "../hooks/useApi";
import { toCsv } from "../lib/csv";
import openacrYaml from "../../../../docs/a11y/evs-openacr.yaml?raw";
import acrMarkdown from "../../../../docs/a11y/evs-acr.md?raw";
import acrHtml from "../../../../docs/a11y/evs-acr.html?raw";
import axeBundle from "../../../../docs/a11y/evs-axe-results.json";

/** Same allow-list and media types as apps/api/evs/routers/accessibility.py. */
const ARTIFACTS: Record<string, { type: string; body: string }> = {
  "evs-openacr.yaml": { type: "application/yaml", body: openacrYaml },
  "evs-acr.md": { type: "text/markdown; charset=utf-8", body: acrMarkdown },
  "evs-acr.html": { type: "text/html; charset=utf-8", body: acrHtml },
  "evs-axe-results.json": { type: "application/json", body: JSON.stringify(axeBundle) },
};

const BASE = "*/api/v1";
const ROLE_HEADER = "x-evs-demo-role";

type Project = Schemas["Project"];
type Milestone = Schemas["Milestone"];
type ProjectMilestone = Schemas["ProjectMilestone"];
type HistoryEvent = Schemas["ProjectHistoryEvent"];

// Mutable copies so the write handlers behave like the API in fixtures mode; reset between tests.
let projectsState: Project[] = structuredClone(fixtures.projects);
let historyState: Record<string, HistoryEvent[]> = {};
let historyId = 1;
let thresholdsState: Schemas["Thresholds"] = { ...thresholds };

export function resetMockState(): void {
  projectsState = structuredClone(fixtures.projects);
  historyState = {};
  historyId = 1;
  thresholdsState = { ...thresholds };
}

function paginate<T>(items: T[], url: URL) {
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 50), 500);
  const offset = Number(url.searchParams.get("offset") ?? 0);
  return { items: items.slice(offset, offset + limit), page: { total: items.length, limit, offset } };
}

/** Interactive Report parameters as in evs.repositories.query: named eq filters, `q`, `filter=col:op:value`, `sort`. */
function applyIr<T extends object>(rows: T[], url: URL, named: readonly string[]): T[] {
  let out = rows;
  for (const key of named) {
    const v = url.searchParams.get(key);
    if (v) out = out.filter((r) => String((r as Record<string, unknown>)[key]) === v);
  }
  for (const f of url.searchParams.getAll("filter")) {
    const [col, op, ...rest] = f.split(":");
    const value = rest.join(":");
    out = out.filter((r) => {
      const cell = (r as Record<string, unknown>)[col];
      const num = Number(value);
      switch (op) {
        case "eq": return String(cell) === value;
        case "ne": return String(cell) !== value;
        case "gt": return Number(cell) > num;
        case "gte": return Number(cell) >= num;
        case "lt": return Number(cell) < num;
        case "lte": return Number(cell) <= num;
        case "like": return String(cell).toLowerCase().includes(value.toLowerCase());
        case "in": return value.split(",").includes(String(cell));
        default: return true;
      }
    });
  }
  const q = url.searchParams.get("q")?.toLowerCase();
  if (q) out = out.filter((r) => Object.values(r).some((v) => typeof v === "string" && v.toLowerCase().includes(q)));
  const sort = url.searchParams.get("sort");
  if (sort) {
    const keys = sort.split(",").map((s) => s.trim()).filter(Boolean).map((s) => ({ col: s.replace(/^[-+]/, ""), desc: s.startsWith("-") }));
    out = [...out].sort((a, b) => {
      for (const { col, desc } of keys) {
        const av = (a as Record<string, unknown>)[col];
        const bv = (b as Record<string, unknown>)[col];
        if (av === bv) continue;
        if (av === null || av === undefined) return 1;
        if (bv === null || bv === undefined) return -1;
        const cmp = typeof av === "number" && typeof bv === "number" ? av - bv : String(av).localeCompare(String(bv));
        return desc ? -cmp : cmp;
      }
      return 0;
    });
  }
  return out;
}

function csvResponse<T extends object>(rows: T[], columns: readonly string[], filename: string) {
  const csv = toCsv(rows, columns.map((c) => ({ key: c, header: c })));
  return new HttpResponse(csv, { headers: { "Content-Type": "text/csv; charset=utf-8", "Content-Disposition": `attachment; filename="${filename}"` } });
}

function listResponse<T extends object>(rows: T[], url: URL, columns: readonly string[], filename: string, extra: Record<string, unknown> = {}) {
  if (url.searchParams.get("format") === "csv") return csvResponse(rows.slice(0, 500), columns, filename);
  return HttpResponse.json({ ...extra, ...paginate(rows, url), as_of: syntheticAsOf() });
}

function forbidden(request: Request) {
  if (request.headers.get(ROLE_HEADER) === "evs_viewer") {
    return HttpResponse.json({ detail: "Role evs_pm required" }, { status: 403 });
  }
  return null;
}

/** The admin router requires evs_admin on reads and writes (APEX "Administration Rights"). */
function adminOnly(request: Request) {
  const role = request.headers.get(ROLE_HEADER);
  if (role && role !== "evs_admin") {
    return HttpResponse.json({ detail: "Requires role evs_admin" }, { status: 403 });
  }
  return null;
}

function daysBetween(a: string | null | undefined, b: string | null | undefined): number | null {
  if (!a || !b) return null;
  return Math.round((new Date(b).getTime() - new Date(a).getTime()) / 86_400_000);
}

export function kanbanColumn(pct: number) {
  const cid = pct <= 20 ? 1 : pct < 40 ? 2 : pct < 50 ? 3 : pct < 80 ? 4 : 5;
  const headings: Record<number, [string, string]> = { 1: ["Identified", "10 to 20"], 2: ["Architecting", "30"], 3: ["Specification Approved", "40"], 4: ["In Development", "50 to 70"], 5: ["Merging and Verification", "80 to 100"] };
  return { column_id: cid, heading: headings[cid][0], pct_complete_range: headings[cid][1] };
}

function scheduleHealth(current: string | null, baseline: string | null): Project["schedule_health"] {
  const slip = daysBetween(baseline, current) ?? 0;
  return slip > 60 ? "late" : slip > 0 ? "at_risk" : "on_track";
}

function fmt(v: unknown): string | null {
  if (v === null || v === undefined) return null;
  return String(v);
}

function record(p2: string, attribute: string, oldValue: unknown, newValue: unknown) {
  (historyState[p2] ??= []).push({ id: historyId++, p2_project_no: p2, attribute, change_type: "UPDATE", old_value: fmt(oldValue), new_value: fmt(newValue), changed_on: new Date().toISOString(), changed_by: "dev" });
}

function statusResult(project: Project): Schemas["ProjectStatusResult"] {
  return { project, kanban: kanbanColumn(project.pct_complete), archived: false, history: historyState[project.p2_project_no] ?? [], as_of: syntheticAsOf() };
}

function milestoneRows(): ProjectMilestone[] {
  return projectsState.flatMap((p) =>
    p.milestones.map((m) => ({ ...m, p2_project_no: p.p2_project_no, project_name: p.name, program_code: p.program_code, district: p.district, slip_days: daysBetween(m.baseline_date, m.current_date) })),
  );
}

const PROGRAM_COLUMNS = ["program_code", "name", "business_line", "division", "funded_amount", "obligated_amount", "expended_amount", "variance_pct", "project_count", "schedule_health"];
const PROJECT_COLUMNS = ["p2_project_no", "name", "program_code", "district", "division", "business_line", "phase", "pdt_lead", "baseline_finish", "current_finish", "pct_complete", "funded_amount", "obligated_amount", "expended_amount", "schedule_health"];
const MILESTONE_COLUMNS = ["p2_project_no", "project_name", "program_code", "district", "code", "name", "baseline_date", "current_date", "actual_date", "status", "slip_days"];
const LABOR_COLUMNS = ["district", "pay_period", "hours_plan", "hours_regular", "hours_overtime", "labor_cost"];
const FACILITY_COLUMNS = ["building_id", "installation", "district", "uniformat_section", "component_type", "ci", "bci", "deficiency_cost", "work_plan_year"];

/** Fixtures carry one evaluation per lock; the mock detail adds three evaluations over the last 24 hours ending at the fixture status. */
function mockHistory(row: (typeof fixtures.locks.items)[number]) {
  const end = new Date(row.as_of.source_as_of ?? Date.now()).getTime();
  const point = (hoursAgo: number, status: string, reason: string) => ({
    evaluated_at: new Date(end - hoursAgo * 3600000).toISOString(),
    status,
    status_reason: reason,
    rule_no: null,
    source: row.as_of.source,
    freshness: row.as_of.freshness,
  });
  return [point(24, "operating", "Lockages within the last 4 hours and no stoppage"), point(12, row.status, row.status_reason), point(0, row.status, row.status_reason)];
}

/** Same filtering rules as apps/api/evs/routers so mock mode behaves like the API. */
export const handlers: HttpHandler[] = [
  http.get(`${BASE}/health`, () => HttpResponse.json({ status: "ok", version: "mock", env: "mock", feed_source: "fixtures" })),

  http.get(`${BASE}/enterprise/kpis`, () => {
    const as_of = syntheticAsOf();
    const funded = projectsState.reduce((s, p) => s + p.funded_amount, 0);
    const obligated = projectsState.reduce((s, p) => s + p.obligated_amount, 0);
    const late = projectsState.filter((p) => p.schedule_health === "late").length;
    const atRisk = projectsState.filter((p) => p.schedule_health === "at_risk").length;
    const slipped = projectsState.reduce((s, p) => s + p.milestones.filter((m) => m.status === "slipped").length, 0);
    const components = fixtures.facilities.rows.length || 1;
    const poor = fixtures.facilities.rows.filter((r) => r.ci < 40).length;
    const counts = fixtures.locks.counts;
    const tiles: Schemas["KpiTile"][] = [
      { id: "programs", label: "Programs", value: fixtures.programs.length, unit: "", delta: null, delta_label: null, as_of },
      { id: "projects", label: "Active projects", value: projectsState.length, unit: "", delta: null, delta_label: null, as_of },
      { id: "obligation_rate", label: "Obligated vs funded", value: funded ? Math.round((1000 * obligated) / funded) / 10 : 0, unit: "%", delta: null, delta_label: `$${Math.round(obligated / 1e6)}M of $${Math.round(funded / 1e6)}M`, as_of },
      { id: "late_projects", label: "Projects late or at risk", value: late + atRisk, unit: "", delta: late, delta_label: `${late} late`, as_of },
      { id: "slipped_milestones", label: "Slipped milestones", value: slipped, unit: "", delta: null, delta_label: null, as_of },
      { id: "facilities_poor", label: "Components in poor condition", value: Math.round((1000 * poor) / components) / 10, unit: "%", delta: null, delta_label: `${poor} of ${components} BUILDER components under CI 40`, as_of: fixtures.facilities.as_of },
      { id: "locks_operating", label: "Locks operating", value: counts.operating, unit: "", delta: counts.closed, delta_label: `${counts.delayed} delayed, ${counts.closed} closed`, as_of: fixtures.locks.as_of },
    ];
    return HttpResponse.json({ tiles, as_of } satisfies Schemas["KpiList"]);
  }),

  http.get(`${BASE}/programs`, ({ request }) => {
    const url = new URL(request.url);
    return listResponse(applyIr(fixtures.programs, url, ["division", "business_line", "schedule_health"]), url, PROGRAM_COLUMNS, "programs.csv");
  }),

  http.get(`${BASE}/projects`, ({ request }) => {
    const url = new URL(request.url);
    let rows = applyIr(projectsState, url, ["program_code", "district", "division", "business_line", "phase", "schedule_health"]);
    const minPct = url.searchParams.get("min_pct_complete");
    if (minPct) rows = rows.filter((r) => r.pct_complete >= Number(minPct));
    return listResponse(rows, url, PROJECT_COLUMNS, "projects.csv");
  }),

  http.get(`${BASE}/projects/:p2/history`, ({ params }) => {
    const p2 = String(params.p2);
    if (!projectsState.some((r) => r.p2_project_no === p2)) return HttpResponse.json({ detail: `Project ${p2} not found` }, { status: 404 });
    return HttpResponse.json({ p2_project_no: p2, events: historyState[p2] ?? [], as_of: syntheticAsOf() } satisfies Schemas["ProjectHistoryList"]);
  }),

  http.get(`${BASE}/projects/:p2`, ({ params }) => {
    const row = projectsState.find((r) => r.p2_project_no === params.p2);
    return row ? HttpResponse.json(row) : HttpResponse.json({ detail: `Project ${String(params.p2)} not found` }, { status: 404 });
  }),

  // APEX page 24 "Process form Project": validations return 422 with item names, like evs.routers._common.apex_validation_error.
  http.put(`${BASE}/projects/:p2/status`, async ({ params, request }) => {
    const denied = forbidden(request);
    if (denied) return denied;
    const row = projectsState.find((r) => r.p2_project_no === params.p2);
    if (!row) return HttpResponse.json({ detail: `Project ${String(params.p2)} not found` }, { status: 404 });
    const body = (await request.json()) as Schemas["ProjectStatusUpdate"];
    const errors: { item: string; message: string }[] = [];
    const pct = Number(body.pct_complete);
    if (!Number.isFinite(pct) || pct < 0 || pct > 100 || pct % 10 !== 0) {
      errors.push({ item: "P24_PCT_COMPLETE", message: "Percent complete must be a multiple of 10 between 0 and 100 (sp_projects_pct_complete_ck)." });
    }
    if (pct >= 50 && !body.current_finish) errors.push({ item: "P24_TARGET_COMPLETE", message: "Must provide Target Complete when 50% complete or higher." });
    if (errors.length) return HttpResponse.json({ detail: errors }, { status: 422 });
    if (pct !== row.pct_complete) {
      record(row.p2_project_no, "PCT_COMPLETE", row.pct_complete, pct);
      row.pct_complete = pct;
    }
    if (body.phase && body.phase !== row.phase) {
      record(row.p2_project_no, "STATUS", row.phase, body.phase);
      row.phase = body.phase;
    }
    if (body.current_finish && body.current_finish !== row.current_finish) {
      record(row.p2_project_no, "TARGET_COMPLETE", row.current_finish, body.current_finish);
      row.current_finish = body.current_finish;
      row.schedule_health = scheduleHealth(row.current_finish, row.baseline_finish);
    }
    if (body.note) record(row.p2_project_no, "NOTE", null, body.note);
    return HttpResponse.json(statusResult(row));
  }),

  // APEX page 4 "Drop Item": pct_complete = decode(column, 1,20, 2,30, 3,40, 4,50, 5,80).
  http.post(`${BASE}/projects/:p2/kanban/move`, ({ params, request }) => {
    const denied = forbidden(request);
    if (denied) return denied;
    const row = projectsState.find((r) => r.p2_project_no === params.p2);
    if (!row) return HttpResponse.json({ detail: `Project ${String(params.p2)} not found` }, { status: 404 });
    const column = Number(new URL(request.url).searchParams.get("column_id"));
    const drop: Record<number, number> = { 1: 20, 2: 30, 3: 40, 4: 50, 5: 80 };
    if (!drop[column]) return HttpResponse.json({ detail: [{ loc: ["query", "column_id"], msg: "Input should be between 1 and 5" }] }, { status: 422 });
    record(row.p2_project_no, "PCT_COMPLETE", row.pct_complete, drop[column]);
    row.pct_complete = drop[column];
    return HttpResponse.json(statusResult(row));
  }),

  // APEX page 508 Milestone form.
  http.put(`${BASE}/projects/:p2/milestones/:code`, async ({ params, request }) => {
    const denied = forbidden(request);
    if (denied) return denied;
    const row = projectsState.find((r) => r.p2_project_no === params.p2);
    const ms = row?.milestones.find((m) => m.code === params.code);
    if (!row || !ms) return HttpResponse.json({ detail: `Milestone ${String(params.code)} not found` }, { status: 404 });
    const body = (await request.json()) as Schemas["MilestoneUpdate"];
    if (body.current_date !== undefined) ms.current_date = body.current_date;
    if (body.actual_date !== undefined) ms.actual_date = body.actual_date;
    const slip = daysBetween(ms.baseline_date, ms.current_date) ?? 0;
    ms.status = ms.actual_date ? "complete" : slip > 0 ? "slipped" : "scheduled";
    return HttpResponse.json(ms satisfies Milestone);
  }),

  http.get(`${BASE}/schedule/milestones`, ({ request }) => {
    const url = new URL(request.url);
    return listResponse(applyIr(milestoneRows(), url, ["status", "district", "program_code", "p2_project_no"]), url, MILESTONE_COLUMNS, "milestones.csv");
  }),

  http.get(`${BASE}/financial/summary`, () => HttpResponse.json(fixtures.financialSummary)),

  http.get(`${BASE}/financial/variance-by-program`, ({ request }) => {
    const fy = Number(new URL(request.url).searchParams.get("fiscal_year") ?? fixtures.financialSummary.fiscal_year);
    const curve = fixtures.financialSummary.execution_curve;
    const planTotal = Math.max(...curve.map((r) => r.plan_cumulative), 0);
    const pace = curve.length && planTotal ? curve[curve.length - 1].plan_cumulative / planTotal : 1;
    const rows: Schemas["ProgramVariance"][] = fixtures.programs
      .map((p) => {
        const plan = Math.round(p.funded_amount * pace * 100) / 100;
        const variance = Math.round((p.obligated_amount - plan) * 100) / 100;
        return { program_code: p.program_code, name: p.name, business_line: p.business_line, division: p.division, funded_amount: p.funded_amount, obligated_amount: p.obligated_amount, plan_to_date: plan, variance_amount: variance, variance_pct: plan ? Math.round((1000 * variance) / plan) / 10 : 0 };
      })
      .sort((a, b) => a.variance_pct - b.variance_pct);
    return HttpResponse.json({ fiscal_year: fy, rows, as_of: syntheticAsOf() } satisfies Schemas["VarianceByProgram"]);
  }),

  http.get(`${BASE}/workforce/labor`, ({ request }) => {
    const url = new URL(request.url);
    const rows = applyIr(fixtures.laborSummary.rows, url, ["district", "pay_period"]);
    if (url.searchParams.get("format") === "csv") return csvResponse(rows, LABOR_COLUMNS, "labor.csv");
    const limit = Math.min(Number(url.searchParams.get("limit") ?? 500), 500);
    const offset = Number(url.searchParams.get("offset") ?? 0);
    return HttpResponse.json({ fiscal_year: fixtures.laborSummary.fiscal_year, rows: rows.slice(offset, offset + limit), page: { total: rows.length, limit, offset }, as_of: fixtures.laborSummary.as_of });
  }),

  http.get(`${BASE}/facilities/condition`, ({ request }) => {
    const url = new URL(request.url);
    let rows = applyIr(fixtures.facilities.rows, url, ["district", "installation", "component_type"]);
    const maxCi = url.searchParams.get("max_ci");
    if (maxCi) rows = rows.filter((r) => r.ci <= Number(maxCi));
    if (url.searchParams.get("format") === "csv") return csvResponse(rows, FACILITY_COLUMNS, "facilities.csv");
    const limit = Math.min(Number(url.searchParams.get("limit") ?? 500), 500);
    const offset = Number(url.searchParams.get("offset") ?? 0);
    return HttpResponse.json({ rows: rows.slice(offset, offset + limit), page: { total: rows.length, limit, offset }, as_of: fixtures.facilities.as_of });
  }),

  http.get(`${BASE}/facilities/ci-distribution`, () => {
    const rows = fixtures.facilities.rows;
    const bands = [
      { label: "Poor (CI 0 to 39)", ci_min: 0, ci_max: 39.99, band: "poor" as const },
      { label: "Fair (CI 40 to 69)", ci_min: 40, ci_max: 69.99, band: "fair" as const },
      { label: "Good (CI 70 to 100)", ci_min: 70, ci_max: 100, band: "good" as const },
    ];
    const buckets: Schemas["CiBucket"][] = bands.map((b) => {
      const inBand = rows.filter((r) => r.ci >= b.ci_min && r.ci <= b.ci_max);
      return { ...b, count: inBand.length, deficiency_cost: inBand.reduce((s, r) => s + r.deficiency_cost, 0) };
    });
    const byInst = new Map<string, Schemas["CiByInstallation"] & { sum: number }>();
    for (const r of rows) {
      const cur = byInst.get(r.installation) ?? { installation: r.installation, district: r.district, component_count: 0, avg_ci: 0, min_ci: 100, deficiency_cost: 0, sum: 0 };
      cur.component_count += 1;
      cur.sum += r.ci;
      cur.min_ci = Math.min(cur.min_ci, r.ci);
      cur.deficiency_cost += r.deficiency_cost;
      byInst.set(r.installation, cur);
    }
    const by_installation = [...byInst.values()].map(({ sum, ...rest }) => ({ ...rest, avg_ci: Math.round((10 * sum) / rest.component_count) / 10 })).sort((a, b) => a.avg_ci - b.avg_ci);
    return HttpResponse.json({ buckets, by_installation, as_of: fixtures.facilities.as_of } satisfies Schemas["CiDistribution"]);
  }),

  http.get(`${BASE}/public/locks`, ({ request }) => {
    const river = new URL(request.url).searchParams.get("river_code");
    const data = river ? { ...fixtures.locks, items: fixtures.locks.items.filter((i) => i.river_code === river) } : fixtures.locks;
    return HttpResponse.json(data);
  }),

  // Mock stream: a `locks` event on connect and every 8 s with a fresh source_as_of so the as-of live region
  // changes, plus a `lock` event that flips the first delayed lock between delayed and operating.
  http.get(`${BASE}/public/locks/stream/events`, () => {
    const encoder = new TextEncoder();
    let tick = 0;
    const asOfNow = () => ({ ...fixtures.locks.as_of, source_as_of: new Date().toISOString(), fetched_at: new Date().toISOString() });
    const locksEvent = () => `event: locks\nid: ${tick}\ndata: ${JSON.stringify({ counts: fixtures.locks.counts, as_of: asOfNow(), changed: [] })}\n\n`;
    const lockEvent = () => {
      const row = fixtures.locks.items.find((i) => i.status === "delayed") ?? fixtures.locks.items[0];
      const flipped = tick % 2 === 0 ? row : { ...row, status: "operating", status_reason: "Mock stream: delay cleared", avg_delay_4h_min: 0, as_of: asOfNow() };
      return `event: lock\nid: ${tick}-lock\ndata: ${JSON.stringify({ id: row.lock_id, ...flipped })}\n\n`;
    };
    const stream = new ReadableStream({
      start(controller) {
        controller.enqueue(encoder.encode(locksEvent()));
        const t = setInterval(() => {
          tick += 1;
          try {
            controller.enqueue(encoder.encode(locksEvent()));
            controller.enqueue(encoder.encode(lockEvent()));
          } catch {
            clearInterval(t);
          }
        }, 8000);
        // @ts-expect-error timer kept for cancel
        controller.timer = t;
      },
      cancel() {
        // @ts-expect-error see start
        clearInterval(this.timer);
      },
    });
    return new HttpResponse(stream, { headers: { "Content-Type": "text/event-stream", "Cache-Control": "no-cache", Connection: "keep-alive" } });
  }),

  http.get(`${BASE}/public/locks/:lockId`, ({ params }) => {
    const row = fixtures.locks.items.find((i) => i.lock_id === params.lockId);
    if (!row) return HttpResponse.json({ detail: `Lock ${String(params.lockId)} not found` }, { status: 404 });
    return HttpResponse.json({ ...row, history: mockHistory(row), ntni_notices: [], queue: [], stoppages: [], recent_lockages: [], gauges: [], status_inputs: {} });
  }),

  http.get(`${BASE}/public/srp/coverage`, () => HttpResponse.json(fixtures.srp)),
  http.get(`${BASE}/accessibility/readout`, () => HttpResponse.json(fixtures.accessibility)),
  http.get(`${BASE}/accessibility/artifacts/:name`, ({ params }) => {
    const artefact = ARTIFACTS[String(params.name)];
    if (!artefact) return HttpResponse.json({ detail: `Unknown artefact; allowed: ${Object.keys(ARTIFACTS).join(", ")}` }, { status: 404 });
    return new HttpResponse(artefact.body, {
      headers: { "Content-Type": artefact.type, "Content-Disposition": `attachment; filename="${String(params.name)}"` },
    });
  }),
  http.get(`${BASE}/admin/feeds`, ({ request }) => adminOnly(request) ?? HttpResponse.json({ feeds: fixtures.feeds, generated_at: new Date().toISOString() })),
  http.get(`${BASE}/admin/thresholds`, ({ request }) => adminOnly(request) ?? HttpResponse.json(thresholdsState)),
  http.put(`${BASE}/admin/thresholds`, async ({ request }) => {
    const denied = adminOnly(request);
    if (denied) return denied;
    const body = (await request.json()) as Schemas["ThresholdUpdate"];
    if (body.delay_red_minutes <= body.delay_yellow_minutes) {
      return HttpResponse.json({ detail: [{ item: "delay_red_minutes", message: "Red delay must exceed yellow delay." }] }, { status: 422 });
    }
    thresholdsState = {
      ...thresholdsState,
      ...body,
      lpms_failover_hours: body.lpms_failover_hours ?? thresholdsState.lpms_failover_hours,
      source: "fixtures",
      updated_at: new Date().toISOString(),
      updated_by: "dev",
    };
    return HttpResponse.json(thresholdsState);
  }),
];
