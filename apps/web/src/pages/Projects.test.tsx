import { screen, within } from "@testing-library/react";
import { axe, fixtures, renderPage, setupPageServer } from "./shared/test-utils";
import { Projects } from "./Projects";

setupPageServer();

describe("Projects", () => {
  it("renders the IR table with variance days and links to project detail, with no axe violations", async () => {
    const { container } = renderPage(<Projects />, { url: "/projects" });
    const table = await screen.findByRole("table", { name: /^projects/i });
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    for (const name of [/p2 number/i, /district/i, /division/i, /business line/i, /phase/i, /complete/i, /baseline finish/i, /current finish/i, /variance/i]) {
      expect(within(table).getByRole("columnheader", { name })).toBeInTheDocument();
    }
    const links = within(table).getAllByRole("link").filter((l) => /^\/projects\/[^/]+$/.test(l.getAttribute("href") ?? ""));
    expect(links.length).toBeGreaterThan(0);
    expect(fixtures.projects.map((p) => `/projects/${p.p2_project_no}`)).toContain(links[0].getAttribute("href"));
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 86");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("reads the saved filter from the URL", async () => {
    const district = fixtures.projects[0].district;
    renderPage(<Projects />, { url: `/projects?district=${district}`, path: "/projects" });
    const table = await screen.findByRole("table", { name: /^projects/i });
    const expected = fixtures.projects.filter((p) => p.district === district).length;
    expect(await screen.findByText(new RegExp(`${expected} projects`))).toBeInTheDocument();
    expect(within(table).getAllByRole("row").length).toBeGreaterThan(1);
  });
});
