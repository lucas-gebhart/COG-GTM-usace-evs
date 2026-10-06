import type { Meta, StoryObj } from "@storybook/react-vite";
import { http, HttpResponse } from "msw";
import { AccessibilityPage } from "./AccessibilityPage";
import { fixtures } from "../mocks/fixtures";
import { leadershipStory } from "../stories/decorators";

const meta = {
  title: "Pages/Accessibility",
  component: AccessibilityPage,
  parameters: { layout: "padded" },
} satisfies Meta<typeof AccessibilityPage>;
export default meta;
type Story = StoryObj<typeof meta>;

/** Rendered from apps/api/fixtures/accessibility.json through the MSW handlers, same as `VITE_MOCK=1`. */
export const Default: Story = {};
export const Leadership = leadershipStory(Default);

export const NoAutomatedEvidence: Story = {
  parameters: {
    msw: {
      handlers: [
        http.get("*/api/v1/accessibility/readout", () =>
          HttpResponse.json({
            ...fixtures.accessibility,
            routes: [],
            summary: { ...fixtures.accessibility.summary, cells: 0, routes_tested: 0, zero_violation_cells: 0, viewports: [], themes: [], last_run_at: null },
          }),
        ),
      ],
    },
  },
};

/** Synthetic failing cells so the expandable violation rows and the impact chart can be reviewed; the real fixture has none. */
export const WithViolations: Story = {
  parameters: {
    msw: {
      handlers: [
        http.get("*/api/v1/accessibility/readout", () => {
          const details = [
            { rule: "color-contrast", impact: "serious", nodes: 3, help_url: "https://dequeuniversity.com/rules/axe/4.13/color-contrast", help: "Elements must meet minimum color contrast ratio thresholds", source: "axe", where: "" },
            { rule: "link-name", impact: "critical", nodes: 1, help_url: "https://dequeuniversity.com/rules/axe/4.13/link-name", help: "Links must have discernible text", source: "axe", where: "" },
          ];
          const routes = fixtures.accessibility.routes.map((cell, i) =>
            i % 16 === 0 ? { ...cell, violations: details.reduce((n, d) => n + d.nodes, 0), violation_details: details } : cell,
          );
          const failing = routes.filter((r) => r.violations > 0).length;
          return HttpResponse.json({
            ...fixtures.accessibility,
            routes,
            summary: { ...fixtures.accessibility.summary, zero_violation_cells: routes.length - failing, total_violations: failing * 4 },
          });
        }),
      ],
    },
  },
};

export const ApiError: Story = {
  parameters: {
    msw: { handlers: [http.get("*/api/v1/accessibility/readout", () => HttpResponse.json({ detail: "fixture missing" }, { status: 500 }))] },
  },
};

export const Loading: Story = {
  parameters: {
    msw: { handlers: [http.get("*/api/v1/accessibility/readout", async () => new Promise(() => {}))] },
  },
};
