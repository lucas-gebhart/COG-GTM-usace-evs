import type { Meta, StoryObj } from "@storybook/react-vite";
import { PageHeader } from "./PageHeader";
import { AsOfBadge } from "./AsOfBadge";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/PageHeader",
  component: PageHeader,
  tags: ["autodocs"],
  args: {
    title: "Financial execution (CEFMS)",
    intro: "Obligations and expenditures against the fiscal year plan, by appropriation. Synthetic data shaped by ER 37-1-30 vocabulary.",
    breadcrumbs: [{ label: "Enterprise overview", to: "/" }, { label: "Financial execution" }],
  },
} satisfies Meta<typeof PageHeader>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const WithActions: Story = {
  args: { actions: <AsOfBadge asOf={{ source_as_of: "2026-10-06T14:30:00Z", fetched_at: "2026-10-06T14:30:00Z", freshness: "fresh", source: "synthetic" }} tickMs={0} /> },
};
export const WithActionsLeadership = leadershipStory(WithActions);
