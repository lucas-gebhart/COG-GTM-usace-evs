import type { StatusValue } from "../../components/status";

/** Schedule health (P2) and milestone status rendered through the kit's status encoding (shape + text + colour). */
export const SCHEDULE_HEALTH: Record<string, { status: StatusValue; label: string }> = {
  on_track: { status: "operating", label: "On track" },
  at_risk: { status: "delayed", label: "At risk" },
  late: { status: "closed", label: "Late" },
};

export const MILESTONE_STATUS: Record<string, { status: StatusValue; label: string }> = {
  complete: { status: "operating", label: "Complete" },
  scheduled: { status: "unknown", label: "Scheduled" },
  slipped: { status: "delayed", label: "Slipped" },
};

export function healthOf(value: string | null | undefined) {
  return SCHEDULE_HEALTH[value ?? ""] ?? { status: "unknown" as StatusValue, label: value ?? "Unknown" };
}

export function milestoneOf(value: string | null | undefined) {
  return MILESTONE_STATUS[value ?? ""] ?? { status: "unknown" as StatusValue, label: value ?? "Unknown" };
}

export function daysBetween(from: string | null | undefined, to: string | null | undefined): number | null {
  if (!from || !to) return null;
  return Math.round((new Date(to).getTime() - new Date(from).getTime()) / 86_400_000);
}

export function formatDays(n: number | null | undefined): string {
  if (n === null || n === undefined || Number.isNaN(n)) return "n/a";
  const sign = n > 0 ? "+" : "";
  return `${sign}${n} d`;
}

export function uniqueSorted<T>(rows: readonly T[], pick: (r: T) => string | null | undefined): string[] {
  return [...new Set(rows.map(pick).filter((v): v is string => Boolean(v)))].sort();
}

export function options(values: readonly string[]) {
  return values.map((v) => ({ value: v, label: v }));
}
