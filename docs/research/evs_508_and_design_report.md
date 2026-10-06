# Enterprise Visibility Suite (EVS): Section 508 / WCAG Design Specification, Compliance Read-out Approach, and Visualization/UX Design

Prepared for the USACE EVS demo (Oracle APEX to React + API + PostgreSQL on AWS GovCloud IL5). Research and design only; no code was built. Companion files: `evs_openacr_skeleton.yaml` (validated against the GSA OpenACR 0.1.0 schema and the VPAT 2.5 WCAG 2.1 + 508 catalog), `evs_openacr_skeleton.md` (the same skeleton rendered by the OpenACR CLI), and six reference screenshots in `refs/`.

Date: 6 October 2026.

---

## Executive summary

1. **Legal baseline.** The Revised Section 508 Standards (36 CFR Part 1194, Appendix A, E205.4 and E207.2) incorporate **WCAG 2.0 Level A and AA** by reference. That is the floor USACE must be able to show conformance to, and it is what a VPAT/ACR "Revised Section 508 edition" reports against.
2. **Design target.** Design and test EVS to **WCAG 2.1 Level AA**, and adopt three WCAG 2.2 criteria as design rules (2.4.11 Focus Not Obscured, 2.5.7 Dragging Movements, 2.5.8 Target Size). Reasons: OMB M-23-22 (Dec 2023) tells agencies to follow the most current WCAG, which it identifies as 2.1; the Access Board states WCAG 2.1 AA content also satisfies 2.0 AA (backward compatible); DOJ's 2024 ADA Title II rule set WCAG 2.1 AA as the public-sector web standard; 2.1 adds the mobile/reflow criteria (1.3.4, 1.4.10, 1.4.11, 1.4.13, 2.5.x, 4.1.3) that directly address USACE's desktop/phone/tablet complaint about APEX. No DoD or Army directive found in this session requires more than WCAG 2.0 AA; the DoD CIO Section 508 and Army accessibility pages were blocked (Akamai "Access Denied") from this environment, so the DoD/Army confirmation step is flagged for USACE's 508 coordinator.
3. **Colour is never the only channel.** The lock status encoding is colour + shape + icon + text (Green circle "Operating", Yellow triangle "Delayed", Red octagon "Closed", Grey hatched "Stale"). All text colours in the palette are verified at 4.5:1 or better; status marker boundaries are verified at 3:1 or better against the basemap.
4. **Compliance read-out is a build artifact produced by CI on every run.** Every CI run executes axe-core via `@axe-core/playwright` on every route at two viewports and two themes, plus `eslint-plugin-jsx-a11y`, the Storybook a11y addon and Lighthouse. A generator (`evs-acr-gen`) merges the axe results with a signed manual attestation file and writes an **OpenACR** YAML (machine-readable) and the OpenACR-rendered Markdown/HTML (human-readable). Of the 48 WCAG 2.1 A/AA criteria, 19 have axe rule coverage that can set the row automatically, 24 are manual-only, 5 are Not Applicable (no media/audio/motion actuation). The skeleton attached validates with `openacr validate`.
5. **The read-out is also a demo visualization.** An in-app `/accessibility` page shows per-route axe results, trend over builds, the manual attestation status, and a "Download ACR" button. Dogfooding the dashboard on itself is a strong story for a visibility suite.
6. **Charts: Recharts 3 as the primary React charting library** (SVG, `accessibilityLayer` on by default with keyboard navigation, testable by axe), wrapped in an EVS `<Figure>` component that adds the caption, long description, "View as table" toggle, CSV download and reduced-motion handling. ECharts is the fallback for the Gantt and big-screen leadership views (built-in `aria.enabled` auto-descriptions and colour-blind `decal` patterns; canvas rendering means axe cannot inspect it, so the table alternative is mandatory). Highcharts has the best accessibility module in the market but is commercial for government use; Vega-Lite is a good "fast new visualization" option with ARIA on SVG marks but no keyboard point navigation.
7. **Map: MapLibre GL JS** with DOM markers rendered as `<button>` elements (full control of name, role, state), `Popup({focusAfterOpen: true})`, keyboard pan/zoom handler, self-hosted vector tiles (no external tile calls from IL5). An always-present list view of the same locks is the accessible alternative. Leaflet is an acceptable fallback; note its open 2.0 issue on keyboard-operable interactive markers.
8. **Information architecture** of ten pages maps each APEX region type to a React pattern (Interactive Report to USWDS table + filter rail; Chart region to `<Figure>`; Form to USWDS form with inline validation), making the migration story explicit.
9. **Responsive rule**: 12-column grid, four breakpoints (320, 640, 1024, 1400 CSS px), every widget stacks to one column at 320 px (400% zoom at 1280 px), charts re-render at container width, data tables and the Gantt are the only 2D-scroll exceptions and both offer a stacked/list alternative.
10. **Assumptions** are listed in Appendix C. The main ones: USWDS (react-uswds) is the component base; no audio/video content; authenticated users only on the internal pages, public users on the Public Value pages; feeds for locks arrive at least every 15 minutes.

---

## Part 1. Section 508 / WCAG design specification

### 1.1 Applicable standard and the version EVS should design to

| Source | What it says | Implication for EVS |
|---|---|---|
| U.S. Access Board, Revised 508 Standards and 255 Guidelines, 36 CFR 1194 App. A and C (final rule Jan 18 2017, corrected Jan 22 2018). https://www.access-board.gov/ict/ | E205.4 (electronic content) and E207.2 (software) require conformance to WCAG 2.0 Level A and Level AA success criteria and conformance requirements (incorporated by reference, 702.10.1). Chapter 3 Functional Performance Criteria (302.1 to 302.9), Chapter 5 Software (502, 503), Chapter 6 Support Documentation (602, 603) also apply. | The legally required floor is WCAG 2.0 A/AA plus the 508-specific chapters. The ACR must use the "Revised Section 508" edition. |
| U.S. Access Board, "Section 508 and WCAG 2.1" FAQ (2023). https://www.access-board.gov/ict/wcag2ict-faqs/ (and https://www.access-board.gov/ict/) | WCAG 2.1 is backward compatible: content that conforms to 2.1 AA also conforms to 2.0 AA. The Board has not yet updated the rule to 2.1. | Designing to 2.1 AA is a safe superset of the legal floor. |
| OMB M-23-22, "Delivering a Digital-First Public Experience" (Sept 22 2023). https://www.whitehouse.gov/wp-content/uploads/2023/09/M-23-22-Delivering-a-Digital-First-Public-Experience.pdf | Agencies "should" conform to the most current WCAG; footnote 6 states the most current version at publication is WCAG 2.1 with 2.2 pending. | Executive-branch policy direction is 2.1 now, 2.2 as it matures. |
| Section508.gov (GSA Government-wide IT Accessibility Program): ICT Testing Baseline, Trusted Tester, ACR/VPAT guidance. https://www.section508.gov/test/ , https://www.section508.gov/sell/vpat/ , https://www.section508.gov/test/trusted-tester/ | Federal test processes (DHS Trusted Tester v5, ICT Testing Baseline) are the accepted manual test methodology; GSA recommends vendors deliver an ACR using the ITI VPAT template (now 2.5). | Manual test plan aligns to Trusted Tester test IDs; deliverable format is VPAT 2.5 / OpenACR. |
| W3C WCAG 2.0 (Dec 2008), 2.1 (June 2018, 2nd ed. Sept 2023), 2.2 (Oct 2023, updated Dec 2024). https://www.w3.org/TR/WCAG20/ , https://www.w3.org/TR/WCAG21/ , https://www.w3.org/TR/WCAG22/ | 2.1 adds 17 criteria (12 at A/AA) covering reflow, non-text contrast, text spacing, hover/focus content, pointer gestures, target/motion, status messages. 2.2 adds 9 (6 at A/AA) and removes 4.1.1 Parsing. | 2.1's additions are the ones that matter most for dashboards on phones and tablets. |
| DOJ ADA Title II web rule, 28 CFR Part 35 (Apr 2024). https://www.ada.gov/resources/2024-03-08-web-rule/ | WCAG 2.1 AA as the technical standard for state and local government web content. | Non-binding for USACE; it is the clearest signal of where federal expectations are heading. |
| GSA OpenACR. https://github.com/GSA/openacr , editor https://acreditor.section508.gov/ | Machine-readable ACR format (YAML, JSON schema 0.1.0) with catalogs for VPAT 2.4 and 2.5 editions, including `2.5-edition-wcag-2.1-508-en.yaml`. CLI validates and renders Markdown. | Skeleton generated and validated in this session. |
| DoD: DoDI 8310.01 (IT Standards), DoDM 8400.01 (Section 508 implementation), DoD CIO Section 508 site https://dodcio.defense.gov/DoDSection508/ ; Army https://www.army.mil/accessibility | Pages returned Akamai "Access Denied" from this environment, so their current text could not be verified. Publicly, DoDM 8400.01 implements the Revised 508 Standards (WCAG 2.0 AA) and DoD Section 508 guidance points to Trusted Tester. | No stronger directive confirmed. Flag for USACE's Section 508 coordinator to confirm whether the Army CIO or USACE Web Enterprise has adopted 2.1 or 2.2 locally. |

**Recommendation.** Design, build and test EVS to WCAG 2.1 Level AA. Report conformance in the VPAT 2.5 "WCAG 2.1 and Revised Section 508" edition so the 2.0 AA legal floor and the 2.1 target appear in one ACR. Treat WCAG 2.2 criteria 2.4.11, 2.5.7 and 2.5.8 as design rules (they cost nothing extra in a new build) and 2.4.12/2.4.13/3.3.7/3.3.8 as "nice to have" tracked outside the ACR. Do not claim AAA.

### 1.2 Design specification

#### 1.2.1 Colour system (USWDS design tokens; ratios computed with the WCAG 2.x relative-luminance formula)

Base text and surfaces (light theme, the default for internal pages):

| Role | Token | Hex | On | Ratio | Rule met |
|---|---|---|---|---|---|
| Body text | gray-90 | #1b1b1b | white #ffffff | 17.22 | 1.4.3 (4.5:1) |
| Secondary text, axis ticks | gray-cool-60 | #565c65 | white | 6.74 | 1.4.3 |
| Secondary text on panel | gray-cool-60 | #565c65 | gray-cool-5 #edeff0 | 5.85 | 1.4.3 |
| Links, primary buttons | blue-60v | #005ea2 | white | 6.72 | 1.4.3, 1.4.11 |
| Header / brand | blue-warm-70v | #1a4480 | white | 9.62 | 1.4.3 |
| Focus ring | blue-40v | #2491ff | white | 3.20 | 1.4.11 (3:1 non-text) |
| Focus ring (dark theme) | blue-40v | #2491ff | blue-warm-90 #13171f | 5.61 | 1.4.11 |
| Panel background | gray-cool-5 | #edeff0 | body text gray-90 | 14.93 | 1.4.3 |
| Disabled text | gray-cool-50 | #71767a | white | 4.59 | 1.4.3 (disabled is exempt; we meet it anyway) |

Do not use gray-cool-40 (#8d9297, 3.14:1) or lighter for any text. gray-cool-20 (#c6cace, 1.65:1) is for hairlines and grid lines only, which are decorative and exempt from 1.4.11.

Status encoding (used by lock status, facility condition, data freshness, schedule health). Each status is a bundle of **colour + shape + icon + text label**; any single channel identifies it, which satisfies 1.4.1 and 1.3.3.

| Status | Meaning (lock view) | Fill token / hex | Shape | Icon | Text chip | Verified contrasts |
|---|---|---|---|---|---|---|
| Green | Operating normally | green-cool-50v #008817 | Circle | check | "Operating", gray-90 on green-cool-5 #ecf3ec | fill vs white 4.63, vs basemap gray-cool-5 4.02; chip text 15.25 |
| Yellow | Delayed: queue or delay above threshold, or feed stale | gold-20v #ffbe2e with 2 px gray-90 stroke | Triangle (point up) | exclamation | "Delayed", gray-90 on gold-5 #f5f0e6 | gold-20v fails on white (1.66) so the gray-90 stroke carries the 3:1 boundary (10.38); chip text 15.16 |
| Red | Closed / unavailable | red-60v #b50909 | Octagon | x | "Closed", gray-90 on red-warm-10 #f4e3db | fill vs white 6.98; chip text 13.83 |
| Grey | Stale data (as-of older than threshold) | gray-cool-60 #565c65, 45-degree hatch pattern | Dashed ring around the last known shape | clock | "Stale since HH:MM", gray-90 on gray-cool-5 | fill vs white 6.74, vs basemap 5.85 |

Why shapes are mandatory, with numbers: green-cool-50v against red-60v is 1.51:1, and under deuteranopia/protanopia simulation both read as similar dark olive/brown tones. The lightness separation (green 4.63:1 vs white, red 6.98:1, yellow 1.66:1) helps but is not sufficient on its own, so the shape (circle / triangle / octagon) and the text label do the identification. Pattern fills (hatch) are used for "stale" and for stacked-bar segments following the USWDS data-visualization guidance ("use colour with care", "discrete dash or datapoint styles distinguish lines without relying upon colour").

Categorical chart palette (light theme), max five series per chart; series are also distinguished by dash pattern and marker shape and are labelled directly at line end:

| Series | Token | Hex | Ratio on white | Dash / marker |
|---|---|---|---|---|
| 1 | blue-60v | #005ea2 | 6.72 | solid / circle |
| 2 | orange-warm-50v | #cf4900 | 4.56 | dashed 6-3 / square |
| 3 | violet-60v | #783cb9 | 6.68 | dotted 2-3 / triangle |
| 4 | green-cool-60v | #216e1f | 6.34 | dash-dot / diamond |
| 5 | gray-cool-60 | #565c65 | 6.74 | long dash 10-4 / cross |

Big-screen leadership (dark) theme, background blue-warm-90 #13171f, text gray-cool-10 #dfe1e2 (13.68:1): series blue-30v #58b4ff (8.02), orange-20v #ffbc78 (10.87), green-cool-30v #21c834 (8.01), violet-warm-30v #ee83ff (7.97), gray-cool-30 #a9aeb1 (8.01); red-30v #ff8d7b (7.99) for negative variance. All exceed 4.5:1 so chart labels drawn in series colour remain readable.

Sequential/diverging palettes: use single-hue sequential ramps (blue-10 to blue-80v) for choropleths and heatmaps; never red-to-green diverging. For "plan vs actual variance" use a blue/orange diverging ramp with a hatched zero band.

Windows High Contrast / `forced-colors: active`: SVG fills are replaced by `CanvasText`/`Highlight` system colours; shapes, dash patterns and text labels carry the meaning. Test with Edge "Forced colors" emulation.

#### 1.2.2 Typography and sizing

- Family: Public Sans (USWDS default), system fallback. Monospace (Roboto Mono) for tabular figures in KPIs and tables (`font-variant-numeric: tabular-nums`).
- Root 16 px; all sizes in rem. Body 1rem/1.5; small 0.875rem (14 px) minimum for UI text; axis tick labels may be 0.75rem (12 px) only when contrast is 4.5:1 or better and a table alternative exists.
- KPI values 2.5rem to 3.5rem (40 to 56 px) desktop, 2rem tablet, 1.5rem mobile; big-screen theme 4.5rem.
- Headings: h1 2rem, h2 1.5rem, h3 1.25rem, h4 1rem bold. One h1 per route; each widget has an h2 or h3 that is also its accessible name (`aria-labelledby`).
- Measure 45 to 75 characters for prose; line height 1.5 for body, 1.2 for headings; paragraph spacing 1rem. Must survive the 1.4.12 text-spacing override (no fixed-height text containers, `min-height` instead of `height`).
- Numbers: thousands separators, units in the label not the value, negative values with a leading minus and the word "under plan" in screen-reader text where colour is also used.

#### 1.2.3 Focus indicators

- Global `:focus-visible` style: `outline: 0.25rem solid #2491ff; outline-offset: 0.25rem` (USWDS default). Never `outline: none` without a replacement.
- SVG chart points and map markers draw an explicit focus ring (`<circle r+4 stroke=#2491ff stroke-width=3>`) because outline rendering on SVG children is inconsistent; the ring is at least 2 px thick and has 3:1 against both the series colour and the background.
- Focus must not be hidden under sticky headers or the as-of banner (WCAG 2.2 2.4.11): `scroll-padding-top` equals header height; sticky elements are limited to 96 px total.

#### 1.2.4 Keyboard navigation model for dashboards

Landmarks and page skeleton (2.4.1, 1.3.1):
```
<header role=banner>  USWDS gov banner + app header + skip link ("Skip to main content", "Skip to filters")
<nav aria-label="Primary">  EVS sections
<main id=main>  h1 route title, "as-of" status region, widget grid
  <section aria-labelledby=w1-h>  (one per widget, heading = widget title)
     <div role=toolbar aria-label="Widget actions">  view-as-table, download, expand
<aside aria-label="Filters">  filter rail (collapses to a dialog on mobile)
<footer role=contentinfo>
```
Tab order: skip links, header, primary nav, filters (desktop) or "Filters" button (mobile), then widgets in reading order. Inside a widget the Tab key stops once on the toolbar group and once on the chart/table/map body; arrow keys move inside the body (roving tabindex, APG "composite widget" pattern).

Chart body keys: Left/Right move across x-categories (announces "FY24 Q3, obligations 412.3 million, plan 400"), Up/Down switch series, Home/End first/last point, Enter opens the detail popover or drills down, Esc closes popover and returns focus to the point. "T" toggles the table view when the chart has focus (single-key shortcut is allowed by 2.1.4 because it is active only while the component has focus).

Table body keys: native `<table>`; sort buttons inside `<th>` with `aria-sort`; row actions are real buttons; Page Up/Down handled by the browser. No grid role unless cells are editable (Admin page only).

Map body keys: Tab to the map canvas (MapLibre keyboard handler: arrows pan, +/- zoom, Shift+arrows rotate/pitch; rotation and pitch are disabled for EVS), then Tab through markers in river-mile order (each marker is a `<button aria-expanded aria-describedby>`), Enter/Space opens the popover and moves focus into it, Esc closes and restores focus to the marker. A visible "Keyboard shortcuts" button on the map toolbar lists these (addresses Leaflet issue #9131 "help should be provided for the map container keyboard shortcuts", which applies to any map).

Dialogs and popovers: focus trapped inside modal dialogs only, returned on close (2.4.3). Non-modal popovers (hover cards) are dismissible with Esc, hoverable, and persistent until dismissed (1.4.13).

Route changes (SPA): on navigation, move focus to the new h1 and announce the page title via a polite live region; update `document.title` to "Page name - EVS" (2.4.2).

#### 1.2.5 Data tables

- `<table>` with `<caption>` (visible title plus as-of time), `<thead>`/`<th scope=col>`, row headers `<th scope=row>` for the identifying column (lock name, project ID). Complex two-level headers use `headers`/`id` pairs. These are what axe rules `th-has-data-cells`, `td-headers-attr`, `table-fake-caption` check.
- Sortable headers: `<th aria-sort="ascending|descending|none"><button>Column name<span class=usa-sr-only>, sort</span></button></th>`. Sorting announces "Sorted by delay, descending" in the table's `aria-live=polite` status cell.
- Pagination and filter result counts announced: "Showing 1 to 25 of 212 locks" via `role=status`.
- Live updates (lock status): live-region behaviour sits outside the table. A single `role=status aria-live=polite aria-atomic=true` region above the table announces a digest at most once per minute: "Lock status updated as of 14:32. Two changes: Lock and Dam 52 now Delayed, Markland now Operating." Rows that changed get a visible "Updated" badge for 60 s and `aria-describedby` pointing to the badge. Feed failure or staleness beyond threshold uses `role=alert` once, then the persistent stale banner.
- Mobile: USWDS `usa-table--stacked-header` pattern below 640 px (each row renders as a labelled card) for tables up to 8 columns; wider tables keep 2D scroll with a visible scrollbar and a `tabindex=0` wrapper labelled "Scrollable table" (rule `scrollable-region-focusable`).
- Export: "Download CSV" button for every table (also satisfies the data alternative for charts built from the same query).

#### 1.2.6 Charts

- Every chart is an EVS `<Figure>`: `<figure aria-labelledby=title aria-describedby=desc>` containing `<figcaption>` (title, one-sentence takeaway, as-of time, source system), the chart SVG, and a toolbar: "View as table" (toggles an inline `<table>` with the same data), "Download CSV", "Expand".
- The one-sentence takeaway is the chart's long description for screen readers: "Obligations are 3.1 percent under plan year to date; the gap opened in Q3." It is written by the same code that computes the KPI, so it never drifts from the data.
- Non-interactive charts (sparklines, KPI trends): `role=img` with `aria-label` equal to the takeaway; the SVG internals are `aria-hidden`.
- Interactive charts: the Recharts `accessibilityLayer` (default on in 3.x) provides a tab stop and arrow-key traversal with the tooltip exposed to assistive technology; EVS adds the explicit focus ring, the "T" table toggle, and announces point values through the shared status region.
- No information by colour alone: direct labels at line ends, dash patterns, marker shapes, hatch fills for stacked segments, and a textual legend that is a real `<ul>`.
- Lines at least 2 px, markers at least 8 px diameter, gridlines gray-cool-20 (decorative), axes gray-cool-60.
- Reduced motion: `prefers-reduced-motion: reduce` sets `isAnimationActive={false}` (Recharts) / `animation:false` (ECharts); live-updating charts redraw without transitions; any auto-advancing carousel or "play" control is off by default and pausable (2.2.2).
- Y axes start at zero for bar/area; a broken axis is never used. Dual axes are avoided; use small multiples instead.
- Minimum size 280 x 180 CSS px; below that the `<Figure>` renders the KPI number and the "View as table" link only.

#### 1.2.7 Maps

- The lock data is always available outside the map. The lock status table (same page) is the accessible alternative and is listed first in DOM order on mobile.
- Markers: DOM elements (`maplibregl.Marker({element})`) rendered as `<button type=button aria-label="Lock and Dam 52, Ohio River, mile 938.9, Delayed, 6 vessels in queue, as of 14:32" aria-expanded=false>` with a 44 x 44 CSS px hit area (visible symbol 24 to 32 px inside a transparent padding box). Clustering at low zoom uses the same button pattern with "12 locks, 2 delayed, 1 closed".
- Hover and press parity (2.1.1, 2.5.x): hover shows the same popover as Enter/Space/tap; hover popover is dismissible with Esc and remains open while the pointer is over it (1.4.13). Press (click/tap/Enter) pins the popover and moves focus into it (`Popup({focusAfterOpen: true, closeButton: true})`); close returns focus to the marker.
- Popover content is HTML (not canvas text): lock name, river, river mile, status chip (icon + text), vessels in queue, average delay, last lockage, as-of timestamp, stale flag, link "Open lock detail".
- Legend is a `<ul>` with shape + colour swatch + text, placed outside the canvas so it reflows and is readable by assistive technology.
- Map controls: zoom in/out buttons, "Reset view", "Keyboard shortcuts", "Switch to list". Scroll-zoom requires Ctrl/Cmd so the page can still scroll; rotation and pitch disabled. All controls at least 44 x 44 px.
- Basemap: self-hosted light vector style (OpenMapTiles schema or Esri vector basemap licensed for GovCloud) with low-saturation land/water so status markers meet 3:1 against it; no basemap labels in red/green/yellow hues.
- Touch: pinch-zoom and drag-pan have button equivalents (2.5.1); markers respond on pointer-up (2.5.2).
- Canvas/WebGL content is invisible to axe and to screen readers; the ACR row for the map is therefore populated from manual tests plus axe results on the DOM markers, list view and controls.

#### 1.2.8 Forms and filters

- USWDS form components: visible `<label>` for every control, hint text via `aria-describedby`, grouped filters in `<fieldset><legend>`.
- Filters apply on explicit "Apply" (desktop rail and mobile dialog) or, for single selects, on change with an announced result count; never on focus (3.2.1, 3.2.2).
- Date ranges: USWDS date picker plus typed input with format hint; validation on blur; errors in text with `aria-invalid` and `aria-describedby`; an error summary at the top of the form receives focus on submit (3.3.1, 3.3.3).
- Autocomplete tokens on login/profile fields (1.3.5).
- Filter state is reflected in the URL so a screen-reader user can share or bookmark a view.
- Destructive or financial-impact actions (Admin source mapping, threshold edits) require confirmation and are reversible for 24 h (3.3.4).

#### 1.2.9 Responsive breakpoints, zoom and reflow

| Breakpoint (CSS px) | Name | Grid | Behaviour |
|---|---|---|---|
| 320 to 639 | mobile | 1 column | Widgets stack in priority order; KPI tiles 2-up; filters in a full-screen dialog; tables stacked-card; map 56 vh with "Switch to list" first in tab order |
| 640 to 1023 | tablet | 2 columns (6+6) | KPI tiles 4-up; chart + table side by side only when each is at least 300 px wide |
| 1024 to 1399 | desktop | 12 columns | Filter rail 3 columns, content 9; default view |
| 1400+ | widescreen / big screen | 12 columns, dark theme optional | Leadership mode: larger type scale, 4 KPI + 2 chart layout, auto-refresh 60 s with visible countdown and pause |

- 1.4.10 Reflow: at 320 CSS px (400% zoom on a 1280 px window) nothing scrolls horizontally except data tables, the Gantt and the map (allowed 2D exceptions), each with a non-2D alternative (stacked table, milestone list, lock list).
- 1.4.4 Resize text: browser zoom to 200% and OS font scaling both honoured (rem everywhere, charts sized by container via `ResizeObserver`).
- 1.3.4 Orientation: no orientation lock; the lock map works in portrait with the list first.
- Container queries (`@container`) decide widget internals (chart vs KPI-only) so a widget works in any grid cell.

#### 1.2.10 Status messages, timeouts, errors, motion

- 4.1.3 Status messages: one global `role=status` region (polite) for non-urgent messages (filters applied, N results, data updated, download ready); one `role=alert` region for feed failure or session expiry warning. Toasts are visible for at least 8 s and are also written to the live region. Never move focus for a status message.
- 2.2.1 Timing: authenticated session idle timeout 15 min with a modal warning at 13 min that offers "Stay signed in" (extends by 15 min, unlimited times) and "Sign out"; the warning is announced via `role=alertdialog`. Live-data refresh is not a timeout and does not disturb focus or scroll position.
- 2.2.2 Pause/stop/hide: live tables and maps have a "Pause live updates" toggle; the leadership auto-refresh has a visible countdown and pause.
- 2.3.1: nothing flashes; status changes pulse once (opacity, 300 ms) and not at all under reduced motion.
- 3.3.1/3.3.3 Errors: identified in text next to the field and in a summary; suggestions included ("Enter a date on or after 1 Oct 2002"). API errors render a plain-language panel with a retry button and a reference ID; chart widgets show "Data unavailable, last good as of HH:MM" rather than an empty axis.

### 1.3 Component-level checklist mapped to WCAG success criteria and 508 provisions

| Component | WCAG SC (2.1 A/AA unless noted) | 508 provision | Implementation notes | Test method |
|---|---|---|---|---|
| App shell, skip links, landmarks | 1.3.1, 2.4.1, 2.4.2, 2.4.3, 2.4.5, 3.2.3, 3.2.4, 3.1.1 | E205.4, 302.1, 302.9 | USWDS banner/header/footer; `lang=en`; one `main`; titles "Page - EVS"; focus to h1 on route change | axe (`bypass`, `document-title`, `html-has-lang`, `region`), keyboard pass, NVDA page-navigation (D/H keys) |
| KPI tile | 1.1.1, 1.3.1, 1.4.3, 1.4.11, 4.1.2 | E205.4 | `<section aria-labelledby>`; number + label + delta with sign word; sparkline `role=img` with takeaway text | axe, SR read-through (MT-SR-01) |
| Status chip / marker symbol | 1.3.3, 1.4.1, 1.4.3, 1.4.11 | 302.3 | icon + shape + text; palette table in 1.2.1 | colour-blind simulation (MT-VIS-01), contrast tool (MT-VIS-02, -04), forced-colors |
| Data table (Interactive Report equivalent) | 1.3.1, 1.3.2, 1.4.10, 2.1.1, 2.4.7, 4.1.2, 4.1.3 | E205.4, 502.3.x N/A (web) | caption, scope, `aria-sort` buttons, status region for sort/filter/pagination, stacked at <640 px, `scrollable-region-focusable` wrapper | axe table rules, keyboard (MT-KBD-01), NVDA table mode (MT-SR-02), 400% zoom (MT-ZOOM-02) |
| Live "as-of" region | 2.2.1, 2.2.2, 4.1.3 | 302.1, 302.9 | polite digest at most 1/min, `role=alert` once on failure, pause toggle, stale banner | NVDA/JAWS announcement check (MT-SR-08), pause test (MT-MOTION-01) |
| Chart (Figure) | 1.1.1, 1.3.1, 1.4.1, 1.4.3, 1.4.11, 1.4.13, 2.1.1, 2.4.7, 2.2.2, 2.3.1, 4.1.2 | E205.4, 302.1, 302.2, 302.3 | figure/figcaption, takeaway sentence, view-as-table, CSV, roving focus via accessibilityLayer, explicit focus ring, dash/shape/direct labels, reduced motion | axe on SVG DOM (`svg-img-alt`, `color-contrast` on text), keyboard traversal (MT-KBD-01), SR (MT-SR-01), reduced-motion emulation |
| Gantt / schedule | 1.3.1, 1.3.2, 1.4.10, 2.1.1, 2.4.7 | E205.4 | bars are buttons with name "Milestone X, planned Jan 3, forecast Feb 10, 38 days late"; milestone list alternative; 2D scroll allowed | keyboard, SR, 400% zoom |
| Map (MapLibre) | 1.1.1, 1.3.1, 1.4.1, 1.4.11, 1.4.13, 2.1.1, 2.1.2, 2.4.3, 2.4.7, 2.5.1, 2.5.2, 2.5.3, 4.1.2; 2.2 2.5.8 | E205.4, 302.1, 302.7 | DOM `<button>` markers 44 px, `focusAfterOpen`, Esc handling, legend `<ul>`, list alternative, controls labelled, Ctrl+scroll zoom | axe on DOM markers/controls, keyboard (MT-KBD-01/02/04), VoiceOver iOS touch (MT-TOUCH-01/02), SR (MT-SR-07) |
| Popover / tooltip | 1.4.13, 2.1.2, 2.4.3, 4.1.2 | E205.4 | hover: dismissible, hoverable, persistent; press: focus in, Esc out, focus restored | keyboard (MT-KBD-04/06), SR |
| Filter rail / dialog | 1.3.1, 1.3.5, 2.1.1, 2.1.2, 2.4.3, 3.2.1, 3.2.2, 3.3.1, 3.3.2, 3.3.3, 4.1.2, 4.1.3 | E205.4, 302.9 | USWDS fieldset/legend, Apply button, announced result count, focus trap only in modal | axe (`label`, `autocomplete-valid`), keyboard, SR (MT-FORM-01..06) |
| Admin forms | 3.3.1 to 3.3.4, 2.2.1 | E205.4 | confirm + undo, error summary, session warning dialog | MT-FORM-03..06, MT-TIME-01 |
| Theme / big-screen mode | 1.4.3, 1.4.11, 1.4.12, 1.4.4 | 302.2 | dark palette table in 1.2.1; text spacing override survives | axe on both themes in CI, contrast tool |
| Downloads (CSV, ACR PDF) | 1.1.1, 2.4.4 | 602.3 | link text includes format and size; PDF tagged | axe `link-name`, PDF checker |
| Accessibility page (read-out) | 1.3.1, 1.4.1, 4.1.3 | 602.2 | per-route table + trend chart built with the same `<Figure>`; results also as table | axe (recursively, it tests itself), SR |

---

## Part 2. Compliance read-out approach

### 2.1 Automated testing set and CI

| Layer | Tool | Scope | Runs | Output |
|---|---|---|---|---|
| Lint | `eslint-plugin-jsx-a11y` (recommended + `strict` for `label-has-associated-control`, `no-static-element-interactions`) | JSX source | pre-commit, PR | ESLint SARIF to GitHub code scanning |
| Component | Storybook `@storybook/addon-a11y` (axe-core) + `@storybook/test-runner` with `axe-playwright` | every story (KPI tile, chip, table, Figure, marker, popover, filter) in light/dark and 320/1280 widths | PR | JUnit + per-story axe JSON |
| Unit | `jest-axe` / `vitest-axe` on rendered components with mock data | components with conditional states (stale, error, empty) | PR | test failures |
| Route (end to end) | `@axe-core/playwright` (`AxeBuilder().withTags(['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa','best-practice'])`) | every route in `routes.json`, 1280 and 360 px, light and dark theme, after data load and after one live update | PR (changed routes), nightly (all), release | `axe-results/<route>-<viewport>-<theme>.json` |
| Page audit | Lighthouse CI accessibility category (`lhci autorun`, assert `categories:accessibility >= 0.95`) | same routes, desktop + mobile presets | nightly, release | LHR JSON + HTML |
| Crawl | `pa11y-ci` (runner axe; `--threshold 0`) | public Public Value pages only, unauthenticated | nightly | JSON |
| Contrast | custom script over design tokens (the one used to produce the tables above) | palette file | PR when tokens change | fails build on any text pair < 4.5 or non-text pair < 3 |

Notes: Lighthouse and pa11y both wrap axe-core, so they add independent scoring and public-page crawling rather than new rules; keep `@axe-core/playwright` as the source of truth for the ACR. Playwright tests run against a seeded demo database so results are deterministic. Each axe run records `axe-core` version, rule set tags, URL, viewport, theme, git SHA and timestamp, which become the ACR's evidence footnotes.

Aggregation: a CI job (`evs-acr-gen`) merges all axe JSON files, maps each `violation.tags` (for example `wcag143`) to the WCAG SC, counts violations per SC per route, and writes:
1. `acr/summary.json` (per-route, per-SC counts; used by the in-app Accessibility page),
2. `acr/evs.openacr.yaml` (OpenACR; Web component levels set per the rule in 2.3),
3. `acr/evs-acr.md` and `.html` via `openacr output` (human-readable, VPAT 2.5 layout),
4. a PR comment with deltas versus main.

### 2.2 Manual test plan

Executed each release (and for the demo, once before the USACE session) by two testers; results recorded in `manual-attestation.yaml` with tester, date, AT/browser versions, pass/fail/notes per test ID.

| ID group | What | Tools | Key flows |
|---|---|---|---|
| MT-KBD-01..08 | Keyboard-only pass: reach, operate, escape every control; focus visible; no traps; order logical; single-key shortcuts scoped | Chrome, Firefox | Enterprise overview to Project detail drill-down; Financial filter and export; Lock table sort and marker popover; Admin threshold edit with session warning |
| MT-SR-01..08 | Screen reader scripts | NVDA 2024.x + Firefox; JAWS 2025 + Chrome; VoiceOver macOS + Safari; VoiceOver iOS + Safari; TalkBack optional | Script example (Locks): "Navigate by landmarks to main. Read the as-of status. Navigate by headings to 'Lock status table'. Enter table mode, read column headers, sort by Average delay, confirm announcement. Tab to the map, Tab to the first marker, read name, press Enter, read popover, Esc, confirm focus returns. Wait for a live update, confirm one polite digest." |
| MT-ZOOM-01..03 | 200% zoom; 400% zoom / 320 px reflow; text-spacing bookmarklet | Chrome DevTools device toolbar | all routes |
| MT-VIS-01..04 | Colour-vision deficiency simulation (protanopia, deuteranopia, tritanopia, achromatopsia); contrast spot-checks on SVG/canvas text; forced-colors (Windows High Contrast, Edge emulation) | Chrome DevTools Rendering panel, Colour Contrast Analyser | status chips, markers, series lines, legend, dark theme |
| MT-MOTION-01..02 | reduced-motion emulation; pause live updates; no flashing | DevTools | lock table/map, leadership auto-refresh |
| MT-TOUCH-01..02 | 44 px targets; gesture alternatives; up-event activation | iPad Safari, Android Chrome | map, filters, table row actions |
| MT-FORM-01..06 | labels, hints, errors, suggestions, confirm/undo, autocomplete | NVDA | filters, login, admin |
| MT-TIME-01 | session timeout warning, extend, announce | NVDA | any authenticated page |
| MT-RESP-01 | portrait/landscape, no orientation lock | iPad | locks, enterprise overview |
| Trusted Tester cross-walk | map each MT to the DHS Trusted Tester v5 test ID (for example 4.F focus order, 10.C table headers) so a USACE Trusted Tester can repeat the pass | TT process doc | all |

### 2.3 Read-out format: VPAT 2.5 / OpenACR

Format: OpenACR YAML conforming to schema `openacr-0.1.0.json` and catalog `2.5-edition-wcag-2.1-508-en.yaml` (GSA/openacr). The YAML is the authoritative record; `openacr output` renders the VPAT 2.5 tables (WCAG 2.1 Tables 1 to 3, Revised 508 Chapters 3 to 6) as Markdown/HTML; a PDF export is produced from the HTML for distribution. USACE can also load the YAML into the ACR Editor (https://acreditor.section508.gov/) for review or edits.

Population rule per criterion (Web component):

| Adherence level | Set when |
|---|---|
| `supports` | automated: zero axe violations for the SC's rules across all routes/viewports/themes in the release run, AND manual: all MT cases mapped to the SC passed in the attestation file |
| `partially-supports` | any open violation or failed MT case that has a linked issue and a workaround or does not block the task |
| `does-not-support` | failed MT case that blocks a core task, or axe `critical` violations without a workaround |
| `not-applicable` | criterion concerns content EVS does not ship (audio, video, motion actuation) |
| `not-evaluated` | never in a released ACR; it is the skeleton placeholder and the generator fails the build if any remain |

Notes field: generator writes "AUTOMATED: axe rules [...] n routes, 0 violations, run <SHA> <date>" and "MANUAL: MT-xx passed by <tester> <date> with <AT>"; humans can append remarks, which the generator preserves by key.

Coverage (from the mapping in Appendix A): of the 48 WCAG 2.1 A/AA criteria, **19 have at least one axe-core rule** (automated evidence that can set `supports` once the manual cases also pass), **24 are manual-only** (no axe rule exists: 1.3.2, 1.3.3, 1.4.4, 1.4.5, 1.4.10, 1.4.11, 1.4.13, 2.1.2, 2.1.4, 2.3.1, 2.4.3, 2.4.5, 2.4.6, 2.4.7, 2.5.1, 2.5.2, 3.2.1 to 3.2.4, 3.3.1, 3.3.3, 3.3.4, 4.1.3), and **5 are Not Applicable** for EVS (1.2.1, 1.2.2, 1.2.3, 1.4.2, 2.5.4). Even for the 19, axe misses canvas text, the meaning of alt text and the wording of live-region messages, so every `supports` row carries both evidence types. Section 508 Chapter 3 FPC rows (302.1 to 302.9) are manual attestations derived from the AT matrix; Chapter 4 Hardware is Not Applicable; Chapter 5 Software 502/503 is reported Not Applicable for a web application evaluated against WCAG per the VPAT 2.5 instructions, 504 is Not Applicable (no authoring); Chapter 6 Support Documentation rows reference the user guide and the in-app Accessibility page.

The attached `evs_openacr_skeleton.yaml` is the generator's output with every Web level set to `not-evaluated` (or `not-applicable` where justified) and every notes field pre-filled with the evidence recipe. It validates: `openacr validate -f evs_openacr_skeleton.yaml -c 2.5-edition-wcag-2.1-508-en.yaml` returns "Valid!". It is a skeleton and makes no conformance claim.

### 2.4 The Accessibility page inside EVS

Route `/accessibility` (visible to all authenticated roles; a public summary on the Public Value footer link):

```
+----------------------------------------------------------------------------------+
| Accessibility conformance                                     Build 2026.10.06.3 |
| As of 06 Oct 2026 14:10 UTC  |  Target: WCAG 2.1 AA  |  [Download ACR (YAML|HTML|PDF)] |
+----------------+----------------+----------------+--------------------------------+
| Routes passing | Open violations| Manual tests    | Criteria status                |
| 10 of 10       | 0 critical     | 41/41 passed    | 43 supports  5 N/A  0 partial  |
|   (circle ok)  | 2 moderate     | (attested 10/03)|                                |
+----------------+----------------+----------------+--------------------------------+
| Violations by route (bar, zero baseline)      | Trend, last 30 builds (line)     |
| /locks            ##  2 moderate              |  violations per build            |
| /financial        .   0                       |  ...                             |
| ...                                           |                                  |
| [View as table] [CSV]                         | [View as table] [CSV]            |
+-----------------------------------------------+----------------------------------+
| Criteria table: SC | level | automated evidence | manual evidence | notes  (sortable, filter by level)
+----------------------------------------------------------------------------------+
| Manual attestation: tester, date, AT matrix (NVDA/JAWS/VoiceOver versions), link to MT results
+----------------------------------------------------------------------------------+
```
Data comes from `acr/summary.json` published by CI (static JSON, no runtime axe in production). A "Run axe on this page now" button (dev/demo builds only) runs axe-core in the browser and shows live results, which is the demo moment: the dashboard audits itself in front of the audience. The page is built from the same `<Figure>` and table components as the rest of EVS, so it is itself covered by the CI run.

---

## Part 3. Visualization and UX design for the demo

### 3.1 Information architecture

Common frame on every page: USWDS gov banner, EVS header (logo, primary nav, global search, user menu), "as-of" status strip (per-domain freshness: CEFMS 02:00, EMS 06:15, P2 03:30, BUILDER 09/30, Locks 14:32 live), filter rail (desktop) or Filters button (mobile), widget grid, footer with Accessibility link. APEX mapping: each APEX page becomes a route; APEX Interactive Report becomes USWDS table + filter rail + saved views + CSV; APEX Chart region becomes `<Figure>`; APEX Form becomes USWDS form with inline validation; APEX Faceted Search becomes the filter rail; APEX Cards become KPI tiles; APEX Dashboard page becomes the widget grid with responsive stacking (the thing APEX could not do).

| # | Route | Key questions | Widgets (2 to 4) | Filters | Mobile / tablet behaviour | APEX origin |
|---|---|---|---|---|---|---|
| 1 | Enterprise overview `/` | How is the enterprise executing against plan this FY? Where are the risks? | KPI row (Obligations vs plan %, Labor hours vs plan, Milestones on time %, Facilities CI average); "Programs by execution" bar (sorted, zero baseline); "Risk watchlist" table (projects with 2+ red flags); mini "Public value" tiles linking to SRP and Locks | FY, Division, Program, Funding type | KPIs 2-up, bar collapses to top 8 with "Show all", watchlist stacked cards | Dashboard page (Cards + Chart + IR) |
| 2 | Program / portfolio `/programs/:id` | Which projects drive variance in this program? | Program KPI strip; Treemap or sorted bar "Projects by obligated $"; "Schedule health" stacked bar (on time / late / critical, hatched); project table | District, Project phase, Status | Treemap becomes sorted bar list; table stacked | IR + Chart |
| 3 | Project detail `/projects/:id` | Is this project on budget, on schedule, staffed? | Header card (P2 ID, district, PM, phase, status chips); Financial burn line (plan vs actual cumulative); Milestone timeline (Gantt-ish, with list toggle); Labor by resource type bar; Facility list (BUILDER) if applicable | Fiscal period | Sections become an accordion; Gantt defaults to list view below 640 px | Form (read-only) + Charts + IR |
| 4 | Financial execution `/financial` | Are we obligating to plan? Where is the burn ahead/behind? What expires? | KPI row (Obligated, Plan, Variance $ and %, Expiring in 90 days); "Cumulative obligations vs plan" line with plan band; "Variance by program" diverging bar (blue/orange, hatched zero band); "Monthly burn" small multiples per appropriation; obligations table | FY, Appropriation, Program, District | Small multiples stack; table stacked | IR + Chart (CEFMS) |
| 5 | Workforce / labor `/labor` | Where are hours going? Are we over/under on labor plan? Which skills are constrained? | KPI row (Hours charged, Plan, Utilization %, Overtime %); "Hours by project type" stacked bar (hatched); "Utilization by district" heatmap (single-hue, values shown in cells); "Top 10 labor codes" table | Pay period range, District, Labor category | Heatmap becomes sorted bar; table stacked | IR + Chart (EMS) |
| 6 | Schedule / lifecycle `/schedule` | Which milestones slip? Which phases are bottlenecks? | KPI row (Milestones due 90 d, On time %, Avg slip days); "Milestone timeline" Gantt (phases as bars, milestones as diamonds, today line) with list toggle; "Slip distribution" histogram; late milestones table | Program, Phase, Date window | Gantt list view default; histogram remains | IR + Chart (P2 / CMP) |
| 7 | Facility status `/facilities` | What is the condition of our built assets? Where is deferred maintenance concentrated? | KPI row (Facilities, Avg condition index, % below 60, Deferred maintenance $); "CI distribution" histogram with threshold bands labelled; "CI by installation" sorted bar; facility table with CI chip (same four-state encoding: Good/Fair/Poor/Stale) | Installation, System (BUILDER UNIFORMAT), CI band | Bars top 10 + show all; table stacked | IR + Chart (BUILDER SMS) |
| 8a | Public value: Sustainable Rivers `/public/srp` | How has SRP coverage grown since 2002? | KPI tiles; cumulative line (river miles) with structures bar; river systems count; small SRP map with list | Year range, River system | see 3.2.1 | Chart + IR (public) |
| 8b | Public value: Lock status `/public/locks` | Which locks are operating right now? Where are delays? | As-of banner; live table; status map; legend; filter by river system | River system, Status, Search lock | see 3.2.2 | IR + custom (public) |
| 9 | Accessibility read-out `/accessibility` | Does EVS conform? What is open? | see 2.4 | Route, Level | KPIs 2-up, charts to tables | none (new) |
| 10 | Admin / data freshness `/admin` | Are the feeds healthy? What are the thresholds? Who can see what? | Feed status table (source, last success, rows, latency, status chip); "Feed latency, 7 days" small multiples; threshold form (stale minutes, delay minutes, queue count); role matrix | Source | Table stacked; form single column | Form + IR |

### 3.2 Specific visualization designs

#### 3.2.1 Sustainable Rivers Program coverage

Desktop wireframe (1280 px):
```
+------------------------------------------------------------------------------------------+
| Sustainable Rivers Program: coverage since 2002        As of 30 Sep 2026 (annual update)  |
| Filters: [Year range 2002-2026] [River system: All v]                       [Download CSV]|
+----------------------+----------------------+----------------------+---------------------+
| River miles covered  | Dams / structures    | River systems        | States              |
| 12,840               | 61                   | 44                   | 27                  |
| +420 since 2025 (up) | +2 since 2025 (up)   | +1 since 2025 (up)   | no change           |
+----------------------+----------------------+----------------------+---------------------+
| Figure 1. Cumulative river miles and structures in SRP, 2002 to 2026                      |
| River miles (left axis, solid line, circles)  Structures (right-hand bars, hatched)       |
|  14k |                                                     ___---o River miles 12,840      |
|  10k |                                   ___----o---o----                                  |
|   6k |                  ___---o---o----                                                    |
|   2k | o---o---o---o----                                                                   |
|      +--|----|----|----|----|----|----|----|----|----|----|----|--                         |
|       2002 2004 2006 2008 2010 2012 2014 2016 2018 2020 2022 2024 2026                     |
| Takeaway: coverage has grown every year since 2002; half of today's miles were added after |
| 2016.                                                   [View as table] [CSV] [Expand]     |
+----------------------------------------------------------+-------------------------------+
| Figure 2. River systems joining SRP by year (bar, zero   | Figure 3. SRP rivers (map)     |
| baseline, direct labels)                                 |  small MapLibre map, river     |
|  ## ## #### ## ... with count labels                      |  lines in blue-60v, hovered /  |
|                                                          |  focused river highlighted and |
|                                                          |  named; [Switch to list]       |
|  [View as table] [CSV]                                   |  list: river, system, year,    |
|                                                          |  miles                         |
+----------------------------------------------------------+-------------------------------+
```
Spec:
- Data: one row per river system per year (system, miles added, structures added, state list). KPI tiles compute totals for the filtered range; deltas compare to the prior year and read "up 420 since 2025" in text, with an arrow icon that is `aria-hidden`.
- Figure 1 avoids a true dual axis: river miles are the line; structures are shown as hatched bars scaled to their own labelled right-hand axis only when both series are requested, otherwise structures move to Figure 2 as a toggle. Default view shows river miles alone with structures available via a "Show structures" checkbox (keeps the chart readable and the table alternative simple).
- Line: blue-60v, 2.5 px, circle markers 8 px, direct label at the line end with the final value; plan band not applicable.
- Table alternative: Year, Miles added, Cumulative miles, Structures added, Cumulative structures, Systems added.
- Map: static extent of CONUS plus Alaska inset; river lines are vector features with `<button>`-style DOM labels for the top 10 systems, remaining systems reachable through the list; hovering/focusing highlights the line (thicker stroke, label) and the same information appears in the list view. Reduced motion disables fly-to animations.
- Mobile: KPIs 2-up, Figure 1 full width at 56 vw height min 200 px, Figure 2 as a sorted list, map 48 vh with list first.
- Source line: "Source: USACE Sustainable Rivers Program annual reporting (synthetic demo data)."

#### 3.2.2 Inland waterway lock status (live)

Desktop wireframe:
```
+------------------------------------------------------------------------------------------+
| Lock status                                                                               |
| [status] Live. Data as of 14:32:10 UTC (updated 40 s ago). Next refresh in 20 s. [Pause] |
| (when stale) [alert icon] Stale data: feed last received 14:02 (31 min ago). Status shown |
|            may be out of date.                                                            |
| Filters: [River system: Ohio v] [Status: All v] [Search lock........] [Download CSV]      |
+----------------------------+-------------------------------------------------------------+
| 212 locks  o 171 Operating | Map (MapLibre, light basemap)          Legend                |
|            ^  28 Delayed   |   o (green circle)   Operating         o Operating           |
|            [] 9 Closed     |   ^ (yellow triangle, dark edge) Delayed   ^ Delayed         |
|            ~  4 Stale      |   [] (red octagon)   Closed             [] Closed            |
|                            |   ~ (grey hatched ring) Stale           ~ Stale              |
| Lock table (sortable)      |                                         [Keyboard shortcuts] |
| Lock | River | Mile |Status|                                         [Switch to list]     |
| L&D 52|Ohio |938.9 | ^ Delayed ...                                  [+] [-] [Reset]      |
| Markland|Ohio|531.5| o Operating                                                           |
| ...                        |   Popover (hover/press on marker or row):                    |
| columns: Vessels in queue, |   +----------------------------------------+                 |
| Avg delay (min), Last      |   | Lock and Dam 52, Ohio River, mile 938.9|                 |
| lockage, As of, [Updated]  |   | ^ Delayed  6 vessels in queue           |                 |
| badge, stale flag          |   | Avg delay 95 min  Last lockage 14:05    |                 |
| Showing 1-25 of 212  [<][>]|   | As of 14:32  Open lock detail  [Close]  |                 |
+----------------------------+-------------------------------------------------------------+
```
Table columns and semantics: Lock name (row header, link to detail), River, River mile (numeric, tabular), Status (chip: icon + text; sortable by severity Closed > Delayed > Stale > Operating), Vessels in queue, Average delay (min), Last lockage (time, relative in `title`), As of (feed timestamp per lock), Stale flag (clock icon + "Stale" text when the lock's own as-of is older than threshold). Default sort: severity, then delay descending. Rows changed in the last update show an "Updated" badge for 60 s.

Status rules (UX terms, thresholds editable in Admin):
- Green "Operating": lock reporting within the stale threshold (default 15 min), not closed, queue below 4 vessels and average delay below 60 min.
- Yellow "Delayed": reporting within threshold and (queue 4 or more, or average delay 60 min or more, or a scheduled restriction such as single-chamber operation). Also used when the lock's own feed is between 15 and 60 min old ("Delayed, data 32 min old" in the label) so a stale lock is never shown as fresh green.
- Red "Closed": lock closed or unavailable to traffic (maintenance, high water, incident), regardless of data age if the closure notice is current.
- Grey "Stale": no report for more than 60 min; last known status shown inside the dashed hatched ring, label "Stale, last reported Operating at 13:20".
- Page-level stale banner when the feed as a whole is older than N (default 15) minutes; `role=alert` once, then persistent visible banner; map and table remain interactive.
- Precedence: Closed > Stale > Delayed > Operating.

Map spec: MapLibre GL JS, self-hosted vector basemap in low-saturation greys/blues; DOM markers as `<button>` with shape SVGs (circle 24 px, triangle 26 px with 2 px gray-90 stroke, octagon 24 px, dashed ring 28 px) inside a 44 x 44 px hit box; cluster buttons at zoom below 6 showing counts per status as text ("12 locks: 9 operating, 2 delayed, 1 closed"); hover and press open the same popover (hover: `aria-describedby` tooltip, press: pinned popup with focus inside); legend as `<ul>` outside the canvas; filter by river system zooms to the system's bounds (no animation under reduced motion); "Switch to list" moves focus to the table; the table row and its marker are linked (focusing a row highlights the marker and vice versa, announced as "Shown on map").

Palette and shapes: as in 1.2.1 (green-cool-50v circle, gold-20v triangle with gray-90 edge, red-60v octagon, gray-cool-60 hatched ring). Under deuteranopia the triangle/octagon/circle distinction and the labels carry the status; under forced-colors the shapes render in `ButtonText` on `ButtonFace`.

Mobile: as-of banner, counts strip (4 chips), table (stacked cards: name and status on line 1, river/mile line 2, queue/delay line 3, as-of line 4), then the map at 56 vh with "Switch to list" first in its tab order; popovers become bottom sheets with a close button and focus management.

#### 3.2.3 Financial execution and labor on a big screen (leadership mode)

Leadership mode layout at 1920 x 1080, dark theme:
```
+------------------------------------------------------------------------------------------+
| EVS  Financial execution, FY26 through 30 Sep              Refresh in 00:45  [Pause]      |
+-----------------------+-----------------------+-----------------------+-------------------+
| Obligated             | Plan to date          | Variance              | Expiring < 90 days |
| $4.21B                | $4.35B                | -$138M (-3.1%)  down  | $212M              |
| 96.9% of plan         |                       | 4 programs under plan | 7 appropriations   |
+-----------------------+-----------------------+-----------------------+-------------------+
| Figure. Cumulative obligations vs plan, FY26 (line, plan as grey band +/-2%)              |
|   $B 5 |                                                        ___ plan band              |
|        |                                               ___----====  actual  ----o 4.21     |
|      3 |                              ___----======-----                                   |
|      1 | ___----=====-----                                                                 |
|        +-----|------|------|------|------|------|------|------|------|------|------|-----   |
|          Oct   Nov    Dec    Jan    Feb    Mar    Apr    May    Jun    Jul    Aug    Sep   |
| Takeaway: execution tracked plan through Q2; the gap opened in April and is concentrated  |
| in Civil Works O&M.                                                                        |
+---------------------------------------------------+--------------------------------------+
| Figure. Variance by program (diverging bar)       | Figure. Labor hours vs plan by        |
|  Civil Works O&M      ########|          -$96M    | district (bullet chart)               |
|  Military Construction     ###|          -$31M    |  LRD   |=========|---|  98%            |
|  Environmental            #|             -$8M    |  SWD   |======|------|  91%            |
|  Civil Works Investig.        |##        +$12M    |  NAD   |===========|-| 104%            |
|  (orange = under, blue = over, hatched zero band, |  ...  (bar = actual, tick = plan, %)  |
|   values labelled on every bar)                   |                                        |
+---------------------------------------------------+--------------------------------------+
```
Spec: type scale x1.4; four KPI tiles with value, context line and a signed delta in words; the main line chart uses a grey plan band rather than a second plan line to make "above or below plan" readable at distance; the diverging bar is sorted by magnitude with values labelled on bars (no legend lookup needed); the labor bullet chart shows actual vs plan per district with percentage text, which reads at distance and is colour-independent. Labor detail (hours by project type) uses a stacked bar with hatch patterns and a "100% view" toggle. All figures keep the `<Figure>` behaviour (table toggle, CSV) even in leadership mode; auto-refresh every 60 s with countdown and pause; no animation between refreshes.

### 3.3 Library accessibility evaluation

Charting (findings from documentation and public issue trackers reviewed in this session):

| Library | Keyboard navigation | ARIA support | Data-table fallback | Reduced motion | Rendering / axe testability | License | Notes and sources |
|---|---|---|---|---|---|---|---|
| **Recharts 3.x** | Yes: `accessibilityLayer` (default on since 3.0) gives a tab stop and arrow-key movement across data with the tooltip exposed; gaps: vertical/radar charts (PR #7167, issue #5390), RTL (#4214), custom bars (#4809), focus ring customisation (#5988) | Adds `role`/`tabIndex`/ARIA to the wrapper; series names via `name`; EVS adds `aria-labelledby/describedby` on the figure | None built in; trivial to add since data is plain arrays | `isAnimationActive={false}` per series | SVG, so axe inspects text contrast and names | MIT | https://github.com/recharts/recharts/wiki/3.0-migration-guide ("Recharts had this prop accessibilityLayer which enables a11y attributes, and keyboard controls... pass accessibilityLayer={false} to disable"); issues listed at https://github.com/recharts/recharts/issues |
| **Nivo** | Partial: `@nivo/bar` exposes `isFocusable`, `barAriaLabel/LabelledBy/DescribedBy` (PR #1719); other chart types uneven; open umbrella issue #2754 "Accessibility" | Per-element ARIA props on some charts; `ariaLabel` on the SVG root | None built in | `animate={false}` | SVG (and canvas variants) | MIT | https://github.com/plouc/nivo/pull/1719 , https://github.com/plouc/nivo/issues/2754 ; the docs' accessibility guide URL returned 404 during this session |
| **Visx** | None built in; low-level primitives, you implement focus and keys | None built in; you own all attributes (issue #1331 "Accessibility attributes", closed) | None | You control animation | SVG | MIT | https://github.com/airbnb/visx/issues/1331 . Maximum control, maximum effort |
| **Apache ECharts 5** | No keyboard traversal of data points in core; EVS would wrap with an external roving index that drives `dispatchAction('showTip')` | `aria: { enabled: true }` auto-generates a chart description (title, series, data) and supports manual `description`; `aria.decal` adds pattern fills for colour-blind users | None built in; `dataset` makes it easy | `animation: false` | Canvas by default (axe cannot inspect text contrast or names inside it); SVG renderer available | Apache-2.0 | https://echarts.apache.org/handbook/en/best-practices/aria/ ("supports generating a description based on the chart configuration... decal patterns... distinguished by decal patterns in addition to color") |
| **Vega-Lite / react-vega** | None for data points (SVG marks are not focusable by default) | Vega 5.10/5.11 adds `description` (sets `aria-label` on the view container) and `aria`/`description` on marks, axes, legends; auto-generated axis/legend descriptions | None built in; data is declarative so a table is easy | `config` can disable transitions; Vega-Lite has no animation by default | SVG or canvas (choose SVG) | BSD-3 | https://vega.github.io/vega/docs/config/ (config.md: "aria: boolean (default true) indicating if ARIA attributes should be included (SVG output only)"; "description determines the aria-label attribute for the container element") |
| **Highcharts** | Yes, best in class: Accessibility module adds keyboard navigation across series/points, legend, menu; sonification module | Screen-reader information region, point descriptions, `aria-label` config, `linkedDescription` | Built-in "View data table" export | `chart.animation: false` | SVG | Commercial (Highsoft Standard License); non-commercial exemption only for personal, school and non-profit use per the license text | https://www.highcharts.com/docs/accessibility/accessibility-module , https://www.highcharts.com/docs/accessibility/keyboard-navigation , license https://shop.highcharts.com/ . A USACE deployment needs a paid license (developer seats plus OEM/SaaS terms); conflicts with the Oracle-cost driver unless USACE already holds one |

Recommendation: **Recharts 3** for the React dashboards, wrapped in the EVS `<Figure>` (caption, takeaway, table toggle, CSV, focus ring, reduced motion). **ECharts** (SVG renderer, `aria.enabled`, `decal`) for the Gantt/timeline and heatmap where Recharts is weak, with the EVS roving-index wrapper. Keep **Vega-Lite** as the "new visualization in an afternoon" option for analysts (declarative JSON specs stored in PostgreSQL), rendered with SVG and always paired with the table toggle. Skip Visx (effort) and Highcharts (license) unless USACE already licenses Highcharts, in which case it becomes the primary.

Maps:

| Library | Keyboard-accessible markers / popups | Screen-reader support | Other | Sources |
|---|---|---|---|---|
| **MapLibre GL JS (v4/v5)** | Map canvas has a `KeyboardHandler` (arrows pan, +/- zoom, Shift+arrows rotate/pitch). Markers are arbitrary DOM elements (`MarkerOptions.element`), so EVS renders `<button>` markers and owns focus, name and `aria-expanded`. `Popup` has `focusAfterOpen` (default true) to move focus into the popup. | Past audit items closed: #53 "WCAG 2.1 Accessibility Evaluation", #355 default accessible name for interactive markers, #356 `role=button`, #357 `aria-expanded`, #360 hide the x glyph, #363 target size, #5623/#6435/#7627 `aria-label` misuse on marker div, #6691 reduced motion from system setting. | WebGL vector tiles; self-hostable (PMTiles/MBTiles) which suits IL5; canvas content is opaque to axe and screen readers, so the list view is mandatory | https://maplibre.org/maplibre-gl-js/docs/API/classes/KeyboardHandler/ , https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/MarkerOptions/ , https://maplibre.org/maplibre-gl-js/docs/API/classes/Popup/ , https://github.com/maplibre/maplibre-gl-js/issues?q=accessibility |
| **Leaflet 1.9.x (2.0 in alpha)** | Docs: "The map container and markers are keyboard operable by default"; markers need `alt`/`title` for an accessible name; `aria-keyshortcuts` on the container (1.9.4, PR #9688); popup close button labelled (PR #8590). Open issue #9898 "Interactive markers are not operable with a keyboard [2.0]" shows the 2.0 rewrite has a regression in progress; #9131 asks for keyboard-shortcut help. | Markers are `<img>` with alt by default; popups are DOM; layers control keyboard fixes in 1.9.3 (#8556). | Raster tiles (or vector via plugins); lighter and simpler; DOM markers can be swapped for buttons via `DivIcon` | https://leafletjs.com/examples/accessibility/ , https://github.com/Leaflet/Leaflet/blob/main/CHANGELOG.md , https://github.com/Leaflet/Leaflet/issues/9898 , https://github.com/Leaflet/Leaflet/issues/9131 |

Recommendation: **MapLibre GL JS** with DOM `<button>` markers, `focusAfterOpen`, rotation/pitch disabled, Ctrl+scroll zoom, and a self-hosted vector basemap. Leaflet 1.9.x is an acceptable fallback if the team prefers raster tiles; avoid Leaflet 2.0 until #9898 is resolved. In both cases the accessibility of the map rests on the DOM (markers, controls, legend, list view); the canvas carries no accessible information.

### 3.4 Visual references (screenshots in `refs/`)

| # | File | What it is | Borrow | Improve on it in EVS |
|---|---|---|---|---|
| 1 | `ref1_usaspending_dod_agency_profile.png` | USAspending.gov, Department of Defense agency profile (FY2025) | Question-led KPI tiles ("How much funding is available to this agency?" then the number, then context "16.7% of the FY 2025 U.S. federal budget"), a sparkline per tile, a single FY filter in the page header, sub-tabs Overview / Status of Funds / Award Spending, "90 day delay" data caveat up front | Donut relies on a colour legend; sparklines lack text alternatives; add table toggles |
| 2 | `ref2_uswds_data_visualizations_guidance.png` | USWDS Data visualizations component guidance | The rules we adopt: prefer common chart types, use colour with care, lossless representation (provide the data table, `usa-sr-only` summaries), clarity of intent (state the takeaway), lines start at zero, discrete dash/datapoint styles so lines are distinguishable without colour; example chart with title, explanatory paragraph, legend and source line | Guidance only; EVS implements it as the `<Figure>` component |
| 3 | `ref3_eia_hourly_grid_monitor_live_map.png` | EIA Hourly Electric Grid Monitor | Live "as of 10/6/2026 9 a.m. EDT" in every chart title, KPI card with delta arrow and text "+1% from prior hour", map of status circles with a legend, hour slider, per-widget info/settings/download icons, "Download data" | Legend is colour-only (continuous ramp, missing-data dot), markers are small, no list alternative; EVS adds shapes, 44 px targets, list view and a stale banner |
| 4 | `ref4_analytics_usa_gov_realtime_kpis.png` | analytics.usa.gov | Real-time KPI tiles with the time window in the tile ("in the last 30 minutes"), agency selector, collapsible panels with per-panel time-window selects, inline bars with percentage text next to each bar | Tile headings are links styled as headings; EVS keeps heading semantics and a separate action |
| 5 | `ref5_cisa_kev_catalog_filters_export.png` | CISA Known Exploited Vulnerabilities Catalog | Left filter rail with labelled controls, "(optional)" hints, CSV/JSON/Print exports with icons and text, JSON schema link with update date, breadcrumb | Export buttons are near the top of a long page; EVS puts table actions in the widget toolbar |
| 6 | `ref6_usace_national_inventory_of_dams.png` | USACE National Inventory of Dams landing | USWDS gov banner on a USACE property, two-card entry with coloured top borders and full-width primary buttons, plain-language counts ("more than 90,000 dams") | Hero text over a photo background has uncertain contrast; EVS avoids text over imagery |

Not used: Performance.gov home (currently a marketing hero, no dashboard content), USGS WaterWatch (decommissioned, redirects to a blog post), AirNow home (landing page), and the USACE Lock Performance Monitoring System (corpslocks.usace.army.mil, APEX) which returned an empty page from this environment. The LPMS APEX app is the closest USACE analogue of the lock view and should be captured by someone on the USACE network for a "before" screenshot.

---

## Appendix A. WCAG 2.1 A/AA criteria to evidence mapping (used by the ACR generator)

| SC | Level | axe-core rules (automated) | Manual evidence |
|---|---|---|---|
| 1.1.1 Non-text Content | A | image-alt, svg-img-alt, role-img-alt, input-image-alt, object-alt, aria-meter-name, aria-progressbar-name | MT-SR-01 chart names/descriptions, map marker names |
| 1.2.1 Audio-only and Video-only (Prerecorded) | A | none | N/A unless media added; EVS ships no audio/video |
| 1.2.2 Captions (Prerecorded) | A | none | N/A unless media added |
| 1.2.3 Audio Description or Media Alternative (Prerecorded) | A | none | N/A unless media added |
| 1.3.1 Info and Relationships | A | list, listitem, definition-list, dlitem, th-has-data-cells, td-headers-attr, td-has-header, table-fake-caption, aria-required-children, aria-required-parent, p-as-heading | MT-SR-02 table header/scope reading, KPI tile semantics, chart "view as table" |
| 1.3.2 Meaningful Sequence | A | none | MT-SR-03 reading order matches visual order on each route at 320px and 1280px |
| 1.3.3 Sensory Characteristics | A | none | MT-VIS-01 status never conveyed by colour/shape/position alone (icons + text labels) |
| 1.3.4 Orientation | AA | css-orientation-lock | MT-RESP-01 portrait/landscape on tablet |
| 1.3.5 Identify Input Purpose | AA | autocomplete-valid | MT-FORM-01 login/profile fields |
| 1.4.1 Use of Color | A | link-in-text-block | MT-VIS-01 colourblind simulation (deuteranopia, protanopia, tritanopia) on status chips, map markers, chart series |
| 1.4.2 Audio Control | A | no-autoplay-audio | N/A |
| 1.4.3 Contrast (Minimum) | AA | color-contrast | MT-VIS-02 contrast spot-check of chart labels drawn in SVG/canvas (axe cannot read canvas text) |
| 1.4.4 Resize text | AA | none | MT-ZOOM-01 200% browser zoom on every route |
| 1.4.5 Images of Text | AA | none | MT-VIS-03 no images of text (logos exempt) |
| 1.4.10 Reflow | AA | none | MT-ZOOM-02 400% zoom / 320px reflow; tables and Gantt allowed 2D scroll with visible scrollbars |
| 1.4.11 Non-text Contrast | AA | none | MT-VIS-04 3:1 for focus rings, chart lines/markers vs background, map markers vs basemap, input borders |
| 1.4.12 Text Spacing | AA | avoid-inline-spacing | MT-ZOOM-03 text-spacing bookmarklet |
| 1.4.13 Content on Hover or Focus | AA | none | MT-KBD-04 tooltips/popovers dismissible with Esc, hoverable, persistent |
| 2.1.1 Keyboard | A | scrollable-region-focusable, frame-focusable-content, server-side-image-map | MT-KBD-01 keyboard-only pass of every route incl. charts (arrow keys) and map (Tab to markers, Enter opens popover) |
| 2.1.2 No Keyboard Trap | A | none | MT-KBD-02 no traps in modal, date picker, map canvas |
| 2.1.4 Character Key Shortcuts | A | none | MT-KBD-03 single-key shortcuts only when a component has focus |
| 2.2.1 Timing Adjustable | A | meta-refresh | MT-TIME-01 session timeout warning with extend; live feed refresh does not move focus |
| 2.2.2 Pause, Stop, Hide | A | blink, marquee | MT-MOTION-01 live table/map updates can be paused; prefers-reduced-motion honoured |
| 2.3.1 Three Flashes or Below Threshold | A | none | MT-MOTION-02 no flashing content |
| 2.4.1 Bypass Blocks | A | bypass | MT-KBD-05 skip link, landmarks (banner, nav, main, complementary) |
| 2.4.2 Page Titled | A | document-title | route titles pattern "Page - EVS" |
| 2.4.3 Focus Order | A | none | MT-KBD-06 focus order in filters, dialogs, popovers, after route change |
| 2.4.4 Link Purpose (In Context) | A | link-name | MT-SR-04 link text in context |
| 2.4.5 Multiple Ways | AA | none | global nav + search + breadcrumbs |
| 2.4.6 Headings and Labels | AA | none | MT-SR-05 headings and labels descriptive |
| 2.4.7 Focus Visible | AA | none | MT-KBD-07 focus visible on every interactive element incl. chart points and map markers |
| 2.5.1 Pointer Gestures | A | none | MT-TOUCH-01 map pinch/drag have button alternatives |
| 2.5.2 Pointer Cancellation | A | none | MT-TOUCH-02 actions on up-event, drag cancel |
| 2.5.3 Label in Name | A | label-content-name-mismatch | MT-SR-06 visible label is part of accessible name |
| 2.5.4 Motion Actuation | A | none | N/A, no motion actuation |
| 3.1.1 Language of Page | A | html-has-lang, html-lang-valid, html-xml-lang-mismatch | none needed beyond automation |
| 3.1.2 Language of Parts | AA | valid-lang | none needed beyond automation |
| 3.2.1 On Focus | A | none | MT-KBD-08 focusing a filter does not change context |
| 3.2.2 On Input | A | none | MT-FORM-02 filter changes announced, no auto-submit surprises |
| 3.2.3 Consistent Navigation | AA | none | consistent header/nav across routes |
| 3.2.4 Consistent Identification | AA | none | consistent icon/label vocabulary (status chips, as-of badges) |
| 3.3.1 Error Identification | A | none | MT-FORM-03 error identified in text, aria-describedby, focus moved to summary |
| 3.3.2 Labels or Instructions | A | label, form-field-multiple-labels | MT-FORM-04 labels and hints present |
| 3.3.3 Error Suggestion | AA | none | MT-FORM-05 suggestions in error text |
| 3.3.4 Error Prevention (Legal, Financial, Data) | AA | none | MT-FORM-06 admin data-source edits are reversible/confirmed |
| 4.1.1 Parsing | A | duplicate-id, duplicate-id-active | Obsolete in WCAG 2.2; still reported for 2.1 edition |
| 4.1.2 Name, Role, Value | A | button-name, aria-allowed-attr, aria-required-attr, aria-valid-attr, aria-valid-attr-value, aria-roles, aria-hidden-focus, aria-command-name, aria-input-field-name, aria-toggle-field-name, aria-tooltip-name, aria-tab-name, nested-interactive, select-name, input-button-name, frame-title | MT-SR-07 name/role/value/state for custom widgets (sortable headers, chips, map markers, chart points) |
| 4.1.3 Status Messages | AA | none | MT-SR-08 aria-live announcements for as-of updates, filter result counts, save confirmations |

Rules are axe-core 4.x rule IDs taken from the axe-core rule descriptions (https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md), matched on their `wcagNNN` tags. Experimental rules (`css-orientation-lock`, `label-content-name-mismatch`) are enabled explicitly. WCAG 2.2 `target-size` (2.5.8) is also run as a design rule and reported outside the ACR.

## Appendix B. Manual test IDs

MT-KBD-01 full keyboard pass per route; -02 no traps (modal, date picker, map); -03 scoped single-key shortcuts; -04 popover dismiss/hover/persist; -05 skip link and landmarks; -06 focus order and restoration; -07 focus visible everywhere incl. SVG points and markers; -08 focus does not change context. MT-SR-01 chart names/descriptions; -02 table header reading; -03 reading order; -04 link purpose; -05 headings/labels; -06 label in name; -07 name/role/value for custom widgets; -08 live-region announcements. MT-ZOOM-01 200%; -02 400%/320 px reflow; -03 text spacing. MT-VIS-01 colour-vision simulation; -02 text contrast in SVG/canvas; -03 images of text; -04 non-text contrast. MT-MOTION-01 pause/reduced motion; -02 no flashing. MT-TOUCH-01 gesture alternatives; -02 up-event activation. MT-FORM-01 autocomplete; -02 predictable changes; -03 error identification; -04 labels and hints; -05 suggestions; -06 confirm/undo. MT-TIME-01 session warning. MT-RESP-01 orientation.

## Appendix C. Assumptions

1. React with react-uswds as the component base; USWDS 3.x design tokens for colour and spacing.
2. EVS ships no audio or video; 1.2.x and 1.4.2 are Not Applicable. Adding a video later requires captions and audio description.
3. Internal pages require authentication (CAC/PIV through the GovCloud identity provider); Public Value pages are anonymous.
4. Lock feed arrives at least every 15 minutes in normal operation; thresholds (15/60 min, 4 vessels, 60 min delay) are demo defaults editable in Admin.
5. Demo data is synthetic; source-system names (CEFMS, EMS, P2/CMP, BUILDER SMS) are used for labelling only.
6. Basemap tiles are self-hosted; no calls leave the IL5 boundary at runtime.
7. The 508 ACR is produced per release by CI; a signed manual attestation by two testers is a release gate.
8. DoD/Army accessibility pages could not be read from this environment (Akamai blocks); the recommendation assumes they do not exceed WCAG 2.0 AA, which is consistent with DoDM 8400.01 implementing the Revised 508 Standards. USACE's 508 coordinator should confirm.

## Appendix D. Sources consulted

- U.S. Access Board, Revised 508 Standards: https://www.access-board.gov/ict/ ; WCAG 2.1 FAQ: https://www.access-board.gov/ict/wcag2ict-faqs/
- Section508.gov: https://www.section508.gov/ , testing https://www.section508.gov/test/ , Trusted Tester https://www.section508.gov/test/trusted-tester/ , ACR/VPAT https://www.section508.gov/sell/vpat/ , ACR Editor https://acreditor.section508.gov/
- W3C WCAG 2.0 / 2.1 / 2.2: https://www.w3.org/TR/WCAG20/ , https://www.w3.org/TR/WCAG21/ , https://www.w3.org/TR/WCAG22/ ; WAI-ARIA Authoring Practices: https://www.w3.org/WAI/ARIA/apg/
- OMB M-23-22: https://www.whitehouse.gov/wp-content/uploads/2023/09/M-23-22-Delivering-a-Digital-First-Public-Experience.pdf
- DOJ ADA Title II web rule: https://www.ada.gov/resources/2024-03-08-web-rule/
- GSA OpenACR: https://github.com/GSA/openacr (catalog `catalog/2.5-edition-wcag-2.1-508-en.yaml`, schema `schema/openacr-0.1.0.json`, npm `@openacr/openacr`)
- USWDS design tokens and data visualization guidance: https://designsystem.digital.gov/design-tokens/color/system-tokens/ , https://designsystem.digital.gov/components/data-visualizations/
- axe-core rule descriptions: https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md ; @axe-core/playwright: https://github.com/dequelabs/axe-core-npm/tree/develop/packages/playwright ; jest-axe: https://github.com/nickcolley/jest-axe
- Recharts: https://github.com/recharts/recharts/wiki/3.0-migration-guide , https://github.com/recharts/recharts/issues
- Nivo: https://github.com/plouc/nivo/pull/1719 , https://github.com/plouc/nivo/issues/2754
- Visx: https://github.com/airbnb/visx/issues/1331
- Apache ECharts ARIA: https://echarts.apache.org/handbook/en/best-practices/aria/
- Vega config (aria, description): https://vega.github.io/vega/docs/config/
- Highcharts accessibility and license: https://www.highcharts.com/docs/accessibility/accessibility-module , https://www.highcharts.com/docs/accessibility/keyboard-navigation , https://shop.highcharts.com/
- MapLibre GL JS: https://maplibre.org/maplibre-gl-js/docs/API/ , issues https://github.com/maplibre/maplibre-gl-js/issues?q=accessibility
- Leaflet: https://leafletjs.com/examples/accessibility/ , https://github.com/Leaflet/Leaflet/issues/9898 , https://github.com/Leaflet/Leaflet/blob/main/CHANGELOG.md
- Reference dashboards: https://www.usaspending.gov/agency/department-of-defense , https://www.eia.gov/electricity/gridmonitor/ , https://analytics.usa.gov/ , https://www.cisa.gov/known-exploited-vulnerabilities-catalog , https://nid.sec.usace.army.mil/ , https://www.performance.gov/
- DoD/Army (blocked from this environment, listed for USACE confirmation): https://dodcio.defense.gov/DoDSection508/ , https://www.army.mil/accessibility , DoDM 8400.01, DoDI 8310.01
