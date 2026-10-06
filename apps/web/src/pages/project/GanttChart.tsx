import { useEffect, useRef } from "react";
import * as echarts from "echarts/core";
import { BarChart, ScatterChart } from "echarts/charts";
import { AriaComponent, GridComponent, LegendComponent, TooltipComponent } from "echarts/components";
import { SVGRenderer } from "echarts/renderers";
import type { Schemas } from "../../hooks/useApi";
import { formatDate } from "../../lib/format";
import { useTheme } from "../../hooks/useTheme";
import { SERIES } from "../../theme";

echarts.use([BarChart, ScatterChart, GridComponent, TooltipComponent, LegendComponent, AriaComponent, SVGRenderer]);

type Milestone = Schemas["Milestone"];

export interface GanttChartProps {
  milestones: readonly Milestone[];
  width: number;
  height: number;
  reducedMotion: boolean;
}

const DAY = 86_400_000;
const ts = (d: string | null | undefined) => (d ? new Date(d).getTime() : null);

/**
 * Milestone Gantt (ECharts, SVG renderer): one row per milestone, a bar from the baseline date to the
 * current date (the slip), markers for baseline (diamond), current (circle) and actual (triangle). The
 * Figure wrapper supplies the table alternative; ECharts aria decals add pattern fills on top of colour.
 */
export default function GanttChart({ milestones, width, height, reducedMotion }: GanttChartProps) {
  const ref = useRef<HTMLDivElement>(null);
  const { isLeadership } = useTheme();

  useEffect(() => {
    if (!ref.current || width === 0) return;
    const chart = echarts.init(ref.current, undefined, { renderer: "svg", width, height });
    const rows = milestones.map((m) => {
      const b = ts(m.baseline_date);
      const c = ts(m.current_date) ?? b;
      const start = b !== null && c !== null ? Math.min(b, c) : (b ?? c ?? Date.now());
      const end = b !== null && c !== null ? Math.max(b, c) : start;
      return { name: `${m.code} ${m.name}`, start, length: Math.max(end - start, DAY / 2), baseline: b, current: c, actual: ts(m.actual_date), status: m.status };
    });
    const ink = isLeadership ? "#dfe1e2" : "#1b1b1b";
    const pick = (i: number) => (isLeadership ? SERIES[i].hexLeadership : SERIES[i].hexLight);
    chart.setOption({
      animation: !reducedMotion,
      aria: { enabled: true, decal: { show: true } },
      textStyle: { color: ink, fontFamily: "inherit" },
      grid: { left: 8, right: 16, top: 32, bottom: 8, containLabel: true },
      legend: { top: 0, textStyle: { color: ink }, data: ["Slip (baseline to current)", "Baseline", "Current", "Actual"] },
      tooltip: {
        trigger: "item",
        formatter: (p: { seriesName: string; name: string; value: unknown }) => {
          const v = Array.isArray(p.value) ? (p.value[0] as number) : null;
          return `${p.name}<br/>${p.seriesName}${v !== null && p.seriesName !== "Slip (baseline to current)" ? `: ${formatDate(new Date(v).toISOString())}` : ""}`;
        },
      },
      xAxis: { type: "value", min: "dataMin", max: "dataMax", axisLabel: { color: ink, formatter: (v: number) => formatDate(new Date(v).toISOString()) }, splitLine: { lineStyle: { color: isLeadership ? "#3d4551" : "#dfe1e2" } } },
      yAxis: { type: "category", data: rows.map((r) => r.name), inverse: true, axisLabel: { color: ink, width: Math.min(220, Math.max(90, width * 0.3)), overflow: "truncate" } },
      series: [
        { name: "offset", type: "bar", stack: "g", silent: true, itemStyle: { color: "transparent" }, emphasis: { disabled: true }, data: rows.map((r) => r.start), tooltip: { show: false }, legendHoverLink: false },
        { name: "Slip (baseline to current)", type: "bar", stack: "g", barWidth: 14, itemStyle: { color: pick(1), borderColor: ink, borderWidth: 1 }, data: rows.map((r) => ({ value: r.length, name: r.name })) },
        { name: "Baseline", type: "scatter", symbol: "diamond", symbolSize: 14, itemStyle: { color: pick(4), borderColor: ink, borderWidth: 1 }, data: rows.flatMap((r) => (r.baseline !== null ? [{ value: [r.baseline, r.name], name: r.name }] : [])) },
        { name: "Current", type: "scatter", symbol: "circle", symbolSize: 12, itemStyle: { color: pick(0), borderColor: ink, borderWidth: 1 }, data: rows.flatMap((r) => (r.current !== null ? [{ value: [r.current, r.name], name: r.name }] : [])) },
        { name: "Actual", type: "scatter", symbol: "triangle", symbolSize: 14, itemStyle: { color: pick(3), borderColor: ink, borderWidth: 1 }, data: rows.flatMap((r) => (r.actual !== null ? [{ value: [r.actual, r.name], name: r.name }] : [])) },
      ],
    });
    return () => chart.dispose();
  }, [milestones, width, height, reducedMotion, isLeadership]);

  return <div ref={ref} style={{ width: "100%", height: "100%" }} aria-hidden="true" data-testid="gantt-chart" />;
}
