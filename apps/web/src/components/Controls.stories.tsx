import type { Meta, StoryObj } from "@storybook/react-vite";
import { fn } from "storybook/test";
import { ThemeToggle } from "./ThemeToggle";
import { RefreshControl } from "./RefreshControl";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/ThemeToggle and RefreshControl",
  tags: ["autodocs"],
} satisfies Meta;
export default meta;
type Story = StoryObj;

export const Theme: Story = { render: () => <ThemeToggle /> };
export const ThemeCompact: Story = { render: () => <ThemeToggle compact /> };
export const Refresh: Story = { render: () => <RefreshControl onRefresh={fn()} initiallyPaused lastRefreshed={new Date()} /> };
export const RefreshRunning: Story = { render: () => <RefreshControl onRefresh={fn()} intervalSeconds={60} />, tags: ["skip-test"] };
export const RefreshLeadership = leadershipStory(Refresh);
