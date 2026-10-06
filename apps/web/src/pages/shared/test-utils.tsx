import type { ReactElement } from "react";
import { render, type RenderResult } from "@testing-library/react";
import { MemoryRouter, Route, Routes } from "react-router";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { afterAll, afterEach, beforeAll } from "vitest";
import { LiveRegionProvider } from "../../hooks/useAnnounce";
import { RoleProvider, type Role } from "../../hooks/useRole";
import { server } from "../../mocks/server";
import { resetMockState } from "../../mocks/handlers";
import { routes } from "../../app/routes";

export { axe } from "../../components/test-utils";
export { server };
export { fixtures } from "../../mocks/fixtures";

/** Starts the MSW node interceptor for a page test file and resets mutable fixture state between tests. */
export function setupPageServer(): void {
  beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
  afterEach(() => {
    server.resetHandlers();
    resetMockState();
    window.localStorage.clear();
  });
  afterAll(() => server.close());
}

export interface RenderPageOptions {
  /** Route pattern from routes.ts the element is mounted on (default: the first path segment of `url`). */
  path?: string;
  url?: string;
  role?: Role;
}

/** Renders a page element under the app's providers at `url`, mounted on the matching route pattern. */
export function renderPage(element: ReactElement, { path, url = "/", role = "evs_admin" }: RenderPageOptions = {}): RenderResult & { queryClient: QueryClient } {
  const queryClient = new QueryClient({ defaultOptions: { queries: { retry: false, gcTime: 0 }, mutations: { retry: false } } });
  const pattern = path ?? routes.find((r) => r.path === url)?.path ?? url;
  const result = render(
    <QueryClientProvider client={queryClient}>
      <RoleProvider switchable initialRole={role}>
        <LiveRegionProvider>
          <MemoryRouter initialEntries={[url]}>
            <Routes>
              <Route path={pattern} element={element} />
              <Route path="*" element={<p>other route</p>} />
            </Routes>
          </MemoryRouter>
        </LiveRegionProvider>
      </RoleProvider>
    </QueryClientProvider>,
  );
  return { ...result, queryClient };
}
