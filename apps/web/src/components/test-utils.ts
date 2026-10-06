import { configureAxe } from "vitest-axe";
import * as matchers from "vitest-axe/matchers";
import { expect } from "vitest";

expect.extend(matchers);

/** axe with the WCAG 2.2 AA rule set; colour contrast is skipped in jsdom (no layout) and covered by Storybook and Playwright. */
export const axe = configureAxe({
  rules: { "color-contrast": { enabled: false }, region: { enabled: false } },
});

declare module "vitest" {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  interface Assertion<T = any> {
    toHaveNoViolations(): T;
  }
}
