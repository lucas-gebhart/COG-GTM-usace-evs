import { screen, waitFor, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { HttpResponse, http } from "msw";
import { axe, fixtures, renderPage, server, setupPageServer } from "./shared/test-utils";
import { Schedule } from "./Schedule";
import { KANBAN_COLUMNS, kanbanColumnId } from "../hooks/useApi";

setupPageServer();

const low = [...fixtures.projects].sort((a, b) => a.pct_complete - b.pct_complete)[0];
const lowColumn = KANBAN_COLUMNS.find((c) => c.id === kanbanColumnId(low.pct_complete))!;
const target = KANBAN_COLUMNS.find((c) => c.id !== lowColumn.id && c.id !== 4)!;

function columnOf(p2: string) {
  const card = screen.getByText(new RegExp(`^${p2},`)).closest("li")!;
  return card.closest(".evs-kanban__column")!.querySelector("h3")!.textContent;
}

describe("Schedule", () => {
  it("renders five Kanban columns, cards with Move to menus, the slip list and the APEX tag, with no axe violations", async () => {
    const { container } = renderPage(<Schedule />, { url: "/schedule", role: "evs_pm" });
    expect(await screen.findByRole("heading", { level: 3, name: /identified/i })).toBeInTheDocument();
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(screen.getAllByRole("list", { name: /cards$/i })).toHaveLength(5);
    expect(screen.getAllByRole("button", { name: /^move to/i }).length).toBeGreaterThan(0);
    expect(await screen.findByRole("table", { name: /slipped milestones/i })).toBeInTheDocument();
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 4");
    expect(await axe(container)).toHaveNoViolations();
  }, 20_000);

  it("moves a card from the keyboard menu and closes the menu on Escape", async () => {
    const user = userEvent.setup();
    renderPage(<Schedule />, { url: "/schedule", role: "evs_pm" });
    await screen.findByRole("heading", { level: 3, name: /identified/i });
    expect(columnOf(low.p2_project_no)).toContain(lowColumn.heading);
    const button = screen.getByRole("button", { name: new RegExp(`move to ${low.p2_project_no}`, "i") });
    await user.click(button);
    const menu = screen.getByRole("menu");
    expect(within(menu).getAllByRole("menuitem")).toHaveLength(4);
    await user.keyboard("{Escape}");
    expect(screen.queryByRole("menu")).not.toBeInTheDocument();
    expect(button).toHaveFocus();
    await user.click(button);
    await user.click(screen.getByRole("menuitem", { name: new RegExp(`move to ${target.heading}`, "i") }));
    await waitFor(() => expect(columnOf(low.p2_project_no)).toContain(target.heading));
  });

  it("rolls the card back when the server rejects the move", async () => {
    server.use(http.post("*/api/v1/projects/:p2/kanban/move", () => HttpResponse.json({ detail: "Role evs_pm required" }, { status: 403 })));
    const user = userEvent.setup();
    renderPage(<Schedule />, { url: "/schedule", role: "evs_pm" });
    await screen.findByRole("heading", { level: 3, name: /identified/i });
    await user.click(screen.getByRole("button", { name: new RegExp(`move to ${low.p2_project_no}`, "i") }));
    await user.click(screen.getByRole("menuitem", { name: /move to in development/i }));
    expect((await screen.findAllByText(/was put back/i)).length).toBeGreaterThan(0);
    await waitFor(() => expect(columnOf(low.p2_project_no)).toContain(lowColumn.heading));
  });

  it("hides the move controls for evs_viewer", async () => {
    renderPage(<Schedule />, { url: "/schedule", role: "evs_viewer" });
    await screen.findByRole("heading", { level: 3, name: /identified/i });
    expect(screen.queryByRole("button", { name: /^move to/i })).not.toBeInTheDocument();
    expect(screen.getByText(/read only/i)).toBeInTheDocument();
  });
});
