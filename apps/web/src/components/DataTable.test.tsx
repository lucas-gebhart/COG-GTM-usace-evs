import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { MemoryRouter } from "react-router";
import type { ColumnDef } from "@tanstack/react-table";
import { axe } from "./test-utils";
import { DataTable } from "./DataTable";

interface Row {
  id: string;
  name: string;
  district: string;
  pct: number;
}
const rows: Row[] = Array.from({ length: 23 }, (_, i) => ({ id: `P${i + 1}`, name: `Project ${String(i + 1).padStart(2, "0")}`, district: i % 2 ? "LRN" : "MVR", pct: (i * 7) % 100 }));
const columns: ColumnDef<Row, unknown>[] = [
  { accessorKey: "name", header: "Project" },
  { accessorKey: "district", header: "District" },
  { accessorKey: "pct", header: "Percent complete", meta: { numeric: true }, enableColumnFilter: false },
];

function renderTable(props: Partial<React.ComponentProps<typeof DataTable<Row>>> = {}) {
  return render(
    <MemoryRouter>
      <DataTable caption="Projects" columns={columns} data={rows} getRowId={(r) => r.id} pageSize={10} {...props} />
    </MemoryRouter>,
  );
}

describe("DataTable", () => {
  it("renders caption, column scopes, row headers and a status line", async () => {
    const { container } = renderTable();
    expect(screen.getByRole("table", { name: /Projects/ })).toBeInTheDocument();
    expect(screen.getAllByRole("columnheader")).toHaveLength(3);
    expect(screen.getAllByRole("rowheader")).toHaveLength(10);
    expect(screen.getByTestId("table-status")).toHaveTextContent("Showing 1 to 10 of 23 rows");
    expect(await axe(container)).toHaveNoViolations();
  });

  it("sorts with aria-sort and announces the direction", async () => {
    renderTable();
    const header = screen.getByRole("columnheader", { name: /Percent complete/ });
    expect(header).toHaveAttribute("aria-sort", "none");
    await userEvent.click(within(header).getByRole("button"));
    expect(header).toHaveAttribute("aria-sort", "ascending");
    expect(screen.getAllByRole("rowheader")[0]).toHaveTextContent("Project 01");
    await userEvent.click(within(header).getByRole("button"));
    expect(header).toHaveAttribute("aria-sort", "descending");
    expect(screen.getByTestId("table-status")).toHaveTextContent("sorted by pct descending");
  });

  it("filters with labelled inputs and paginates", async () => {
    renderTable({ enableFilters: true });
    const filter = screen.getByLabelText("Filter by District");
    await userEvent.type(filter, "LRN");
    expect(screen.getByTestId("table-status")).toHaveTextContent("Showing 1 to 10 of 11 rows");
    await userEvent.click(screen.getByRole("button", { name: "Next" }));
    expect(screen.getByTestId("table-status")).toHaveTextContent("Showing 11 to 11 of 11 rows");
    await userEvent.selectOptions(screen.getByLabelText("Rows per page"), "25");
    expect(screen.getByTestId("table-status")).toHaveTextContent("Showing 1 to 11 of 11 rows");
  });

  it("links the row header and activates on row click or Enter", async () => {
    const onRowActivate = vi.fn();
    renderTable({ onRowActivate });
    const first = screen.getAllByRole("rowheader")[0];
    const btn = within(first).getByRole("button", { name: "Project 01" });
    await userEvent.click(btn);
    expect(onRowActivate).toHaveBeenCalledWith(rows[0]);
    const row = first.closest("tr")!;
    btn.blur();
    await userEvent.click(row.querySelector("td")!);
    expect(onRowActivate).toHaveBeenCalledTimes(2);
  });

  it("renders href links when getRowHref is set", () => {
    renderTable({ getRowHref: (r) => `/projects/${r.id}` });
    expect(screen.getByRole("link", { name: "Project 01" })).toHaveAttribute("href", "/projects/P1");
  });

  it("switches to stacked card mode with data labels", async () => {
    const { container } = renderTable({ stacked: true });
    expect(screen.getByTestId("data-table")).toHaveAttribute("data-mode", "cards");
    expect(container.querySelector("table")).toHaveClass("usa-table--stacked");
    expect(container.querySelector('td[data-label="District"]')).toBeInTheDocument();
    expect(await axe(container)).toHaveNoViolations();
  });

  it("shows the empty message", () => {
    renderTable({ data: [] });
    expect(screen.getByText("No rows match the current filters.")).toBeInTheDocument();
    expect(screen.getByTestId("table-status")).toHaveTextContent("No rows to show");
  });
});
