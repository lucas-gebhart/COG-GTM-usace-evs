import { useMemo, useState } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Button, Icon } from "@trussworks/react-uswds";
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge, DataTable, Figure, FilterBar, StatusChip } from "../components";
import { downloadServerCsv, useCiDistribution, useFacilities, type Schemas } from "../hooks/useApi";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatCompact, formatCurrency, formatNumber } from "../lib/format";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../theme";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { options, uniqueSorted } from "./shared/health";

type Facility = Schemas["FacilityRow"];

const FILTER_KEYS = ["district", "installation", "component_type", "max_ci"] as const;

function ciChip(ci: number) {
  if (ci < 40) return <StatusChip status="closed" label={`Poor, CI ${formatNumber(ci)}`} />;
  if (ci < 70) return <StatusChip status="delayed" label={`Fair, CI ${formatNumber(ci)}`} />;
  return <StatusChip status="operating" label={`Good, CI ${formatNumber(ci)}`} />;
}

const columns: ColumnDef<Facility, unknown>[] = [
  { id: "building_id", accessorKey: "building_id", header: "Building" },
  { id: "installation", accessorKey: "installation", header: "Installation" },
  { id: "district", accessorKey: "district", header: "District" },
  { id: "uniformat_section", accessorKey: "uniformat_section", header: "UNIFORMAT" },
  { id: "component_type", accessorKey: "component_type", header: "Component" },
  { id: "ci", accessorKey: "ci", header: "Condition", cell: (c) => ciChip(c.getValue<number>()) },
  { id: "bci", accessorKey: "bci", header: "BCI", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>()) },
  { id: "deficiency_cost", accessorKey: "deficiency_cost", header: "Deficiency cost", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) },
  { id: "work_plan_year", accessorKey: "work_plan_year", header: "Work plan year" },
];

/** New page (no APEX source): BUILDER SMS condition index distribution, deficiency cost by work plan year, component table. */
export function Facilities() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const { announce } = useAnnounce();
  const [exporting, setExporting] = useState(false);
  const query = useMemo(
    () => ({ district: values.district || undefined, installation: values.installation || undefined, component_type: values.component_type || undefined, max_ci: values.max_ci ? Number(values.max_ci) : undefined, limit: 500 }),
    [values.district, values.installation, values.component_type, values.max_ci],
  );
  const facilities = useFacilities(query);
  const all = useFacilities({ limit: 500 });
  const distribution = useCiDistribution();

  const byYear = useMemo(() => {
    const agg = new Map<number, { work_plan_year: number; components: number; deficiency_cost: number; poor: number }>();
    for (const r of facilities.data?.rows ?? []) {
      const c = agg.get(r.work_plan_year) ?? { work_plan_year: r.work_plan_year, components: 0, deficiency_cost: 0, poor: 0 };
      c.components += 1;
      c.deficiency_cost += r.deficiency_cost;
      if (r.ci < 40) c.poor += 1;
      agg.set(r.work_plan_year, c);
    }
    return [...agg.values()].sort((a, b) => a.work_plan_year - b.work_plan_year);
  }, [facilities.data]);

  const exportCsv = async () => {
    setExporting(true);
    try {
      await downloadServerCsv("/api/v1/facilities/condition", { ...query, limit: undefined }, "facilities.csv");
      announce("Facilities CSV download started");
    } catch {
      announce("CSV export failed", "assertive");
    } finally {
      setExporting(false);
    }
  };

  const base = all.data?.rows ?? [];
  const fields = [
    { id: "district", label: "District", type: "select" as const, options: options(uniqueSorted(base, (r) => r.district)) },
    { id: "installation", label: "Installation", type: "select" as const, options: options(uniqueSorted(base, (r) => r.installation)) },
    { id: "component_type", label: "Component type", type: "select" as const, options: options(uniqueSorted(base, (r) => r.component_type)) },
    { id: "max_ci", label: "Condition at or below", type: "select" as const, options: [{ value: "39.99", label: "Poor (CI under 40)" }, { value: "69.99", label: "Fair or poor (CI under 70)" }] },
  ];

  return (
    <PageFrame
      path="/facilities"
      intro="BUILDER Sustainment Management System condition index (CI) and building condition index (BCI) for USACE owned components, with deficiency cost by work plan year."
      actions={
        <Button type="button" outline onClick={() => void exportCsv()} disabled={exporting}>
          <Icon.FileDownload aria-hidden="true" focusable={false} />
          {exporting ? "Preparing CSV" : "Export CSV (server)"}
        </Button>
      }
    >
      <FilterBar className="evs-leadership-hide" legend="Facility filters" fields={fields} values={Object.fromEntries(FILTER_KEYS.map((k) => [k, values[k] ?? ""]))} onApply={apply} onReset={reset} resultCount={facilities.data?.page?.total ?? null} resultNoun="components" />

      <div className="evs-grid evs-grid--2 margin-top-3">
        <QueryBoundary query={distribution} label="Loading condition distribution" variant="chart">
          {(data) => (
            <Figure
              title="CI distribution across all BUILDER components"
              description={`${formatNumber(data.buckets.reduce((s, b) => s + b.count, 0), { integer: true })} components; ${formatNumber(data.buckets.find((b) => b.band === "poor")?.count ?? 0, { integer: true })} poor, ${formatNumber(data.buckets.find((b) => b.band === "fair")?.count ?? 0, { integer: true })} fair, ${formatNumber(data.buckets.find((b) => b.band === "good")?.count ?? 0, { integer: true })} good.`}
              data={data.buckets}
              columns={[
                { key: "label", header: "CI band", rowHeader: true },
                { key: "count", header: "Components", numeric: true },
                { key: "deficiency_cost", header: "Deficiency cost", numeric: true, format: (v) => formatCurrency(v as number) },
              ]}
              legend={[{ name: "Components", seriesIndex: 3 }]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="ci-distribution"
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

        <QueryBoundary query={facilities} label="Loading deficiency cost" variant="chart" isEmpty={() => byYear.length === 0} emptyMessage="No components match these filters.">
          {(data) => (
            <Figure
              title="Deficiency cost by work plan year"
              description={`${formatCurrency(byYear.reduce((s, y) => s + y.deficiency_cost, 0))} of deficiency cost across ${byYear.length} work plan years for the filtered components.`}
              data={byYear}
              columns={[
                { key: "work_plan_year", header: "Work plan year", rowHeader: true },
                { key: "components", header: "Components", numeric: true },
                { key: "poor", header: "Poor condition", numeric: true },
                { key: "deficiency_cost", header: "Deficiency cost", numeric: true, format: (v) => formatCurrency(v as number) },
              ]}
              legend={[{ name: "Deficiency cost", seriesIndex: 1 }]}
              footer={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              headingLevel={2}
              csvName="deficiency-cost-by-year"
            >
              {({ reducedMotion }) => (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={byYear} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                    <ChartPatterns />
                    <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                    <XAxis dataKey="work_plan_year" tick={{ fill: CHART_TOKENS.axis }} />
                    <YAxis tickFormatter={(v: number) => formatCompact(v)} width={56} tick={{ fill: CHART_TOKENS.axis }} />
                    <Tooltip formatter={(v) => formatCurrency(Number(v))} />
                    <Bar name="Deficiency cost" dataKey="deficiency_cost" fill={`url(#${SERIES[1].patternId})`} stroke={SERIES[1].color} isAnimationActive={!reducedMotion} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </Figure>
          )}
        </QueryBoundary>
      </div>

      <QueryBoundary query={facilities} label="Loading BUILDER components" isEmpty={(d) => d.rows.length === 0} emptyMessage="No components match these filters.">
        {(data) => (
          <DataTable
            caption="BUILDER components"
            captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
            columns={columns}
            data={data.rows}
            getRowId={(r) => `${r.building_id}-${r.uniformat_section}-${r.component_type}`}
            rowHeaderColumnId="building_id"
            pageSize={15}
            initialSorting={[{ id: "ci", desc: false }]}
            className="margin-top-3"
          />
        )}
      </QueryBoundary>
    </PageFrame>
  );
}

export default Facilities;
