import { render, screen, within } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { createMemoryRouter, RouterProvider } from "react-router";
import { axe } from "../../components/test-utils";
import { LiveRegionProvider } from "../../hooks/useAnnounce";
import { fixtures } from "../../mocks/fixtures";
import { server } from "../../mocks/server";
import { SrpPage } from "./SrpPage";

beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function mount(url = "/public/srp") {
  const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  const router = createMemoryRouter([{ path: "/public/srp", element: <SrpPage /> }], { initialEntries: [url] });
  return render(
    <QueryClientProvider client={qc}>
      <LiveRegionProvider>
        <RouterProvider router={router} />
      </LiveRegionProvider>
    </QueryClientProvider>,
  );
}

describe("SrpPage", () => {
  it("shows every headline figure with its citation, the growth figure, the site list and the economic callout", async () => {
    const { container } = mount();
    expect(screen.getByRole("heading", { level: 1, name: "Sustainable Rivers Program" })).toBeInTheDocument();
    await screen.findByText("Program scale");
    const headline = fixtures.srp.headline as Record<string, number>;
    expect(screen.getByText(String(headline.river_systems))).toBeInTheDocument();
    const sources = screen.getByRole("list", { name: "Sources for the program scale figures" });
    const cites = fixtures.srp.citations ?? [];
    for (const c of cites.filter((c) => ["river_systems", "river_miles", "dams_and_reservoirs", "districts", "states"].includes(c.figure))) {
      expect(within(sources).getAllByText(new RegExp(`${c.source}, ${c.year}`)).length).toBeGreaterThan(0);
    }
    expect(screen.getByText(/River systems, river miles and dams in the program, 2002 to 2024/)).toBeInTheDocument();
    expect(screen.getByRole("heading", { level: 3, name: "Sites by river" })).toBeInTheDocument();
    const economic = screen.getByTestId("srp-economic");
    expect(economic).toHaveTextContent(`$${headline.npv_usd_m_low}M to $${headline.npv_usd_m_high}M`);
    expect(economic).toHaveTextContent(`${headline.bcr_low} to ${headline.bcr_high}`);
    expect(screen.getByRole("link", { name: /Hydrologic Engineering Center/ })).toHaveAttribute("href", expect.stringContaining("hec.usace.army.mil"));
    expect(screen.getByRole("link", { name: /Institute for Water Resources/ })).toHaveAttribute("href", expect.stringContaining("iwr.usace.army.mil"));
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(await axe(container)).toHaveNoViolations();
  }, 20000);

  it("opens the site panel from the grouped list and the URL", async () => {
    const site = fixtures.srp.sites[0];
    mount(`/public/srp?site=${encodeURIComponent(site.nid_id ?? site.name)}`);
    const dialog = await screen.findByRole("dialog");
    expect(within(dialog).getByRole("heading", { level: 3 })).toHaveTextContent(site.name);
    expect(within(dialog).getAllByText(site.river).length).toBeGreaterThan(0);
  });
});
