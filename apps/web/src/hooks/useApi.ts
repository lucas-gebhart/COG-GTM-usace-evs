import { useMutation, useQuery, useQueryClient, type UseQueryOptions, type UseQueryResult } from "@tanstack/react-query";
import { api } from "../api/client";
import type { components, paths } from "../api/schema";
import { downloadCsv } from "../lib/csv";

export type Schemas = components["schemas"];
export type AsOf = Schemas["AsOf"];
export type Freshness = AsOf["freshness"];

export type Query<P extends keyof paths> = paths[P] extends { get: { parameters: { query?: infer Q } } } ? NonNullable<Q> : never;

export class ApiError extends Error {
  constructor(
    public status: number,
    public detail: unknown,
    public referenceId: string,
  ) {
    super(typeof detail === "string" ? detail : `Request failed with status ${status}`);
    this.name = "ApiError";
  }
}

export interface ValidationItem {
  item: string;
  message: string;
}

/** APEX style inline validation messages carried by a 422 (`detail: [{item, message}]`). */
export function validationItems(error: unknown): ValidationItem[] {
  if (!(error instanceof ApiError) || error.status !== 422 || !Array.isArray(error.detail)) return [];
  return error.detail.filter((d): d is ValidationItem => typeof d === "object" && d !== null && "message" in d);
}

function referenceId(): string {
  return `EVS-${Date.now().toString(36).toUpperCase()}`;
}

/** Unwraps an openapi-fetch result, throwing ApiError (with a user-facing reference id) on failure. */
export function unwrap<T>(result: { data?: T; error?: unknown; response: Response }): T {
  if (result.error !== undefined || result.data === undefined) {
    const detail = (result.error as { detail?: unknown } | undefined)?.detail ?? result.error ?? "No response body";
    throw new ApiError(result.response.status, detail, referenceId());
  }
  return result.data;
}

type Extra<T> = Omit<UseQueryOptions<T, ApiError>, "queryKey" | "queryFn">;

export function useHealth(extra?: Extra<Record<string, unknown>>) {
  return useQuery<Record<string, unknown>, ApiError>({ queryKey: ["health"], queryFn: async () => unwrap(await api.GET("/api/v1/health")) as Record<string, unknown>, ...extra });
}

export function useEnterpriseKpis(extra?: Extra<Schemas["KpiList"]>) {
  return useQuery<Schemas["KpiList"], ApiError>({ queryKey: ["enterprise-kpis"], queryFn: async () => unwrap(await api.GET("/api/v1/enterprise/kpis")), ...extra });
}

export function usePrograms(query: Query<"/api/v1/programs"> = {}, extra?: Extra<Schemas["ProgramList"]>) {
  return useQuery<Schemas["ProgramList"], ApiError>({ queryKey: ["programs", query], queryFn: async () => unwrap(await api.GET("/api/v1/programs", { params: { query } })), ...extra });
}

export function useProjects(query: Query<"/api/v1/projects"> = {}, extra?: Extra<Schemas["ProjectList"]>) {
  return useQuery<Schemas["ProjectList"], ApiError>({ queryKey: ["projects", query], queryFn: async () => unwrap(await api.GET("/api/v1/projects", { params: { query } })), ...extra });
}

export function useProject(p2ProjectNo: string | undefined, extra?: Extra<Schemas["Project"]>) {
  return useQuery<Schemas["Project"], ApiError>({
    queryKey: ["project", p2ProjectNo],
    queryFn: async () => unwrap(await api.GET("/api/v1/projects/{p2_project_no}", { params: { path: { p2_project_no: p2ProjectNo! } } })),
    enabled: Boolean(p2ProjectNo),
    ...extra,
  });
}

export function useProjectHistory(p2ProjectNo: string | undefined, extra?: Extra<Schemas["ProjectHistoryList"]>) {
  return useQuery<Schemas["ProjectHistoryList"], ApiError>({
    queryKey: ["project-history", p2ProjectNo],
    queryFn: async () => unwrap(await api.GET("/api/v1/projects/{p2_project_no}/history", { params: { path: { p2_project_no: p2ProjectNo! } } })),
    enabled: Boolean(p2ProjectNo),
    ...extra,
  });
}

export function useMilestones(query: Query<"/api/v1/schedule/milestones"> = {}, extra?: Extra<Schemas["MilestoneList"]>) {
  return useQuery<Schemas["MilestoneList"], ApiError>({ queryKey: ["milestones", query], queryFn: async () => unwrap(await api.GET("/api/v1/schedule/milestones", { params: { query } })), ...extra });
}

export function useFinancialSummary(fiscalYear?: number, extra?: Extra<Schemas["FinancialSummary"]>) {
  const query = fiscalYear ? { fiscal_year: fiscalYear } : {};
  return useQuery<Schemas["FinancialSummary"], ApiError>({ queryKey: ["financial-summary", query], queryFn: async () => unwrap(await api.GET("/api/v1/financial/summary", { params: { query } })), ...extra });
}

export function useVarianceByProgram(fiscalYear?: number, extra?: Extra<Schemas["VarianceByProgram"]>) {
  const query = fiscalYear ? { fiscal_year: fiscalYear } : {};
  return useQuery<Schemas["VarianceByProgram"], ApiError>({ queryKey: ["financial-variance", query], queryFn: async () => unwrap(await api.GET("/api/v1/financial/variance-by-program", { params: { query } })), ...extra });
}

export function useLabor(fiscalYear?: number, extra?: Extra<Schemas["LaborSummary"]>) {
  const query = fiscalYear ? { fiscal_year: fiscalYear } : {};
  return useQuery<Schemas["LaborSummary"], ApiError>({ queryKey: ["labor", query], queryFn: async () => unwrap(await api.GET("/api/v1/workforce/labor", { params: { query } })), ...extra });
}

/** EMS labor rows with the Interactive Report parameters (district, pay_period, sort, q, limit). */
export function useLaborRows(query: Query<"/api/v1/workforce/labor"> = {}, extra?: Extra<Schemas["LaborSummary"]>) {
  return useQuery<Schemas["LaborSummary"], ApiError>({ queryKey: ["labor", query], queryFn: async () => unwrap(await api.GET("/api/v1/workforce/labor", { params: { query } })), ...extra });
}

export function useFacilityCondition(extra?: Extra<Schemas["FacilitySummary"]>) {
  return useQuery<Schemas["FacilitySummary"], ApiError>({ queryKey: ["facility-condition"], queryFn: async () => unwrap(await api.GET("/api/v1/facilities/condition")), ...extra });
}

/** BUILDER component rows with the Interactive Report parameters (district, installation, component_type, max_ci). */
export function useFacilities(query: Query<"/api/v1/facilities/condition"> = {}, extra?: Extra<Schemas["FacilitySummary"]>) {
  return useQuery<Schemas["FacilitySummary"], ApiError>({ queryKey: ["facility-condition", query], queryFn: async () => unwrap(await api.GET("/api/v1/facilities/condition", { params: { query } })), ...extra });
}

export function useCiDistribution(extra?: Extra<Schemas["CiDistribution"]>) {
  return useQuery<Schemas["CiDistribution"], ApiError>({ queryKey: ["facility-ci-distribution"], queryFn: async () => unwrap(await api.GET("/api/v1/facilities/ci-distribution")), ...extra });
}

export function useLocks(riverCode?: string | null, extra?: Extra<Schemas["LockList"]>) {
  const query = riverCode ? { river_code: riverCode } : {};
  return useQuery<Schemas["LockList"], ApiError>({ queryKey: ["locks", query], queryFn: async () => unwrap(await api.GET("/api/v1/public/locks", { params: { query } })), ...extra });
}

export function useLock(lockId: string | undefined, extra?: Extra<Schemas["LockDetail"]>) {
  return useQuery<Schemas["LockDetail"], ApiError>({
    queryKey: ["lock", lockId],
    queryFn: async () => unwrap(await api.GET("/api/v1/public/locks/{lock_id}", { params: { path: { lock_id: lockId! } } })),
    enabled: Boolean(lockId),
    ...extra,
  });
}

export function useSrpCoverage(extra?: Extra<Schemas["SrpCoverage"]>) {
  return useQuery<Schemas["SrpCoverage"], ApiError>({ queryKey: ["srp-coverage"], queryFn: async () => unwrap(await api.GET("/api/v1/public/srp/coverage")), ...extra });
}

export function useAccessibilityReadout(extra?: Extra<Schemas["AccessibilityReadout"]>) {
  return useQuery<Schemas["AccessibilityReadout"], ApiError>({ queryKey: ["accessibility-readout"], queryFn: async () => unwrap(await api.GET("/api/v1/accessibility/readout")), ...extra });
}

export function useFeeds(extra?: Extra<Schemas["FeedHealthList"]>) {
  return useQuery<Schemas["FeedHealthList"], ApiError>({ queryKey: ["admin-feeds"], queryFn: async () => unwrap(await api.GET("/api/v1/admin/feeds")), ...extra });
}

export function useThresholds(extra?: Extra<Schemas["Thresholds"]>) {
  return useQuery<Schemas["Thresholds"], ApiError>({ queryKey: ["admin-thresholds"], queryFn: async () => unwrap(await api.GET("/api/v1/admin/thresholds")), ...extra });
}

// Writes (role evs_pm). The API exposes PUT /projects/{p2}/status and POST /projects/{p2}/kanban/move
// (WP3); see the PR description for the PATCH /projects/{p2} naming in the work package brief.

export type ProjectStatusUpdate = Schemas["ProjectStatusUpdate"];
export type ProjectStatusResult = Schemas["ProjectStatusResult"];

/** Optimistic project status save: the detail cache is patched immediately and rolled back on error. */
export function useUpdateProjectStatus(p2ProjectNo: string) {
  const qc = useQueryClient();
  return useMutation<ProjectStatusResult, ApiError, ProjectStatusUpdate, { previous?: Schemas["Project"] }>({
    mutationFn: async (body) => unwrap(await api.PUT("/api/v1/projects/{p2_project_no}/status", { params: { path: { p2_project_no: p2ProjectNo } }, body })),
    onMutate: async (body) => {
      await qc.cancelQueries({ queryKey: ["project", p2ProjectNo] });
      const previous = qc.getQueryData<Schemas["Project"]>(["project", p2ProjectNo]);
      if (previous) {
        qc.setQueryData<Schemas["Project"]>(["project", p2ProjectNo], {
          ...previous,
          pct_complete: body.pct_complete,
          phase: body.phase ?? previous.phase,
          current_finish: body.current_finish ?? previous.current_finish,
        });
      }
      return { previous };
    },
    onError: (_err, _body, ctx) => {
      if (ctx?.previous) qc.setQueryData(["project", p2ProjectNo], ctx.previous);
    },
    onSuccess: (result) => {
      qc.setQueryData(["project", p2ProjectNo], result.project);
    },
    onSettled: () => {
      void qc.invalidateQueries({ queryKey: ["project", p2ProjectNo] });
      void qc.invalidateQueries({ queryKey: ["project-history", p2ProjectNo] });
      void qc.invalidateQueries({ queryKey: ["projects"] });
    },
  });
}

export interface KanbanMoveInput {
  p2ProjectNo: string;
  columnId: number;
}

/** Kanban drop (APEX page 4 "Drop Item"): optimistic column change on the projects list, rollback on error. */
export function useKanbanMove(listKey: readonly unknown[]) {
  const qc = useQueryClient();
  return useMutation<ProjectStatusResult, ApiError, KanbanMoveInput, { previous?: Schemas["ProjectList"] }>({
    mutationFn: async ({ p2ProjectNo, columnId }) =>
      unwrap(await api.POST("/api/v1/projects/{p2_project_no}/kanban/move", { params: { path: { p2_project_no: p2ProjectNo }, query: { column_id: columnId } } })),
    onMutate: async ({ p2ProjectNo, columnId }) => {
      await qc.cancelQueries({ queryKey: listKey });
      const previous = qc.getQueryData<Schemas["ProjectList"]>(listKey);
      if (previous) {
        qc.setQueryData<Schemas["ProjectList"]>(listKey, {
          ...previous,
          items: previous.items.map((p) => (p.p2_project_no === p2ProjectNo ? { ...p, pct_complete: KANBAN_DROP_PCT[columnId] ?? p.pct_complete } : p)),
        });
      }
      return { previous };
    },
    onError: (_err, _vars, ctx) => {
      if (ctx?.previous) qc.setQueryData(listKey, ctx.previous);
    },
    onSettled: () => {
      void qc.invalidateQueries({ queryKey: ["projects"] });
    },
  });
}

export type ThresholdUpdate = Schemas["ThresholdUpdate"];

/** Status engine thresholds (APEX page 10000 lookups, role evs_admin): optimistic, rolled back on error. */
export function useUpdateThresholds() {
  const qc = useQueryClient();
  return useMutation<Schemas["Thresholds"], ApiError, ThresholdUpdate, { previous?: Schemas["Thresholds"] }>({
    mutationFn: async (body) => unwrap(await api.PUT("/api/v1/admin/thresholds", { body })),
    onMutate: async (body) => {
      await qc.cancelQueries({ queryKey: ["admin-thresholds"] });
      const previous = qc.getQueryData<Schemas["Thresholds"]>(["admin-thresholds"]);
      if (previous) qc.setQueryData<Schemas["Thresholds"]>(["admin-thresholds"], { ...previous, ...body, lpms_failover_hours: body.lpms_failover_hours ?? previous.lpms_failover_hours });
      return { previous };
    },
    onError: (_err, _body, ctx) => {
      if (ctx?.previous) qc.setQueryData(["admin-thresholds"], ctx.previous);
    },
    onSuccess: (result) => qc.setQueryData(["admin-thresholds"], result),
    onSettled: () => {
      void qc.invalidateQueries({ queryKey: ["admin-thresholds"] });
    },
  });
}

export type MilestoneUpdate = Schemas["MilestoneUpdate"];

export function useUpdateMilestone(p2ProjectNo: string) {
  const qc = useQueryClient();
  return useMutation<Schemas["Milestone"], ApiError, { code: string; body: MilestoneUpdate }>({
    mutationFn: async ({ code, body }) =>
      unwrap(await api.PUT("/api/v1/projects/{p2_project_no}/milestones/{code}", { params: { path: { p2_project_no: p2ProjectNo, code } }, body })),
    onSettled: () => {
      void qc.invalidateQueries({ queryKey: ["project", p2ProjectNo] });
      void qc.invalidateQueries({ queryKey: ["milestones"] });
    },
  });
}

/** Kanban Board columns (port of the APEX page 4 region SQL, see evs.legacy_ports.kanban). */
export const KANBAN_COLUMNS = [
  { id: 1, heading: "Identified", range: "10 to 20" },
  { id: 2, heading: "Architecting", range: "30" },
  { id: 3, heading: "Specification Approved", range: "40" },
  { id: 4, heading: "In Development", range: "50 to 70" },
  { id: 5, heading: "Merging and Verification", range: "80 to 100" },
] as const;
export const KANBAN_DROP_PCT: Record<number, number> = { 1: 20, 2: 30, 3: 40, 4: 50, 5: 80 };

export function kanbanColumnId(pctComplete: number): number {
  if (pctComplete <= 20) return 1;
  if (pctComplete < 40) return 2;
  if (pctComplete < 50) return 3;
  if (pctComplete < 80) return 4;
  return 5;
}

/** Server side CSV export (`format=csv`, same filters, up to 500 rows) downloaded through the browser. */
export async function downloadServerCsv(path: string, query: Record<string, string | number | undefined>, filename: string): Promise<void> {
  const base = import.meta.env.VITE_API_BASE || (typeof window !== "undefined" ? window.location.origin : "");
  const url = new URL(path, base);
  for (const [k, v] of Object.entries(query)) if (v !== undefined && v !== "") url.searchParams.set(k, String(v));
  url.searchParams.set("format", "csv");
  const res = await fetch(url.toString(), { headers: { Accept: "text/csv" } });
  if (!res.ok) throw new ApiError(res.status, await res.text(), referenceId());
  downloadCsv(filename, await res.text());
}

/** Path of the public lock SSE stream, for useSse. */
export const LOCKS_STREAM_URL = `${import.meta.env.VITE_API_BASE ?? ""}/api/v1/public/locks/stream/events`;

export type ApiQueryResult<T> = UseQueryResult<T, ApiError>;
