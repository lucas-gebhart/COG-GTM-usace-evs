import { createBrowserRouter } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { EnterpriseOverview } from "../pages/EnterpriseOverview";
import { Programs } from "../pages/Programs";
import { Projects } from "../pages/Projects";
import { ProjectDetail } from "../pages/ProjectDetail";
import { Financial } from "../pages/Financial";
import { Workforce } from "../pages/Workforce";
import { Schedule } from "../pages/Schedule";
import { Facilities } from "../pages/Facilities";
import { routes } from "./routes";
import type { ReactElement } from "react";

/** WP4b internal pages; public, accessibility and admin routes keep the placeholder until their work packages land. */
const PAGES: Partial<Record<(typeof routes)[number]["path"], ReactElement>> = {
  "/": <EnterpriseOverview />,
  "/programs": <Programs />,
  "/projects": <Projects />,
  "/projects/:p2": <ProjectDetail />,
  "/financial": <Financial />,
  "/workforce": <Workforce />,
  "/schedule": <Schedule />,
  "/facilities": <Facilities />,
};

export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: routes.map((r) => ({
      path: r.path === "/" ? undefined : r.path.slice(1),
      index: r.path === "/",
      element: PAGES[r.path] ?? <Placeholder title={r.title} />,
    })),
  },
]);
