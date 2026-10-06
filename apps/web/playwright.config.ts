import { defineConfig, devices } from "@playwright/test";

// Accessibility e2e suite: axe matrix (routes x viewports x themes x reduced-motion), keyboard traversal
// smoke test and 320 px reflow check. Viewports are set per test in e2e/matrix.ts, so one browser project.
// Results land in a11y-results/ and feed tools/acr (evs-acr-gen).
export default defineConfig({
  testDir: "./e2e",
  outputDir: "./test-results",
  globalSetup: "./e2e/global-setup.ts",
  fullyParallel: true,
  workers: process.env.CI ? 2 : undefined,
  retries: process.env.CI ? 1 : 0,
  timeout: 60_000,
  reporter: [["list"], ["json", { outputFile: "a11y-results/playwright.json" }], ["html", { outputFolder: "a11y-results/playwright-report", open: "never" }]],
  use: { baseURL: process.env.BASE_URL ?? "http://localhost:4173", trace: "retain-on-failure" },
  webServer: process.env.BASE_URL ? undefined : { command: "pnpm preview", port: 4173, reuseExistingServer: true },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
});
