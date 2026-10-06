// Runs pa11y-ci with the JSON reporter and writes a11y-results/pa11y.json (the CLI prints JSON to stdout).
// pa11y-ci counts every included issue (warnings too) towards its exit code, so the exit code is recomputed
// here: only `error` items fail; `warning` items are axe "needs review" findings kept for evs-acr-gen.
const { spawnSync } = require("node:child_process");
const { mkdirSync, writeFileSync } = require("node:fs");
const { resolve } = require("node:path");

const out = resolve(__dirname, "..", "a11y-results");
mkdirSync(out, { recursive: true });
const run = spawnSync("pa11y-ci", ["--config", ".pa11yci.cjs", "--json"], { cwd: resolve(__dirname, ".."), encoding: "utf8", shell: process.platform === "win32" });
if (run.error) throw run.error;
writeFileSync(resolve(out, "pa11y.json"), run.stdout);
process.stderr.write(run.stderr);
let report;
try {
  report = JSON.parse(run.stdout);
} catch {
  process.stdout.write(run.stdout);
  process.exit(run.status ?? 1);
}
const results = report.results ?? {};
let errors = 0;
let warnings = 0;
for (const items of Object.values(results)) {
  for (const item of items ?? []) {
    if (item.type === "error") errors += 1;
    else warnings += 1;
  }
}
const urls = Object.keys(results).length;
process.stdout.write(`pa11y-ci: ${urls} URLs, ${errors} errors, ${warnings} needs-review warnings\n`);
process.exit(errors > 0 || urls === 0 ? 2 : 0);
