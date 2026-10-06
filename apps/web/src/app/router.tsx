import { lazy, Suspense, type ReactNode } from "react";
import { createBrowserRouter } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { SkeletonLoader } from "../components/SkeletonLoader";
import { EnterpriseOverview } from "../pages/EnterpriseOverview";
import { Programs } from "../pages/Programs";
import { Projects } from "../pages/Projects";
import { ProjectDetail } from "../pages/ProjectDetail";
import { Financial } from "../pages/Financial";
import { Workforce } from "../pages/Workforce";
import { Schedule } from "../pages/Schedule";
import { Facilities } from "../pages/Facilities";
import { routes } from "./routes";

const AccessibilityPage = lazy(() => import("../pages/AccessibilityPage").then((m) => ({ default: m.AccessibilityPage })));
const LocksPage = lazy(() => import("../pages/locks/LocksPage").then((m) => ({ default: m.LocksPage })));
const LockDetailPage = lazy(() => import("../pages/locks/LockDetailPage").then((m) => ({ default: m.LockDetailPage })));
const SrpPage = lazy(() => import("../pages/srp/SrpPage").then((m) => ({ default: m.SrpPage })));

// Public and accessibility pages are code-split so the map library only loads on the routes that draw a map.
// WP4b internal pages load eagerly. Routes without an entry (admin) keep the scaffold placeholder until their work package lands.
const PAGES: Partial<Record<(typeof routes)[number]["path"], ReactNode>> = {
  "/": <EnterpriseOverview />,
  "/programs": <Programs />,
  "/projects": <Projects />,
  "/projects/:p2": <ProjectDetail />,
  "/financial": <Financial />,
  "/workforce": <Workforce />,
  "/schedule": <Schedule />,
  "/facilities": <Facilities />,
  "/accessibility": <AccessibilityPage />,
  "/public/locks": <LocksPage />,
  "/public/locks/:id": <LockDetailPage />,
  "/public/srp": <SrpPage />,
};

export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: routes.map((r) => ({
      path: r.path === "/" ? undefined : r.path.slice(1),
      index: r.path === "/",
      element: PAGES[r.path] ? <Suspense fallback={<SkeletonLoader label={`Loading ${r.title}`} variant="text" lines={6} />}>{PAGES[r.path]}</Suspense> : <Placeholder title={r.title} />,
    })),
  },
]);
