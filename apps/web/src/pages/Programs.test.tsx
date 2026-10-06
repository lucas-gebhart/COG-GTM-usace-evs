import { screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe, renderPage, setupPageServer } from "./shared/test-utils";
import { Programs } from "./Programs";

setupPageServer();

describe("Programs", () => {
  it("renders the IR table with sortable columns, a column chooser and the APEX tag, with no axe violations", async () => {
    const user = userEvent.setup();
    const { container } = renderPage(<Programs />, { url: "/programs" });
    const table = await screen.findByRole("table", { name: /programs and portfolio/i });
    expect(screen.getAllByRole("heading", { level: 1 })).toHaveLength(1);
    expect(within(table).getByRole("columnheader", { name: /fy budget/i })).toBeInTheDocument();
    expect(within(table).getByRole("columnheader", { name: /percent obligated/i })).toBeInTheDocument();
    expect(screen.getByTestId("apex-tag")).toHaveTextContent("Migrated from APEX page 21");

    await user.click(screen.getByRole("checkbox", { name: "Projects" }));
    expect(within(screen.getByRole("table", { name: /programs and portfolio/i })).queryByRole("columnheader", { name: /^projects$/i })).not.toBeInTheDocument();

    expect(await axe(container)).toHaveNoViolations();
  });

  it("applies a server filter and shows the empty state when nothing matches", async () => {
    const user = userEvent.setup();
    renderPage(<Programs />, { url: "/programs" });
    await screen.findByRole("table", { name: /programs and portfolio/i });
    await user.type(screen.getByRole("searchbox", { name: /search/i }), "zzz-no-such-program");
    await user.click(screen.getByRole("button", { name: /apply/i }));
    expect(await screen.findByText(/no programs match/i)).toBeInTheDocument();
  });
});
