import { render, screen } from "@testing-library/react";
import { createMemoryRouter, RouterProvider } from "react-router";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";

test("renders skip link, banner and main landmark", () => {
  const router = createMemoryRouter([{ path: "/", element: <AppLayout />, children: [{ index: true, element: <Placeholder title="Enterprise overview" /> }] }]);
  render(<QueryClientProvider client={new QueryClient()}><RouterProvider router={router} /></QueryClientProvider>);
  expect(screen.getByText("Skip to main content")).toHaveAttribute("href", "#main-content");
  expect(screen.getByRole("main")).toBeInTheDocument();
  expect(screen.getByRole("heading", { level: 1 })).toHaveTextContent("Enterprise overview");
});
