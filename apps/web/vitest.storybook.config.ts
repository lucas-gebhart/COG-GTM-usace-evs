import { defineConfig, mergeConfig } from "vitest/config";
import { storybookTest } from "@storybook/addon-vitest/vitest-plugin";
import viteConfig from "./vite.config";

// `pnpm test:storybook`: renders every story in headless Chromium and runs axe through addon-a11y.
export default mergeConfig(
  viteConfig,
  defineConfig({
    plugins: [storybookTest({ configDir: ".storybook", storybookScript: "pnpm storybook --ci", tags: { include: ["test"], exclude: ["skip-test"] } })],
    test: {
      name: "storybook",
      environment: undefined,
      globals: false,
      setupFiles: ["./.storybook/vitest.setup.ts"],
      include: ["src/**/*.stories.@(ts|tsx)"],
      // One story file at a time: parallel browser workers race the addon-vitest setup file ("Vitest failed to find the runner").
      fileParallelism: false,
      retry: 1,
      exclude: ["e2e/**", "node_modules/**"],
      browser: { enabled: true, provider: "playwright", headless: true, instances: [{ browser: "chromium" }] },
    },
  }),
);
