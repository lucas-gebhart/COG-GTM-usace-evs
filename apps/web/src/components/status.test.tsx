import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe } from "./test-utils";
import { StatusChip } from "./StatusChip";
import { StatusMarker } from "./StatusMarker";
import { STATUS_VALUES } from "./status";

describe("StatusChip", () => {
  it("shows the label text and a shape for every status", async () => {
    const { container } = render(
      <div>
        {STATUS_VALUES.map((s) => (
          <StatusChip key={s} status={s} />
        ))}
      </div>,
    );
    for (const label of ["Operating", "Delayed", "Closed", "Stale", "Unknown"]) expect(screen.getByText(label)).toBeInTheDocument();
    expect(container.querySelectorAll("svg.evs-chip__shape")).toHaveLength(5);
    expect(await axe(container)).toHaveNoViolations();
  });

  it("keeps the canonical status in the accessible text when the label is customised", () => {
    render(<StatusChip status="delayed" label="Delayed 45 min" />);
    expect(screen.getByText("Delayed 45 min")).toBeInTheDocument();
    expect(screen.getByText(/status Delayed/)).toHaveClass("evs-sr-only");
  });

  it("falls back to Unknown for unexpected values and exposes an aria-label when icon only", () => {
    render(<StatusChip status="weird" iconOnly />);
    expect(screen.getByRole("img", { name: "Unknown" })).toBeInTheDocument();
  });
});

describe("StatusMarker", () => {
  it("renders an image with subject and status in the name", async () => {
    const { container } = render(<StatusMarker status="closed" label="Lock and Dam 18" />);
    expect(screen.getByRole("img", { name: "Lock and Dam 18: Closed" })).toBeInTheDocument();
    expect(await axe(container)).toHaveNoViolations();
  });

  it("is a 44 px button when activatable and fires on click and Enter", async () => {
    const onActivate = vi.fn();
    const user = userEvent.setup();
    render(<StatusMarker status="operating" label="Lock 1" onActivate={onActivate} />);
    const btn = screen.getByRole("button", { name: "Lock 1: Operating" });
    expect(btn).toHaveClass("evs-marker");
    await user.click(btn);
    btn.focus();
    await user.keyboard("{Enter}");
    expect(onActivate).toHaveBeenCalledTimes(2);
  });
});
