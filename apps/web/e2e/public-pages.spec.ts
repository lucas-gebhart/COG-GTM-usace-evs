import { test, expect, type Page } from "@playwright/test";

// WP5b feature checks in mock mode (VITE_MOCK=1 build served by `pnpm preview`): keyboard-only traversal of three
// map markers and panel open/close, an SSE update changing the as-of live region, and river filtering narrowing
// both the table and the map.

const MARKER = "button.evs-mapmarker";

async function tabToFirstMarker(page: Page): Promise<void> {
  for (let i = 0; i < 80; i += 1) {
    await page.keyboard.press("Tab");
    const onMarker = await page.evaluate(() => document.activeElement?.classList.contains("evs-mapmarker") ?? false);
    if (onMarker) return;
  }
  throw new Error("Tab never reached a map marker");
}

async function activeName(page: Page): Promise<string> {
  return page.evaluate(() => (document.activeElement as HTMLElement | null)?.getAttribute("aria-label") ?? "");
}

test.describe("/public/locks", () => {
  test("keyboard-only traversal of three markers in river-mile order, Enter opens the panel, Escape closes it and returns focus", async ({ page }) => {
    await page.goto("/public/locks?view=map&river=OH");
    await expect(page.locator(MARKER).first()).toBeVisible({ timeout: 30000 });
    const total = await page.locator(MARKER).count();
    expect(total).toBeGreaterThanOrEqual(3);

    await tabToFirstMarker(page);
    const names = [await activeName(page)];
    for (let i = 0; i < 2; i += 1) {
      await page.keyboard.press("ArrowRight");
      names.push(await activeName(page));
    }
    expect(new Set(names).size).toBe(3);
    // The DOM order is the river-mile order the page sorts the filtered locks into; the first three table rows match.
    const rowHeaders = await page.locator("table tbody th").allTextContents();
    for (let i = 0; i < 3; i += 1) expect(names[i].startsWith(rowHeaders[i].split("(")[0].trim())).toBeTruthy();

    const box = await page.locator(MARKER).nth(2).boundingBox();
    expect(box?.width ?? 0).toBeGreaterThanOrEqual(44);
    expect(box?.height ?? 0).toBeGreaterThanOrEqual(44);
    await expect(page.getByRole("tooltip").filter({ hasText: names[2].split(",")[0] })).toBeVisible();

    await page.keyboard.press("Enter");
    const dialog = page.getByRole("dialog");
    await expect(dialog).toBeVisible();
    await expect(dialog.getByRole("heading", { level: 2 })).toBeFocused();
    expect(page.url()).toContain("lock=");
    await expect(dialog.getByText("Queue and traffic")).toBeVisible();

    await page.keyboard.press("Escape");
    await expect(dialog).toHaveCount(0);
    expect(page.url()).not.toContain("lock=");
    expect(await activeName(page)).toBe(names[2]);
  });

  test("an SSE update changes the aria-live as-of text", async ({ page }) => {
    // The stream is stubbed so the check does not depend on the ingestion worker: two `locks` events a minute apart.
    const counts = { operating: 50, delayed: 20, closed: 5, stale: 0, unknown: 0 };
    const asOf = (t: Date) => ({ source_as_of: t.toISOString(), fetched_at: t.toISOString(), freshness: "fresh", source: "simulated" });
    const t0 = new Date("2026-01-01T12:00:00Z");
    const t1 = new Date("2026-01-01T12:01:00Z");
    const body = `event: locks\nid: 1\ndata: ${JSON.stringify({ counts, as_of: asOf(t0), changed: 0 })}\n\n` + `event: locks\nid: 2\ndata: ${JSON.stringify({ counts: { ...counts, delayed: 21, operating: 49 }, as_of: asOf(t1), changed: 1 })}\n\nretry: 600000\n\n`;
    await page.route("**/api/v1/public/locks/stream/events", (route) => route.fulfill({ status: 200, headers: { "content-type": "text/event-stream", "cache-control": "no-cache" }, body }));

    await page.goto("/public/locks");
    const live = page.getByTestId("locks-asof");
    await expect(live).toHaveAttribute("aria-live", "polite");
    await expect(live).toContainText(/^As of .* fetched .* source (fixtures|live|simulated)\.$/);
    const toggle = page.getByTestId("live-toggle");
    if ((await toggle.getAttribute("aria-pressed")) !== "true") await toggle.click();
    await expect(live).toContainText("source simulated", { timeout: 15000 });
    await expect(live).toContainText("12:01", { timeout: 15000 });
    await expect(page.getByTestId("count-delayed")).toContainText("21");
  });

  test("filtering by river narrows the table and the map and lands in the URL", async ({ page }) => {
    await page.goto("/public/locks?view=map");
    await expect(page.locator(MARKER).first()).toBeVisible({ timeout: 30000 });
    const allMarkers = await page.locator(MARKER).count();
    const allRows = await page.locator("table caption").textContent();
    await page.getByLabel("River system").selectOption("OH");
    await page.getByRole("button", { name: /^Apply/ }).click();
    await expect(page).toHaveURL(/river=OH/);
    await expect(page.locator("table caption")).toContainText("Ohio River");
    await expect.poll(() => page.locator(MARKER).count()).toBeLessThan(allMarkers);
    const narrowed = await page.locator("table caption").textContent();
    expect(narrowed).not.toBe(allRows);
    const rivers = await page.locator("table tbody td:first-child").allTextContents();
    expect(rivers.length).toBeGreaterThan(0);
    for (const r of rivers) expect(r).toContain("Ohio");
  });
});

test.describe("/public/srp", () => {
  test("shows cited figures and opens a site panel from the grouped list", async ({ page }) => {
    await page.goto("/public/srp");
    await expect(page.getByRole("heading", { level: 1, name: "Sustainable Rivers Program" })).toBeVisible();
    await expect(page.getByRole("list", { name: "Sources for the program scale figures" })).toContainText("HEC");
    await expect(page.getByTestId("srp-economic")).toContainText("Benefit-cost ratio");
    const firstSite = page.locator(".evs-sitelist button").first();
    const name = await firstSite.textContent();
    await firstSite.click();
    const dialog = page.getByRole("dialog");
    await expect(dialog.getByRole("heading", { level: 3 })).toHaveText(name ?? "");
    await expect(page).toHaveURL(/site=/);
    await dialog.getByRole("button", { name: /Close/ }).click();
    await expect(dialog).toHaveCount(0);
  });
});
