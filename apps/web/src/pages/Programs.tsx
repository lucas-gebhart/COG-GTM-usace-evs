import { useMemo, useState } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Button, Checkbox, Icon } from "@trussworks/react-uswds";
import { AsOfBadge, DataTable, FilterBar, StatusChip } from "../components";
import { downloadServerCsv, usePrograms, type Schemas } from "../hooks/useApi";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatCurrency, formatNumber, formatPercentValue } from "../lib/format";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { healthOf, options, uniqueSorted } from "./shared/health";

type Program = Schemas["Program"];

const FILTER_KEYS = ["division", "business_line", "schedule_health", "q", "cols"] as const;

const ALL_COLUMNS: { id: string; header: string; def: ColumnDef<Program, unknown> }[] = [
  { id: "program_code", header: "Program code", def: { id: "program_code", accessorKey: "program_code", header: "Program code" } },
  { id: "name", header: "Program", def: { id: "name", accessorKey: "name", header: "Program" } },
  { id: "business_line", header: "Business line", def: { id: "business_line", accessorKey: "business_line", header: "Business line" } },
  { id: "division", header: "Division (appropriation owner)", def: { id: "division", accessorKey: "division", header: "Division" } },
  { id: "funded_amount", header: "FY budget", def: { id: "funded_amount", accessorKey: "funded_amount", header: "FY budget", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) } },
  { id: "obligated_amount", header: "Obligated", def: { id: "obligated_amount", accessorKey: "obligated_amount", header: "Obligated", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()) } },
  {
    id: "pct_obligated",
    header: "Percent obligated",
    def: { id: "pct_obligated", accessorFn: (r) => (r.funded_amount ? r.obligated_amount / r.funded_amount : 0), header: "Percent obligated", meta: { numeric: true }, cell: (c) => formatPercentValue(c.getValue<number>()) },
  },
  { id: "project_count", header: "Projects", def: { id: "project_count", accessorKey: "project_count", header: "Projects", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>(), { integer: true }) } },
  {
    id: "schedule_health",
    header: "Schedule health",
    def: { id: "schedule_health", accessorKey: "schedule_health", header: "Schedule health", cell: (c) => { const h = healthOf(c.getValue<string>()); return <StatusChip status={h.status} label={h.label} />; } },
  },
];
const DEFAULT_HIDDEN = new Set(["name"]);

/** APEX page 21 (Initiatives IR): server filtered programs table with column chooser and server CSV export. */
export function Programs() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const { announce } = useAnnounce();
  const [exporting, setExporting] = useState(false);
  const query = useMemo(
    () => ({ division: values.division || undefined, business_line: values.business_line || undefined, schedule_health: values.schedule_health || undefined, q: values.q || undefined, limit: 500 }),
    [values.division, values.business_line, values.schedule_health, values.q],
  );
  const programs = usePrograms(query);
  const all = usePrograms({ limit: 500 });

  const visible = useMemo(() => {
    if (values.cols) return new Set(values.cols.split(",").filter(Boolean));
    return new Set(ALL_COLUMNS.map((c) => c.id).filter((id) => !DEFAULT_HIDDEN.has(id)));
  }, [values.cols]);
  const toggleColumn = (id: string) => {
    const next = new Set(visible);
    if (next.has(id)) {
      if (next.size === 1) return;
      next.delete(id);
    } else next.add(id);
    apply({ ...values, cols: ALL_COLUMNS.map((c) => c.id).filter((c) => next.has(c)).join(",") });
  };
  const columns = useMemo(() => ALL_COLUMNS.filter((c) => visible.has(c.id)).map((c) => c.def), [visible]);

  const exportCsv = async () => {
    setExporting(true);
    try {
      await downloadServerCsv("/api/v1/programs", { division: values.division, business_line: values.business_line, schedule_health: values.schedule_health, q: values.q }, "programs.csv");
      announce("Programs CSV download started");
    } catch {
      announce("CSV export failed", "assertive");
    } finally {
      setExporting(false);
    }
  };

  const rows = all.data?.items ?? [];
  const fields = [
    { id: "division", label: "Division", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.division)) },
    { id: "business_line", label: "Business line", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.business_line)) },
    { id: "schedule_health", label: "Schedule health", type: "select" as const, options: [{ value: "on_track", label: "On track" }, { value: "at_risk", label: "At risk" }, { value: "late", label: "Late" }] },
    { id: "q", label: "Search", type: "search" as const, placeholder: "Program code or name" },
  ];

  return (
    <PageFrame
      path="/programs"
      intro="Program level funding and execution from CEFMS with P2 schedule health. Filters are saved in the page address."
      actions={
        <Button type="button" outline onClick={() => void exportCsv()} disabled={exporting}>
          <Icon.FileDownload aria-hidden="true" focusable={false} />
          {exporting ? "Preparing CSV" : "Export CSV (server)"}
        </Button>
      }
    >
      <FilterBar legend="Program filters" fields={fields} values={{ division: values.division ?? "", business_line: values.business_line ?? "", schedule_health: values.schedule_health ?? "", q: values.q ?? "" }} onApply={(v) => apply({ ...values, ...v })} onReset={() => reset()} resultCount={programs.data?.page.total ?? null} resultNoun="programs" />

      <fieldset className="usa-fieldset margin-top-2 evs-leadership-hide">
        <legend className="usa-legend font-body-sm">Columns</legend>
        <div className="grid-row grid-gap-1">
          {ALL_COLUMNS.map((c) => (
            <div key={c.id} className="tablet:grid-col-4 desktop:grid-col-3">
              <Checkbox id={`col-${c.id}`} name="columns" label={c.header} checked={visible.has(c.id)} onChange={() => toggleColumn(c.id)} className="margin-top-0" />
            </div>
          ))}
        </div>
      </fieldset>

      <QueryBoundary query={programs} label="Loading programs" isEmpty={(d) => d.items.length === 0} emptyMessage="No programs match these filters. Reset the filters to see all programs.">
        {(data) => (
          <DataTable
            caption="Programs and portfolio"
            captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
            columns={columns}
            data={data.items}
            getRowId={(r) => r.program_code}
            rowHeaderColumnId={visible.has("program_code") ? "program_code" : columns[0]?.id}
            getRowHref={(r) => `/projects?program_code=${encodeURIComponent(r.program_code)}`}
            pageSize={10}
            initialSorting={[{ id: visible.has("funded_amount") ? "funded_amount" : columns[0]?.id ?? "program_code", desc: visible.has("funded_amount") }]}
            className="margin-top-2"
          />
        )}
      </QueryBoundary>
    </PageFrame>
  );
}

export default Programs;
