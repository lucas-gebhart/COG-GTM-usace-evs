import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { Facilities } from "./Facilities";
import { HttpResponse, http } from "msw";
import { atUrl, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";

const Page = () => (
  <Routes>
    <Route path="/facilities" element={<Facilities />} />
  </Routes>
);

const meta = {
  title: "Pages/Facilities",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/facilities")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/facilities/condition")) } } };
export const Empty: Story = { parameters: { msw: { handlers: withOverrides(http.get("*/api/v1/facilities/condition", () => HttpResponse.json({ fiscal_year: 2026, rows: [], page: { total: 0, limit: 500, offset: 0 }, as_of: { source_as_of: new Date().toISOString(), fetched_at: new Date().toISOString(), freshness: "fresh", source: "synthetic" } }))) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/facilities/condition")) } } };
