import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, screen, waitFor, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { http, HttpResponse } from "msw";
import { MemoryRouter } from "react-router";
import { LiveRegionProvider } from "../hooks/useAnnounce";
import { axe } from "../components/test-utils";
import { fixtures } from "../mocks/fixtures";
import { server } from "../mocks/server";
import { AccessibilityPage } from "./AccessibilityPage";

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function renderPage() {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return render(
    <QueryClientProvider client={client}>
      <LiveRegionProvider>
        <MemoryRouter initialEntries={["/accessibility"]}>
          <AccessibilityPage />
        </MemoryRouter>
      </LiveRegionProvider>
    </QueryClientProvider>,
  );
}

const readout = fixtures.accessibility;

describe("AccessibilityPage", () => {
  it("renders every section from the fixture with one h1 and no axe violations", async () => {
    const { container } = renderPage();
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(screen.getByRole("heading", { level: 1 })).toHaveTextContent("Accessibility read-out");
    await screen.findByRole("heading", { level: 2, name: "Summary" });
    for (const name of ["Conformance table", "Automated results", "Manual test plan status", "Downloads", "Conformance statement"]) {
      expect(screen.getByRole("heading", { level: 2, name })).toBeInTheDocument();
    }
    // KPI values come from the fixture summary, never from the page.
    const s = readout.summary;
    const kpis = screen.getByRole("heading", { level: 2, name: "Summary" }).parentElement!;
    expect(within(kpis).getByText("Supports").parentElement).toHaveTextContent(String(s.supports));
    expect(within(kpis).getByText("Not evaluated").parentElement).toHaveTextContent(String(s.not_evaluated));
    expect(within(kpis).getByText("axe-core").parentElement).toHaveTextContent(readout.versions.axe);
    // Downloads are the API artefact URLs from the fixture.
    for (const a of readout.artifacts) {
      expect(screen.getByRole("link", { name: a.label })).toHaveAttribute("href", a.href);
    }
    // Status chips carry shape text for screen readers, not colour alone.
    const table = screen.getByRole("table", { name: /Conformance by criterion/ });
    expect(within(table).getAllByText(/circle|triangle|octagon|ring|diamond/).length).toBeGreaterThan(0);
    expect(await axe(container)).toHaveNoViolations();
  }, 30000);

  it("filters the conformance table by status and chapter", async () => {
    const user = userEvent.setup();
    renderPage();
    await screen.findByRole("heading", { level: 2, name: "Summary" });
    const rows = [...readout.criteria, ...(readout.section508 ?? [])];
    const notEvaluated = rows.filter((r) => r.status === "not-evaluated").length;
    await user.selectOptions(screen.getByLabelText("Status"), "not-evaluated");
    await user.click(screen.getByRole("button", { name: /apply/i }));
    await waitFor(() => expect(screen.getByText(`${notEvaluated} of ${rows.length} rows`, { exact: false })).toBeInTheDocument());
    await user.selectOptions(screen.getByLabelText("Chapter"), "functional_performance_criteria");
    await user.click(screen.getByRole("button", { name: /apply/i }));
    const fpc = rows.filter((r) => r.status === "not-evaluated" && r.chapter === "functional_performance_criteria").length;
    await waitFor(() => expect(screen.getByText(`${fpc} of ${rows.length} rows`, { exact: false })).toBeInTheDocument());
  });

  it("shows the error state with retry when the API fails", async () => {
    server.use(http.get("*/api/v1/accessibility/readout", () => HttpResponse.json({ detail: "boom" }, { status: 500 })));
    renderPage();
    expect(await screen.findByRole("heading", { level: 1 })).toBeInTheDocument();
    expect(await screen.findByText(/could not be loaded/)).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /retry|try again/i })).toBeInTheDocument();
  });

  it("shows the empty state for automated results when the fixture has no cells", async () => {
    server.use(
      http.get("*/api/v1/accessibility/readout", () =>
        HttpResponse.json({ ...readout, routes: [], summary: { ...readout.summary, cells: 0, routes_tested: 0, zero_violation_cells: 0, viewports: [], themes: [] } }),
      ),
    );
    renderPage();
    expect(await screen.findByText("No automated evidence in this build")).toBeInTheDocument();
  });
});
