// Categorical chart palette from the 508 report (section 1.2.1). Each series carries colour, dash
// pattern, marker shape and an SVG pattern fill id so no series is identified by colour alone.
export type MarkerShape = "circle" | "square" | "triangle" | "diamond" | "cross";

export interface SeriesStyle {
  /** CSS custom property so the colour follows the active theme (light or leadership). */
  color: string;
  /** Resolved hex for the light theme, used where CSS variables are not available (CSV legends, tests). */
  hexLight: string;
  hexLeadership: string;
  strokeDasharray?: string;
  marker: MarkerShape;
  /** id of the <pattern> defined by <ChartPatterns>, use as fill="url(#id)". */
  patternId: string;
  label: string;
}

export const SERIES: readonly SeriesStyle[] = [
  { color: "var(--evs-series-1)", hexLight: "#005ea2", hexLeadership: "#58b4ff", marker: "circle", patternId: "evs-pattern-solid", label: "solid line, circle markers, solid fill" },
  { color: "var(--evs-series-2)", hexLight: "#cf4900", hexLeadership: "#ffbc78", strokeDasharray: "6 3", marker: "square", patternId: "evs-pattern-diagonal", label: "dashed line, square markers, diagonal hatch" },
  { color: "var(--evs-series-3)", hexLight: "#783cb9", hexLeadership: "#ee83ff", strokeDasharray: "2 3", marker: "triangle", patternId: "evs-pattern-dots", label: "dotted line, triangle markers, dotted fill" },
  { color: "var(--evs-series-4)", hexLight: "#216e1f", hexLeadership: "#21c834", strokeDasharray: "8 3 2 3", marker: "diamond", patternId: "evs-pattern-cross", label: "dash-dot line, diamond markers, cross hatch" },
  { color: "var(--evs-series-5)", hexLight: "#565c65", hexLeadership: "#a9aeb1", strokeDasharray: "10 4", marker: "cross", patternId: "evs-pattern-horizontal", label: "long dash line, cross markers, horizontal lines" },
];

export const NEGATIVE_SERIES: SeriesStyle = {
  color: "var(--evs-series-negative)", hexLight: "#b50909", hexLeadership: "#ff8d7b", marker: "square", patternId: "evs-pattern-negative", label: "under plan, dense diagonal hatch",
};

export const CHART_TOKENS = {
  grid: "var(--evs-chart-grid)",
  axis: "var(--evs-chart-axis)",
  planBand: "var(--evs-chart-plan-band)",
  focus: "var(--evs-color-focus)",
  minLineWidth: 2,
  minMarkerDiameter: 8,
  minWidth: 240,
  minHeight: 180,
} as const;

export function seriesStyle(index: number): SeriesStyle {
  return SERIES[index % SERIES.length];
}
