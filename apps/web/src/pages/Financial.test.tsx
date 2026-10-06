import { screen, waitFor } from "@testing-library/react";
import { axe, renderPage, setupPageServer } from "./shared/test-utils";
import { Financial } from "./Financial";

setupPageServer();

describe("Financial", () => {
  it("renders the execution curve, appropriation chart and variance table with no axe violations", async () => {
    const { container } = renderPage(<Financial />, { url: "/financial" });
    expect(await screen.findByRole("figure", { name: /cumulative obligations and expenditures by month/i })).toBeInTheDocument();
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    await waitFor(() => expect(screen.getAllByRole("figure")).toHaveLength(2));
    expect(await screen.findByRole("table", { name: /obligation variance to plan/i })).toBeInTheDocument();
    expect(screen.queryByText(/project count by status/i)).not.toBeInTheDocument();
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 161");
    expect(await axe(container)).toHaveNoViolations();
  });
});
