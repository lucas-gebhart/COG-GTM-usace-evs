import type { Meta, StoryObj } from "@storybook/react-vite";
import { createMemoryRouter, RouterProvider } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { routes } from "./routes";
import { leadershipStory } from "../stories/decorators";

function Shell({ path = "/" }: { path?: string }) {
  const router = createMemoryRouter(
    [{ path: "/", element: <AppLayout />, children: routes.map((r) => ({ path: r.path, element: <Placeholder title={r.title} /> })) }],
    { initialEntries: [path] },
  );
  return <RouterProvider router={router} />;
}

const meta = {
  title: "Shell/AppLayout",
  component: Shell,
  // The shell owns its own router and live regions, so the global router decorator is skipped here.
  decorators: [(Story) => <Story />],
  parameters: {
    router: false, layout: "fullscreen" },
} satisfies Meta<typeof Shell>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Overview: Story = {};
export const LocksPage: Story = { args: { path: "/public/locks" } };
export const OverviewLeadership = leadershipStory(Overview);
