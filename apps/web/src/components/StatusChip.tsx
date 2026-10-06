import { normalizeStatus, STATUS_META, type StatusValue } from "./status";
import { StatusShape } from "./StatusMarker";

export interface StatusChipProps {
  status: StatusValue | string;
  /** Override the visible label, e.g. "Delayed 45 min". The canonical status stays in the accessible name. */
  label?: string;
  /** Hide visible text (icon-only, for dense tables); the label moves to aria-label. */
  iconOnly?: boolean;
  className?: string;
}

/** Inline status: shape + colour + text (section 1.2.3). */
export function StatusChip({ status, label, iconOnly = false, className }: StatusChipProps) {
  const value = normalizeStatus(status);
  const meta = STATUS_META[value];
  const text = label ?? meta.label;
  const classes = ["evs-chip", `evs-chip--${value}`, className].filter(Boolean).join(" ");
  if (iconOnly) {
    return (
      <span className={classes} role="img" aria-label={text === meta.label ? meta.label : `${meta.label}, ${text}`} title={meta.shape}>
        <StatusShape status={value} size={14} className="evs-chip__shape" />
      </span>
    );
  }
  return (
    <span className={classes} data-status={value}>
      <StatusShape status={value} size={14} className="evs-chip__shape" />
      <span>{text}</span>
      {text !== meta.label && <span className="evs-sr-only">, status {meta.label}</span>}
    </span>
  );
}
