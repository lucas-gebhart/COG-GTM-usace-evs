import { render, screen } from "@testing-library/react";
import { axe } from "./test-utils";
import { AsOfBadge } from "./AsOfBadge";

const minutesAgo = (m: number) => new Date(Date.now() - m * 60000).toISOString();

describe("AsOfBadge", () => {
  it("shows freshness text, relative and absolute time in a polite live region", async () => {
    const { container } = render(<AsOfBadge asOf={{ source_as_of: minutesAgo(4), fetched_at: minutesAgo(1), freshness: "fresh", source: "lpms" }} tickMs={0} />);
    const badge = screen.getByTestId("as-of-badge");
    expect(badge).toHaveAttribute("aria-live", "polite");
    expect(screen.getByText("Fresh")).toBeInTheDocument();
    expect(screen.getByText("4 minutes ago")).toBeInTheDocument();
    expect(screen.getAllByText(/UTC/).length).toBeGreaterThan(0);
    expect(screen.getByRole("button", { name: /About this timestamp/ })).toBeInTheDocument();
    expect(screen.getAllByText(/Lock Performance Monitoring System/).length).toBeGreaterThan(0);
    expect(await axe(container)).toHaveNoViolations();
  });

  it("marks stale and simulated states in text", () => {
    const { rerender } = render(<AsOfBadge asOf={{ source_as_of: minutesAgo(90), fetched_at: minutesAgo(1), freshness: "stale", source: "lpms" }} tickMs={0} />);
    expect(screen.getByText("Stale")).toBeInTheDocument();
    rerender(<AsOfBadge asOf={{ source_as_of: minutesAgo(1), fetched_at: minutesAgo(1), freshness: "simulated", source: "simulated" }} tickMs={0} />);
    expect(screen.getByText("Simulated")).toBeInTheDocument();
  });

  it("handles a missing as_of", () => {
    render(<AsOfBadge asOf={null} tickMs={0} />);
    expect(screen.getByText("unknown")).toBeInTheDocument();
  });
});
