import { useEffect, useId, useMemo, useRef, useState, type DragEvent, type KeyboardEvent } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Alert, Button } from "@trussworks/react-uswds";
import { Link } from "react-router";
import { AsOfBadge, DataTable, FilterBar, StatusChip } from "../components";
import { KANBAN_COLUMNS, kanbanColumnId, useKanbanMove, useMilestones, useProjects, type Schemas } from "../hooks/useApi";
import { useRole } from "../hooks/useRole";
import { useUrlFilters } from "../hooks/useUrlFilters";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatDate, formatPercentValue } from "../lib/format";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";
import { formatDays, healthOf, milestoneOf, options, uniqueSorted } from "./shared/health";

type Project = Schemas["Project"];
type ProjectMilestone = Schemas["ProjectMilestone"];

const FILTER_KEYS = ["district", "program_code", "phase"] as const;

const slipColumns: ColumnDef<ProjectMilestone, unknown>[] = [
  { id: "p2_project_no", accessorKey: "p2_project_no", header: "P2 number" },
  { id: "project_name", accessorKey: "project_name", header: "Project" },
  { id: "name", accessorKey: "name", header: "Milestone" },
  { id: "district", accessorKey: "district", header: "District" },
  { id: "baseline_date", accessorKey: "baseline_date", header: "Baseline", cell: (c) => formatDate(c.getValue<string | null>()) },
  { id: "current_date", accessorKey: "current_date", header: "Current", cell: (c) => formatDate(c.getValue<string | null>()) },
  { id: "slip_days", accessorKey: "slip_days", header: "Slip", meta: { numeric: true }, cell: (c) => formatDays(c.getValue<number | null>()) },
  { id: "status", accessorKey: "status", header: "Status", cell: (c) => { const s = milestoneOf(c.getValue<string>()); return <StatusChip status={s.status} label={s.label} />; } },
];

/** APEX page 4 (Kanban): columns by percent complete band, keyboard "Move to" menu plus drag as an enhancement, slip list. */
export function Schedule() {
  const { values, apply, reset } = useUrlFilters(FILTER_KEYS);
  const { canWrite } = useRole();
  const { announce } = useAnnounce();
  const query = useMemo(() => ({ district: values.district || undefined, program_code: values.program_code || undefined, phase: values.phase || undefined, limit: 500 }), [values.district, values.program_code, values.phase]);
  const projects = useProjects(query);
  const all = useProjects({ limit: 500 });
  const milestones = useMilestones({ status: "slipped", sort: "-slip_days", limit: 100 });
  const move = useKanbanMove(["projects", query]);
  const [error, setError] = useState<string | null>(null);
  const [overColumn, setOverColumn] = useState<number | null>(null);

  const doMove = (project: Project, columnId: number) => {
    const target = KANBAN_COLUMNS.find((c) => c.id === columnId)!;
    setError(null);
    move.mutate(
      { p2ProjectNo: project.p2_project_no, columnId },
      {
        onSuccess: () => announce(`${project.p2_project_no} moved to ${target.heading}.`),
        onError: (err) => {
          const msg = err.status === 403 ? `Move refused: role evs_pm is required. ${project.p2_project_no} was put back.` : `Move failed (${err.referenceId}). ${project.p2_project_no} was put back.`;
          setError(msg);
          announce(msg, "assertive");
        },
      },
    );
  };

  const onDrop = (e: DragEvent, columnId: number) => {
    e.preventDefault();
    setOverColumn(null);
    const p2 = e.dataTransfer.getData("text/plain");
    const project = projects.data?.items.find((p) => p.p2_project_no === p2);
    if (project && kanbanColumnId(project.pct_complete) !== columnId) doMove(project, columnId);
  };

  const base = all.data?.items ?? [];
  const fields = [
    { id: "district", label: "District", type: "select" as const, options: options(uniqueSorted(base, (r) => r.district)) },
    { id: "program_code", label: "Program code", type: "select" as const, options: options(uniqueSorted(base, (r) => r.program_code)) },
    { id: "phase", label: "Phase", type: "select" as const, options: options(uniqueSorted(base, (r) => r.phase)) },
  ];

  return (
    <PageFrame path="/schedule" intro="Kanban board over percent complete bands (the APEX page 4 columns), with a keyboard move menu on every card. Dragging is optional; the menu is the accessible path.">
      <FilterBar className="evs-leadership-hide" legend="Board filters" fields={fields} values={{ district: values.district ?? "", program_code: values.program_code ?? "", phase: values.phase ?? "" }} onApply={apply} onReset={reset} resultCount={projects.data?.page.total ?? null} resultNoun="projects on the board" />
      {!canWrite && <Alert type="info" slim className="margin-top-2">Read only: the current role can view the board but not move cards. Choose a project manager role in the header to move cards.</Alert>}
      {error && <Alert type="error" slim role="alert" className="margin-top-2">{error}</Alert>}

      <QueryBoundary query={projects} label="Loading Kanban board" variant="kpi" isEmpty={(d) => d.items.length === 0} emptyMessage="No projects match these filters.">
        {(data) => (
          <section aria-labelledby="board-heading" className="margin-top-3">
            <h2 id="board-heading" className="evs-sr-only">Kanban board</h2>
            <p className="margin-top-0"><AsOfBadge asOf={data.as_of} tickMs={0} /></p>
            <ul className="evs-kanban">
              {KANBAN_COLUMNS.map((col) => {
                const cards = data.items.filter((p) => kanbanColumnId(p.pct_complete) === col.id);
                return (
                  // Drop targets are an enhancement over the "Move to" menu (WCAG 2.5.7 single pointer alternative).
                  // eslint-disable-next-line jsx-a11y/no-noninteractive-element-interactions
                  <li
                    key={col.id}
                    className={["evs-kanban__column", overColumn === col.id && "evs-kanban__column--over"].filter(Boolean).join(" ")}
                    aria-labelledby={`col-${col.id}`}
                    onDragOver={canWrite ? (e) => { e.preventDefault(); setOverColumn(col.id); } : undefined}
                    onDragLeave={canWrite ? () => setOverColumn(null) : undefined}
                    onDrop={canWrite ? (e) => onDrop(e, col.id) : undefined}
                  >
                    <h3 id={`col-${col.id}`} className="evs-kanban__heading">{col.heading} <span className="text-normal">({cards.length})</span></h3>
                    <p className="evs-kanban__range">{col.range}% complete</p>
                    <ul className="evs-kanban__cards" aria-label={`${col.heading} cards`}>
                      {cards.map((p) => (
                        <KanbanCard key={p.p2_project_no} project={p} columnId={col.id} canWrite={canWrite} saving={move.isPending && move.variables?.p2ProjectNo === p.p2_project_no} onMove={(target) => doMove(p, target)} />
                      ))}
                      {cards.length === 0 && <li className="font-body-2xs evs-muted">No cards</li>}
                    </ul>
                  </li>
                );
              })}
            </ul>
          </section>
        )}
      </QueryBoundary>

      <section className="evs-section" aria-labelledby="slip-heading">
        <h2 id="slip-heading" className="evs-section__heading">Milestone slip list</h2>
        <QueryBoundary query={milestones} label="Loading slipped milestones" isEmpty={(d) => d.items.length === 0} emptyTitle="No slipped milestones" emptyMessage="Every P2 milestone is on or ahead of its baseline date.">
          {(data) => (
            <DataTable
              caption={`Slipped milestones (${data.page.total})`}
              captionMeta={<AsOfBadge asOf={data.as_of} tickMs={0} />}
              columns={slipColumns}
              data={data.items}
              getRowId={(r) => `${r.p2_project_no}-${r.code}`}
              rowHeaderColumnId="p2_project_no"
              getRowHref={(r) => `/projects/${encodeURIComponent(r.p2_project_no)}`}
              pageSize={10}
              initialSorting={[{ id: "slip_days", desc: true }]}
            />
          )}
        </QueryBoundary>
      </section>
    </PageFrame>
  );
}

interface CardProps {
  project: Project;
  columnId: number;
  canWrite: boolean;
  saving: boolean;
  onMove: (columnId: number) => void;
}

function KanbanCard({ project, columnId, canWrite, saving, onMove }: CardProps) {
  const id = useId();
  const [open, setOpen] = useState(false);
  const [dragging, setDragging] = useState(false);
  const buttonRef = useRef<HTMLButtonElement>(null);
  const menuRef = useRef<HTMLUListElement>(null);
  const health = healthOf(project.schedule_health);
  const targets = KANBAN_COLUMNS.filter((c) => c.id !== columnId);

  useEffect(() => {
    if (!open) return;
    menuRef.current?.querySelector<HTMLElement>("[role=menuitem]")?.focus();
    const onDoc = (e: MouseEvent) => {
      if (!menuRef.current?.contains(e.target as Node) && e.target !== buttonRef.current) setOpen(false);
    };
    document.addEventListener("mousedown", onDoc);
    return () => document.removeEventListener("mousedown", onDoc);
  }, [open]);

  const close = (refocus = true) => {
    setOpen(false);
    if (refocus) buttonRef.current?.focus();
  };
  const onMenuKey = (e: KeyboardEvent<HTMLUListElement>) => {
    const items = [...(menuRef.current?.querySelectorAll<HTMLElement>("[role=menuitem]") ?? [])];
    const i = items.indexOf(document.activeElement as HTMLElement);
    if (e.key === "Escape") { e.preventDefault(); e.stopPropagation(); close(); }
    else if (e.key === "ArrowDown") { e.preventDefault(); items[(i + 1) % items.length]?.focus(); }
    else if (e.key === "ArrowUp") { e.preventDefault(); items[(i - 1 + items.length) % items.length]?.focus(); }
    else if (e.key === "Home") { e.preventDefault(); items[0]?.focus(); }
    else if (e.key === "End") { e.preventDefault(); items.at(-1)?.focus(); }
    else if (e.key === "Tab") close(false);
  };

  return (
    // Drag start is an enhancement; the "Move to" menu is the keyboard path.
    // eslint-disable-next-line jsx-a11y/no-noninteractive-element-interactions
    <li
      className={["evs-kanban__card", dragging && "evs-kanban__card--dragging", saving && "evs-kanban__card--saving"].filter(Boolean).join(" ")}
      draggable={canWrite}
      onDragStart={canWrite ? (e) => { e.dataTransfer.setData("text/plain", project.p2_project_no); e.dataTransfer.effectAllowed = "move"; setDragging(true); } : undefined}
      onDragEnd={canWrite ? () => setDragging(false) : undefined}
      aria-busy={saving || undefined}
    >
      <p className="evs-kanban__card-title"><Link to={`/projects/${encodeURIComponent(project.p2_project_no)}`} className="usa-link">{project.name}</Link></p>
      <p className="evs-kanban__card-meta">{project.p2_project_no}, {project.district}, {formatPercentValue(project.pct_complete, true)}</p>
      <StatusChip status={health.status} label={health.label} />
      {canWrite && (
        <div className="evs-kanban__menu margin-top-1">
          <Button ref={buttonRef} type="button" outline id={`${id}-btn`} aria-haspopup="menu" aria-expanded={open} aria-controls={`${id}-menu`} onClick={() => setOpen((o) => !o)} onKeyDown={(e) => { if (e.key === "ArrowDown" && !open) { e.preventDefault(); setOpen(true); } else if (e.key === "Escape" && open) { e.preventDefault(); close(); } }} disabled={saving}>
            {saving ? "Moving" : "Move to"}
            <span className="evs-sr-only"> {project.p2_project_no} to another column</span>
          </Button>
          {open && (
            // WAI-ARIA menu button pattern: the list is the menu, items are buttons.
            // eslint-disable-next-line jsx-a11y/no-noninteractive-element-to-interactive-role
            <ul ref={menuRef} id={`${id}-menu`} role="menu" aria-labelledby={`${id}-btn`} className="evs-kanban__menu-list" onKeyDown={onMenuKey}>
              {targets.map((t) => (
                <li key={t.id} role="none">
                  <button type="button" role="menuitem" className="evs-kanban__menu-item" onClick={() => { close(); onMove(t.id); }}>
                    Move to {t.heading} ({t.range}%)
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </li>
  );
}

export default Schedule;
