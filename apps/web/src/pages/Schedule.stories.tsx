import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { Schedule } from "./Schedule";
import { atUrl, emptyList, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";

const Page = () => (
  <Routes>
    <Route path="/schedule" element={<Schedule />} />
  </Routes>
);

const meta = {
  title: "Pages/Schedule",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/schedule")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const ViewerReadOnly: Story = { parameters: { role: "evs_viewer" } };
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/projects")) } } };
export const Empty: Story = { parameters: { msw: { handlers: withOverrides(emptyList("/projects")) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/projects")) } } };
