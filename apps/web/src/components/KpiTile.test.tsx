import { render, screen } from "@testing-library/react";
import { axe } from "./test-utils";
import { KpiTile } from "./KpiTile";

describe("KpiTile", () => {
  it("names the region by its label and describes the delta in words", async () => {
    const { container } = render(<KpiTile label="Obligated" value="$1.42B" deltaPct={-3.1} deltaLabel="vs plan" context="Plan $1.47B" />);
    expect(screen.getByRole("region", { name: "Obligated" })).toBeInTheDocument();
    expect(screen.getByText("$1.42B")).toBeInTheDocument();
    expect(screen.getByText("down 3.1% vs plan")).toHaveClass("evs-sr-only");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("omits the delta row when deltaPct is null", () => {
    render(<KpiTile label="Locks operating" value="57" unit="of 77" deltaPct={null} />);
    expect(screen.queryByText(/vs plan/)).not.toBeInTheDocument();
    expect(screen.getByText("of 77")).toBeInTheDocument();
  });
});
