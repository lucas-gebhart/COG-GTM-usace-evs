import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { HttpResponse, http } from "msw";
import { Admin } from "./Admin";
import { atUrl, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";
import { fixtures } from "../mocks/fixtures";

const Page = () => (
  <Routes>
    <Route path="/admin" element={<Admin />} />
  </Routes>
);

const meta = {
  title: "Pages/Admin",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/admin")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const ProjectManagerGate: Story = { parameters: { role: "evs_pm" } };
export const LiveFeedsDegraded: Story = {
  parameters: {
    msw: {
      handlers: withOverrides(
        http.get("*/api/v1/admin/feeds", () =>
          HttpResponse.json({
            generated_at: new Date().toISOString(),
            feeds: fixtures.feeds.map((f, i) => ({
              ...f,
              mode: "live",
              status: (["healthy", "degraded", "down", "healthy", "simulated", "healthy"] as const)[i % 6],
              last_success_at: new Date(Date.now() - i * 37 * 60_000).toISOString(),
              consecutive_failures: i === 2 ? 4 : 0,
              rows_parsed: i === 2 ? 0 : 77 + i,
            })),
          }),
        ),
      ),
    },
  },
};
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/admin/feeds"), slow("/admin/thresholds")) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/admin/feeds")) } } };
