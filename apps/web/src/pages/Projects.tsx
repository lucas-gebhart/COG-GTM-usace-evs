import { useMemo, useState } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Button, Icon } from "@trussworks/react-uswds";
import { AsOfBadge, DataTable, FilterBar, StatusChip } from "../components";
import { downloadServerCsv, useProjects, type Schemas } from "../hooks/useApi";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatDate, formatPercentValue } from "../lib/format";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { daysBetween, formatDays, healthOf, options, uniqueSorted } from "./shared/health";

type Project = Schemas["Project"];

const FILTER_KEYS = ["program_code", "district", "division", "business_line", "phase", "q"] as const;

const columns: ColumnDef<Project, unknown>[] = [
  { id: "p2_project_no", accessorKey: "p2_project_no", header: "P2 number" },
  { id: "name", accessorKey: "name", header: "Project" },
  { id: "district", accessorKey: "district", header: "District" },
  { id: "division", accessorKey: "division", header: "Division" },
  { id: "business_line", accessorKey: "business_line", header: "Business line" },
  { id: "phase", accessorKey: "phase", header: "Phase" },
  { id: "pct_complete", accessorKey: "pct_complete", header: "Complete", meta: { numeric: true }, cell: (c) => formatPercentValue(c.getValue<number>(), true) },
  { id: "baseline_finish", accessorKey: "baseline_finish", header: "Baseline finish", cell: (c) => formatDate(c.getValue<string>()) },
  { id: "current_finish", accessorKey: "current_finish", header: "Current finish", cell: (c) => formatDate(c.getValue<string>()) },
  { id: "variance_days", accessorFn: (r) => daysBetween(r.baseline_finish, r.current_finish) ?? 0, header: "Variance", meta: { numeric: true }, cell: (c) => formatDays(c.getValue<number>()) },
  { id: "schedule_health", accessorKey: "schedule_health", header: "Schedule health", cell: (c) => { const h = healthOf(c.getValue<string>()); return <StatusChip status={h.status} label={h.label} />; } },
];

/** APEX page 86 (Projects IR), the page migrated live on stage: FilterBar + DataTable over useProjects. */
export function Projects() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const { announce } = useAnnounce();
  const [exporting, setExporting] = useState(false);
  const query = useMemo(
    () => ({ program_code: values.program_code || undefined, district: values.district || undefined, division: values.division || undefined, business_line: values.business_line || undefined, phase: values.phase || undefined, q: values.q || undefined, limit: 500 }),
    [values.program_code, values.district, values.division, values.business_line, values.phase, values.q],
  );
  const projects = useProjects(query);
  const all = useProjects({ limit: 500 });
  const rows = all.data?.items ?? [];

  const exportCsv = async () => {
    setExporting(true);
    try {
      await downloadServerCsv("/api/v1/projects", { ...query, limit: undefined }, "projects.csv");
      announce("Projects CSV download started");
    } catch {
      announce("CSV export failed", "assertive");
    } finally {
      setExporting(false);
    }
  };

  const fields = [
    { id: "district", label: "District", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.district)) },
    { id: "division", label: "Division", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.division)) },
    { id: "business_line", label: "Business line", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.business_line)) },
    { id: "phase", label: "Phase", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.phase)) },
    { id: "program_code", label: "Program code", type: "select" as const, options: options(uniqueSorted(rows, (r) => r.program_code)) },
    { id: "q", label: "Search", type: "search" as const, placeholder: "P2 number or name" },
  ];

  return (
    <PageFrame
      path="/projects"
      intro="P2 projects with baseline and current finish, percent complete and schedule health. Filters are saved in the page address."
      actions={
        <Button type="button" outline onClick={() => void exportCsv()} disabled={exporting}>
          <Icon.FileDownload aria-hidden="true" focusable={false} />
          {exporting ? "Preparing CSV" : "Export CSV (server)"}
        </Button>
      }
    >
      <FilterBar legend="Project filters" fields={fields} values={Object.fromEntries(FILTER_KEYS.map((k) => [k, values[k] ?? ""]))} onApply={(v) => apply(v)} onReset={reset} resultCount={projects.data?.page.total ?? null} resultNoun="projects" />
      <QueryBoundary query={projects} label="Loading projects" isEmpty={(d) => d.items.length === 0} emptyMessage="No projects match these filters. Reset the filters to see all projects.">
        {(data) => (
          <DataTable
            caption="Projects"
            captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
            columns={columns}
            data={data.items}
            getRowId={(r) => r.p2_project_no}
            rowHeaderColumnId="p2_project_no"
            getRowHref={(r) => `/projects/${encodeURIComponent(r.p2_project_no)}`}
            pageSize={15}
            initialSorting={[{ id: "variance_days", desc: true }]}
            className="margin-top-2"
          />
        )}
      </QueryBoundary>
    </PageFrame>
  );
}

export default Projects;
