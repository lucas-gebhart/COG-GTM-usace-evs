import type { ButtonHTMLAttributes, ReactNode } from "react";
import { normalizeStatus, STATUS_META, type StatusValue } from "./status";

export interface StatusMarkerProps {
  status: StatusValue | string;
  /** Visible or accessible subject, e.g. the lock name. Combined with the status in the accessible name. */
  label?: string;
  /** Renders as a button (for map and list markers that open detail). */
  onActivate?: () => void;
  /** Brief one-shot pulse when the status changed (disabled under reduced motion). */
  pulse?: boolean;
  size?: number;
  className?: string;
  children?: ReactNode;
  buttonProps?: Omit<ButtonHTMLAttributes<HTMLButtonElement>, "onClick" | "aria-label">;
}

/** Shape, colour and glyph together in a 28 px symbol, 44x44 hit area (section 1.2.3). */
export function StatusShape({ status, size = 28, className }: { status: StatusValue; size?: number; className?: string }) {
  const color = `var(--evs-status-${status})`;
  const glyph =
    status === "operating" ? <path className="evs-marker__glyph" d="M8.5 14.5l3.5 3.5 7.5-8" />
    : status === "delayed" ? <path className="evs-marker__glyph" d="M14 10v6.5M14 20.5v0.5" />
    : status === "closed" ? <path className="evs-marker__glyph" d="M9.5 9.5l9 9M18.5 9.5l-9 9" />
    : status === "stale" ? <path className="evs-marker__glyph" d="M14 8.5V14l3.5 2.5" />
    : <path className="evs-marker__glyph" d="M11.5 11a2.5 2.5 0 1 1 3.6 2.2c-0.8 0.5-1.1 1-1.1 1.8M14 19v0.5" />;
  return (
    <svg className={["evs-marker__svg", className].filter(Boolean).join(" ")} viewBox="0 0 28 28" width={size} height={size} aria-hidden="true" focusable="false">
      {status === "operating" && <circle className="evs-marker__shape" cx="14" cy="14" r="11.5" fill={color} />}
      {status === "delayed" && <path className="evs-marker__shape" d="M14 3.5L25.5 24H2.5z" fill={color} />}
      {status === "closed" && <path className="evs-marker__shape" d="M9 2.5h10l6.5 6.5v10L19 25.5H9L2.5 19V9z" fill={color} />}
      {status === "stale" && (
        <>
          <circle className="evs-marker__shape" cx="14" cy="14" r="11.5" fill="var(--evs-status-stale-bg)" />
          <circle className="evs-marker__ring" cx="14" cy="14" r="8" />
        </>
      )}
      {status === "unknown" && <path className="evs-marker__shape" d="M14 2.5L25.5 14 14 25.5 2.5 14z" fill="var(--evs-status-unknown-bg)" />}
      {glyph}
    </svg>
  );
}

export function StatusMarker({ status, label, onActivate, pulse = false, size = 28, className, children, buttonProps }: StatusMarkerProps) {
  const value = normalizeStatus(status);
  const meta = STATUS_META[value];
  const name = label ? `${label}: ${meta.label}` : meta.label;
  const classes = ["evs-marker", `evs-marker--${value}`, onActivate && "evs-marker--button", pulse && "evs-marker--pulse", className].filter(Boolean).join(" ");
  const inner = (
    <>
      <StatusShape status={value} size={size} />
      {children}
    </>
  );
  if (onActivate) {
    return (
      <button type="button" className={classes} onClick={onActivate} aria-label={name} title={`${meta.label} (${meta.shape})`} {...buttonProps}>
        {inner}
      </button>
    );
  }
  return (
    <span className={classes} role="img" aria-label={name} title={`${meta.label} (${meta.shape})`}>
      {inner}
    </span>
  );
}
