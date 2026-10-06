import type { Meta, StoryObj } from "@storybook/react-vite";
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { Figure } from "../../components/Figure";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { CHART_TOKENS, ChartPatterns, SERIES } from "../../theme";
import { useProjectCountByStatus } from "./useProjectCountByStatus";

/**
 * The chart added to /financial live on stage (APEX page 161 region). The hook and this Figure are ready;
 * the live step imports ProjectCountByStatus into pages/Financial.tsx.
 */
export function ProjectCountByStatus() {
  const { rows, isPending } = useProjectCountByStatus();
  if (isPending) return <SkeletonLoader label="Loading project counts" variant="chart" />;
  return (
    <Figure
      title="Project count by schedule status"
      description={rows.map((r) => `${r.projects} ${r.label.toLowerCase()}`).join(", ") + "."}
      data={rows}
      columns={[
        { key: "label", header: "Status", rowHeader: true },
        { key: "projects", header: "Projects", numeric: true },
      ]}
      legend={[{ name: "Projects", seriesIndex: 0 }]}
      headingLevel={2}
      csvName="project-count-by-status"
    >
      {({ reducedMotion }) => (
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={rows} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
            <ChartPatterns />
            <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
            <XAxis dataKey="label" tick={{ fill: CHART_TOKENS.axis }} />
            <YAxis allowDecimals={false} width={40} tick={{ fill: CHART_TOKENS.axis }} />
            <Tooltip />
            <Bar name="Projects" dataKey="projects" fill={`url(#${SERIES[0].patternId})`} stroke={SERIES[0].color} isAnimationActive={!reducedMotion} />
          </BarChart>
        </ResponsiveContainer>
      )}
    </Figure>
  );
}

const meta = {
  title: "Pages/Financial/Project count by status (live step)",
  component: ProjectCountByStatus,
  parameters: { layout: "padded" },
} satisfies Meta<typeof ProjectCountByStatus>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Leadership: Story = { globals: { theme: "leadership" } };
