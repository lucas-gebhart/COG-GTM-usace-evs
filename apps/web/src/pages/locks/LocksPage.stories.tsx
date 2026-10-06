import type { Meta, StoryObj } from "@storybook/react-vite";
import { createMemoryRouter, RouterProvider } from "react-router";
import { LiveRegionProvider } from "../../hooks/useAnnounce";
import { fixtures } from "../../mocks/fixtures";
import { LocksPage } from "./LocksPage";
import { LockDetailPage } from "./LockDetailPage";

function Page({ url }: { url: string }) {
  const router = createMemoryRouter(
    [
      { path: "/public/locks", element: <LocksPage /> },
      { path: "/public/locks/:id", element: <LockDetailPage /> },
    ],
    { initialEntries: [url] },
  );
  return (
    <LiveRegionProvider>
      <main id="main">
        <RouterProvider router={router} />
      </main>
    </LiveRegionProvider>
  );
}

const meta = {
  title: "Pages/Public/Lock status",
  component: Page,
  parameters: { router: false, layout: "padded" },
} satisfies Meta<typeof Page>;
export default meta;
type Story = StoryObj<typeof meta>;

const first = fixtures.locks.items[0];

export const Table: Story = { args: { url: "/public/locks" } };
export const FilteredByRiver: Story = { args: { url: `/public/locks?river=${first.river_code}` } };
export const MapWithPanel: Story = { args: { url: `/public/locks?view=map&lock=${first.lock_id}` } };
export const Mobile375: Story = { args: { url: "/public/locks" }, globals: { viewport: { value: "mobile360", isRotated: false } } };
export const DetailPage: Story = { args: { url: `/public/locks/${first.lock_id}` } };
