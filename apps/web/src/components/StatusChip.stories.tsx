import type { Meta, StoryObj } from "@storybook/react-vite";
import { StatusChip } from "./StatusChip";
import { STATUS_VALUES } from "./status";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/StatusChip",
  component: StatusChip,
  tags: ["autodocs"],
  args: { status: "operating" },
} satisfies Meta<typeof StatusChip>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Operating: Story = {};
export const Delayed: Story = { args: { status: "delayed", label: "Delayed 45 min" } };
export const Closed: Story = { args: { status: "closed" } };
export const Stale: Story = { args: { status: "stale" } };
export const Unknown: Story = { args: { status: "unknown" } };
export const IconOnly: Story = { args: { status: "closed", iconOnly: true } };
export const AllStatuses: Story = {
  render: () => (
    <div style={{ display: "flex", gap: "0.5rem", flexWrap: "wrap" }}>
      {STATUS_VALUES.map((s) => (
        <StatusChip key={s} status={s} />
      ))}
    </div>
  ),
};
export const AllStatusesLeadership = leadershipStory(AllStatuses);
