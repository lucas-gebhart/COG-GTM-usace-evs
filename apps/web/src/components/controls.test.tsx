import { act, render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe } from "./test-utils";
import { ThemeToggle } from "./ThemeToggle";
import { RefreshControl } from "./RefreshControl";

describe("ThemeToggle", () => {
  afterEach(() => {
    delete document.documentElement.dataset.theme;
    localStorage.clear();
  });

  it("toggles data-theme on <html> and persists", async () => {
    const { container } = render(<ThemeToggle />);
    const btn = screen.getByRole("button", { name: "Switch to leadership view" });
    expect(btn).toHaveAttribute("aria-pressed", "false");
    await userEvent.click(btn);
    expect(document.documentElement.dataset.theme).toBe("leadership");
    expect(localStorage.getItem("evs.theme")).toBe("leadership");
    expect(screen.getByRole("button", { name: "Switch to standard view" })).toHaveAttribute("aria-pressed", "true");
    await userEvent.click(screen.getByRole("button"));
    expect(document.documentElement.dataset.theme).toBeUndefined();
    expect(await axe(container)).toHaveNoViolations();
  });
});

describe("RefreshControl", () => {
  beforeEach(() => vi.useFakeTimers({ shouldAdvanceTime: true }));
  afterEach(() => vi.useRealTimers());

  it("counts down, pauses and refreshes on demand", async () => {
    const onRefresh = vi.fn();
    const user = userEvent.setup({ advanceTimers: vi.advanceTimersByTime });
    const { container } = render(<RefreshControl onRefresh={onRefresh} intervalSeconds={3} />);
    expect(screen.getByTestId("refresh-status")).toHaveTextContent("Refresh in 3 s");
    await act(async () => {
      vi.advanceTimersByTime(1000);
    });
    expect(screen.getByTestId("refresh-status")).toHaveTextContent("Refresh in 2 s");
    await act(async () => {
      vi.advanceTimersByTime(2000);
    });
    expect(onRefresh).toHaveBeenCalledTimes(1);

    await user.click(screen.getByRole("button", { name: "Pause" }));
    expect(screen.getByTestId("refresh-status")).toHaveTextContent("Auto refresh paused");
    await act(async () => {
      vi.advanceTimersByTime(5000);
    });
    expect(onRefresh).toHaveBeenCalledTimes(1);

    await user.click(screen.getByRole("button", { name: "Refresh now" }));
    expect(onRefresh).toHaveBeenCalledTimes(2);
    expect(await axe(container)).toHaveNoViolations();
  });
});
