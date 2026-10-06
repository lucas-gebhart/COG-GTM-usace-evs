import type { Decorator, StoryObj } from "@storybook/react-vite";

/** Forces a story to render in leadership mode regardless of the toolbar. Use for the dark-theme variants. */
export const leadershipStory = <T,>(story: StoryObj<T>): StoryObj<T> => ({
  ...story,
  name: `${(story.name ?? "Default") as string} (leadership)`,
  globals: { ...(story.globals ?? {}), theme: "leadership" },
});

/** Constrains a story to a mobile-width column so card mode and reflow can be inspected on a desktop viewport. */
export const narrow =
  (width = 360): Decorator =>
  (Story) => (
    <div style={{ maxWidth: width, border: "1px dashed var(--evs-color-hairline)", padding: "0.5rem" }}>
      <Story />
    </div>
  );
