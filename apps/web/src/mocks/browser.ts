import { setupWorker } from "msw/browser";
import { handlers } from "./handlers";

/** Service worker for `VITE_MOCK=1 pnpm dev` and Storybook. */
export const worker = setupWorker(...handlers);
