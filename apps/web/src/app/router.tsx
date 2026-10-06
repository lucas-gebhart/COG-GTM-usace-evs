import { createElement, type ComponentType } from "react";
import { createBrowserRouter } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { AccessibilityPage } from "../pages/AccessibilityPage";
import { routes } from "./routes";

/** Routes with a real page; everything else keeps the scaffold until its work package lands. */
const PAGES: Record<string, ComponentType> = { "/accessibility": AccessibilityPage };

export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: routes.map((r) => {
      const Page = PAGES[r.path];
      return {
        path: r.path === "/" ? undefined : r.path.slice(1),
        index: r.path === "/",
        element: Page ? createElement(Page) : <Placeholder title={r.title} />,
      };
    }),
  },
]);
