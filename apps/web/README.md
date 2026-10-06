# EVS Web (Vite + React 19 + USWDS)

- `pnpm install`, `pnpm gen:api` (types from `packages/contract/openapi.json`), `pnpm dev` (proxies `/api` to :8000)
- `pnpm test` (Vitest + Testing Library), `pnpm test:a11y` (Playwright + axe on every route, desktop and mobile)
- `pnpm lint` runs `eslint-plugin-jsx-a11y` strict; `pnpm typecheck`

Conventions: USWDS components from `@trussworks/react-uswds`; status never by colour alone (shape + text + colour);
every chart wrapped in `<Figure>` with a table alternative; map always has a list alternative; `aria-live="polite"` on as-of updates.
