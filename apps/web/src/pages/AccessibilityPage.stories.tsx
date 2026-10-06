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
