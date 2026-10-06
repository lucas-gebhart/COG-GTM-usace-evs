import type { Meta, StoryObj } from "@storybook/react-vite";
import { Bar, BarChart, CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { Figure } from "./Figure";
import { AsOfBadge } from "./AsOfBadge";
import { fixtures } from "../mocks/fixtures";
import { ChartPatterns, SERIES, CHART_TOKENS } from "../theme";
import { formatCurrency, formatDate } from "../lib/format";
import { leadershipStory, narrow } from "../stories/decorators";

type CurvePoint = (typeof fixtures.financialSummary.execution_curve)[number];
type Approp = (typeof fixtures.financialSummary.by_appropriation)[number];

const curve = fixtures.financialSummary.execution_curve;
const approps = fixtures.financialSummary.by_appropriation;

const curveColumns = [
  { key: "period", header: "Period", format: (v: unknown) => formatDate(v as string), rowHeader: true },
  { key: "plan_cumulative", header: "Plan, cumulative", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
  { key: "obligated_cumulative", header: "Obligated, cumulative", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
  { key: "expended_cumulative", header: "Expended, cumulative", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
];

const meta = {
  title: "Components/Figure",
  component: Figure,
  tags: ["autodocs"],
  parameters: { layout: "padded" },
} satisfies Meta<typeof Figure>;
export default meta;
type Story = StoryObj<Meta<typeof Figure<CurvePoint>>>;

export const ExecutionCurve: Story = {
  args: {
    title: "FY26 execution curve",
    description: "Cumulative obligations and expenditures track below the plan line all year. The gap widens from February and is largest in June, when obligations are about 7 percent under plan.",
    data: curve,
    columns: curveColumns,
    legend: [
      { name: "Plan", seriesIndex: 4 },
      { name: "Obligated", seriesIndex: 0 },
      { name: "Expended", seriesIndex: 1 },
    ],
    footer: <AsOfBadge asOf={fixtures.financialSummary.as_of} tickMs={0} />,
    children: ({ reducedMotion }) => (
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={curve} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
          <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
          <XAxis dataKey="period" tickFormatter={(v: string) => formatDate(v).slice(0, 3)} tick={{ fill: CHART_TOKENS.axis }} />
          <YAxis tickFormatter={(v: number) => formatCurrency(v)} width={64} tick={{ fill: CHART_TOKENS.axis }} />
          <Tooltip formatter={(v) => formatCurrency(Number(v))} labelFormatter={(l) => formatDate(String(l))} />
          <Line name="Plan" dataKey="plan_cumulative" stroke={SERIES[4].color} strokeDasharray={SERIES[4].strokeDasharray} strokeWidth={2} dot={false} isAnimationActive={!reducedMotion} />
          <Line name="Obligated" dataKey="obligated_cumulative" stroke={SERIES[0].color} strokeWidth={2} dot={{ r: 4 }} isAnimationActive={!reducedMotion} />
          <Line name="Expended" dataKey="expended_cumulative" stroke={SERIES[1].color} strokeDasharray={SERIES[1].strokeDasharray} strokeWidth={2} dot={{ r: 4, strokeWidth: 2 }} isAnimationActive={!reducedMotion} />
        </LineChart>
      </ResponsiveContainer>
    ),
  },
};

export const TableView: Story = { args: { ...ExecutionCurve.args, defaultView: "table" } };

export const ByAppropriation: StoryObj<Meta<typeof Figure<Approp>>> = {
  args: {
    title: "Obligated and expended by appropriation",
    description: "Construction carries the largest balance. Investigations has expended about 60 percent of its obligations, the lowest ratio of the four appropriations.",
    data: approps,
    columns: [
      { key: "title", header: "Appropriation", rowHeader: true },
      { key: "appropriation", header: "Code" },
      { key: "allotted", header: "Allotted", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
      { key: "obligated", header: "Obligated", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
      { key: "expended", header: "Expended", numeric: true, format: (v: unknown) => formatCurrency(v as number) },
    ],
    legend: [
      { name: "Obligated", seriesIndex: 0 },
      { name: "Expended", seriesIndex: 1 },
    ],
    children: ({ reducedMotion }) => (
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={approps} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
          <ChartPatterns />
          <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
          <XAxis dataKey="title" tick={{ fill: CHART_TOKENS.axis }} />
          <YAxis tickFormatter={(v: number) => formatCurrency(v)} width={64} tick={{ fill: CHART_TOKENS.axis }} />
          <Tooltip formatter={(v) => formatCurrency(Number(v))} />
          <Bar name="Obligated" dataKey="obligated" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
          <Bar name="Expended" dataKey="expended" fill={`url(#${SERIES[1].patternId})`} stroke={SERIES[1].color} isAnimationActive={!reducedMotion} />
        </BarChart>
      </ResponsiveContainer>
    ),
  },
};

export const Narrow360: Story = { ...ExecutionCurve, decorators: [narrow(360)] };
export const TooNarrowFallsBackToTable: Story = { ...ExecutionCurve, decorators: [narrow(260)] };
export const ExecutionCurveLeadership = leadershipStory(ExecutionCurve);
export const ByAppropriationLeadership = leadershipStory(ByAppropriation);
