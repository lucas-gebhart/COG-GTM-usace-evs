# EVS Web (Vite + React 19 + USWDS)

Demo frontend for the USACE Enterprise Visibility Suite. Nothing here is an operational USACE system.

## Scripts

| Command | What it does |
| --- | --- |
| `pnpm install` | Install dependencies (`pnpm-workspace.yaml` approves the esbuild, msw and @parcel/watcher build scripts) |
| `pnpm gen:api` | Regenerate `src/api/schema.d.ts` from `packages/contract/openapi.json` |
| `pnpm dev` | Vite dev server on :5173 (the Compose web container serves :3000), proxies `/api` to the FastAPI server on :8000 |
| `pnpm dev:mock` | Same, with `VITE_MOCK=1`: MSW serves `apps/api/fixtures/*.json` so no API or database is needed |
| `pnpm lint`, `pnpm typecheck` | ESLint (`jsx-a11y` strict) and `tsc -b` |
| `pnpm test` | Vitest + Testing Library + `vitest-axe` on every component and hook |
| `pnpm build` | Production bundle into `dist/` |
| `pnpm test:a11y` | Playwright + axe on every route, desktop and mobile |
| `pnpm storybook` | Storybook on :6006 with the a11y addon and MSW mock data |
| `pnpm build-storybook` | Static Storybook into `storybook-static/` |
| `pnpm test:storybook` | Renders every story in headless Chromium and fails on any axe violation (CI job `storybook`) |

## Layout

```
src/
  app/          routes.ts (stable paths and titles), router.tsx, AppLayout.tsx (shell)
  api/          openapi-fetch client and generated schema types
  components/   the accessible component kit (one file per component, .stories.tsx and .test.tsx beside it)
  hooks/        useApi, useSse, useMediaQuery, useReducedMotion, useElementSize, useTheme, useAnnounce
  lib/          format.ts (numbers, dates, deltas), csv.ts
  mocks/        MSW handlers built from apps/api/fixtures (browser worker and node server)
  styles/       _tokens.scss (colour pairs with contrast ratios), _base.scss, _components.scss, uswds-settings.scss
  theme/        chartPalette.ts (series colours, dash patterns, marker shapes) and ChartPatterns.tsx (SVG pattern fills)
```

## Component kit

Import from `src/components`. Every component is keyboard operable, announces state changes in text and works from 320 px up.

| Component | Use it for | Notes |
| --- | --- | --- |
| `PageHeader` | The single `h1` on each page, intro text, breadcrumbs, action slot | Breadcrumb current item carries `aria-current="page"` |
| `KpiTile` | Headline numbers | Delta rendered as icon + sign + screen-reader sentence ("down 3.1% vs plan") |
| `Figure` | Any Recharts chart | Requires `title`, `description`, `data`, `columns`. Adds "View as table" toggle, CSV download, `aria-labelledby`/`aria-describedby`, legend with pattern swatches, falls back to the table under 280 px. Pass `accessibilityLayer` to the chart and use `reducedMotion` from the render props to disable animation |
| `DataTable` | TanStack Table v8 as a USWDS table | `caption`, `scope="col"` and `scope="row"`, `aria-sort`, labelled column filters, pagination status (`role="status"`), sticky header on desktop, stacked cards under 640 px (`usa-table--stacked`), row navigation via `getRowHref` (links) or `onRowActivate` (buttons, row click, Enter) |
| `FilterBar` | USWDS form controls above a table or map | Applies on the Apply button or Enter only, never on change. Announces the result count through the live region. Collapses behind a "Filters" button under 640 px |
| `StatusChip`, `StatusMarker` | Lock and project status | Shape + text + colour: green circle Operating, yellow triangle Delayed, red octagon Closed, grey hatched ring Stale, grey diamond Unknown. Marker has a 44 x 44 hit area and can be a button |
| `AsOfBadge` | Data freshness on every dataset | Relative and absolute `source_as_of`, freshness icon + text (fresh, aging, stale, simulated), tooltip with `fetched_at` and source, `aria-live="polite"` |
| `EmptyState`, `ErrorState`, `SkeletonLoader` | Query states | `ErrorState` is `role="alert"` with Retry and the API reference id; `SkeletonLoader` sets `aria-busy` with a text label |
| `ThemeToggle` | Leadership mode | Sets `<html data-theme="leadership">`, persisted in `localStorage`; dark palette, 140 percent type scale for 1920 x 1080 displays |
| `RefreshControl` | Live pages | 60 s countdown with Pause/Resume and Refresh now; status is text (`data-testid="refresh-status"`) |

Typical page:

```tsx
const locks = useLocks(filters.river);
return (
  <>
    <PageHeader title="Locks" intro="Public LPMS lock status." breadcrumbs={[{ label: "Home", to: "/" }, { label: "Locks" }]} />
    <FilterBar fields={fields} values={filters} onApply={setFilters} resultCount={locks.data?.items.length} resultNoun="locks" />
    {locks.isPending && <SkeletonLoader variant="table" label="Loading locks" />}
    {locks.isError && <ErrorState error={locks.error} onRetry={() => locks.refetch()} />}
    {locks.data && (
      <DataTable caption="Locks" captionMeta={<AsOfBadge asOf={locks.data.as_of} />} columns={columns} data={locks.data.items} getRowHref={(r) => `/locks/${r.lock_id}`} />
    )}
  </>
);
```

## Hooks

- `useApi.ts`: one TanStack Query hook per endpoint (`useHealth`, `useProjects`, `useProject`, `useLocks`, `useLock`, `useFinancialSummary`, `useLabor`, `useFacilities`, `useSrpCoverage`, `useAccessibilityReadout`, `useFeeds`, `useThresholds`). Failures are `ApiError` with `status`, `detail` and a `referenceId` shown by `ErrorState`.
- `useSse(url, { events, onEvent })`: `EventSource` with exponential backoff reconnect, pause/resume and `status` text. `LOCKS_STREAM_URL` points at `/api/v1/public/locks/stream/events`.
- `useMediaQuery`, `useIsMobile` (under 640 px), `useReducedMotion`, `useElementSize`, `useTheme`.
- `useAnnounce` + `LiveRegionProvider` (mounted in `AppLayout`): `announce(text)` for polite updates, `announce(text, "assertive")` for alerts.

## Accessibility conventions

- Status is never colour alone: shape + text + colour (see `src/components/status.ts`). Chart series use colour + dash pattern + marker shape + pattern fill (`src/theme/chartPalette.ts`).
- Every chart is wrapped in `Figure` with a real `<table>` alternative and CSV download. Maps (WP5b) must offer a list alternative.
- One `h1` per page via `PageHeader`; landmarks come from `AppLayout` (header, nav, main, footer, skip link).
- Focus is always visible: 3 px `#2491ff` outline with offset on every focusable element, including in leadership mode.
- `prefers-reduced-motion: reduce` disables transitions, the skeleton shimmer and marker pulse; charts read `reducedMotion` from `Figure`.
- `forced-colors: active` maps tokens to system colours; status shapes keep their outlines.
- Only tables, Gantt views and maps may scroll horizontally at 320 px, and each has a non-2D alternative.
- Colour pairs and their contrast ratios are documented beside each token in `src/styles/_tokens.scss`.
- Live announcements go through the shared `LiveRegionProvider`; do not add ad hoc `aria-live` regions.
- No em dashes in UI copy.

## Mock mode and fixtures

`src/mocks/handlers.ts` mirrors the FastAPI routers and reads `apps/api/fixtures/*.json` directly, so the fixtures stay the single source of data. Responses carry `as_of.source = "fixtures"`. The same handlers run in the browser (`VITE_MOCK=1`, Storybook) and in Node (Vitest through `src/mocks/server.ts`). `public/mockServiceWorker.js` is generated by `npx msw init public/`.

## Storybook

Every component has stories in light and leadership themes (toolbar switch) at 320, 360, 768, 1280 and 1920 px viewports. `parameters.a11y.test = "error"` so `pnpm test:storybook` fails on any axe violation. Stories that mount their own router set `parameters.router = false`.
