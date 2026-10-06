import { useEffect, useState } from "react";
import type { AsOf, Freshness, Schemas } from "../../hooks/useApi";
import { STATUS_META, normalizeStatus, type StatusValue } from "../../components/status";
import { formatDateTime, formatNumber, formatRelative } from "../../lib/format";

export type LockSummary = Schemas["LockSummary"];
export type LockDetail = Schemas["LockDetail"];
export type LockCounts = Schemas["LockList"]["counts"];

export const COUNT_STATUSES: StatusValue[] = ["operating", "delayed", "closed", "stale"];

/** Vertical position of each status on the 24-hour sparkline (operating on top). */
export const STATUS_LEVEL: Record<StatusValue, number> = { operating: 3, delayed: 2, closed: 1, stale: 0, unknown: 0 };
export const LEVEL_LABEL: Record<number, string> = { 3: "Operating", 2: "Delayed", 1: "Closed", 0: "Stale or unknown" };

const SOURCE_TEXT: Record<string, string> = {
  live: "live",
  fixtures: "fixtures",
  simulated: "simulated",
  synthetic: "synthetic",
  "cited-public": "cited public documents",
};

export function sourceText(source: string | null | undefined): string {
  return source ? (SOURCE_TEXT[source] ?? source) : "unknown";
}

/** The header strip sentence: "As of <source_as_of>, fetched <fetched_at>, source <source>". */
export function asOfSentence(asOf: AsOf | null | undefined): string {
  if (!asOf) return "As of time unknown.";
  return `As of ${formatDateTime(asOf.source_as_of)}, fetched ${formatDateTime(asOf.fetched_at)}, source ${sourceText(asOf.source)}.`;
}

export function formatMinutes(n: number | null | undefined): string {
  if (n === null || n === undefined) return "No data";
  return `${formatNumber(Math.round(n), { integer: true })} min`;
}

export function statusLabel(status: string): string {
  return STATUS_META[normalizeStatus(status)].label;
}

/** River name, then river mile, then lock number: the order used for keyboard traversal of the markers. */
export function compareRiverMile(a: LockSummary, b: LockSummary): number {
  const river = a.river_name.localeCompare(b.river_name);
  if (river !== 0) return river;
  const ma = a.river_mile ?? Number.POSITIVE_INFINITY;
  const mb = b.river_mile ?? Number.POSITIVE_INFINITY;
  if (ma !== mb) return ma - mb;
  return a.lock_no.localeCompare(b.lock_no, undefined, { numeric: true });
}

export function useNow(tickMs = 30000): Date {
  const [now, setNow] = useState(() => new Date());
  useEffect(() => {
    if (!tickMs) return;
    const t = setInterval(() => setNow(new Date()), tickMs);
    return () => clearInterval(t);
  }, [tickMs]);
  return now;
}

/** Relative time as text, absolute time in the title and in visually hidden text (table rows). */
export function RelativeTime({ value, now }: { value: string | null | undefined; now: Date }) {
  if (!value) return <span>No timestamp</span>;
  const absolute = formatDateTime(value);
  return (
    <time dateTime={value} title={absolute} className="evs-reltime">
      {formatRelative(value, now)}
      <span className="evs-sr-only">, {absolute}</span>
    </time>
  );
}

const FRESH_LABEL: Record<Freshness, string> = { fresh: "Fresh", aging: "Aging", stale: "Stale", simulated: "Simulated" };

export function FreshnessTag({ freshness }: { freshness: Freshness | string | null | undefined }) {
  const key = (freshness ?? "stale") as Freshness;
  const label = FRESH_LABEL[key] ?? String(freshness);
  return <span className={`usa-tag evs-freshtag evs-freshtag--${key}`}>{label}</span>;
}

export function countsSentence(counts: Partial<LockCounts> | null | undefined): string {
  if (!counts) return "";
  return COUNT_STATUSES.map((s) => `${counts[s] ?? 0} ${STATUS_META[s].label.toLowerCase()}`).join(", ");
}
