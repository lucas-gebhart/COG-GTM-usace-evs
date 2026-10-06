import { screen, waitFor, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { HttpResponse, http } from "msw";
import { axe, fixtures, renderPage, server, setupPageServer } from "./shared/test-utils";
import { ProjectDetail } from "./ProjectDetail";

setupPageServer();

const project = fixtures.projects.find((p) => p.pct_complete < 50 && p.milestones.length > 0) ?? fixtures.projects[0];
const url = `/projects/${project.p2_project_no}`;
const opts = { url, path: "/projects/:p2" } as const;

describe("ProjectDetail", () => {
  it("renders the header, status form, tabs and APEX tag with no axe violations", async () => {
    const { container } = renderPage(<ProjectDetail />, opts);
    expect(await screen.findByRole("heading", { level: 1, name: new RegExp(project.name) })).toBeInTheDocument();
    expect(screen.getByTestId("status-form")).toBeInTheDocument();
    expect(screen.getAllByRole("tab")).toHaveLength(5);
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 3");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("is read only for evs_viewer", async () => {
    renderPage(<ProjectDetail />, { ...opts, role: "evs_viewer" });
    await screen.findByTestId("status-form");
    expect(screen.getByText(/read only: role evs_viewer/i)).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /save status/i })).toBeDisabled();
    expect(screen.getByLabelText(/percent complete/i)).toBeDisabled();
  });

  it("validates inline before saving and moves focus to the first error", async () => {
    const user = userEvent.setup();
    renderPage(<ProjectDetail />, { ...opts, role: "evs_pm" });
    await screen.findByTestId("status-form");
    await user.selectOptions(screen.getByLabelText(/percent complete/i), "60");
    await user.clear(screen.getByLabelText(/current finish/i));
    await user.click(screen.getByRole("button", { name: /save status/i }));
    expect(await screen.findByText(/provide a current finish date/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/current finish/i)).toHaveFocus();
    expect(screen.getByLabelText(/current finish/i)).toHaveAttribute("aria-invalid", "true");
  });

  it("saves optimistically and records the change in the history", async () => {
    const user = userEvent.setup();
    renderPage(<ProjectDetail />, { ...opts, role: "evs_pm" });
    await screen.findByTestId("status-form");
    await user.selectOptions(screen.getByLabelText(/percent complete/i), "40");
    await user.type(screen.getByLabelText(/pm note/i), "Reviewed with PDT");
    await user.click(screen.getByRole("button", { name: /save status/i }));
    expect(await screen.findByText(new RegExp(`Project ${project.p2_project_no} saved`))).toBeInTheDocument();
    const history = await screen.findByRole("table", { name: /change history/i });
    expect(within(history).getByText("PCT_COMPLETE")).toBeInTheDocument();
    expect(within(history).getByText("NOTE")).toBeInTheDocument();
  });

  it("switches to read only after the server answers 403", async () => {
    server.use(http.put("*/api/v1/projects/:p2/status", () => HttpResponse.json({ detail: "Role evs_pm required" }, { status: 403 })));
    const user = userEvent.setup();
    renderPage(<ProjectDetail />, { ...opts, role: "evs_pm" });
    await screen.findByTestId("status-form");
    await user.selectOptions(screen.getByLabelText(/percent complete/i), "40");
    await user.click(screen.getByRole("button", { name: /save status/i }));
    expect(await screen.findByText(/refused the last save \(403\)/i)).toBeInTheDocument();
    await waitFor(() => expect(screen.getByRole("button", { name: /save status/i })).toBeDisabled());
  });

  it("moves between tabs with the arrow keys", async () => {
    const user = userEvent.setup();
    renderPage(<ProjectDetail />, opts);
    await screen.findByTestId("status-form");
    const first = screen.getByRole("tab", { name: /financial/i });
    first.focus();
    await user.keyboard("{ArrowRight}");
    expect(screen.getByRole("tab", { name: /schedule/i })).toHaveAttribute("aria-selected", "true");
    expect(await screen.findByRole("figure", { name: /milestone schedule/i })).toBeInTheDocument();
  });
});
