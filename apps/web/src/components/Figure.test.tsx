import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe } from "./test-utils";
import { Figure } from "./Figure";
import * as csv from "../lib/csv";

const data = [
  { period: "2025-10-01", plan: 200, actual: 162 },
  { period: "2025-11-01", plan: 400, actual: 363 },
];
const columns = [
  { key: "period", header: "Period", rowHeader: true },
  { key: "plan", header: "Plan", numeric: true },
  { key: "actual", header: "Actual", numeric: true },
];

function renderFigure(extra: Partial<React.ComponentProps<typeof Figure<(typeof data)[number]>>> = {}) {
  return render(
    <Figure title="Execution curve" description="Actuals trail plan by 9 percent." data={data} columns={columns} {...extra}>
      {({ reducedMotion }) => <svg data-testid="chart" data-reduced={String(reducedMotion)} />}
    </Figure>,
  );
}

describe("Figure", () => {
  it("links title and description to the figure and toggles to a table", async () => {
    const { container } = renderFigure();
    const fig = screen.getByRole("figure", { name: "Execution curve" });
    expect(fig).toHaveAccessibleDescription("Actuals trail plan by 9 percent.");
    expect(screen.getByTestId("chart")).toBeInTheDocument();

    const toggle = screen.getByRole("button", { name: "View as table" });
    expect(toggle).toHaveAttribute("aria-pressed", "false");
    await userEvent.click(toggle);
    expect(screen.getByRole("button", { name: "View as chart" })).toHaveAttribute("aria-pressed", "true");
    expect(screen.queryByTestId("chart")).not.toBeInTheDocument();
    expect(screen.getByRole("columnheader", { name: "Plan" })).toBeInTheDocument();
    expect(screen.getByRole("rowheader", { name: "2025-10-01" })).toBeInTheDocument();
    expect(await axe(container)).toHaveNoViolations();
  });

  it("downloads a CSV built from the columns", async () => {
    const spy = vi.spyOn(csv, "downloadCsv").mockImplementation(() => {});
    renderFigure();
    await userEvent.click(screen.getByRole("button", { name: "Download CSV" }));
    expect(spy).toHaveBeenCalledWith("execution-curve", "Period,Plan,Actual\r\n2025-10-01,200,162\r\n2025-11-01,400,363\r\n");
    spy.mockRestore();
  });

  it("passes reduced motion to the render function", () => {
    window.matchMedia = ((q: string) => ({ matches: q.includes("reduce"), media: q, addEventListener() {}, removeEventListener() {}, onchange: null, addListener() {}, removeListener() {}, dispatchEvent: () => false })) as typeof window.matchMedia;
    renderFigure();
    expect(screen.getByTestId("chart")).toHaveAttribute("data-reduced", "true");
  });
});
