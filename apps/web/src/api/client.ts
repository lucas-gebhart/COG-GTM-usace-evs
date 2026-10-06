import createClient from "openapi-fetch";
import type { paths } from "./schema";
import { ROLE_HEADER, readRole } from "../hooks/useRole";

// Typed client generated from packages/contract/openapi.json (pnpm gen:api).
// Relative URLs are proxied by Vite in dev; tests (jsdom) and MSW need an absolute origin.
const baseUrl = import.meta.env.VITE_API_BASE || (typeof window !== "undefined" ? window.location.origin : "");
export const api = createClient<paths>({
  baseUrl,
  // Resolve fetch lazily so request interceptors installed later (MSW in tests and mock mode) are honoured.
  fetch: (input) => globalThis.fetch(input),
});

// Demo role header: honoured by the MSW handlers (403 on writes for evs_viewer). With OIDC the bearer token wins.
api.use({
  onRequest({ request }) {
    if (typeof window !== "undefined") request.headers.set(ROLE_HEADER, readRole());
    return request;
  },
});

export type ApiPaths = paths;
