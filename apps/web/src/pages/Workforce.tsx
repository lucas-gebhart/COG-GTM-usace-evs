import { useMemo, useState } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Button, Icon } from "@trussworks/react-uswds";
import { Bar, BarChart, CartesianGrid, Line, ComposedChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge, DataTable, Figure, FilterBar, StatusChip } from "../components";
import { downloadServerCsv, useLaborRows, type Schemas } from "../hooks/useApi";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatCompact, formatCurrency, formatNumber, formatPercentValue } from "../lib/format";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../theme";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { options, uniqueSorted } from "./shared/health";

type LaborRow = Schemas["LaborRow"];
interface Row extends LaborRow {
  utilization: number;
  overtime_share: number;
}

const FILTER_KEYS = ["district", "pay_period"] as const;
/** Overtime above this share of planned hours is flagged (EMS supervisory review threshold in the demo). */
const OVERTIME_FLAG = 0.05;

function overtimeChip(share: number) {
  if (share >= OVERTIME_FLAG * 2) return <StatusChip status="closed" label={`Overtime high ${formatPercentValue(share)}`} />;
  if (share >= OVERTIME_FLAG) return <StatusChip status="delayed" label={`Overtime flag ${formatPercentValue(share)}`} />;
  return <StatusChip status="operating" label={`Within plan ${formatPercentValue(share)}`} />;
}

const columns: ColumnDef<Row, unknown>[] = [
  { id: "district", accessorKey: "district", header: "District" },
  { id: "pay_period", accessorKey: "pay_period", header: "Pay period" },
  { id: "hours_plan", accessorKey: "hours_plan", header: "Planned hours", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>(), { integer: true }) },
  { id: "hours_regular", accessorKey: "hours_regular", header: "Regular hours", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>(), { integer: true }) },
  { id: "hours_overtime", accessorKey: "hours_overtime", header: "Overtime hours", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>(), { integer: true }) },
  { id: "utilization", accessorKey: "utilization", header: "Utilization", meta: { numeric: true }, cell: (c) => formatPercentValue(c.getValue<number>()) },
  { id: "labor_cost", accessorKey: "labor_cost", header: "Labor cost", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "overtime_share", accessorKey: "overtime_share", header: "Overtime flag", cell: (c) => overtimeChip(c.getValue<number>()) },
];

/** APEX page 74 (People): EMS labor hours by district and pay period with utilization and overtime flag. */
export function Workforce() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const { announce } = useAnnounce();
  const [exporting, setExporting] = useState(false);
  const query = useMemo(() => ({ district: values.district || undefined, pay_period: values.pay_period || undefined, limit: 500 }), [values.district, values.pay_period]);
  const labor = useLaborRows(query);
  const all = useLaborRows({ limit: 500 });

  const rows = useMemo<Row[]>(
    () => (labor.data?.rows ?? []).map((r) => ({ ...r, utilization: r.hours_plan ? (r.hours_regular + r.hours_overtime) / r.hours_plan : 0, overtime_share: r.hours_plan ? r.hours_overtime / r.hours_plan : 0 })),
    [labor.data],
  );
  const byPeriod = useMemo(() => {
    const agg = new Map<string, { pay_period: string; hours_plan: number; hours_regular: number; hours_overtime: number }>();
    for (const r of rows) {
      const c = agg.get(r.pay_period) ?? { pay_period: r.pay_period, hours_plan: 0, hours_regular: 0, hours_overtime: 0 };
      c.hours_plan += r.hours_plan;
      c.hours_regular += r.hours_regular;
      c.hours_overtime += r.hours_overtime;
      agg.set(r.pay_period, c);
    }
    return [...agg.values()].sort((a, b) => a.pay_period.localeCompare(b.pay_period));
  }, [rows]);
  const byDistrict = useMemo(() => {
    const agg = new Map<string, { district: string; hours_plan: number; worked: number; overtime: number }>();
    for (const r of rows) {
      const c = agg.get(r.district) ?? { district: r.district, hours_plan: 0, worked: 0, overtime: 0 };
      c.hours_plan += r.hours_plan;
      c.worked += r.hours_regular + r.hours_overtime;
      c.overtime += r.hours_overtime;
      agg.set(r.district, c);
    }
    return [...agg.values()].map((c) => ({ ...c, utilization_pct: c.hours_plan ? (100 * c.worked) / c.hours_plan : 0, overtime_pct: c.hours_plan ? (100 * c.overtime) / c.hours_plan : 0 })).sort((a, b) => b.utilization_pct - a.utilization_pct);
  }, [rows]);

  const exportCsv = async () => {
    setExporting(true);
    try {
      await downloadServerCsv("/api/v1/workforce/labor", { district: values.district, pay_period: values.pay_period }, "labor.csv");
      announce("Labor CSV download started");
    } catch {
      announce("CSV export failed", "assertive");
    } finally {
      setExporting(false);
    }
  };

  const base = all.data?.rows ?? [];
  const fields = [
    { id: "district", label: "District", type: "select" as const, options: options(uniqueSorted(base, (r) => r.district)) },
    { id: "pay_period", label: "Pay period", type: "select" as const, options: options(uniqueSorted(base, (r) => r.pay_period)) },
  ];

  return (
    <PageFrame
      path="/workforce"
      intro="EMS labor hours against plan by district and pay period. Utilization is hours worked over planned hours; overtime above 5 percent of plan is flagged."
      actions={
        <Button type="button" outline onClick={() => void exportCsv()} disabled={exporting}>
          <Icon.FileDownload aria-hidden="true" focusable={false} />
          {exporting ? "Preparing CSV" : "Export CSV (server)"}
        </Button>
      }
    >
      <FilterBar className="evs-leadership-hide" legend="Labor filters" fields={fields} values={{ district: values.district ?? "", pay_period: values.pay_period ?? "" }} onApply={apply} onReset={reset} resultCount={labor.data?.page?.total ?? null} resultNoun="labor rows" />

      <QueryBoundary query={labor} label="Loading labor hours" variant="chart" isEmpty={(d) => d.rows.length === 0} emptyMessage="No labor rows match these filters.">
        {(data) => (
          <>
            <div className="evs-grid evs-grid--2 margin-top-3">
              <Figure
                title={`Hours by pay period, FY${data.fiscal_year}${values.district ? `, ${values.district}` : ""}`}
                description={`Regular and overtime hours stacked against the planned line for ${byPeriod.length} pay periods.`}
                data={byPeriod}
                columns={[
                  { key: "pay_period", header: "Pay period", rowHeader: true },
                  { key: "hours_plan", header: "Planned", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                  { key: "hours_regular", header: "Regular", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                  { key: "hours_overtime", header: "Overtime", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                ]}
                legend={[{ name: "Regular", seriesIndex: 0 }, { name: "Overtime", seriesIndex: 2 }, { name: "Planned", seriesIndex: 4 }]}
                footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
                headingLevel={2}
                csvName="hours-by-pay-period"
              >
                {({ reducedMotion }) => (
                  <ResponsiveContainer width="100%" height="100%">
                    <ComposedChart data={byPeriod} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                      <ChartPatterns />
                      <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                      <XAxis dataKey="pay_period" tick={{ fill: CHART_TOKENS.axis, fontSize: 11 }} />
                      <YAxis tickFormatter={(v: number) => formatCompact(v)} width={48} tick={{ fill: CHART_TOKENS.axis }} />
                      <Tooltip formatter={(v) => formatNumber(Number(v), { integer: true })} />
                      <Bar name="Regular" dataKey="hours_regular" stackId="h" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
                      <Bar name="Overtime" dataKey="hours_overtime" stackId="h" fill={`url(#${SERIES[2].patternId})`} stroke={SERIES[2].color} isAnimationActive={!reducedMotion} />
                      <Line name="Planned" dataKey="hours_plan" stroke={SERIES[4].color} strokeDasharray={SERIES[4].strokeDasharray} strokeWidth={2} dot={false} isAnimationActive={!reducedMotion} />
                    </ComposedChart>
                  </ResponsiveContainer>
                )}
              </Figure>

              <Figure
                title="Utilization by district"
                description={`Hours worked as a percent of planned hours; ${byDistrict.filter((d) => d.overtime_pct >= OVERTIME_FLAG * 100).length} of ${byDistrict.length} districts exceed the 5 percent overtime flag.`}
                data={byDistrict}
                columns={[
                  { key: "district", header: "District", rowHeader: true },
                  { key: "utilization_pct", header: "Utilization", numeric: true, format: (v) => formatPercentValue(v as number, true) },
                  { key: "overtime_pct", header: "Overtime share", numeric: true, format: (v) => formatPercentValue(v as number, true) },
                  { key: "hours_plan", header: "Planned hours", numeric: true, format: (v) => formatNumber(v as number, { integer: true }) },
                ]}
                legend={[{ name: "Utilization", seriesIndex: 0 }, { name: "Overtime share", seriesIndex: 2 }]}
                footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
                headingLevel={2}
                csvName="utilization-by-district"
              >
                {({ reducedMotion }) => (
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={byDistrict} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                      <ChartPatterns />
                      <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                      <XAxis dataKey="district" tick={{ fill: CHART_TOKENS.axis }} />
                      <YAxis tickFormatter={(v: number) => `${v}%`} width={48} tick={{ fill: CHART_TOKENS.axis }} />
                      <Tooltip formatter={(v) => formatPercentValue(Number(v), true)} />
                      <Bar name="Utilization" dataKey="utilization_pct" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
                      <Bar name="Overtime share" dataKey="overtime_pct" fill={`url(#${SERIES[2].patternId})`} stroke={SERIES[2].color} isAnimationActive={!reducedMotion} />
                    </BarChart>
                  </ResponsiveContainer>
                )}
              </Figure>
            </div>

            <DataTable
              caption="EMS labor by district and pay period"
              captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              columns={columns}
              data={rows}
              getRowId={(r) => `${r.district}-${r.pay_period}`}
              rowHeaderColumnId="district"
              pageSize={15}
              initialSorting={[{ id: "overtime_share", desc: true }]}
              className="margin-top-3"
            />
          </>
        )}
      </QueryBoundary>
    </PageFrame>
  );
}

export default Workforce;
