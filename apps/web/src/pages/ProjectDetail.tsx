import { Suspense, lazy, useId, useMemo, useState, type KeyboardEvent } from "react";
import { useParams } from "react-router";
import { Bar, BarChart, CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge, DataTable, EmptyState, Figure, SkeletonLoader, StatusChip } from "../components";
import { useFacilities, useLaborRows, useProject, useProjectHistory, type Schemas } from "../hooks/useApi";
import { formatCompact, formatCurrency, formatDate, formatDateTime, formatNumber, formatPercentValue } from "../lib/format";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../theme";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { daysBetween, formatDays, healthOf, milestoneOf } from "./shared/health";
import { StatusForm } from "./project/StatusForm";

const GanttChart = lazy(() => import("./project/GanttChart"));

type Project = Schemas["Project"];
type Milestone = Schemas["Milestone"];

const TABS = [
  { id: "financial", label: "Financial (CEFMS)" },
  { id: "schedule", label: "Schedule (P2)" },
  { id: "labor", label: "Labor (EMS)" },
  { id: "contracts", label: "Contracts (CMP)" },
  { id: "facilities", label: "Facilities (BUILDER)" },
] as const;
type TabId = (typeof TABS)[number]["id"];

/** APEX page 3 (Project Details form plus child regions). */
export function ProjectDetail() {
  const { p2 } = useParams<{ p2: string }>();
  const project = useProject(p2);
  return (
    <PageFrame
      path="/projects/:p2"
      title={project.data ? `${project.data.p2_project_no} ${project.data.name}` : `Project ${p2 ?? ""}`}
      breadcrumbs={[{ label: "Projects", to: "/projects" }, { label: p2 ?? "Project" }]}
    >
      <QueryBoundary query={project} label="Loading project" variant="text">
        {(data) => <ProjectBody project={data} />}
      </QueryBoundary>
    </PageFrame>
  );
}

function ProjectBody({ project }: { project: Project }) {
  const health = healthOf(project.schedule_health);
  const [tab, setTab] = useState<TabId>("financial");
  const id = useId();
  const variance = daysBetween(project.baseline_finish, project.current_finish);

  const onTabKey = (e: KeyboardEvent<HTMLButtonElement>, index: number) => {
    const next = e.key === "ArrowRight" ? (index + 1) % TABS.length : e.key === "ArrowLeft" ? (index - 1 + TABS.length) % TABS.length : e.key === "Home" ? 0 : e.key === "End" ? TABS.length - 1 : null;
    if (next === null) return;
    e.preventDefault();
    setTab(TABS[next].id);
    document.getElementById(`${id}-tab-${TABS[next].id}`)?.focus();
  };

  return (
    <>
      <dl className="evs-detail-list" aria-label="Project summary">
        <div><dt>Schedule health</dt><dd><StatusChip status={health.status} label={health.label} /></dd></div>
        <div><dt>Program</dt><dd>{project.program_code}</dd></div>
        <div><dt>District / division</dt><dd>{project.district} / {project.division}</dd></div>
        <div><dt>Business line</dt><dd>{project.business_line}</dd></div>
        <div><dt>PDT lead</dt><dd>{project.pdt_lead ?? "n/a"}</dd></div>
        <div><dt>Phase and progress</dt><dd>{project.phase}, {formatPercentValue(project.pct_complete, true)} complete</dd></div>
        <div><dt>Baseline / current finish</dt><dd>{formatDate(project.baseline_finish)} / {formatDate(project.current_finish)} ({formatDays(variance)})</dd></div>
        <div><dt>Funded / obligated / expended</dt><dd>{formatCompact(project.funded_amount)} / {formatCompact(project.obligated_amount)} / {formatCompact(project.expended_amount)}</dd></div>
      </dl>

      <StatusForm project={project} />

      <section className="evs-section evs-tabs" aria-labelledby={`${id}-tabs-heading`}>
        <h2 id={`${id}-tabs-heading`} className="evs-section__heading">Project regions</h2>
        <div role="tablist" aria-label="Project regions" className="evs-tabs__list">
          {TABS.map((t, i) => (
            <button key={t.id} id={`${id}-tab-${t.id}`} type="button" role="tab" aria-selected={tab === t.id} aria-controls={`${id}-panel-${t.id}`} tabIndex={tab === t.id ? 0 : -1} className="evs-tabs__tab" onClick={() => setTab(t.id)} onKeyDown={(e) => onTabKey(e, i)}>
              {t.label}
            </button>
          ))}
        </div>
        <div id={`${id}-panel-${tab}`} role="tabpanel" aria-labelledby={`${id}-tab-${tab}`} className="evs-tabs__panel">
          {tab === "financial" && <FinancialTab project={project} />}
          {tab === "schedule" && <ScheduleTab project={project} />}
          {tab === "labor" && <LaborTab project={project} />}
          {tab === "contracts" && <ContractsTab project={project} />}
          {tab === "facilities" && <FacilitiesTab project={project} />}
        </div>
      </section>

      <HistorySection p2={project.p2_project_no} />
    </>
  );
}

function FinancialTab({ project }: { project: Project }) {
  const rows = [
    { item: "Funded (CEFMS allotment)", amount: project.funded_amount, share: 1 },
    { item: "Obligated", amount: project.obligated_amount, share: project.funded_amount ? project.obligated_amount / project.funded_amount : 0 },
    { item: "Expended", amount: project.expended_amount, share: project.funded_amount ? project.expended_amount / project.funded_amount : 0 },
    { item: "Unobligated balance", amount: project.funded_amount - project.obligated_amount, share: project.funded_amount ? (project.funded_amount - project.obligated_amount) / project.funded_amount : 0 },
  ];
  return (
    <Figure
      title="CEFMS execution for this project"
      description={`${formatPercentValue(rows[1].share)} of ${formatCurrency(project.funded_amount)} obligated and ${formatPercentValue(rows[2].share)} expended. Work item level CEFMS detail needs a project scoped endpoint (see PR notes).`}
      data={rows}
      columns={[
        { key: "item", header: "Line", rowHeader: true },
        { key: "amount", header: "Amount", numeric: true, format: (v) => formatCurrency(v as number) },
        { key: "share", header: "Share of funded", numeric: true, format: (v) => formatPercentValue(v as number) },
      ]}
      legend={[{ name: "Amount", seriesIndex: 0 }]}
      height={240}
      headingLevel={3}
      csvName={`${project.p2_project_no}-cefms`}
      footer={<span className="font-body-2xs">Synthetic demo data (CEFMS rollup on the project row).</span>}
    >
      {({ reducedMotion }) => (
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={rows} layout="vertical" accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
            <ChartPatterns />
            <CartesianGrid stroke={CHART_TOKENS.grid} horizontal={false} />
            <XAxis type="number" tickFormatter={(v: number) => formatCompact(v)} tick={{ fill: CHART_TOKENS.axis }} />
            <YAxis type="category" dataKey="item" width={150} tick={{ fill: CHART_TOKENS.axis, fontSize: 12 }} />
            <Tooltip formatter={(v) => formatCurrency(Number(v))} />
            <Bar name="Amount" dataKey="amount" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
          </BarChart>
        </ResponsiveContainer>
      )}
    </Figure>
  );
}

function ScheduleTab({ project }: { project: Project }) {
  const milestones = project.milestones;
  const slipped = milestones.filter((m) => m.status === "slipped").length;
  return (
    <Figure
      title="Milestone schedule"
      description={`${milestones.length} P2 milestones, ${slipped} slipped. Bars run from the baseline date to the current date; triangles mark actual completion.`}
      data={milestones}
      columns={[
        { key: "code", header: "Code", rowHeader: true },
        { key: "name", header: "Milestone" },
        { key: "baseline_date", header: "Baseline", format: (v) => formatDate(v as string | null) },
        { key: "current_date", header: "Current", format: (v) => formatDate(v as string | null) },
        { key: "actual_date", header: "Actual", format: (v) => formatDate(v as string | null) },
        { key: "status", header: "Status", format: (v) => milestoneOf(v as string).label },
      ]}
      legend={[
        { name: "Slip (baseline to current)", seriesIndex: 1 },
        { name: "Baseline (diamond)", seriesIndex: 4 },
        { name: "Current (circle)", seriesIndex: 0 },
        { name: "Actual (triangle)", seriesIndex: 3 },
      ]}
      height={Math.max(220, 48 * milestones.length + 60)}
      headingLevel={3}
      csvName={`${project.p2_project_no}-milestones`}
      footer={<MilestoneChips milestones={milestones} />}
    >
      {({ reducedMotion, width, height }) => (
        <Suspense fallback={<SkeletonLoader label="Loading Gantt chart" variant="chart" />}>
          <GanttChart milestones={milestones} width={width} height={height} reducedMotion={reducedMotion} />
        </Suspense>
      )}
    </Figure>
  );
}

function MilestoneChips({ milestones }: { milestones: readonly Milestone[] }) {
  return (
    <ul className="usa-list usa-list--unstyled display-flex flex-wrap" aria-label="Milestone status">
      {milestones.map((m) => {
        const s = milestoneOf(m.status);
        return (
          <li key={m.code} className="margin-right-1 margin-bottom-05">
            <StatusChip status={s.status} label={`${m.code} ${s.label}${m.status === "slipped" ? ` ${formatDays(daysBetween(m.baseline_date, m.current_date))}` : ""}`} />
          </li>
        );
      })}
    </ul>
  );
}

function LaborTab({ project }: { project: Project }) {
  const labor = useLaborRows({ district: project.district, limit: 500 });
  return (
    <QueryBoundary query={labor} label="Loading EMS hours" variant="chart" isEmpty={(d) => d.rows.length === 0} emptyMessage={`No EMS labor rows for ${project.district}.`}>
      {(data) => {
        const rows = [...data.rows].sort((a, b) => a.pay_period.localeCompare(b.pay_period));
        return (
          <Figure
            title={`EMS hours by pay period, ${project.district} district, FY${data.fiscal_year}`}
            description="District level hours (plan, regular, overtime) by pay period. Project level charging needs a project filter on the labor endpoint (see PR notes)."
            data={rows}
            columns={[
              { key: "pay_period", header: "Pay period", rowHeader: true },
              { key: "hours_plan", header: "Planned", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
              { key: "hours_regular", header: "Regular", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
              { key: "hours_overtime", header: "Overtime", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
              { key: "labor_cost", header: "Labor cost", numeric: true, format: (v) => formatCurrency(v as number) },
            ]}
            legend={[{ name: "Planned", seriesIndex: 4 }, { name: "Regular", seriesIndex: 0 }, { name: "Overtime", seriesIndex: 2 }]}
            headingLevel={3}
            csvName={`${project.p2_project_no}-labor`}
            footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
          >
            {({ reducedMotion }) => (
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={rows} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                  <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                  <XAxis dataKey="pay_period" tick={{ fill: CHART_TOKENS.axis, fontSize: 11 }} />
                  <YAxis tickFormatter={(v: number) => formatCompact(v)} width={48} tick={{ fill: CHART_TOKENS.axis }} />
                  <Tooltip formatter={(v) => formatNumber(Number(v), { integer: true })} />
                  <Line name="Planned" dataKey="hours_plan" stroke={SERIES[4].color} strokeDasharray={SERIES[4].strokeDasharray} strokeWidth={2} dot={false} isAnimationActive={!reducedMotion} />
                  <Line name="Regular" dataKey="hours_regular" stroke={SERIES[0].color} strokeWidth={2} dot={{ r: 3 }} isAnimationActive={!reducedMotion} />
                  <Line name="Overtime" dataKey="hours_overtime" stroke={SERIES[2].color} strokeDasharray={SERIES[2].strokeDasharray} strokeWidth={2} dot={{ r: 3 }} isAnimationActive={!reducedMotion} />
                </LineChart>
              </ResponsiveContainer>
            )}
          </Figure>
        );
      }}
    </QueryBoundary>
  );
}

function ContractsTab({ project }: { project: Project }) {
  return (
    <EmptyState
      title="No CMP contract records in this API build"
      message={`Contract actions for ${project.p2_project_no} will appear here once the WP3 API exposes a project scoped CMP endpoint (requested in the PR notes). The region layout, table alternative and provenance badge follow the other tabs.`}
    />
  );
}

function FacilitiesTab({ project }: { project: Project }) {
  const facilities = useFacilities({ district: project.district, limit: 500 });
  return (
    <QueryBoundary query={facilities} label="Loading BUILDER components" isEmpty={(d) => d.rows.length === 0} emptyMessage={`No BUILDER components recorded for ${project.district}.`}>
      {(data) => (
        <DataTable
          caption={`BUILDER components, ${project.district} district`}
          captionMeta={<><AsOfBadge asOf={data.as_of} tickMs={0} /> <span className="font-body-2xs">District level; project to building links need a BUILDER join in the API.</span></>}
          columns={[
            { id: "building_id", accessorKey: "building_id", header: "Building" },
            { id: "installation", accessorKey: "installation", header: "Installation" },
            { id: "component_type", accessorKey: "component_type", header: "Component" },
            { id: "ci", accessorKey: "ci", header: "CI", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>()) },
            { id: "bci", accessorKey: "bci", header: "BCI", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>()) },
            { id: "deficiency_cost", accessorKey: "deficiency_cost", header: "Deficiency cost", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
            { id: "work_plan_year", accessorKey: "work_plan_year", header: "Work plan year" },
          ]}
          data={data.rows}
          getRowId={(r) => `${r.building_id}-${r.uniformat_section}-${r.component_type}`}
          rowHeaderColumnId="building_id"
          pageSize={10}
          initialSorting={[{ id: "ci", desc: false }]}
        />
      )}
    </QueryBoundary>
  );
}

function HistorySection({ p2 }: { p2: string }) {
  const history = useProjectHistory(p2);
  const events = useMemo(() => [...(history.data?.events ?? [])].sort((a, b) => b.changed_on.localeCompare(a.changed_on)), [history.data]);
  return (
    <section className="evs-section" aria-labelledby="history-heading">
      <h2 id="history-heading" className="evs-section__heading">Change history</h2>
      <QueryBoundary query={history} label="Loading change history" variant="text" isEmpty={(d) => d.events.length === 0} emptyTitle="No changes recorded" emptyMessage="Saves from the status form appear here (APEX sp_history port).">
        {() => (
          <DataTable
            caption="Change history"
            columns={[
              { id: "changed_on", accessorKey: "changed_on", header: "When", cell: (c) => formatDateTime(c.getValue<string>()) },
              { id: "attribute", accessorKey: "attribute", header: "Attribute" },
              { id: "old_value", accessorKey: "old_value", header: "From", cell: (c) => c.getValue<string | null>() ?? "n/a" },
              { id: "new_value", accessorKey: "new_value", header: "To", cell: (c) => c.getValue<string | null>() ?? "n/a" },
              { id: "changed_by", accessorKey: "changed_by", header: "By", cell: (c) => c.getValue<string | null>() ?? "n/a" },
            ]}
            data={events}
            getRowId={(r) => String(r.id)}
            rowHeaderColumnId="changed_on"
            pageSize={5}
            enableSorting={false}
          />
        )}
      </QueryBoundary>
    </section>
  );
}

export default ProjectDetail;
