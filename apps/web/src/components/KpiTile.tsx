import { useId, type ReactNode } from "react";
import { Icon } from "@trussworks/react-uswds";
import { describeDelta, formatPercent } from "../lib/format";

export interface KpiTileProps {
  label: string;
  /** Pre-formatted display value, units belong in `unit` or the label (never in the number). */
  value: string;
  unit?: string;
  /** Signed percentage points, e.g. -3.1 for 3.1 percent under plan. */
  deltaPct?: number | null;
  deltaLabel?: string;
  context?: string;
  /** Optional sparkline or other visual, must be decorative (aria-hidden) since the numbers carry the meaning. */
  visual?: ReactNode;
  headingLevel?: 2 | 3 | 4;
  /** Accent colour token for the top rule; defaults to the link colour. */
  accent?: string;
  className?: string;
}

/** Headline number with label, delta (icon + sign + text) and context sentence (section 1.2.2 and 3.2.2). */
export function KpiTile({ label, value, unit, deltaPct, deltaLabel = "vs plan", context, visual, headingLevel = 3, accent, className }: KpiTileProps) {
  const id = useId();
  const Heading = `h${headingLevel}` as const;
  const direction = deltaPct === null || deltaPct === undefined ? null : deltaPct > 0 ? "up" : deltaPct < 0 ? "down" : "flat";
  const DeltaIcon = direction === "up" ? Icon.ArrowUpward : direction === "down" ? Icon.ArrowDownward : Icon.Remove;
  return (
    <section className={["evs-kpi", className].filter(Boolean).join(" ")} aria-labelledby={`${id}-label`} style={accent ? { borderTopColor: accent } : undefined}>
      <Heading id={`${id}-label`} className="evs-kpi__label">{label}</Heading>
      <p className="evs-kpi__value">
        {value}
        {unit && <span className="evs-kpi__unit">{unit}</span>}
      </p>
      {direction && (
        <p className={`evs-kpi__delta evs-kpi__delta--${direction}`}>
          <DeltaIcon aria-hidden="true" focusable={false} />
          <span aria-hidden="true">{formatPercent(deltaPct, true)} {deltaLabel}</span>
          <span className="evs-sr-only">{describeDelta(deltaPct, deltaLabel)}</span>
        </p>
      )}
      {context && <p className="evs-kpi__context">{context}</p>}
      {visual && <div className="evs-kpi__spark" aria-hidden="true">{visual}</div>}
    </section>
  );
}
