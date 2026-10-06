// Lists the URLs the pa11y-ci and Lighthouse CI runs cover: every entry in src/app/routes.ts, with the
// `/projects/:p2` parameter resolved to the first fixture project. Usage: node scripts/a11y-urls.cjs [base]
const { readFileSync } = require("node:fs");
const { resolve } = require("node:path");

function fixtureProjectId() {
  try {
    const data = JSON.parse(readFileSync(resolve(__dirname, "..", "..", "api", "fixtures", "projects.json"), "utf8"));
    const first = Array.isArray(data) ? data[0] : data.items && data.items[0];
    if (first && first.p2_project_no) return String(first.p2_project_no);
  } catch {
    // fall through
  }
  return "385694";
}

function routePaths() {
  const source = readFileSync(resolve(__dirname, "..", "src", "app", "routes.ts"), "utf8");
  const id = fixtureProjectId();
  return Array.from(source.matchAll(/path:\s*"([^"]+)"/g), (m) => m[1].replace(/:[A-Za-z0-9_]+/g, id));
}

function routeUrls(base = process.env.BASE_URL || "http://localhost:4173") {
  return routePaths().map((p) => new URL(p, base).toString());
}

module.exports = { routePaths, routeUrls };

if (require.main === module) {
  process.stdout.write(routeUrls(process.argv[2]).join("\n") + "\n");
}
