import { test, expect, type Page } from "@playwright/test";
import { PAGES, applyTheme, gitSha, openPage, writeResult } from "./matrix";

// Keyboard traversal smoke test (WCAG 2.1.1, 2.1.2, 2.4.1, 2.4.3, 2.4.7): the first Tab reaches the skip link,
// activating it moves focus to main, tabbing onward reaches the navigation and then main, and Escape closes
// any dialog or popover that a trigger opens, returning focus to the trigger.

const SHA = gitSha();
const MAX_TABS = 80;

interface FocusStep {
  tag: string;
  role: string | null;
  name: string;
  landmark: string | null;
  visibleFocus: boolean;
}

async function describeFocus(page: Page): Promise<FocusStep> {
  return page.evaluate(() => {
    const el = document.activeElement as HTMLElement | null;
    if (!el || el === document.body) return { tag: "body", role: null, name: "", landmark: null, visibleFocus: false };
    const landmarkOf = (node: HTMLElement | null): string | null => {
      for (let n: HTMLElement | null = node; n; n = n.parentElement) {
        const role = n.getAttribute("role");
        if (role && ["banner", "navigation", "main", "contentinfo", "complementary", "search", "region", "dialog"].includes(role)) return role;
        const tag = n.tagName.toLowerCase();
        if (tag === "main") return "main";
        if (tag === "nav") return "navigation";
        if (tag === "header") return "banner";
        if (tag === "footer") return "contentinfo";
        if (tag === "aside") return "complementary";
      }
      return null;
    };
    const style = getComputedStyle(el);
    const visibleFocus = el.matches(":focus-visible") && (style.outlineStyle !== "none" || style.boxShadow !== "none");
    return {
      tag: el.tagName.toLowerCase(),
      role: el.getAttribute("role"),
      name: (el.getAttribute("aria-label") ?? el.textContent ?? "").trim().slice(0, 60),
      landmark: landmarkOf(el),
      visibleFocus,
    };
  });
}

test.describe("keyboard traversal", () => {
  test.use({ viewport: { width: 1280, height: 800 } });

  for (const pageUnderTest of PAGES) {
    test(`tab order and escape on ${pageUnderTest.path}`, async ({ page }, info) => {
      await applyTheme(page, "light");
      await openPage(page, pageUnderTest.url);

      // 1. First Tab lands on the skip link and Enter moves focus into main (2.4.1 Bypass Blocks).
      await page.keyboard.press("Tab");
      const skip = page.locator(".usa-skipnav");
      await expect(skip).toBeFocused();
      await page.keyboard.press("Enter");
      const mainFocused = await page.evaluate(() => {
        const active = document.activeElement;
        return active?.id === "main-content" || location.hash === "#main-content";
      });
      expect(mainFocused, "activating the skip link moves focus to #main-content").toBe(true);

      // 2. From the top, tabbing passes through the navigation before reaching main (2.4.3 Focus Order).
      await page.reload();
      await page.getByRole("main").waitFor();
      const path: FocusStep[] = [];
      let sawNav = false;
      let sawMainAfterNav = false;
      let noFocusVisible = 0;
      for (let i = 0; i < MAX_TABS; i += 1) {
        await page.keyboard.press("Tab");
        const step = await describeFocus(page);
        path.push(step);
        if (step.tag === "body") break; // focus wrapped to the document
        if (!step.visibleFocus) noFocusVisible += 1;
        if (step.landmark === "navigation") sawNav = true;
        if (step.landmark === "main" && sawNav) {
          sawMainAfterNav = true;
          break;
        }
      }
      const mainHasFocusables = await page.getByRole("main").locator("a, button, input, select, textarea, [tabindex]:not([tabindex='-1'])").count();
      expect(sawNav, "tab order reaches the primary navigation").toBe(true);
      if (mainHasFocusables > 0) expect(sawMainAfterNav, "tab order reaches main after the navigation").toBe(true);
      else info.annotations.push({ type: "note", description: "main has no focusable controls yet; main-reach check skipped" });

      // 3. Escape closes dialogs and popovers opened from keyboard and returns focus to the trigger (1.4.13, 2.1.2).
      // USWDS tooltips keep an aria-hidden [role=tooltip] in the DOM while closed, so only visible ones count as open.
      const triggers = page.getByRole("main").locator("[aria-haspopup], [aria-expanded='false'], [data-popover-trigger]");
      const triggerCount = Math.min(await triggers.count(), 8);
      const escapeResults: Array<{ trigger: string; opened: boolean; closedOnEscape: boolean; focusRestored: boolean }> = [];
      for (let i = 0; i < triggerCount; i += 1) {
        const trigger = triggers.nth(i);
        const label = ((await trigger.getAttribute("aria-label")) ?? (await trigger.textContent()) ?? "").trim().slice(0, 60);
        await trigger.focus();
        await page.keyboard.press("Enter");
        await page.waitForTimeout(150);
        const opened = await page.evaluate(() => {
          const dialog = document.querySelector("[role='dialog'], [role='menu'], [role='listbox'], [role='tooltip']:not([aria-hidden='true']), .usa-modal.is-visible");
          const expanded = document.activeElement?.getAttribute("aria-expanded") === "true" || !!document.querySelector("[aria-expanded='true']");
          return !!dialog || expanded;
        });
        let closedOnEscape = false;
        let focusRestored = false;
        if (opened) {
          await page.keyboard.press("Escape");
          await page.waitForTimeout(150);
          closedOnEscape = await page.evaluate(() => {
            const dialog = document.querySelector("[role='dialog'], [role='menu'], [role='listbox'], [role='tooltip']:not([aria-hidden='true']), .usa-modal.is-visible");
            return !dialog && !document.querySelector("[aria-expanded='true']");
          });
          focusRestored = await trigger.evaluate((el) => el === document.activeElement);
          expect(closedOnEscape, `Escape closes the popover opened by "${label}"`).toBe(true);
          expect(focusRestored, `focus returns to "${label}" after Escape`).toBe(true);
        }
        escapeResults.push({ trigger: label, opened, closedOnEscape, focusRestored });
      }
      if (triggerCount === 0) info.annotations.push({ type: "note", description: "no dialog or popover triggers on this route" });

      writeResult(`keyboard/${pageUnderTest.slug}.json`, {
        route: pageUnderTest.path,
        url: pageUnderTest.url,
        runAt: new Date().toISOString(),
        gitSha: SHA,
        skipLinkFirst: true,
        skipLinkMovesFocusToMain: mainFocused,
        navReached: sawNav,
        mainReachedAfterNav: sawMainAfterNav,
        mainFocusableCount: mainHasFocusables,
        stepsWithoutVisibleFocus: noFocusVisible,
        tabPath: path,
        popovers: escapeResults,
      });
      expect(noFocusVisible, "every focused element shows a visible focus indicator (2.4.7)").toBe(0);
    });
  }
});
