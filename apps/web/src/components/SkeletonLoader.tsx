import { useReducedMotion } from "../hooks/useReducedMotion";

export interface SkeletonLoaderProps {
  /** What is loading, read by screen readers: "Loading financial execution". */
  label: string;
  variant?: "text" | "kpi" | "chart" | "table";
  lines?: number;
  className?: string;
}

/** aria-busy placeholder, shimmer disabled under reduced motion. */
export function SkeletonLoader({ label, variant = "text", lines = 3, className }: SkeletonLoaderProps) {
  const still = useReducedMotion();
  const classes = ["evs-skeleton", still && "evs-skeleton--still", className].filter(Boolean).join(" ");
  return (
    <div className={classes} role="status" aria-busy="true" aria-live="polite" data-testid="skeleton">
      <span className="evs-sr-only">{label}</span>
      {variant === "kpi" && (
        <>
          <div className="evs-skeleton__bar evs-skeleton__bar--title" aria-hidden="true" />
          <div className="evs-skeleton__bar evs-skeleton__bar--value" aria-hidden="true" />
          <div className="evs-skeleton__bar" aria-hidden="true" />
        </>
      )}
      {variant === "chart" && (
        <>
          <div className="evs-skeleton__bar evs-skeleton__bar--title" aria-hidden="true" />
          <div className="evs-skeleton__bar evs-skeleton__bar--chart" aria-hidden="true" />
        </>
      )}
      {(variant === "text" || variant === "table") &&
        Array.from({ length: variant === "table" ? Math.max(lines, 4) : lines }, (_, i) => (
          <div key={i} className="evs-skeleton__bar" aria-hidden="true" style={{ width: variant === "table" ? "100%" : `${100 - (i % 3) * 15}%` }} />
        ))}
    </div>
  );
}
