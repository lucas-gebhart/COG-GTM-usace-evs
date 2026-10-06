import { useMemo } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Bar, BarChart, CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge, DataTable, Figure, FilterBar, StatusChip } from "../components";
import { useFinancialSummary, useVarianceByProgram, type Schemas } from "../hooks/useApi";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { formatCompact, formatCurrency, formatDate, formatPercent } from "../lib/format";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../theme";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { options, uniqueSorted } from "./shared/health";

type Variance = Schemas["ProgramVariance"];

const FILTER_KEYS = ["fiscal_year", "appropriation", "division"] as const;
const FISCAL_YEARS = [2026, 2025];

function varianceChip(pct: number) {
  if (pct <= -10) return <StatusChip status="closed" label={`Behind plan ${formatPercent(pct, true)}`} />;
  if (pct < 0) return <StatusChip status="delayed" label={`Slightly behind ${formatPercent(pct, true)}`} />;
  return <StatusChip status="operating" label={`On or ahead ${formatPercent(pct, true)}`} />;
}

const varianceColumns: ColumnDef<Variance, unknown>[] = [
  { id: "program_code", accessorKey: "program_code", header: "Program" },
  { id: "name", accessorKey: "name", header: "Name" },
  { id: "division", accessorKey: "division", header: "Division" },
  { id: "funded_amount", accessorKey: "funded_amount", header: "Funded", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "plan_to_date", accessorKey: "plan_to_date", header: "Plan to date", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "obligated_amount", accessorKey: "obligated_amount", header: "Obligated", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "variance_amount", accessorKey: "variance_amount", header: "Variance", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "variance_pct", accessorKey: "variance_pct", header: "Variance status", cell: (c) => varianceChip(c.getValue<number>()) },
];

/** APEX page 161 (Cumulative Flow JET chart): execution curve, by appropriation, variance by program. */
export function Financial() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const fy = Number(values.fiscal_year) || FISCAL_YEARS[0];
  const summary = useFinancialSummary(fy);
  const variance = useVarianceByProgram(fy);

  const appropriations = useMemo(() => (summary.data?.by_appropriation ?? []).filter((a) => !values.appropriation || a.appropriation === values.appropriation), [summary.data, values.appropriation]);
  const varianceRows = useMemo(() => (variance.data?.rows ?? []).filter((r) => !values.division || r.division === values.division), [variance.data, values.division]);
  const curve = summary.data?.execution_curve ?? [];
  const last = curve.at(-1);

  const fields = [
    { id: "fiscal_year", label: "Fiscal year", type: "select" as const, options: FISCAL_YEARS.map((y) => ({ value: String(y), label: `FY${y}` })) },
    { id: "appropriation", label: "Appropriation", type: "select" as const, options: options(uniqueSorted(summary.data?.by_appropriation ?? [], (a) => a.appropriation)) },
    { id: "division", label: "Division", type: "select" as const, options: options(uniqueSorted(variance.data?.rows ?? [], (r) => r.division)) },
  ];

  return (
    <PageFrame path="/financial" intro="CEFMS obligations and expenditures against the spend plan. Synthetic demo data; district level rollups need a CEFMS district field in the API.">
      <FilterBar className="evs-leadership-hide" legend="Financial filters" fields={fields} values={{ fiscal_year: values.fiscal_year ?? "", appropriation: values.appropriation ?? "", division: values.division ?? "" }} onApply={apply} onReset={reset} />

      <div className="evs-grid evs-grid--2 margin-top-3">
        <QueryBoundary query={summary} label="Loading execution curve" variant="chart">
          {(data) => (
            <Figure
              title={`Cumulative obligations and expenditures by month, FY${data.fiscal_year}`}
              description={last ? `Through ${formatDate(last.period)}: plan ${formatCompact(last.plan_cumulative)}, obligated ${formatCompact(last.obligated_cumulative)}, expended ${formatCompact(last.expended_cumulative)}.` : "No execution curve rows."}
              data={curve}
              columns={[
                { key: "period", header: "Period", rowHeader: true, format: (v) => formatDate(v as string) },
                { key: "plan_cumulative", header: "Plan", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "obligated_cumulative", header: "Obligated", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "expended_cumulative", header: "Expended", numeric: true, format: (v) => formatCurrency(v as number) },
              ]}
              legend={[{ name: "Plan", seriesIndex: 4 }, { name: "Obligated", seriesIndex: 0 }, { name: "Expended", seriesIndex: 1 }]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName={`fy${data.fiscal_year}-execution-curve`}
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

        <QueryBoundary query={summary} label="Loading appropriations" variant="chart" isEmpty={() => appropriations.length === 0} emptyMessage="No appropriation matches the filter.">
          {(data) => (
            <Figure
              title={`Obligated and expended by appropriation, FY${data.fiscal_year}`}
              description={`${appropriations.length} appropriation${appropriations.length === 1 ? "" : "s"}; allotted, obligated and expended totals.`}
              data={appropriations}
              columns={[
                { key: "appropriation", header: "Appropriation", rowHeader: true },
                { key: "allotted", header: "Allotted", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "obligated", header: "Obligated", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "expended", header: "Expended", numeric: true, format: (v) => formatCurrency(v as number) },
                { key: "variance_pct", header: "Variance", numeric: true, format: (v) => formatPercent(v as number, true) },
              ]}
              legend={[{ name: "Funded", seriesIndex: 4 }, { name: "Obligated", seriesIndex: 0 }, { name: "Expended", seriesIndex: 1 }]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName={`fy${data.fiscal_year}-by-appropriation`}
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={appropriations} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <ChartPatterns />
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="appropriation" tick={{ fill: CHART_TOKENS.axis, fontSize: 11 }} />
                    <YAxis tickFormatter={(v: number) => formatCompact(v)} width={56} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip formatter={(v) => formatCurrency(Number(v))} />
                    <Bar name="Allotted" dataKey="allotted" fill={`url(#${SERIES[4].patternId})`} stroke={SERIES[4].color} isAnimationActive={!reducedMotion} />
                    <Bar name="Obligated" dataKey="obligated" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
                    <Bar name="Expended" dataKey="expended" fill={`url(#${SERIES[1].patternId})`} stroke={SERIES[1].color} isAnimationActive={!reducedMotion} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>
      </div>

      <section className="evs-section" aria-labelledby="variance-heading">
        <h2 id="variance-heading" className="evs-section__heading">Variance to plan by program</h2>
        <QueryBoundary query={variance} label="Loading variance by program" isEmpty={() => varianceRows.length === 0} emptyMessage="No programs match the division filter.">
          {(data) => (
            <DataTable
              caption={`Obligation variance to plan, FY${data.fiscal_year}`}
              captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              columns={varianceColumns}
              data={varianceRows}
              getRowId={(r) => r.program_code}
              rowHeaderColumnId="program_code"
              getRowHref={(r) => `/projects?program_code=${encodeURIComponent(r.program_code)}`}
              pageSize={10}
              initialSorting={[{ id: "variance_pct", desc: false }]}
            />
          )}
        </QueryBoundary>
      </section>
    </PageFrame>
  );
}

export default Financial;
