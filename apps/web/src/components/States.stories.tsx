import type { Meta, StoryObj } from "@storybook/react-vite";
import { fn } from "storybook/test";
import { EmptyState } from "./EmptyState";
import { ErrorState } from "./ErrorState";
import { SkeletonLoader } from "./SkeletonLoader";
import { ApiError } from "../hooks/useApi";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/Empty, Error and Loading states",
  tags: ["autodocs"],
} satisfies Meta;
export default meta;
type Story = StoryObj;

export const Empty: Story = {
  render: () => <EmptyState message="No projects match district LRN and phase Construction. Clear a filter to widen the search." />,
};
export const Error: Story = {
  render: () => <ErrorState error={new ApiError(503, "Upstream LPMS feed unavailable", "EVS-7F3K2A")} onRetry={fn()} />,
};
export const LoadingKpi: Story = { render: () => <SkeletonLoader label="Loading financial execution" variant="kpi" /> };
export const LoadingChart: Story = { render: () => <SkeletonLoader label="Loading execution curve" variant="chart" /> };
export const LoadingTable: Story = { render: () => <SkeletonLoader label="Loading projects" variant="table" lines={5} /> };
export const ErrorLeadership = leadershipStory(Error);
