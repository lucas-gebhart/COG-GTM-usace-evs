import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { Programs } from "./Programs";
import { atUrl, emptyList, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";

const Page = () => (
  <Routes>
    <Route path="/programs" element={<Programs />} />
  </Routes>
);

const meta = {
  title: "Pages/Programs",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/programs")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/programs")) } } };
export const Empty: Story = { parameters: { msw: { handlers: withOverrides(emptyList("/programs")) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/programs")) } } };
