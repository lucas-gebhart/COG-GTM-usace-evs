import { execSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import type { Page } from "@playwright/test";
import { routes } from "../src/app/routes";

// Shared matrix definition for the accessibility e2e suite. The ACR generator (tools/acr) reads the
// JSON written under a11y-results/, so keep the file layout and the field names stable.

const HERE = dirname(fileURLToPath(import.meta.url));
export const RESULTS_DIR = resolve(HERE, "..", "a11y-results");

export const VIEWPORTS = [
  { name: "mobile-360", width: 360, height: 800 },
  { name: "tablet-768", width: 768, height: 1024 },
  { name: "desktop-1280", width: 1280, height: 800 },
  { name: "wide-1920", width: 1920, height: 1080 },
] as const;
export type Viewport = (typeof VIEWPORTS)[number];

export const THEMES = ["light", "leadership"] as const;
export type Theme = (typeof THEMES)[number];

export const MOTION = ["no-preference", "reduce"] as const;
export type Motion = (typeof MOTION)[number];

// WCAG 2.1 A/AA tags gate the build. 2.2 AA and best-practice rules run too but are reported as advisories.
export const GATING_TAGS = ["wcag2a", "wcag2aa", "wcag21a", "wcag21aa"] as const;
export const ADVISORY_TAGS = ["wcag22aa", "best-practice"] as const;

function fixtureProjectId(): string {
  const fixture = resolve(HERE, "..", "..", "api", "fixtures", "projects.json");
  try {
    const data = JSON.parse(readFileSync(fixture, "utf8")) as Array<{ p2_project_no?: string }> | { items?: Array<{ p2_project_no?: string }> };
    const first = Array.isArray(data) ? data[0] : data.items?.[0];
    if (first?.p2_project_no) return String(first.p2_project_no);
  } catch {
    // fall through to the default below
  }
  return "385694";
}

export interface PageUnderTest {
  path: string;
  url: string;
  title: string;
  slug: string;
}

const PROJECT_ID = fixtureProjectId();

export const PAGES: PageUnderTest[] = routes.map((r) => {
  const url = r.path.includes(":") ? r.path.replace(/:[A-Za-z0-9_]+/g, PROJECT_ID) : r.path;
  return { path: r.path, url, title: r.title, slug: r.path === "/" ? "root" : r.path.slice(1).replace(/[/:]/g, "_") };
});

export function gitSha(): string {
  if (process.env.GITHUB_SHA) return process.env.GITHUB_SHA;
  try {
    return execSync("git rev-parse HEAD", { cwd: HERE, stdio: ["ignore", "pipe", "ignore"] }).toString().trim();
  } catch {
    return "unknown";
  }
}

export function writeResult(relPath: string, data: unknown): string {
  const target = resolve(RESULTS_DIR, relPath);
  mkdirSync(dirname(target), { recursive: true });
  writeFileSync(target, JSON.stringify(data, null, 2));
  return target;
}

export function resultsExist(relPath: string): boolean {
  return existsSync(resolve(RESULTS_DIR, relPath));
}

export async function applyTheme(page: Page, theme: Theme): Promise<void> {
  // The leadership theme is toggled on <html data-theme="leadership"> (see src/styles/global.scss).
  await page.addInitScript((t: string) => {
    if (t === "leadership") document.documentElement.dataset.theme = "leadership";
  }, theme);
}

export async function openPage(page: Page, url: string): Promise<void> {
  await page.goto(url);
  await page.getByRole("main").waitFor();
  // Let data queries resolve, but never block on long-lived connections (SSE on /public/locks).
  await Promise.race([page.waitForLoadState("networkidle").catch(() => undefined), page.waitForTimeout(3000)]);
}
