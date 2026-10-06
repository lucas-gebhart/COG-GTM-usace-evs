import createClient from "openapi-fetch";
import type { paths } from "./schema";

// Typed client generated from packages/contract/openapi.json (pnpm gen:api).
export const api = createClient<paths>({ baseUrl: import.meta.env.VITE_API_BASE ?? "" });

export type ApiPaths = paths;
