export interface CsvColumn<T> {
  key: keyof T | string;
  header: string;
  /** Formats the cell for the table view and the CSV. Raw value is used when omitted. */
  format?: (value: unknown, row: T) => string | number | null | undefined;
}

function escapeCell(v: unknown): string {
  if (v === null || v === undefined) return "";
  const s = String(v);
  return /[",\n\r]/.test(s) ? `"${s.replaceAll('"', '""')}"` : s;
}

export function toCsv<T extends object>(rows: readonly T[], columns: readonly CsvColumn<T>[]): string {
  const head = columns.map((c) => escapeCell(c.header)).join(",");
  const body = rows.map((row) =>
    columns
      .map((c) => {
        const raw = (row as Record<string, unknown>)[c.key as string];
        return escapeCell(c.format ? c.format(raw, row) : raw);
      })
      .join(","),
  );
  return [head, ...body].join("\r\n") + "\r\n";
}

export function downloadCsv(filename: string, csv: string): void {
  const blob = new Blob(["\ufeff" + csv], { type: "text/csv;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename.endsWith(".csv") ? filename : `${filename}.csv`;
  a.rel = "noopener";
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 0);
}

export function slugify(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "") || "data";
}
