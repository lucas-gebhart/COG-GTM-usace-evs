import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import { mkdirSync, writeFileSync } from "node:fs";

// Every route, every project (desktop + mobile). WP6a adds the leadership theme and the OpenACR merge.
const ROUTES = ["/", "/programs", "/projects", "/financial", "/workforce", "/schedule", "/facilities", "/public/srp", "/public/locks", "/accessibility", "/admin"];

for (const route of ROUTES) {
  test(`axe: ${route}`, async ({ page }, info) => {
    await page.goto(route);
    await page.getByRole("main").waitFor();
    const results = await new AxeBuilder({ page }).withTags(["wcag2a", "wcag2aa", "wcag21a", "wcag21aa"]).analyze();
    mkdirSync("a11y-results", { recursive: true });
    writeFileSync(`a11y-results/axe${route.replaceAll("/", "_") || "_root"}-${info.project.name}.json`, JSON.stringify(results, null, 2));
    expect(results.violations, JSON.stringify(results.violations, null, 2)).toEqual([]);
  });
}
