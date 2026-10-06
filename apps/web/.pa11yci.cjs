// pa11y-ci: axe runner over every route, WCAG 2.1 AA, zero-error threshold. Uses the Chromium that
// Playwright installs so no second browser download is needed. Run: pnpm a11y:pa11y
const { routeUrls } = require("./scripts/a11y-urls.cjs");

let executablePath;
try {
  executablePath = require("@playwright/test").chromium.executablePath();
} catch {
  executablePath = undefined;
}

module.exports = {
  defaults: {
    standard: "WCAG2AA",
    runners: ["axe"],
    timeout: 30000,
    wait: 1500,
    // axe "needs review" items (e.g. contrast with overlapping backgrounds) are reported as warnings, not
    // errors, so they are recorded as incomplete by evs-acr-gen instead of failing the criterion.
    includeWarnings: true,
    levelCapWhenNeedsReview: "warning",
    chromeLaunchConfig: { executablePath, args: ["--no-sandbox", "--disable-dev-shm-usage"] },
    viewport: { width: 1280, height: 800 },
  },
  urls: routeUrls(),
};
