import React from "react";
import ReactDOM from "react-dom/client";
import { RouterProvider } from "react-router";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { router } from "./app/router";
import { restoreTheme } from "./hooks/useTheme";
import { RoleProvider } from "./hooks/useRole";
import "./styles/global.scss";

restoreTheme();

// The demo role can be switched when the API has no OIDC in front of it (mock mode, EVS_AUTH_DISABLED locally).
const roleSwitchable = import.meta.env.VITE_MOCK === "1" || import.meta.env.VITE_AUTH_DISABLED === "1" || import.meta.env.DEV;

const queryClient = new QueryClient({ defaultOptions: { queries: { staleTime: 30_000, refetchOnWindowFocus: false, retry: 1 } } });

async function enableMocks() {
  if (import.meta.env.VITE_MOCK !== "1") return;
  const { worker } = await import("./mocks/browser");
  await worker.start({ onUnhandledRequest: "bypass", serviceWorker: { url: `${import.meta.env.BASE_URL}mockServiceWorker.js` } });
}

enableMocks().then(() => {
  ReactDOM.createRoot(document.getElementById("root")!).render(
    <React.StrictMode>
      <QueryClientProvider client={queryClient}>
        <RoleProvider switchable={roleSwitchable}>
          <RouterProvider router={router} />
        </RoleProvider>
      </QueryClientProvider>
    </React.StrictMode>,
  );
});
