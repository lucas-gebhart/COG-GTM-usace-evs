import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { MemoryRouter } from "react-router";
import { axe } from "./test-utils";
import { EmptyState } from "./EmptyState";
import { ErrorState } from "./ErrorState";
import { SkeletonLoader } from "./SkeletonLoader";
import { PageHeader } from "./PageHeader";
import { ApiError } from "../hooks/useApi";

describe("EmptyState", () => {
  it("is a status region with a heading", async () => {
    const { container } = render(<EmptyState message="No projects match." />);
    expect(screen.getByRole("status")).toHaveTextContent("No data to show");
    expect(await axe(container)).toHaveNoViolations();
  });
});

describe("ErrorState", () => {
  it("is an alert with retry and a reference id", async () => {
    const onRetry = vi.fn();
    const { container } = render(<ErrorState error={new ApiError(503, "Upstream unavailable", "EVS-ABC")} onRetry={onRetry} />);
    expect(screen.getByRole("alert")).toBeInTheDocument();
    expect(screen.getByText(/reference EVS-ABC/)).toBeInTheDocument();
    await userEvent.click(screen.getByRole("button", { name: "Retry" }));
    expect(onRetry).toHaveBeenCalled();
    expect(await axe(container)).toHaveNoViolations();
  });
});

describe("SkeletonLoader", () => {
  it("sets aria-busy and a readable label", async () => {
    const { container } = render(<SkeletonLoader label="Loading projects" variant="table" />);
    const el = screen.getByRole("status");
    expect(el).toHaveAttribute("aria-busy", "true");
    expect(el).toHaveTextContent("Loading projects");
    expect(await axe(container)).toHaveNoViolations();
  });
});

describe("PageHeader", () => {
  it("renders one h1, intro and a breadcrumb with aria-current", async () => {
    const { container } = render(
      <MemoryRouter>
        <PageHeader title="Projects" intro="All projects." breadcrumbs={[{ label: "Home", to: "/" }, { label: "Projects" }]} />
      </MemoryRouter>,
    );
    expect(screen.getByRole("heading", { level: 1, name: "Projects" })).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Home" })).toHaveAttribute("href", "/");
    expect(container.querySelector('[aria-current="page"]')).toHaveTextContent("Projects");
    expect(await axe(container)).toHaveNoViolations();
  });
});
