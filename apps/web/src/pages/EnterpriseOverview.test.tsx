import { screen, waitFor } from "@testing-library/react";
import { HttpResponse, http } from "msw";
import { axe, renderPage, server, setupPageServer } from "./shared/test-utils";
import { EnterpriseOverview } from "./EnterpriseOverview";

setupPageServer();

describe("EnterpriseOverview", () => {
  it("renders one h1, the KPI tiles, four figures and the APEX tag, with no axe violations", async () => {
    const { container } = renderPage(<EnterpriseOverview />, { url: "/" });
    expect(await screen.findByText("Obligation rate")).toBeInTheDocument();
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    for (const label of ["Projects on schedule", "Labor utilization", "Average facility CI", "Locks operating now"]) {
      expect(await screen.findByText(label)).toBeInTheDocument();
    }
    await waitFor(() => expect(screen.getAllByRole("figure")).toHaveLength(4));
    expect(screen.getAllByRole("button", { name: /download csv/i })).toHaveLength(4);
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 1");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("shows the error state with retry when the KPI endpoint fails", async () => {
    server.use(http.get("*/api/v1/enterprise/kpis", () => HttpResponse.json({ detail: "boom" }, { status: 500 })));
    renderPage(<EnterpriseOverview />, { url: "/" });
    expect(await screen.findByRole("button", { name: /retry|try again/i })).toBeInTheDocument();
  });
});
