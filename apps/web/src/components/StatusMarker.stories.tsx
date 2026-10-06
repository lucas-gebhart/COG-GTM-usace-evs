import type { Meta, StoryObj } from "@storybook/react-vite";
import { fn } from "storybook/test";
import { StatusMarker } from "./StatusMarker";
import { STATUS_VALUES } from "./status";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Components/StatusMarker",
  component: StatusMarker,
  tags: ["autodocs"],
  args: { status: "operating", label: "Lock and Dam 18" },
} satisfies Meta<typeof StatusMarker>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Static: Story = {};
export const AsButton: Story = { args: { status: "delayed", onActivate: fn() } };
export const AllShapes: Story = {
  render: () => (
    <ul style={{ display: "flex", gap: "0.5rem", listStyle: "none", padding: 0, margin: 0 }}>
      {STATUS_VALUES.map((s) => (
        <li key={s} style={{ display: "flex", flexDirection: "column", alignItems: "center", fontSize: "0.875rem" }}>
          <StatusMarker status={s} label={`Example ${s}`} onActivate={fn()} />
          {s}
        </li>
      ))}
    </ul>
  ),
};
export const AllShapesLeadership = leadershipStory(AllShapes);
