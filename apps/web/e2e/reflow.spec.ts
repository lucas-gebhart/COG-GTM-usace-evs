import { test, expect } from "@playwright/test";
import { PAGES, THEMES, applyTheme, gitSha, openPage, writeResult } from "./matrix";

// WCAG 1.4.10 Reflow: 400% zoom on a 1280 px desktop is equivalent to a 320 CSS px viewport. No route may
// require horizontal scrolling at that width, in either theme (the leadership theme scales type by 1.4).

const SHA = gitSha();
const TOLERANCE_PX = 1;

test.describe("reflow at 320 CSS px (400% zoom)", () => {
  test.use({ viewport: { width: 320, height: 480 } });

  for (const theme of THEMES) {
    for (const pageUnderTest of PAGES) {
      test(`no horizontal scroll on ${pageUnderTest.path} [${theme}]`, async ({ page }) => {
        await applyTheme(page, theme);
        await openPage(page, pageUnderTest.url);
        const metrics = await page.evaluate(() => {
          const doc = document.documentElement;
          // Elements allowed to scroll in two dimensions (data tables, Gantt) must opt in with data-allow-2d-scroll.
          const offenders = Array.from(document.querySelectorAll<HTMLElement>("body *"))
            .filter((el) => el.getBoundingClientRect().right > doc.clientWidth + 1 && !el.closest("[data-allow-2d-scroll]"))
            .slice(0, 10)
            .map((el) => `${el.tagName.toLowerCase()}${el.id ? `#${el.id}` : ""}${el.className && typeof el.className === "string" ? `.${el.className.split(" ")[0]}` : ""}`);
          return { scrollWidth: doc.scrollWidth, clientWidth: doc.clientWidth, offenders };
        });
        writeResult(`reflow/${pageUnderTest.slug}__${theme}.json`, {
          route: pageUnderTest.path,
          url: pageUnderTest.url,
          theme,
          viewportWidth: 320,
          runAt: new Date().toISOString(),
          gitSha: SHA,
          ...metrics,
          pass: metrics.scrollWidth <= metrics.clientWidth + TOLERANCE_PX,
        });
        expect(metrics.scrollWidth, `horizontal overflow; offenders: ${metrics.offenders.join(", ")}`).toBeLessThanOrEqual(metrics.clientWidth + TOLERANCE_PX);
      });
    }
  }
});
