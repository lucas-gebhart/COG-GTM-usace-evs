import { defineConfig, devices } from "@playwright/test";

// Accessibility and e2e runs. WP6a adds the per-route axe matrix and reporters.
export default defineConfig({
  testDir: "./e2e",
  outputDir: "./test-results",
  reporter: [["list"], ["json", { outputFile: "a11y-results/playwright.json" }]],
  use: { baseURL: process.env.BASE_URL ?? "http://localhost:4173" },
  webServer: process.env.BASE_URL ? undefined : { command: "pnpm preview", port: 4173, reuseExistingServer: true },
  projects: [
    { name: "desktop", use: { ...devices["Desktop Chrome"] } },
    { name: "mobile", use: { ...devices["Pixel 7"] } },
  ],
});
