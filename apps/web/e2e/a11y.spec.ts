import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import { ADVISORY_TAGS, GATING_TAGS, MOTION, PAGES, THEMES, VIEWPORTS, applyTheme, gitSha, openPage, writeResult } from "./matrix";

// axe-core on every route x viewport (360, 768, 1280, 1920) x theme (light, leadership) x prefers-reduced-motion.
// One JSON file per cell in a11y-results/axe/, consumed by tools/acr (evs-acr-gen) to populate the OpenACR.

const SHA = gitSha();
const GATING = new Set<string>(GATING_TAGS);

for (const viewport of VIEWPORTS) {
  test.describe(viewport.name, () => {
    test.use({ viewport: { width: viewport.width, height: viewport.height } });

    for (const theme of THEMES) {
      for (const motion of MOTION) {
        for (const pageUnderTest of PAGES) {
          test(`axe ${pageUnderTest.path} [${theme}, motion=${motion}]`, async ({ page }) => {
            await applyTheme(page, theme);
            await page.emulateMedia({ reducedMotion: motion });
            await openPage(page, pageUnderTest.url);

            const results = await new AxeBuilder({ page })
              .withTags([...GATING_TAGS, ...ADVISORY_TAGS])
              .options({ rules: { "css-orientation-lock": { enabled: true }, "label-content-name-mismatch": { enabled: true } } })
              .analyze();

            const gating = results.violations.filter((v) => v.tags.some((t) => GATING.has(t)));
            const advisories = results.violations.filter((v) => !v.tags.some((t) => GATING.has(t)));

            writeResult(`axe/${pageUnderTest.slug}__${viewport.name}__${theme}__${motion}.json`, {
              route: pageUnderTest.path,
              url: pageUnderTest.url,
              title: pageUnderTest.title,
              viewport: viewport.name,
              width: viewport.width,
              height: viewport.height,
              theme,
              reducedMotion: motion === "reduce",
              runAt: new Date().toISOString(),
              gitSha: SHA,
              axeVersion: results.testEngine.version,
              tags: [...GATING_TAGS, ...ADVISORY_TAGS],
              gatingTags: [...GATING_TAGS],
              violations: gating,
              advisories,
              incomplete: results.incomplete,
              passes: results.passes.map((p) => ({ id: p.id, tags: p.tags, nodes: p.nodes.length })),
              inapplicable: results.inapplicable.map((p) => p.id),
            });

            expect(gating, JSON.stringify(gating, null, 2)).toEqual([]);
          });
        }
      }
    }
  });
}
