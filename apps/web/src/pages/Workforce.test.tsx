import { screen, waitFor, within } from "@testing-library/react";
import { axe, renderPage, setupPageServer } from "./shared/test-utils";
import { Workforce } from "./Workforce";

setupPageServer();

describe("Workforce", () => {
  it("renders hours and utilization figures and the IR table with an overtime flag, with no axe violations", async () => {
    const { container } = renderPage(<Workforce />, { url: "/workforce" });
    const table = await screen.findByRole("table", { name: /ems labor by district and pay period/i });
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    await waitFor(() => expect(screen.getAllByRole("figure")).toHaveLength(2));
    expect(within(table).getByRole("columnheader", { name: /overtime flag/i })).toBeInTheDocument();
    expect(within(table).getAllByText(/overtime|within plan/i).length).toBeGreaterThan(0);
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 74");
    expect(await axe(container)).toHaveNoViolations();
  });
});
