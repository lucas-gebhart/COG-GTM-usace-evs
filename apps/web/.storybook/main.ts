import type { StorybookConfig } from "@storybook/react-vite";

const config: StorybookConfig = {
  stories: ["../src/**/*.stories.@(ts|tsx)"],
  addons: ["@storybook/addon-docs", "@storybook/addon-a11y", "@storybook/addon-vitest"],
  framework: { name: "@storybook/react-vite", options: {} },
  staticDirs: ["../public"],
  viteFinal: (viteConfig) => ({
    ...viteConfig,
    server: { ...viteConfig.server, fs: { allow: [".", "../api/fixtures", "../../"] } },
  }),
};
export default config;
