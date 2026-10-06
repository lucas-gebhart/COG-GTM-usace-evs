import { useMemo } from "react";
import { useProjects } from "../../hooks/useApi";

export interface StatusCount {
  schedule_health: string;
  label: string;
  projects: number;
}

const LABEL: Record<string, string> = { on_track: "On track", at_risk: "At risk", late: "Late" };

/** Project count by schedule status; the hook behind the chart added live on stage (APEX page 161 region). */
export function useProjectCountByStatus(filters: { district?: string; program_code?: string } = {}) {
  const query = useProjects({ ...filters, limit: 500 });
  const rows = useMemo<StatusCount[]>(() => {
    const counts = new Map<string, number>();
    for (const p of query.data?.items ?? []) counts.set(p.schedule_health, (counts.get(p.schedule_health) ?? 0) + 1);
    return ["on_track", "at_risk", "late"].map((k) => ({ schedule_health: k, label: LABEL[k], projects: counts.get(k) ?? 0 }));
  }, [query.data]);
  return { ...query, rows };
}
