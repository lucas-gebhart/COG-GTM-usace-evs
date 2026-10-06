import type { Meta, StoryObj } from "@storybook/react-vite";
import { createMemoryRouter, RouterProvider } from "react-router";
import { LiveRegionProvider } from "../../hooks/useAnnounce";
import { fixtures } from "../../mocks/fixtures";
import { SrpPage } from "./SrpPage";

function Page({ url }: { url: string }) {
  const router = createMemoryRouter([{ path: "/public/srp", element: <SrpPage /> }], { initialEntries: [url] });
  return (
    <LiveRegionProvider>
      <main id="main">
        <RouterProvider router={router} />
      </main>
    </LiveRegionProvider>
  );
}

const meta = {
  title: "Pages/Public/Sustainable Rivers Program",
  component: Page,
  parameters: { router: false, layout: "padded" },
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = { args: { url: "/public/srp" } };
export const SitePanel: Story = { args: { url: `/public/srp?site=${encodeURIComponent(fixtures.srp.sites[0].nid_id ?? fixtures.srp.sites[0].name)}` } };
export const Mobile375: Story = { args: { url: "/public/srp" }, globals: { viewport: { value: "mobile360", isRotated: false } } };
