import { STATUS_META, type StatusValue } from "../../components/status";
import { StatusShape } from "../../components/StatusMarker";
import type { Schemas } from "../../hooks/useApi";

export type ConformanceStatus = Schemas["CriterionStatus"]["status"];
export type ManualStatus = Schemas["ManualTestRow"]["status"];

interface ChipMeta {
  label: string;
  /** Kit status that supplies the shape, glyph and colour pair, so the encoding matches the rest of EVS. */
  kit: StatusValue;
}

export const CONFORMANCE_META: Record<ConformanceStatus, ChipMeta> = {
  supports: { label: "Supports", kit: "operating" },
  "partially-supports": { label: "Partially supports", kit: "delayed" },
  "does-not-support": { label: "Does not support", kit: "closed" },
  "not-applicable": { label: "Not applicable", kit: "unknown" },
  "not-evaluated": { label: "Not evaluated", kit: "stale" },
};

export const MANUAL_META: Record<ManualStatus, ChipMeta> = {
  passed: { label: "Passed", kit: "operating" },
  partial: { label: "Passed with defects", kit: "delayed" },
  failed: { label: "Failed", kit: "closed" },
  planned: { label: "Planned", kit: "stale" },
  "not-evaluated": { label: "Not evaluated", kit: "unknown" },
};

export const CONFORMANCE_ORDER: ConformanceStatus[] = [
  "does-not-support",
  "partially-supports",
  "not-evaluated",
  "supports",
  "not-applicable",
];

/** Shape + text + colour chip for conformance and manual test statuses (never colour alone). */
export function ConformanceChip({ meta, className }: { meta: ChipMeta; className?: string }) {
  const shape = STATUS_META[meta.kit].shape;
  return (
    <span className={["evs-chip", `evs-chip--${meta.kit}`, className].filter(Boolean).join(" ")} title={`${meta.label} (${shape})`}>
      <StatusShape status={meta.kit} size={14} className="evs-chip__shape" />
      <span>{meta.label}</span>
      <span className="usa-sr-only">, {shape}</span>
    </span>
  );
}
