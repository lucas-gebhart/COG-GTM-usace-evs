import { render, screen, waitFor, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { createMemoryRouter, RouterProvider } from "react-router";
import { axe } from "../../components/test-utils";
import { LiveRegionProvider } from "../../hooks/useAnnounce";
import { fixtures } from "../../mocks/fixtures";
import { server } from "../../mocks/server";
import { LocksPage } from "./LocksPage";
import { LockDetailPage } from "./LockDetailPage";

beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function mount(url: string) {
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  const router = createMemoryRouter(
    [
      { path: "/public/locks", element: <LocksPage /> },
      { path: "/public/locks/:id", element: <LockDetailPage /> },
    ],
    { initialEntries: [url] },
  );
  const utils = render(
    <QueryClientProvider client={qc}>
      <LiveRegionProvider>
        <RouterProvider router={router} />
      </LiveRegionProvider>
    </QueryClientProvider>,
  );
  return { ...utils, router };
}

const first = fixtures.locks.items[0];

describe("LocksPage", () => {
  it("renders counts, the as-of live region, filters and the table with no axe violations", async () => {
    const { container } = mount("/public/locks");
    expect(screen.getByRole("heading", { level: 1, name: "Lock status by river" })).toBeInTheDocument();
    await screen.findByTestId("locks-strip");
    expect(within(screen.getByTestId("count-operating")).getByText(String(fixtures.locks.counts.operating))).toBeInTheDocument();
    const live = screen.getByTestId("locks-asof");
    expect(live).toHaveAttribute("aria-live", "polite");
    expect(live).toHaveTextContent(/^As of .*fetched .*source fixtures\.$/);
    expect(screen.getByRole("button", { name: /Live updates (on|off)/ })).toBeInTheDocument();
    expect(screen.getByLabelText("River system")).toBeInTheDocument();
    expect(screen.getByRole("table")).toBeInTheDocument();
    expect(screen.getAllByRole("rowheader", { name: new RegExp(`^${first.lock_name} \\(${first.lock_id}`) }).length).toBe(1);
    expect(await axe(container)).toHaveNoViolations();
  }, 20000);

  it("filters by river from the URL and keeps the selection in the URL", async () => {
    const river = first.river_code;
    const expected = new Set(fixtures.locks.items.filter((i) => i.river_code === river).map((i) => i.lock_id));
    const { router } = mount(`/public/locks?river=${river}&status=&q=`);
    await screen.findByTestId("locks-strip");
    const rows = screen.getAllByRole("row").slice(1);
    expect(rows.length).toBe(Math.min(expected.size, 25));
    expect(screen.getByLabelText("River system")).toHaveValue(river);
    expect(router.state.location.search).toContain(`river=${river}`);
  });

  it("opens the detail side panel for ?lock= and renders the 24-hour history figure", async () => {
    const { container } = mount(`/public/locks?lock=${first.lock_id}`);
    const dialog = await screen.findByRole("dialog");
    expect(within(dialog).getByRole("heading", { level: 2 })).toHaveTextContent(first.lock_name);
    await within(dialog).findByText("Status, last 24 hours");
    expect(within(dialog).getByRole("link", { name: "Full page" })).toHaveAttribute("href", `/public/locks/${first.lock_id}`);
    expect(within(dialog).getByRole("button", { name: /Close .* details/ })).toBeInTheDocument();
    expect(await axe(container)).toHaveNoViolations();
  }, 20000);
});

describe("LockDetailPage", () => {
  it("renders the detail panel full page with one h1 and no axe violations", async () => {
    const { container } = mount(`/public/locks/${first.lock_id}`);
    await waitFor(() => expect(screen.getByRole("heading", { level: 1 })).toHaveTextContent(first.lock_name));
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(screen.getByText("Queue and traffic")).toBeInTheDocument();
    expect(await screen.findByText("Status, last 24 hours")).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Lock status by river" })).toHaveAttribute("href", "/public/locks");
    expect(await axe(container)).toHaveNoViolations();
  }, 20000);

  it("shows an error state for an unknown lock", async () => {
    mount("/public/locks/NOPE-1");
    expect(await screen.findByText(/No lock with ID NOPE-1/)).toBeInTheDocument();
  });
});
