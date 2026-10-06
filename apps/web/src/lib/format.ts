// Number and date formatting. Units go in the label, not the value (508 report 1.2.2).

const NUMBER = new Intl.NumberFormat("en-US", { maximumFractionDigits: 1 });
const INTEGER = new Intl.NumberFormat("en-US", { maximumFractionDigits: 0 });
const COMPACT = new Intl.NumberFormat("en-US", { notation: "compact", maximumFractionDigits: 2 });
const PERCENT = new Intl.NumberFormat("en-US", { style: "percent", maximumFractionDigits: 1, signDisplay: "exceptZero" });
const CURRENCY = new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", notation: "compact", maximumFractionDigits: 2 });

export function formatNumber(n: number | null | undefined, options?: { integer?: boolean }): string {
  if (n === null || n === undefined || Number.isNaN(n)) return "n/a";
  return options?.integer ? INTEGER.format(n) : NUMBER.format(n);
}

export function formatCompact(n: number | null | undefined): string {
  if (n === null || n === undefined || Number.isNaN(n)) return "n/a";
  return COMPACT.format(n);
}

export function formatCurrency(n: number | null | undefined): string {
  if (n === null || n === undefined || Number.isNaN(n)) return "n/a";
  return CURRENCY.format(n);
}

/** Percent from a fraction (0.031 -> +3.1%) or from a percentage (3.1 -> +3.1% when `isPercentage`). */
export function formatPercent(n: number | null | undefined, isPercentage = false): string {
  if (n === null || n === undefined || Number.isNaN(n)) return "n/a";
  return PERCENT.format(isPercentage ? n / 100 : n);
}

export function parseDate(value: string | Date | null | undefined): Date | null {
  if (!value) return null;
  const d = value instanceof Date ? value : new Date(value);
  return Number.isNaN(d.getTime()) ? null : d;
}

export function formatDateTime(value: string | Date | null | undefined, timeZone = "UTC"): string {
  const d = parseDate(value);
  if (!d) return "unknown";
  return new Intl.DateTimeFormat("en-US", { dateStyle: "medium", timeStyle: "short", timeZone, hour12: false }).format(d) + (timeZone === "UTC" ? " UTC" : "");
}

export function formatTime(value: string | Date | null | undefined, timeZone = "UTC"): string {
  const d = parseDate(value);
  if (!d) return "unknown";
  return new Intl.DateTimeFormat("en-US", { hour: "2-digit", minute: "2-digit", timeZone, hour12: false }).format(d);
}

export function formatDate(value: string | Date | null | undefined): string {
  const d = parseDate(value);
  if (!d) return "unknown";
  return new Intl.DateTimeFormat("en-US", { dateStyle: "medium", timeZone: "UTC" }).format(d);
}

const RELATIVE = new Intl.RelativeTimeFormat("en-US", { numeric: "auto" });
const UNITS: [Intl.RelativeTimeFormatUnit, number][] = [
  ["year", 365 * 24 * 3600],
  ["month", 30 * 24 * 3600],
  ["day", 24 * 3600],
  ["hour", 3600],
  ["minute", 60],
];

/** "4 minutes ago", "in 2 hours", "just now". */
export function formatRelative(value: string | Date | null | undefined, now: Date = new Date()): string {
  const d = parseDate(value);
  if (!d) return "unknown";
  const seconds = Math.round((d.getTime() - now.getTime()) / 1000);
  if (Math.abs(seconds) < 45) return "just now";
  for (const [unit, size] of UNITS) {
    if (Math.abs(seconds) >= size) return RELATIVE.format(Math.round(seconds / size), unit);
  }
  return RELATIVE.format(seconds, "second");
}

export function minutesSince(value: string | Date | null | undefined, now: Date = new Date()): number | null {
  const d = parseDate(value);
  return d ? Math.round((now.getTime() - d.getTime()) / 60000) : null;
}

/** Signed delta in words for screen readers and leadership tiles: "down 3.1% from plan". */
export function describeDelta(delta: number | null | undefined, label = "", isPercentage = true): string {
  if (delta === null || delta === undefined || Number.isNaN(delta)) return "";
  const word = delta > 0 ? "up" : delta < 0 ? "down" : "unchanged";
  const magnitude = isPercentage ? formatPercent(Math.abs(delta), true).replace("+", "") : formatNumber(Math.abs(delta));
  return delta === 0 ? `${word}${label ? ` ${label}` : ""}` : `${word} ${magnitude}${label ? ` ${label}` : ""}`;
}

export function titleCase(s: string): string {
  return s.replace(/[_-]+/g, " ").replace(/\b\w/g, (c) => c.toUpperCase());
}
