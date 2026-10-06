import type { Meta, StoryObj } from "@storybook/react-vite";
import { KpiTile } from "./KpiTile";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/KpiTile",
  component: KpiTile,
  tags: ["autodocs"],
  args: { label: "Obligated, FY26 to date", value: "$1.42B", deltaPct: -3.1, deltaLabel: "vs plan", context: "Plan $1.47B through September" },
} satisfies Meta<typeof KpiTile>;
export default meta;
type Story = StoryObj<typeof meta>;

export const UnderPlan: Story = {};
export const OverPlan: Story = { args: { label: "Expended", value: "$1.18B", deltaPct: 2.4 } };
export const NoDelta: Story = { args: { label: "Locks operating", value: "57", unit: "of 77", deltaPct: null, context: "14 delayed, 6 closed" } };
export const Grid: Story = {
  render: (args) => (
    <div className="evs-grid evs-grid--kpis">
      <KpiTile {...args} />
      <KpiTile label="Expended" value="$1.18B" deltaPct={2.4} deltaLabel="vs plan" />
      <KpiTile label="Locks operating" value="57" unit="of 77" deltaPct={null} context="14 delayed, 6 closed" />
      <KpiTile label="Overtime share" value="9.8" unit="%" deltaPct={0} deltaLabel="vs last period" />
    </div>
  ),
};
export const GridLeadership = leadershipStory(Grid);
