import { HttpResponse, http, type HttpHandler } from "msw";
import { fixtures, syntheticAsOf, thresholds } from "./fixtures";
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

function paginate<T>(items: T[], url: URL) {
  const limit = Math.min(Number(url.searchParams.get("limit") ?? 50), 500);
  const offset = Number(url.searchParams.get("offset") ?? 0);
  return { items: items.slice(offset, offset + limit), page: { total: items.length, limit, offset } };
}

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

  http.get(`${BASE}/programs`, ({ request }) => HttpResponse.json({ ...paginate(fixtures.programs, new URL(request.url)), as_of: syntheticAsOf() })),

  http.get(`${BASE}/projects`, ({ request }) => {
    const url = new URL(request.url);
    const program = url.searchParams.get("program_code");
    const district = url.searchParams.get("district");
    let rows = fixtures.projects;
    if (program) rows = rows.filter((r) => r.program_code === program);
    if (district) rows = rows.filter((r) => r.district === district);
    return HttpResponse.json({ ...paginate(rows, url), as_of: syntheticAsOf() });
  }),

  http.get(`${BASE}/projects/:p2`, ({ params }) => {
    const row = fixtures.projects.find((r) => r.p2_project_no === params.p2);
    return row ? HttpResponse.json(row) : HttpResponse.json({ detail: `Project ${String(params.p2)} not found` }, { status: 404 });
  }),

  http.get(`${BASE}/financial/summary`, () => HttpResponse.json(fixtures.financialSummary)),
  http.get(`${BASE}/workforce/labor`, () => HttpResponse.json(fixtures.laborSummary)),
  http.get(`${BASE}/facilities/condition`, () => HttpResponse.json(fixtures.facilities)),

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
  http.get(`${BASE}/admin/feeds`, () => HttpResponse.json({ feeds: fixtures.feeds, generated_at: new Date().toISOString() })),
  http.get(`${BASE}/admin/thresholds`, () => HttpResponse.json(thresholds)),
];
