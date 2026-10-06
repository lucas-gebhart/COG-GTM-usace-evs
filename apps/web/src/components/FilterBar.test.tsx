import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe } from "./test-utils";
import { FilterBar } from "./FilterBar";
import { LiveRegionProvider } from "../hooks/useAnnounce";

const fields = [
  { id: "q", label: "Project name", type: "search" as const },
  { id: "district", label: "District", options: [{ value: "LRN", label: "LRN" }, { value: "MVR", label: "MVR" }] },
];

describe("FilterBar", () => {
  it("applies only on submit, via button or Enter, and announces the count", async () => {
    const onApply = vi.fn();
    const { container, rerender } = render(
      <LiveRegionProvider>
        <FilterBar fields={fields} values={{}} onApply={onApply} resultCount={101} resultNoun="projects" />
      </LiveRegionProvider>,
    );
    expect(screen.getByRole("form", { name: "Filters" })).toBeInTheDocument();
    await userEvent.selectOptions(screen.getByLabelText("District"), "LRN");
    expect(onApply).not.toHaveBeenCalled();
    await userEvent.click(screen.getByRole("button", { name: "Apply filters" }));
    expect(onApply).toHaveBeenLastCalledWith({ district: "LRN" });

    await userEvent.type(screen.getByLabelText("Project name"), "Nav{Enter}");
    expect(onApply).toHaveBeenLastCalledWith({ district: "LRN", q: "Nav" });

    rerender(
      <LiveRegionProvider>
        <FilterBar fields={fields} values={{ district: "LRN", q: "Nav" }} onApply={onApply} resultCount={7} resultNoun="projects" />
      </LiveRegionProvider>,
    );
    expect(screen.getByTestId("filter-count")).toHaveTextContent("7 projects");
    await vi.waitFor(() => expect(screen.getByTestId("evs-status-region")).toHaveTextContent("7 projects"));
    expect(await axe(container)).toHaveNoViolations();
  });

  it("reset clears every field", async () => {
    const onApply = vi.fn();
    render(<FilterBar fields={fields} values={{ district: "LRN" }} onApply={onApply} />);
    await userEvent.click(screen.getByRole("button", { name: "Reset" }));
    expect(onApply).toHaveBeenLastCalledWith({ q: "", district: "" });
  });
});
