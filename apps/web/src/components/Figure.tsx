import { useId, useRef, useState, type ReactNode } from "react";
import { Button, Icon, Table } from "@trussworks/react-uswds";
import { useReducedMotion } from "../hooks/useReducedMotion";
import { useElementSize } from "../hooks/useElementSize";
import { useAnnounce } from "../hooks/useAnnounce";
import { downloadCsv, slugify, toCsv, type CsvColumn } from "../lib/csv";
import { CHART_TOKENS, SERIES } from "../theme/chartPalette";
import { ChartPatterns } from "../theme/ChartPatterns";

export interface FigureColumn<T> extends CsvColumn<T> {
  /** Right-align numbers. */
  numeric?: boolean;
  /** Use this column as the row header (scope=row). Defaults to the first column. */
  rowHeader?: boolean;
}

export interface FigureRenderProps {
  /** True when the OS asks for reduced motion; pass `isAnimationActive={!reducedMotion}` to Recharts series. */
  reducedMotion: boolean;
  width: number;
  height: number;
}

export interface FigureProps<T extends object> {
  title: string;
  /** Long description: the takeaway in words (what the chart shows, trend, outliers). Linked by aria-describedby and visible. */
  description: string;
  data: readonly T[];
  columns: readonly FigureColumn<T>[];
  /** The Recharts chart. A function receives reduced-motion and size so series can disable animation. */
  children: ReactNode | ((props: FigureRenderProps) => ReactNode);
  /** Legend entries, rendered as text + swatch so the chart never relies on the Recharts colour-only legend. */
  legend?: { name: string; seriesIndex?: number; color?: string; patternId?: string; note?: string }[];
  height?: number;
  /** Start in table view. */
  defaultView?: "chart" | "table";
  /** Filename stem for the CSV; defaults to the slugified title. */
  csvName?: string;
  /** Extra footer content, e.g. an AsOfBadge. */
  footer?: ReactNode;
  headingLevel?: 2 | 3 | 4;
  className?: string;
  /** Row key for the table alternative. */
  getRowKey?: (row: T, index: number) => string;
}

function cell<T extends object>(col: FigureColumn<T>, row: T): string {
  const raw = (row as Record<string, unknown>)[col.key as string];
  const v = col.format ? col.format(raw, row) : raw;
  return v === null || v === undefined ? "" : String(v);
}

/**
 * Accessible chart wrapper (508 report 1.2.5 and 1.2.6): figure with heading and long description,
 * "View as table" toggle, CSV download, reduced-motion aware, Recharts accessibilityLayer expected on.
 * Below 240 px of container width the chart is replaced by the table so nothing is clipped (1.4.10).
 */
export function Figure<T extends object>({
  title, description, data, columns, children, legend, height = 260, defaultView = "chart", csvName, footer, headingLevel = 3, className, getRowKey,
}: FigureProps<T>) {
  const id = useId();
  const titleId = `${id}-title`;
  const descId = `${id}-desc`;
  const [view, setView] = useState<"chart" | "table">(defaultView);
  const reducedMotion = useReducedMotion();
  const chartRef = useRef<HTMLDivElement>(null);
  const size = useElementSize(chartRef);
  const figRef = useRef<HTMLElement>(null);
  const figSize = useElementSize(figRef);
  const { announce } = useAnnounce();
  const Heading = `h${headingLevel}` as const;

  const tooNarrow = figSize.width > 0 && figSize.width < CHART_TOKENS.minWidth;
  const showTable = view === "table" || tooNarrow;
  const rowHeaderIndex = Math.max(0, columns.findIndex((c) => c.rowHeader));

  const toggle = () => {
    const next = view === "chart" ? "table" : "chart";
    setView(next);
    announce(next === "table" ? `${title}: showing data table` : `${title}: showing chart`);
  };
  const exportCsv = () => {
    downloadCsv(csvName ?? slugify(title), toCsv(data, columns));
    announce(`${title}: CSV download started`);
  };

  return (
    <figure ref={figRef} className={["evs-figure", className].filter(Boolean).join(" ")} aria-labelledby={titleId} aria-describedby={descId}>
      <figcaption className="evs-figure__caption">
        <Heading id={titleId} className="evs-figure__title">{title}</Heading>
        <p id={descId} className="evs-figure__desc">{description}</p>
      </figcaption>
      <div className="evs-figure__toolbar" role="group" aria-label={`${title} display options`}>
        <Button type="button" outline onClick={toggle} aria-pressed={view === "table"} disabled={tooNarrow}>
          <Icon.List aria-hidden="true" focusable={false} />
          {view === "table" ? "View as chart" : "View as table"}
        </Button>
        <Button type="button" outline onClick={exportCsv}>
          <Icon.FileDownload aria-hidden="true" focusable={false} />
          Download CSV
        </Button>
      </div>
      {showTable ? (
        // Scrollable data regions must be keyboard reachable (axe scrollable-region-focusable)
        // eslint-disable-next-line jsx-a11y/no-noninteractive-tabindex
        <div className="evs-figure__table evs-scroll-x" role="region" tabIndex={0} aria-label={`${title}, data table`} data-testid="figure-table">
          <Table bordered={false} striped fullWidth scrollable={false}>
            <caption className="evs-sr-only">{title} data table</caption>
            <thead>
              <tr>
                {columns.map((c) => (
                  <th key={String(c.key)} scope="col" className={c.numeric ? "evs-table__num" : undefined}>{c.header}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {data.map((row, i) => (
                <tr key={getRowKey ? getRowKey(row, i) : i}>
                  {columns.map((c, ci) =>
                    ci === rowHeaderIndex ? (
                      <th key={String(c.key)} scope="row">{cell(c, row)}</th>
                    ) : (
                      <td key={String(c.key)} className={c.numeric ? "evs-table__num" : undefined}>{cell(c, row)}</td>
                    ),
                  )}
                </tr>
              ))}
            </tbody>
          </Table>
          {tooNarrow && <p className="evs-figure__hint">Chart hidden at this width; the table carries the same data.</p>}
        </div>
      ) : (
        <div ref={chartRef} className="evs-figure__chart" style={{ height }} data-testid="figure-chart">
          {typeof children === "function" ? children({ reducedMotion, width: size.width, height: size.height || height }) : children}
        </div>
      )}
      {legend && legend.length > 0 && (
        <ul className="evs-legend" aria-label={`${title} legend`}>
          {/* Pattern defs live here, not only inside the chart, so swatches keep their fills in table view. */}
          <svg width="0" height="0" className="evs-legend__defs" aria-hidden="true" focusable="false"><ChartPatterns /></svg>
          {legend.map((item) => {
            const s = item.seriesIndex !== undefined ? SERIES[item.seriesIndex % SERIES.length] : undefined;
            const color = item.color ?? s?.color ?? "currentColor";
            const patternId = item.patternId ?? s?.patternId;
            return (
              <li key={item.name} className="evs-legend__item">
                <svg className="evs-legend__swatch" viewBox="0 0 24 14" aria-hidden="true" focusable="false">
                  <rect x="1" y="1" width="22" height="12" fill={patternId ? `url(#${patternId})` : color} stroke={color} strokeWidth="1" />
                  {s?.strokeDasharray && <line x1="0" y1="7" x2="24" y2="7" stroke={color} strokeWidth="2" strokeDasharray={s.strokeDasharray} />}
                </svg>
                <span>
                  {item.name}
                  {(item.note ?? s?.label) && <span className="evs-sr-only"> ({item.note ?? s?.label})</span>}
                </span>
              </li>
            );
          })}
        </ul>
      )}
      {footer && <div className="evs-figure__meta">{footer}</div>}
    </figure>
  );
}
