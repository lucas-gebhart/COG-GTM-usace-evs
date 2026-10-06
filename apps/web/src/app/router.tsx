import { createBrowserRouter } from "react-router";
import { AppLayout } from "./AppLayout";
import { Placeholder } from "../pages/Placeholder";
import { routes } from "./routes";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: routes.map((r) => ({
      path: r.path === "/" ? undefined : r.path.slice(1),
      index: r.path === "/",
      element: <Placeholder title={r.title} />,
    })),
  },
]);
