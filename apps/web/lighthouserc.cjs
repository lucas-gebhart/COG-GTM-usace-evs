// Lighthouse CI: accessibility category only, score budget 100 on every route (mobile emulation).
// Run against the preview server: pnpm preview & pnpm a11y:lhci
const { routeUrls } = require("./scripts/a11y-urls.cjs");

let chromePath;
try {
  chromePath = require("@playwright/test").chromium.executablePath();
} catch {
  chromePath = undefined;
}

module.exports = {
  ci: {
    collect: {
      url: routeUrls(),
      numberOfRuns: 1,
      chromePath,
      settings: { onlyCategories: ["accessibility"], chromeFlags: "--no-sandbox --disable-dev-shm-usage" },
    },
    assert: {
      assertions: { "categories:accessibility": ["error", { minScore: 1 }] },
    },
    upload: { target: "filesystem", outputDir: "a11y-results/lighthouse", reportFilenamePattern: "%%PATHNAME%%.%%EXTENSION%%" },
  },
};
