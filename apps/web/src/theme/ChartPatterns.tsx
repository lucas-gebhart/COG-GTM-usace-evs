import { SERIES, NEGATIVE_SERIES } from "./chartPalette";

/**
 * SVG pattern fills for stacked bars and areas. Render once inside a Recharts chart (as a direct child)
 * and reference with fill="url(#evs-pattern-diagonal)". Patterns draw in the series colour over a
 * transparent base so the hatch carries the series identity without colour (USWDS data-viz guidance).
 */
export function ChartPatterns() {
  const [solid, diagonal, dots, cross, horizontal] = SERIES;
  return (
    <defs>
      <pattern id={solid.patternId} width="4" height="4" patternUnits="userSpaceOnUse">
        <rect width="4" height="4" fill={solid.color} />
      </pattern>
      <pattern id={diagonal.patternId} width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
        <rect width="8" height="8" fill={diagonal.color} fillOpacity="0.25" />
        <rect width="3" height="8" fill={diagonal.color} />
      </pattern>
      <pattern id={dots.patternId} width="8" height="8" patternUnits="userSpaceOnUse">
        <rect width="8" height="8" fill={dots.color} fillOpacity="0.2" />
        <circle cx="4" cy="4" r="2" fill={dots.color} />
      </pattern>
      <pattern id={cross.patternId} width="8" height="8" patternUnits="userSpaceOnUse">
        <rect width="8" height="8" fill={cross.color} fillOpacity="0.2" />
        <path d="M0 4h8M4 0v8" stroke={cross.color} strokeWidth="2" />
      </pattern>
      <pattern id={horizontal.patternId} width="8" height="8" patternUnits="userSpaceOnUse">
        <rect width="8" height="8" fill={horizontal.color} fillOpacity="0.2" />
        <rect width="8" height="3" fill={horizontal.color} />
      </pattern>
      <pattern id={NEGATIVE_SERIES.patternId} width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(-45)">
        <rect width="6" height="6" fill={NEGATIVE_SERIES.color} fillOpacity="0.3" />
        <rect width="2" height="6" fill={NEGATIVE_SERIES.color} />
      </pattern>
    </defs>
  );
}
