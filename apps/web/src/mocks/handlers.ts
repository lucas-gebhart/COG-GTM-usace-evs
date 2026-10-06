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

  http.get(`${BASE}/public/locks/stream/events`, () => {
    const encoder = new TextEncoder();
    const payload = () => `event: locks\ndata: ${JSON.stringify({ counts: fixtures.locks.counts, as_of: fixtures.locks.as_of })}\n\n`;
    const stream = new ReadableStream({
      start(controller) {
        controller.enqueue(encoder.encode(payload()));
        const t = setInterval(() => controller.enqueue(encoder.encode(payload())), 30000);
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
    return row ? HttpResponse.json(row) : HttpResponse.json({ detail: `Lock ${String(params.lockId)} not found` }, { status: 404 });
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
