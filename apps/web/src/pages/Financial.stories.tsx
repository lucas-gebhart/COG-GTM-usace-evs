import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { Financial } from "./Financial";
import { HttpResponse, http } from "msw";
import { atUrl, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";

const Page = () => (
  <Routes>
    <Route path="/financial" element={<Financial />} />
  </Routes>
);

const meta = {
  title: "Pages/Financial",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/financial")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/financial/summary")) } } };
export const Empty: Story = { parameters: { msw: { handlers: withOverrides(http.get("*/api/v1/financial/variance-by-program", () => HttpResponse.json({ fiscal_year: 2026, rows: [], as_of: { source_as_of: new Date().toISOString(), fetched_at: new Date().toISOString(), freshness: "fresh", source: "synthetic" } }))) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/financial/summary")) } } };
