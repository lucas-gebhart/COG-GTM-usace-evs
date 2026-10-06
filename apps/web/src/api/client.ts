import createClient from "openapi-fetch";
import type { paths } from "./schema";

// Typed client generated from packages/contract/openapi.json (pnpm gen:api).
// Relative URLs are proxied by Vite in dev; tests (jsdom) and MSW need an absolute origin.
const baseUrl = import.meta.env.VITE_API_BASE || (typeof window !== "undefined" ? window.location.origin : "");
export const api = createClient<paths>({
  baseUrl,
  // Resolve fetch lazily so request interceptors installed later (MSW in tests and mock mode) are honoured.
  fetch: (input) => globalThis.fetch(input),
});

export type ApiPaths = paths;
