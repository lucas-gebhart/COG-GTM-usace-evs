import { screen, waitFor, within } from "@testing-library/react";
import { axe, renderPage, setupPageServer } from "./shared/test-utils";
import { Facilities } from "./Facilities";

setupPageServer();

describe("Facilities", () => {
  it("renders the CI distribution, deficiency cost by year and the component table with no axe violations", async () => {
    const { container } = renderPage(<Facilities />, { url: "/facilities" });
    const table = await screen.findByRole("table", { name: /builder components/i });
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    await waitFor(() => expect(screen.getAllByRole("figure")).toHaveLength(2));
    expect(within(table).getByRole("columnheader", { name: /condition/i })).toBeInTheDocument();
    expect(within(table).getAllByText(/^(poor|fair|good), ci/i).length).toBeGreaterThan(0);
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("New in EVS, no APEX source page");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("filters to poor condition through the URL", async () => {
    renderPage(<Facilities />, { url: "/facilities?max_ci=39.99", path: "/facilities" });
    const table = await screen.findByRole("table", { name: /builder components/i });
    await waitFor(() => expect(within(table).queryAllByText(/^(fair|good), ci/i)).toHaveLength(0));
  });
});
