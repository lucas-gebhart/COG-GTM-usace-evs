import type { Meta, StoryObj } from "@storybook/react-vite";
import { Route, Routes } from "react-router";
import { EnterpriseOverview } from "./EnterpriseOverview";
import { atUrl, failing, pageParameters, slow, withOverrides } from "./shared/stories";
import { narrow } from "../stories/decorators";

const Page = () => (
  <Routes>
    <Route path="/" element={<EnterpriseOverview />} />
  </Routes>
);

const meta = {
  title: "Pages/Enterprise overview",
  component: Page,
  parameters: pageParameters,
  decorators: [atUrl("/")],
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Mobile360: Story = { decorators: [narrow(360)] };
export const Leadership: Story = { globals: { theme: "leadership" } };
export const Loading: Story = { parameters: { msw: { handlers: withOverrides(slow("/enterprise/kpis")) } } };
export const ErrorState: Story = { parameters: { msw: { handlers: withOverrides(failing("/enterprise/kpis")) } } };
