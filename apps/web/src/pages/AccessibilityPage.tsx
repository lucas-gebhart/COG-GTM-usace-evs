import { type MouseEvent, useMemo, useState } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Alert, Button } from "@trussworks/react-uswds";
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import {
  AsOfBadge,
  DataTable,
  EmptyState,
  ErrorState,
  Figure,
  FilterBar,
  KpiTile,
  PageHeader,
  SkeletonLoader,
  type FigureColumn,
  type FilterValues,
} from "../components";
import { useAccessibilityReadout, type Schemas } from "../hooks/useApi";
import { downloadCsv, toCsv } from "../lib/csv";
import { formatDate, formatDateTime, formatNumber } from "../lib/format";
import { ChartPatterns, CHART_TOKENS, SERIES } from "../theme";
import { CONFORMANCE_META, CONFORMANCE_ORDER, ConformanceChip, MANUAL_META } from "./accessibility/ConformanceChip";

type Readout = Schemas["AccessibilityReadout"];
type Criterion = Schemas["CriterionStatus"];
type Cell = Schemas["AxeRouteResult"];
type ManualRow = Schemas["ManualTestRow"];
type Impact = Schemas["AxeViolation"]["impact"];

const TITLE = "Accessibility read-out";
const IMPACTS: readonly Impact[] = ["critical", "serious", "moderate", "minor"];
const IMPACT_SERIES: Record<Impact, number> = { critical: 3, serious: 1, moderate: 2, minor: 0, unknown: 4 };
const METHOD_LABEL: Record<Criterion["method"], string> = { automated: "Automated", manual: "Manual", not_applicable: "Not applicable" };
const CHAPTER_SHORT: Record<Criterion["chapter"], string> = {
  success_criteria_level_a: "WCAG A",
  success_criteria_level_aa: "WCAG AA",
  functional_performance_criteria: "508 Ch. 3",
  support_documentation_and_services: "508 Ch. 6",
};
const CATEGORY_LABEL: Record<ManualRow["category"], string> = {
  screen_reader: "Screen reader",
  keyboard: "Keyboard",
  zoom: "Zoom and reflow",
  contrast: "Contrast and forced colours",
  motion: "Motion",
  touch: "Touch and pointer",
  forms: "Forms and timing",
  other: "Other",
};

interface ImpactRow {
  route: string;
  critical: number;
  serious: number;
  moderate: number;
  minor: number;
  total: number;
  cells: number;
}

function cellId(c: Cell) {
  return `${c.route}|${c.viewport}|${c.theme}|${c.reduced_motion ? "rm" : "m"}`;
}

function impactRows(cells: readonly Cell[]): ImpactRow[] {
  const byRoute = new Map<string, ImpactRow>();
  for (const c of cells) {
    const row = byRoute.get(c.route) ?? { route: c.route, critical: 0, serious: 0, moderate: 0, minor: 0, total: 0, cells: 0 };
    row.cells += 1;
    for (const v of c.violation_details ?? []) {
      if (v.impact !== "unknown") row[v.impact] += 1;
      row.total += 1;
    }
    byRoute.set(c.route, row);
  }
  return [...byRoute.values()].sort((a, b) => a.route.localeCompare(b.route));
}

function ViolationDetails({ cell }: { cell: Cell }) {
  const details = cell.violation_details ?? [];
  if (details.length === 0) return <span>None</span>;
  return (
    <details className="evs-a11y-details">
      <summary>
        {details.length} {details.length === 1 ? "violation" : "violations"}
      </summary>
      <ul className="usa-list usa-list--unstyled">
        {details.map((v) => (
          <li key={`${v.rule}-${v.where}`}>
            <code>{v.rule}</code> {v.impact}, {v.nodes} {v.nodes === 1 ? "node" : "nodes"}
            {v.help_url && (
              <>
                {" "}
                <a className="usa-link usa-link--external" href={v.help_url} target="_blank" rel="noreferrer">
                  axe help
                </a>
              </>
            )}
          </li>
        ))}
      </ul>
    </details>
  );
}

function EvidenceLinks({ links }: { links: Criterion["evidence"] }) {
  if (!links || links.length === 0) return <span>None</span>;
  return (
    <ul className="evs-a11y-evidence">
      {links.map((l) => (
        <li key={l.href + l.label}>
          <a className="usa-link" href={l.href} target={l.href.startsWith("http") ? "_blank" : undefined} rel={l.href.startsWith("http") ? "noreferrer" : undefined}>
            {l.label}
          </a>
        </li>
      ))}
    </ul>
  );
}

const conformanceColumns: ColumnDef<Criterion, unknown>[] = [
  { accessorKey: "criterion", header: "Criterion", id: "criterion", sortingFn: "alphanumeric" },
  { accessorKey: "name", header: "Name" },
  { accessorKey: "level", header: "Level" },
  { accessorKey: "chapter", header: "Chapter", cell: (c) => CHAPTER_SHORT[c.getValue<Criterion["chapter"]>()] },
  {
    accessorKey: "status",
    header: "Status",
    cell: (c) => <ConformanceChip meta={CONFORMANCE_META[c.getValue<Criterion["status"]>()]} />,
    sortingFn: (a, b) => CONFORMANCE_ORDER.indexOf(a.original.status) - CONFORMANCE_ORDER.indexOf(b.original.status),
  },
  { accessorKey: "method", header: "Method", cell: (c) => METHOD_LABEL[c.getValue<Criterion["method"]>()] },
  { accessorKey: "notes", header: "Notes", enableSorting: false },
  { accessorKey: "evidence", header: "Evidence", enableSorting: false, cell: (c) => <EvidenceLinks links={c.getValue<Criterion["evidence"]>()} /> },
];

const matrixColumns: ColumnDef<Cell, unknown>[] = [
  { accessorKey: "route", header: "Route", id: "route" },
  { accessorKey: "viewport", header: "Viewport" },
  { accessorKey: "theme", header: "Theme" },
  { accessorKey: "reduced_motion", header: "Motion", cell: (c) => (c.getValue<boolean>() ? "Reduced" : "Default"), enableColumnFilter: false },
  { accessorKey: "passes", header: "Passes", meta: { numeric: true }, enableColumnFilter: false },
  { accessorKey: "violations", header: "Violations", meta: { numeric: true }, enableColumnFilter: false },
  { accessorKey: "incomplete", header: "Needs review", meta: { numeric: true }, enableColumnFilter: false },
  { id: "details", header: "Violation details", enableSorting: false, enableColumnFilter: false, cell: (c) => <ViolationDetails cell={c.row.original} /> },
];

const manualColumns: ColumnDef<ManualRow, unknown>[] = [
  { accessorKey: "name", header: "Environment", id: "name", cell: (c) => (c.row.original.version ? `${c.getValue<string>()} ${c.row.original.version}` : c.getValue<string>()) },
  { accessorKey: "category", header: "Category", cell: (c) => CATEGORY_LABEL[c.getValue<ManualRow["category"]>()] },
  { accessorKey: "status", header: "Status", cell: (c) => <ConformanceChip meta={MANUAL_META[c.getValue<ManualRow["status"]>()]} /> },
  { id: "coverage", header: "Criteria attested", meta: { numeric: true }, accessorFn: (r) => r.criteria_attested, cell: (c) => `${c.row.original.criteria_attested} of ${c.row.original.criteria_total}` },
  { accessorKey: "tester", header: "Tester", cell: (c) => c.getValue<string | null>() ?? "Unassigned" },
  { accessorKey: "date", header: "Date", cell: (c) => (c.getValue<string | null>() ? formatDate(c.getValue<string>()) : "Not run") },
  { accessorKey: "tests", header: "Test plan ids", enableSorting: false, cell: (c) => c.getValue<string[]>().join(", ") },
];

const impactColumns: readonly FigureColumn<ImpactRow>[] = [
  { key: "route", header: "Route", rowHeader: true },
  { key: "critical", header: "Critical", numeric: true },
  { key: "serious", header: "Serious", numeric: true },
  { key: "moderate", header: "Moderate", numeric: true },
  { key: "minor", header: "Minor", numeric: true },
  { key: "total", header: "Total", numeric: true },
  { key: "cells", header: "Cells tested", numeric: true },
];

function ImpactFigure({ cells }: { cells: readonly Cell[] }) {
  const rows = useMemo(() => impactRows(cells), [cells]);
  const total = rows.reduce((n, r) => n + r.total, 0);
  const worst = rows.filter((r) => r.total > 0).sort((a, b) => b.total - a.total)[0];
  const description =
    total === 0
      ? `No axe violations across ${rows.length} routes and ${cells.length} cells; every bar is zero.`
      : `${total} violations across ${rows.length} routes; ${worst?.route} has the most with ${worst?.total}. Bars stack critical, serious, moderate and minor counts.`;
  return (
    <Figure title="axe violations by impact per route" description={description} data={rows} columns={impactColumns} csvName="evs-axe-violations-by-route" height={300} legend={IMPACTS.map((i) => ({ name: i.charAt(0).toUpperCase() + i.slice(1), seriesIndex: IMPACT_SERIES[i] }))} headingLevel={3}>
      {({ reducedMotion }) => (
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={rows} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
            <ChartPatterns />
            <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
            <XAxis dataKey="route" tick={{ fontSize: 12 }} interval={0} angle={-30} textAnchor="end" height={64} />
            <YAxis allowDecimals={false} width={32} />
            <Tooltip />
            {IMPACTS.map((i) => {
              const s = SERIES[IMPACT_SERIES[i]];
              return <Bar key={i} name={i.charAt(0).toUpperCase() + i.slice(1)} dataKey={i} stackId="impact" fill={`url(#${s.patternId})`} stroke={s.color} isAnimationActive={!reducedMotion} />;
            })}
          </BarChart>
        </ResponsiveContainer>
      )}
    </Figure>
  );
}

function Summary({ data }: { data: Readout }) {
  const s = data.summary;
  const v = data.versions;
  const of = `of ${s.criteria_total} WCAG 2.1 A and AA criteria`;
  return (
    <div className="evs-grid evs-grid--kpis">
      <KpiTile label="Supports" value={formatNumber(s.supports)} deltaPct={null} context={of} headingLevel={3} />
      <KpiTile label="Partially supports" value={formatNumber(s.partially_supports)} deltaPct={null} context={of} headingLevel={3} />
      <KpiTile label="Does not support" value={formatNumber(s.does_not_support)} deltaPct={null} context={of} headingLevel={3} />
      <KpiTile label="Not applicable" value={formatNumber(s.not_applicable)} deltaPct={null} context={of} headingLevel={3} />
      <KpiTile label="Not evaluated" value={formatNumber(s.not_evaluated)} deltaPct={null} context="Manual attestation outstanding, no claim made" headingLevel={3} />
      <KpiTile label="Routes tested" value={formatNumber(s.routes_tested)} deltaPct={null} context={`${s.cells} axe cells (route x viewport x theme x motion)`} headingLevel={3} />
      <KpiTile label="Viewports and themes" value={`${s.viewports.length} x ${s.themes.length}`} deltaPct={null} context={[...s.viewports, ...s.themes].join(", ") || "No cells"} headingLevel={3} />
      <KpiTile label="Last automated run" value={s.last_run_at ? formatDate(s.last_run_at) : "No run"} deltaPct={null} context={s.last_run_at ? formatDateTime(s.last_run_at) : "Run pnpm test:a11y and evs-acr-gen"} headingLevel={3} />
      <KpiTile label="axe-core" value={v.axe} deltaPct={null} context="Playwright matrix and pa11y runner" headingLevel={3} />
      <KpiTile label="pa11y-ci" value={v.pa11y ?? "Not run"} deltaPct={null} context={s.pa11y_urls ? `${s.pa11y_urls} URLs, ${s.pa11y_errors} errors` : "No pa11y results in this build"} headingLevel={3} />
      <KpiTile label="Lighthouse" value={v.lighthouse ?? "Not run"} deltaPct={null} context={s.lighthouse_runs ? `${s.lighthouse_runs} runs, minimum accessibility score ${s.lighthouse_min_score ?? "n/a"}` : "No Lighthouse results in this build"} headingLevel={3} />
      <KpiTile label="Zero-violation cells" value={formatNumber(s.zero_violation_cells)} unit={`of ${s.cells}`} deltaPct={null} context={`${s.total_violations} violations, ${s.needs_review} needs review`} headingLevel={3} />
    </div>
  );
}

function Conformance({ data }: { data: Readout }) {
  const rows = useMemo(() => [...data.criteria, ...(data.section508 ?? [])], [data]);
  const [filters, setFilters] = useState<FilterValues>({ status: "", chapter: "" });
  const filtered = useMemo(() => rows.filter((r) => (!filters.status || r.status === filters.status) && (!filters.chapter || r.chapter === filters.chapter)), [rows, filters]);
  const statusOptions = CONFORMANCE_ORDER.filter((s) => rows.some((r) => r.status === s)).map((s) => ({ value: s, label: CONFORMANCE_META[s].label }));
  const chapterOptions = [...new Map(rows.map((r) => [r.chapter, r.chapter_title])).entries()].map(([value, label]) => ({ value, label }));
  const exportCsv = () =>
    downloadCsv(
      "evs-conformance.csv",
      toCsv(filtered, [
        { key: "criterion", header: "Criterion" },
        { key: "name", header: "Name" },
        { key: "level", header: "Level" },
        { key: "chapter_title", header: "Chapter" },
        { key: "status", header: "Status", format: (v) => CONFORMANCE_META[v as Criterion["status"]]?.label ?? String(v) },
        { key: "method", header: "Method", format: (v) => METHOD_LABEL[v as Criterion["method"]] ?? String(v) },
        { key: "notes", header: "Notes" },
        { key: "evidence", header: "Evidence", format: (v) => ((v as Criterion["evidence"]) ?? []).map((l) => `${l.label}: ${l.href}`).join("; ") },
      ]),
    );
  return (
    <>
      <FilterBar
        legend="Filter conformance rows"
        fields={[
          { id: "status", label: "Status", type: "select", options: statusOptions },
          { id: "chapter", label: "Chapter", type: "select", options: chapterOptions },
        ]}
        values={filters}
        onApply={setFilters}
        onReset={() => setFilters({ status: "", chapter: "" })}
        resultCount={filtered.length}
        resultNoun="criteria"
      />
      <div className="evs-a11y-toolbar">
        <Button type="button" outline onClick={exportCsv}>
          Download conformance CSV
        </Button>
      </div>
      <DataTable
        caption="Conformance by criterion"
        captionMeta={`${filtered.length} of ${rows.length} rows; OpenACR 2.5 chapters, Revised 508 and WCAG 2.1`}
        columns={conformanceColumns}
        data={filtered}
        getRowId={(r) => `${r.chapter}-${r.criterion}`}
        rowHeaderColumnId="criterion"
        enableSorting
        pageSize={25}
        initialSorting={[{ id: "criterion", desc: false }]}
        emptyMessage="No criteria match the selected filters."
      />
    </>
  );
}

/**
 * Fetch the artefact and save it as a blob. Anchor downloads are navigations, which the MSW service worker
 * does not intercept in mock mode; fetch() is intercepted, and the href stays as the no-JS fallback.
 */
async function saveArtifact(event: MouseEvent<HTMLAnchorElement>, href: string, name: string): Promise<void> {
  if (event.defaultPrevented || event.button !== 0 || event.metaKey || event.ctrlKey) return;
  event.preventDefault();
  try {
    const res = await fetch(href);
    if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
    const url = URL.createObjectURL(await res.blob());
    const a = document.createElement("a");
    a.href = url;
    a.download = name;
    a.rel = "noopener";
    document.body.appendChild(a);
    a.click();
    a.remove();
    setTimeout(() => URL.revokeObjectURL(url), 0);
  } catch {
    window.location.assign(href);
  }
}

function Downloads({ data }: { data: Readout }) {
  return (
    <ul className="evs-a11y-downloads">
      {data.artifacts.map((a) => (
        <li key={a.name}>
          <a className="usa-button usa-button--outline" href={a.href} download={a.name} onClick={(e) => void saveArtifact(e, a.href, a.name)}>
            {a.label}
          </a>
        </li>
      ))}
    </ul>
  );
}

function Statement({ data }: { data: Readout }) {
  const st = data.statement;
  return (
    <div className="evs-a11y-statement">
      <Alert type="info" slim>
        <p className="usa-alert__text">{st.demo_notice}</p>
      </Alert>
      <dl>
        <dt>Product</dt>
        <dd>{st.product}</dd>
        <dt>Version</dt>
        <dd>
          {st.version} (commit {st.git_sha}, report date {formatDate(st.report_date)})
        </dd>
        <dt>Standard</dt>
        <dd>{st.standard}</dd>
        <dt>Design rules adopted from WCAG 2.2</dt>
        <dd>
          <ul className="usa-list usa-list--unstyled">
            {st.design_rules.map((r) => (
              <li key={r}>{r}</li>
            ))}
          </ul>
        </dd>
        <dt>Scope</dt>
        <dd>{st.scope_routes.length ? `${st.scope_routes.length} routes: ${st.scope_routes.join(", ")}` : "No routes in the automated evidence for this build"}</dd>
        <dt>Evaluation methods</dt>
        <dd>{st.evaluation_methods}</dd>
        <dt>Known issues</dt>
        <dd>
          {st.known_issues.length ? (
            <ul className="usa-list">
              {st.known_issues.map((k) => (
                <li key={k}>{k}</li>
              ))}
            </ul>
          ) : (
            "None recorded"
          )}
        </dd>
        <dt>Contact</dt>
        <dd>{st.contact}</dd>
        {st.repository && (
          <>
            <dt>Repository</dt>
            <dd>{st.repository}</dd>
          </>
        )}
      </dl>
      {st.legal_disclaimer && <p className="evs-a11y-disclaimer">{st.legal_disclaimer}</p>}
    </div>
  );
}

export function AccessibilityPage() {
  const q = useAccessibilityReadout();
  const data = q.data;
  return (
    <>
      <PageHeader title={TITLE} intro="Section 508 and WCAG 2.1 AA conformance of this EVS demo build, generated from the CI accessibility evidence and the manual attestation file. Nothing on this page is typed in by hand." actions={data ? <AsOfBadge asOf={data.as_of} /> : undefined} />
      {q.isPending && (
        <div className="evs-a11y-loading">
          <SkeletonLoader label="Loading accessibility read-out" variant="kpi" />
          <SkeletonLoader label="Loading conformance table" variant="table" />
        </div>
      )}
      {q.isError && <ErrorState title="The accessibility read-out could not be loaded" error={q.error} onRetry={() => void q.refetch()} />}
      {data && (
        <>
          <section className="evs-a11y-section" aria-labelledby="a11y-summary">
            <h2 id="a11y-summary">Summary</h2>
            <Summary data={data} />
          </section>
          <section className="evs-a11y-section" aria-labelledby="a11y-conformance">
            <h2 id="a11y-conformance">Conformance table</h2>
            <Conformance data={data} />
          </section>
          <section className="evs-a11y-section" aria-labelledby="a11y-automated">
            <h2 id="a11y-automated">Automated results</h2>
            {data.routes.length === 0 ? (
              <EmptyState title="No automated evidence in this build" message="The axe matrix has not run for this commit. Run pnpm test:a11y in apps/web, then uv run evs-acr-gen in tools/acr, to populate this section." headingLevel={3} />
            ) : (
              <>
                <p>
                  {data.summary.cells} cells: {data.summary.routes_tested} routes, {data.summary.viewports.length} viewports, {data.summary.themes.length} themes, {data.summary.motion_settings} motion settings. Keyboard smoke {data.summary.keyboard_routes_passed} of {data.summary.keyboard_routes_total} routes passed; reflow smoke {data.summary.reflow_cells_passed} of {data.summary.reflow_cells_total} cells passed.
                </p>
                <ImpactFigure cells={data.routes} />
                <DataTable
                  caption="axe results by route, viewport, theme and motion setting"
                  captionMeta={`${data.routes.length} cells; expand a row's details for rule id, impact, node count and help link`}
                  columns={matrixColumns}
                  data={data.routes}
                  getRowId={cellId}
                  rowHeaderColumnId="route"
                  enableFilters
                  enableSorting
                  pageSize={24}
                  initialSorting={[
                    { id: "violations", desc: true },
                    { id: "route", desc: false },
                  ]}
                />
              </>
            )}
          </section>
          <section className="evs-a11y-section" aria-labelledby="a11y-manual">
            <h2 id="a11y-manual">Manual test plan status</h2>
            <p>
              {data.summary.manual_passed} of {data.summary.manual_total} environments passed. Status is derived from docs/a11y/manual_attestation.yaml: a row passes only when every attested criterion that cites its tests says supports.
            </p>
            <DataTable caption="Manual test environments" columns={manualColumns} data={data.manual} getRowId={(r) => r.id} rowHeaderColumnId="name" enableSorting pageSize={12} emptyMessage="No manual test rows are defined." />
          </section>
          <section className="evs-a11y-section" aria-labelledby="a11y-downloads">
            <h2 id="a11y-downloads">Downloads</h2>
            <Downloads data={data} />
          </section>
          <section className="evs-a11y-section" aria-labelledby="a11y-statement">
            <h2 id="a11y-statement">Conformance statement</h2>
            <Statement data={data} />
          </section>
        </>
      )}
    </>
  );
}

export default AccessibilityPage;
