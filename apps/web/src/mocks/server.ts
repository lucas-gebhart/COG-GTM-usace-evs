import { setupServer } from "msw/node";
import { handlers } from "./handlers";

/** Node interceptor for Vitest. */
export const server = setupServer(...handlers);
