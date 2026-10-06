import { useQuery, type UseQueryOptions, type UseQueryResult } from "@tanstack/react-query";
import { api } from "../api/client";
import type { components, paths } from "../api/schema";

export type Schemas = components["schemas"];
export type AsOf = Schemas["AsOf"];
export type Freshness = AsOf["freshness"];

type Query<P extends keyof paths> = paths[P] extends { get: { parameters: { query?: infer Q } } } ? NonNullable<Q> : never;

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

export function useFinancialSummary(fiscalYear?: number, extra?: Extra<Schemas["FinancialSummary"]>) {
  const query = fiscalYear ? { fiscal_year: fiscalYear } : {};
  return useQuery<Schemas["FinancialSummary"], ApiError>({ queryKey: ["financial-summary", query], queryFn: async () => unwrap(await api.GET("/api/v1/financial/summary", { params: { query } })), ...extra });
}

export function useLabor(fiscalYear?: number, extra?: Extra<Schemas["LaborSummary"]>) {
  const query = fiscalYear ? { fiscal_year: fiscalYear } : {};
  return useQuery<Schemas["LaborSummary"], ApiError>({ queryKey: ["labor", query], queryFn: async () => unwrap(await api.GET("/api/v1/workforce/labor", { params: { query } })), ...extra });
}

export function useFacilityCondition(extra?: Extra<Schemas["FacilitySummary"]>) {
  return useQuery<Schemas["FacilitySummary"], ApiError>({ queryKey: ["facility-condition"], queryFn: async () => unwrap(await api.GET("/api/v1/facilities/condition")), ...extra });
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

export function useThresholds(extra?: Extra<Record<string, number>>) {
  return useQuery<Record<string, number>, ApiError>({ queryKey: ["admin-thresholds"], queryFn: async () => unwrap(await api.GET("/api/v1/admin/thresholds")) as Record<string, number>, ...extra });
}

/** Path of the public lock SSE stream, for useSse. */
export const LOCKS_STREAM_URL = `${import.meta.env.VITE_API_BASE ?? ""}/api/v1/public/locks/stream/events`;

export type ApiQueryResult<T> = UseQueryResult<T, ApiError>;
