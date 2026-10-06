import type { Meta, StoryObj } from "@storybook/react-vite";
import { AsOfBadge } from "./AsOfBadge";
import { leadershipStory } from "../stories/decorators";

const minutesAgo = (m: number) => new Date(Date.now() - m * 60000).toISOString();

const meta = {
  title: "Components/AsOfBadge",
  component: AsOfBadge,
  tags: ["autodocs"],
  args: { asOf: { source_as_of: minutesAgo(4), fetched_at: minutesAgo(1), freshness: "fresh", source: "lpms" }, tickMs: 0 },
} satisfies Meta<typeof AsOfBadge>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Fresh: Story = {};
export const Aging: Story = { args: { asOf: { source_as_of: minutesAgo(14), fetched_at: minutesAgo(1), freshness: "aging", source: "lpms" } } };
export const Stale: Story = { args: { asOf: { source_as_of: minutesAgo(95), fetched_at: minutesAgo(1), freshness: "stale", source: "lpms" } } };
export const Simulated: Story = { args: { asOf: { source_as_of: minutesAgo(2), fetched_at: minutesAgo(2), freshness: "simulated", source: "simulated" } } };
export const Missing: Story = { args: { asOf: null } };
export const StaleLeadership = leadershipStory(Stale);
