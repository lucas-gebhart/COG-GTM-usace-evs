import type { Decorator, Preview } from "@storybook/react-vite";
import { useEffect } from "react";
import { MemoryRouter } from "react-router";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { mswLoader } from "msw-storybook-addon/csf3";
import { handlers } from "../src/mocks/handlers";

async function startWorker() {
  const { setupWorker } = await import("msw/browser");
  const worker = setupWorker();
  await worker.start({ quiet: true, onUnhandledRequest: "bypass", serviceWorker: { url: "./mockServiceWorker.js" } });
  return worker;
}
import { LiveRegionProvider } from "../src/hooks/useAnnounce";
import "../src/styles/global.scss";

const queryClient = new QueryClient({ defaultOptions: { queries: { retry: false, staleTime: Infinity } } });

const withTheme: Decorator = (Story, context) => {
  const theme = (context.globals.theme as string) ?? "light";
  useEffect(() => {
    if (theme === "leadership") document.documentElement.dataset.theme = "leadership";
    else delete document.documentElement.dataset.theme;
    document.body.style.background = theme === "leadership" ? "#13171f" : "#ffffff";
  }, [theme]);
  return (
    <div style={{ padding: "1rem", minHeight: "100%", background: "var(--evs-color-bg)", color: "var(--evs-color-ink)" }}>
      <Story />
    </div>
  );
};

// Stories that mount their own router (AppLayout) set `parameters.router = false`.
const withProviders: Decorator = (Story, context) => {
  const body = (
    <LiveRegionProvider>
      <Story />
    </LiveRegionProvider>
  );
  return (
    <QueryClientProvider client={queryClient}>
      {context.parameters.router === false ? body : <MemoryRouter initialEntries={["/"]}>{body}</MemoryRouter>}
    </QueryClientProvider>
  );
};

const preview: Preview = {
  loaders: [mswLoader(startWorker)],
  decorators: [withTheme, withProviders],
  globalTypes: {
    theme: {
      description: "EVS theme",
      toolbar: { title: "Theme", icon: "contrast", items: [{ value: "light", title: "Light (default)" }, { value: "leadership", title: "Leadership (dark, 1920x1080)" }], dynamicTitle: true },
    },
  },
  initialGlobals: { theme: "light" },
  parameters: {
    msw: { handlers },
    layout: "fullscreen",
    a11y: {
      // Fail the story on any axe violation (the Vitest addon treats "error" as a test failure).
      test: "error",
      options: {
        runOnly: { type: "tag", values: ["wcag2a", "wcag2aa", "wcag21a", "wcag21aa", "wcag22aa", "best-practice"] },
        // Components render as fragments without page landmarks; the Playwright route suite (pnpm test:a11y) checks landmarks on full pages.
        rules: { region: { enabled: false } },
      },
    },
    viewport: {
      options: {
        mobile320: { name: "Mobile 320", styles: { width: "320px", height: "640px" } },
        mobile360: { name: "Mobile 360", styles: { width: "360px", height: "740px" } },
        tablet: { name: "Tablet 768", styles: { width: "768px", height: "1024px" } },
        desktop: { name: "Desktop 1280", styles: { width: "1280px", height: "800px" } },
        leadership: { name: "Leadership 1920", styles: { width: "1920px", height: "1080px" } },
      },
    },
  },
};
export default preview;
