import { useMemo, useState } from "react";
import { Bar, BarChart, CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge, Figure, FilterBar, KpiTile, ThemeToggle, type FilterValues } from "../components";
import { useCiDistribution, useEnterpriseKpis, useFinancialSummary, useLabor, useProjects, type Schemas } from "../hooks/useApi";
import { useTheme } from "../hooks/useTheme";
import { formatCompact, formatCurrency, formatDate, formatNumber, formatPercentValue } from "../lib/format";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../theme";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { options, uniqueSorted } from "./shared/health";

type Tile = Schemas["KpiTile"];

function tileValue(t: Tile | undefined): string {
  if (!t) return "n/a";
  return t.unit === "%" ? formatPercentValue(t.value, true) : formatNumber(t.value, { integer: Number.isInteger(t.value) });
}

/** APEX page 1 (Home): KPI tiles and four charts, each with a table alternative and CSV export. */
export function EnterpriseOverview() {
  const { isLeadership } = useTheme();
  const kpis = useEnterpriseKpis();
  const financial = useFinancialSummary();
  const projects = useProjects({ limit: 500 });
  const labor = useLabor();
  const ci = useCiDistribution();
  const [filters, setFilters] = useState<FilterValues>({});

  const tile = (id: string) => kpis.data?.tiles.find((t) => t.id === id);
  const onSchedule = useMemo(() => {
    const total = tile("projects")?.value ?? 0;
    const late = tile("late_projects")?.value ?? 0;
    return total ? ((total - late) / total) * 100 : null;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [kpis.data]);
  const utilization = useMemo(() => {
    const rows = labor.data?.rows ?? [];
    const plan = rows.reduce((s, r) => s + r.hours_plan, 0);
    const worked = rows.reduce((s, r) => s + r.hours_regular + r.hours_overtime, 0);
    return plan ? (worked / plan) * 100 : null;
  }, [labor.data]);
  const avgCi = useMemo(() => {
    const rows = ci.data?.by_installation ?? [];
    const n = rows.reduce((s, r) => s + r.component_count, 0);
    return n ? rows.reduce((s, r) => s + r.avg_ci * r.component_count, 0) / n : null;
  }, [ci.data]);

  const byPhase = useMemo(() => {
    const counts = new Map<string, { phase: string; projects: number; late_or_at_risk: number }>();
    for (const p of projects.data?.items ?? []) {
      const c = counts.get(p.phase) ?? { phase: p.phase, projects: 0, late_or_at_risk: 0 };
      c.projects += 1;
      if (p.schedule_health !== "on_track") c.late_or_at_risk += 1;
      counts.set(p.phase, c);
    }
    return [...counts.values()].sort((a, b) => b.projects - a.projects);
  }, [projects.data]);

  const districts = useMemo(() => uniqueSorted(labor.data?.rows ?? [], (r) => r.district), [labor.data]);
  const byDistrict = useMemo(() => {
    const rows = (labor.data?.rows ?? []).filter((r) => !filters.district || r.district === filters.district);
    const agg = new Map<string, { district: string; hours_regular: number; hours_overtime: number; hours_plan: number }>();
    for (const r of rows) {
      const c = agg.get(r.district) ?? { district: r.district, hours_regular: 0, hours_overtime: 0, hours_plan: 0 };
      c.hours_regular += r.hours_regular;
      c.hours_overtime += r.hours_overtime;
      c.hours_plan += r.hours_plan;
      agg.set(r.district, c);
    }
    return [...agg.values()].sort((a, b) => a.district.localeCompare(b.district));
  }, [labor.data, filters.district]);

  const curve = financial.data?.execution_curve ?? [];
  const lastPoint = curve.at(-1);
  const gapPct = lastPoint && lastPoint.plan_cumulative ? ((lastPoint.obligated_cumulative - lastPoint.plan_cumulative) / lastPoint.plan_cumulative) * 100 : null;

  return (
    <PageFrame
      path="/"
      intro="Enterprise roll-up of P2 schedule, CEFMS execution, EMS labor, BUILDER condition and public lock status."
      actions={<ThemeToggle />}
    >
      <QueryBoundary query={kpis} label="Loading enterprise indicators" variant="kpi">
        {(data) => (
          <section aria-labelledby="kpi-heading">
            <h2 id="kpi-heading" className="evs-sr-only">Key indicators</h2>
            <div className="evs-grid evs-grid--kpis">
              <KpiTile label="Obligation rate" value={tileValue(tile("obligation_rate"))} deltaPct={gapPct === null ? null : Number(gapPct.toFixed(1))} deltaLabel="vs plan to date" context={tile("obligation_rate")?.delta_label ?? undefined} />
              <KpiTile label="Projects on schedule" value={onSchedule === null ? "n/a" : formatPercentValue(onSchedule, true)} deltaPct={null} context={tile("late_projects") ? `${formatNumber(tile("late_projects")!.value, { integer: true })} late or at risk of ${formatNumber(tile("projects")!.value, { integer: true })}` : undefined} />
              <KpiTile label="Labor utilization" value={utilization === null ? "n/a" : formatPercentValue(utilization, true)} deltaPct={utilization === null ? null : Number((utilization - 100).toFixed(1))} deltaLabel="vs planned hours" context={labor.data ? `FY${labor.data.fiscal_year} EMS hours worked over plan` : undefined} />
              <KpiTile label="Average facility CI" value={avgCi === null ? "n/a" : formatNumber(avgCi)} deltaPct={null} context={tile("facilities_poor") ? `${formatPercentValue(tile("facilities_poor")!.value, true)} of components in poor condition` : undefined} />
              <KpiTile label="Locks operating now" value={tileValue(tile("locks_operating"))} deltaPct={null} context={tile("locks_operating")?.delta_label ?? undefined} accent="var(--evs-status-operating)" />
              <KpiTile label="Slipped milestones" value={tileValue(tile("slipped_milestones"))} deltaPct={null} context="P2 milestones past their baseline date" />
            </div>
            <p className="margin-top-1 margin-bottom-0">
              <AsOfBadge asOf={data.as_of} tickMs={0} />
              {tile("locks_operating") && <AsOfBadge asOf={tile("locks_operating")!.as_of} prefix="Locks as of" tickMs={0} className="margin-left-1" />}
            </p>
          </section>
        )}
      </QueryBoundary>

      {!isLeadership && (
        <FilterBar
          className="evs-leadership-hide margin-top-3"
          legend="Chart filters"
          fields={[{ id: "district", label: "District (labor chart)", type: "select", options: options(districts) }]}
          values={filters}
          onApply={setFilters}
        />
      )}

      <div className="evs-grid evs-grid--2 margin-top-3">
        <QueryBoundary query={financial} label="Loading execution curve" variant="chart">
          {(data) => (
            <Figure
              title={`Obligations vs plan by month, FY${data.fiscal_year}`}
              description={gapPct === null ? "Cumulative plan, obligations and expenditures by month." : `Cumulative obligations are ${formatPercentValue(Math.abs(gapPct), true)} ${gapPct < 0 ? "under" : "over"} plan at ${formatDate(lastPoint!.period)}.`}
              data={curve}
              columns={[
                { key: "period", header: "Period", rowHeader: true, format: (v) => formatDate(v as string) },
                { key: "plan_cumulative", header: "Plan, cumulative", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "obligated_cumulative", header: "Obligated, cumulative", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "expended_cumulative", header: "Expended, cumulative", numeric: true, format: (v) => formatCurrency(v as number) },
              ]}
              legend={[
                { name: "Plan", seriesIndex: 4 },
                { name: "Obligated", seriesIndex: 0 },
                { name: "Expended", seriesIndex: 1 },
              ]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="obligations-vs-plan"
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={curve} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="period" tickFormatter={(v: string) => formatDate(v).slice(0, 3)} tick={{ fill: CHART_TOKENS.axis }} />
                    <YAxis tickFormatter={(v: number) => formatCompact(v)} width={56} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip formatter={(v) => formatCurrency(Number(v))} labelFormatter={(l) => formatDate(String(l))} />
                    <Line name="Plan" dataKey="plan_cumulative" stroke={SERIES[4].color} strokeDasharray={SERIES[4].strokeDasharray} strokeWidth={2} dot={false} isAnimationActive={!reducedMotion} />
                    <Line name="Obligated" dataKey="obligated_cumulative" stroke={SERIES[0].color} strokeWidth={2} dot={{ r: 4 }} isAnimationActive={!reducedMotion} />
                    <Line name="Expended" dataKey="expended_cumulative" stroke={SERIES[1].color} strokeDasharray={SERIES[1].strokeDasharray} strokeWidth={2} dot={{ r: 4, strokeWidth: 2 }} isAnimationActive={!reducedMotion} />
                  </LineChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>

        <QueryBoundary query={projects} label="Loading projects by phase" variant="chart">
          {(data) => (
            <Figure
              title="Projects by phase"
              description={`${formatNumber(data.page.total, { integer: true })} projects across ${byPhase.length} P2 phases; the hatched segment counts projects late or at risk.`}
              data={byPhase}
              columns={[
                { key: "phase", header: "Phase", rowHeader: true },
                { key: "projects", header: "Projects", numeric: true },
                { key: "late_or_at_risk", header: "Late or at risk", numeric: true },
              ]}
              legend={[
                { name: "Projects", seriesIndex: 0 },
                { name: "Late or at risk", seriesIndex: 1 },
              ]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="projects-by-phase"
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={byPhase} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <ChartPatterns />
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="phase" tick={{ fill: CHART_TOKENS.axis }} />
                    <YAxis allowDecimals={false} width={40} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip />
                    <Bar name="Projects" dataKey="projects" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
                    <Bar name="Late or at risk" dataKey="late_or_at_risk" fill={`url(#${SERIES[1].patternId})`} stroke={SERIES[1].color} isAnimationActive={!reducedMotion} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>

        <QueryBoundary query={labor} label="Loading labor hours" variant="chart">
          {(data) => (
            <Figure
              title={`Labor hours by district, FY${data.fiscal_year}`}
              description={`Regular and overtime EMS hours summed over ${uniqueSorted(data.rows, (r) => r.pay_period).length} pay periods${filters.district ? ` for ${filters.district}` : ""}.`}
              data={byDistrict}
              columns={[
                { key: "district", header: "District", rowHeader: true },
                { key: "hours_plan", header: "Planned hours", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                { key: "hours_regular", header: "Regular hours", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                { key: "hours_overtime", header: "Overtime hours", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
              ]}
              legend={[
                { name: "Regular", seriesIndex: 0 },
                { name: "Overtime", seriesIndex: 2 },
              ]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="labor-hours-by-district"
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={byDistrict} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <ChartPatterns />
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="district" tick={{ fill: CHART_TOKENS.axis }} />
                    <YAxis tickFormatter={(v: number) => formatCompact(v)} width={48} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip formatter={(v) => formatNumber(Number(v), { integer: true })} />
                    <Bar name="Regular" dataKey="hours_regular" stackId="h" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
                    <Bar name="Overtime" dataKey="hours_overtime" stackId="h" fill={`url(#${SERIES[2].patternId})`} stroke={SERIES[2].color} isAnimationActive={!reducedMotion} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>

        <QueryBoundary query={ci} label="Loading facility condition" variant="chart">
          {(data) => (
            <Figure
              title="Facility condition index distribution"
              description={`BUILDER components by CI band; ${formatNumber(data.buckets.find((b) => b.band === "poor")?.count ?? 0, { integer: true })} components are in poor condition.`}
              data={data.buckets}
              columns={[
                { key: "label", header: "CI band", rowHeader: true },
                { key: "count", header: "Components", numeric: true },
                { key: "deficiency_cost", header: "Deficiency cost", numeric: true, format: (v) => formatCurrency(v as number) },
              ]}
              legend={[{ name: "Components", seriesIndex: 3 }]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="facility-ci-distribution"
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={data.buckets} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <ChartPatterns />
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="label" tick={{ fill: CHART_TOKENS.axis }} />
                    <YAxis allowDecimals={false} width={40} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip labelFormatter={(l) => { const b = data.buckets.find((x) => x.label === l); return b ? `CI ${b.label} (${b.band})` : String(l); }} />
                    <Bar name="Components" dataKey="count" fill={`url(#${SERIES[3].patternId})`} stroke={SERIES[3].color} isAnimationActive={!reducedMotion} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>
      </div>
    </PageFrame>
  );
}

export default EnterpriseOverview;
