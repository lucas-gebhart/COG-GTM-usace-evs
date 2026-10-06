/// <reference types="vitest/config" />
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: { "/api": { target: process.env.VITE_API_UPSTREAM ?? "http://localhost:8000", changeOrigin: true } },
  },
  css: {
    preprocessorOptions: {
      scss: { loadPaths: ["node_modules/@uswds/uswds/packages"], quietDeps: true, silenceDeprecations: ["global-builtin", "import"] },
    },
  },
  test: { environment: "jsdom", setupFiles: ["./src/test-setup.ts"], globals: true, exclude: ["e2e/**", "node_modules/**"] },
});
