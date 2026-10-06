import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { HttpResponse, http } from "msw";
import { ProjectDetail } from "./ProjectDetail";
import { atUrl, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";
import { fixtures } from "../mocks/fixtures";

const project = fixtures.projects.find((p) => p.pct_complete < 50) ?? fixtures.projects[0];
const url = `/projects/${project.p2_project_no}`;

const Page = () => (
  <Routes>
    <Route path="/projects/:p2" element={<ProjectDetail />} />
  </Routes>
);

const meta = {
  title: "Pages/Project detail",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl(url, "evs_pm")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const ProjectManager: Story = {};
export const Viewer: Story = { parameters: { role: "evs_viewer" } };
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow(`/projects/${project.p2_project_no}`)) } } };
export const NotFound: Story = { parameters: { url: "/projects/000000" } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing(`/projects/${project.p2_project_no}`)) } } };
/** The API refuses the save (403) even though the UI role is PM: the form drops into read only. */
export const ServerForbidsSave: Story = {
  parameters: { msw: { handlers: withOverrides(http.put("*/api/v1/projects/:p2/status", () => HttpResponse.json({ detail: "Role evs_pm required" }, { status: 403 }))) } },
};
