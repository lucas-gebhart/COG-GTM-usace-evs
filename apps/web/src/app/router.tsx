import { lazy, Suspense, type ReactNode } from "react";
import { createBrowserRouter } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { SkeletonLoader } from "../components/SkeletonLoader";
import { routes } from "./routes";

const LocksPage = lazy(() => import("../pages/locks/LocksPage").then((m) => ({ default: m.LocksPage })));
const LockDetailPage = lazy(() => import("../pages/locks/LockDetailPage").then((m) => ({ default: m.LockDetailPage })));
const SrpPage = lazy(() => import("../pages/srp/SrpPage").then((m) => ({ default: m.SrpPage })));

// Pages are code-split so the map library only loads on the routes that draw a map.
const PAGES: Record<string, ReactNode> = {
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
