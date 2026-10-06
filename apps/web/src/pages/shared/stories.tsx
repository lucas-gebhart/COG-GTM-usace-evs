import type { Decorator } from "@storybook/react-vite";
import { HttpResponse, delay, http, type HttpHandler } from "msw";
import { MemoryRouter } from "react-router";
import { handlers } from "../../mocks/handlers";
import { RoleProvider, type Role } from "../../hooks/useRole";

/**
 * Page stories mount their own router (parameters.router = false) so the URL and search params can be set.
 * Stories override `parameters.url` and `parameters.role` instead of adding a second decorator (nested routers throw).
 */
export const atUrl =
  (defaultUrl: string, defaultRole: Role = "evs_admin"): Decorator =>
  (Story, context) => {
    const url = (context.parameters.url as string | undefined) ?? defaultUrl;
    const role = (context.parameters.role as Role | undefined) ?? defaultRole;
    return (
      <RoleProvider key={`${url}:${role}`} switchable initialRole={role}>
        <MemoryRouter initialEntries={[url]}>
          <Story />
        </MemoryRouter>
      </RoleProvider>
    );
  };

export const pageParameters = { router: false, layout: "padded" } as const;

/** Prepend overrides to the default handlers for loading, empty and error variants. */
export function withOverrides(...overrides: HttpHandler[]): HttpHandler[] {
  return [...overrides, ...handlers];
}

export const slow = (path: string) => http.get(`*/api/v1${path}`, async () => { await delay("infinite"); return HttpResponse.json({}); });
export const failing = (path: string) => http.get(`*/api/v1${path}`, () => HttpResponse.json({ detail: "Upstream unavailable" }, { status: 503 }));
export const emptyList = (path: string) => http.get(`*/api/v1${path}`, () => HttpResponse.json({ items: [], page: { total: 0, limit: 50, offset: 0 }, as_of: { source_as_of: new Date().toISOString(), fetched_at: new Date().toISOString(), freshness: "fresh", source: "synthetic" } }));
