import { screen, waitFor, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { HttpResponse, http } from "msw";
import { axe, renderPage, server, setupPageServer } from "./shared/test-utils";
import { Admin, validateThresholds } from "./Admin";

setupPageServer();

describe("Admin", () => {
  it("renders feed health and the thresholds form for an administrator with no axe violations", async () => {
    const { container } = renderPage(<Admin />, { url: "/admin" });
    const table = await screen.findByRole("table", { name: /feed health/i });
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(within(table).getAllByText(/^(healthy|degraded|down|fixtures|simulated)$/i).length).toBeGreaterThan(0);
    const form = await screen.findByTestId("thresholds-form");
    expect(within(form).getByLabelText(/red delay/i)).toHaveValue(240);
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 10000");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("validates inline before saving and then saves optimistically", async () => {
    const user = userEvent.setup();
    renderPage(<Admin />, { url: "/admin" });
    const form = await screen.findByTestId("thresholds-form");
    const red = within(form).getByLabelText(/red delay/i);
    await user.clear(red);
    await user.type(red, "30");
    await user.click(within(form).getByRole("button", { name: /save thresholds/i }));
    expect(await within(form).findByText(/red delay must exceed yellow delay/i)).toBeInTheDocument();
    expect(red).toHaveFocus();
    await user.clear(red);
    await user.type(red, "300");
    await user.click(within(form).getByRole("button", { name: /save thresholds/i }));
    expect(await within(form).findByText(/thresholds saved by dev/i, {}, { timeout: 3000 })).toBeInTheDocument();
    await waitFor(() => expect(within(form).getByText(/last changed .* by dev/i)).toBeInTheDocument());
  });

  it("shows the role gate for a project manager and the 403 path on save", async () => {
    renderPage(<Admin />, { url: "/admin", role: "evs_pm" });
    expect(await screen.findByRole("heading", { name: /administrator role required/i })).toBeInTheDocument();
    expect(screen.queryByTestId("thresholds-form")).not.toBeInTheDocument();

    server.use(http.put("*/api/v1/admin/thresholds", () => HttpResponse.json({ detail: "Requires role evs_admin" }, { status: 403 })));
    const user = userEvent.setup();
    renderPage(<Admin />, { url: "/admin" });
    const form = await screen.findByTestId("thresholds-form");
    await user.click(within(form).getByRole("button", { name: /save thresholds/i }));
    expect(await within(form).findByText(/refused the last save \(403\)/i)).toBeInTheDocument();
    expect(within(form).getByLabelText(/red delay/i)).toBeDisabled();
  });

  it("validateThresholds enforces ranges and ordering", () => {
    const ok = { stale_after_minutes: "120", delay_yellow_minutes: "60", delay_red_minutes: "240", queue_yellow_vessels: "6", lpms_failover_hours: "6" };
    expect(validateThresholds(ok)).toEqual({});
    expect(validateThresholds({ ...ok, queue_yellow_vessels: "0" })).toHaveProperty("queue_yellow_vessels");
    expect(validateThresholds({ ...ok, delay_red_minutes: "60" })).toHaveProperty("delay_red_minutes");
    expect(validateThresholds({ ...ok, lpms_failover_hours: "1.5" })).toHaveProperty("lpms_failover_hours");
  });
});
