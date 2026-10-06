import { setProjectAnnotations } from "@storybook/react-vite";
import * as a11yAddonAnnotations from "@storybook/addon-a11y/preview";
import * as projectAnnotations from "./preview";

// Applies the preview decorators, loaders (MSW) and the a11y addon so each story runs axe as a test.
setProjectAnnotations([a11yAddonAnnotations, projectAnnotations]);
