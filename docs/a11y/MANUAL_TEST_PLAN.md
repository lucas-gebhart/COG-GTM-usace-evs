# EVS manual accessibility test plan

Scope: the EVS web application (every route in `apps/web/src/app/routes.ts`), demo build. Results are
recorded in `manual_attestation.yaml` (criterion, status, tester, date, assistive technology, notes) and
merged with the CI evidence by `evs-acr-gen`. A criterion is reported as Supports only when the automated
cells pass and the manual tests listed for it pass. Until a test is recorded the row stays Not Evaluated.

## Criteria split (WCAG 2.1 A and AA, 48 criteria)

19 criteria have at least one axe-core rule and are checked automatically on every cell of the CI
matrix; 15 of
those also need a manual test for the part axe cannot see. 24 criteria are manual only. 5 criteria are
not applicable because EVS ships no audio, video or motion-actuated functions.

| Criterion | Level | Method | axe rules (first four) | Manual tests |
|---|---|---|---|---|
| 1.1.1 Non-text Content | A | Automated + manual | image-alt, svg-img-alt, role-img-alt, input-image-alt ... | MT-SR-01 |
| 1.2.1 Audio-only and Video-only (Prerecorded) | A | N/A | - | n/a |
| 1.2.2 Captions (Prerecorded) | A | N/A | - | n/a |
| 1.2.3 Audio Description or Media Alternative (Prerecorded) | A | N/A | - | n/a |
| 1.3.1 Info and Relationships | A | Automated + manual | list, listitem, definition-list, dlitem ... | MT-SR-02 |
| 1.3.2 Meaningful Sequence | A | Manual | - | MT-SR-03 |
| 1.3.3 Sensory Characteristics | A | Manual | - | MT-VIS-01 |
| 1.3.4 Orientation | AA | Automated + manual | css-orientation-lock | MT-RESP-01 |
| 1.3.5 Identify Input Purpose | AA | Automated + manual | autocomplete-valid | MT-FORM-01 |
| 1.4.1 Use of Color | A | Automated + manual | link-in-text-block | MT-VIS-01 |
| 1.4.2 Audio Control | A | N/A | no-autoplay-audio | n/a |
| 1.4.3 Contrast (Minimum) | AA | Automated + manual | color-contrast | MT-VIS-02 |
| 1.4.4 Resize text | AA | Manual | - | MT-ZOOM-01 |
| 1.4.5 Images of Text | AA | Manual | - | MT-VIS-03 |
| 1.4.10 Reflow | AA | Manual | - | MT-ZOOM-02 |
| 1.4.11 Non-text Contrast | AA | Manual | - | MT-VIS-04 |
| 1.4.12 Text Spacing | AA | Automated + manual | avoid-inline-spacing | MT-ZOOM-03 |
| 1.4.13 Content on Hover or Focus | AA | Manual | - | MT-KBD-04 |
| 2.1.1 Keyboard | A | Automated + manual | scrollable-region-focusable, frame-focusable-content, server-side-image-map | MT-KBD-01 |
| 2.1.2 No Keyboard Trap | A | Manual | - | MT-KBD-02 |
| 2.1.4 Character Key Shortcuts | A | Manual | - | MT-KBD-03 |
| 2.2.1 Timing Adjustable | A | Automated + manual | meta-refresh | MT-TIME-01 |
| 2.2.2 Pause, Stop, Hide | A | Automated + manual | blink, marquee | MT-MOTION-01 |
| 2.3.1 Three Flashes or Below Threshold | A | Manual | - | MT-MOTION-02 |
| 2.4.1 Bypass Blocks | A | Automated + manual | bypass | MT-KBD-05 |
| 2.4.2 Page Titled | A | Automated | document-title | none |
| 2.4.3 Focus Order | A | Manual | - | MT-KBD-06 |
| 2.4.4 Link Purpose (In Context) | A | Automated + manual | link-name | MT-SR-04 |
| 2.4.5 Multiple Ways | AA | Manual | - | MT-SR-05 |
| 2.4.6 Headings and Labels | AA | Manual | - | MT-SR-05 |
| 2.4.7 Focus Visible | AA | Manual | - | MT-KBD-07 |
| 2.5.1 Pointer Gestures | A | Manual | - | MT-TOUCH-01 |
| 2.5.2 Pointer Cancellation | A | Manual | - | MT-TOUCH-02 |
| 2.5.3 Label in Name | A | Automated + manual | label-content-name-mismatch | MT-SR-06 |
| 2.5.4 Motion Actuation | A | N/A | - | n/a |
| 3.1.1 Language of Page | A | Automated | html-has-lang, html-lang-valid, html-xml-lang-mismatch | none |
| 3.1.2 Language of Parts | AA | Automated | valid-lang | none |
| 3.2.1 On Focus | A | Manual | - | MT-KBD-08 |
| 3.2.2 On Input | A | Manual | - | MT-FORM-02 |
| 3.2.3 Consistent Navigation | AA | Manual | - | MT-SR-05 |
| 3.2.4 Consistent Identification | AA | Manual | - | MT-SR-05 |
| 3.3.1 Error Identification | A | Manual | - | MT-FORM-03 |
| 3.3.2 Labels or Instructions | A | Automated + manual | label, form-field-multiple-labels | MT-FORM-04 |
| 3.3.3 Error Suggestion | AA | Manual | - | MT-FORM-05 |
| 3.3.4 Error Prevention (Legal, Financial, Data) | AA | Manual | - | MT-FORM-06 |
| 4.1.1 Parsing | A | Automated | duplicate-id, duplicate-id-active | none |
| 4.1.2 Name, Role, Value | A | Automated + manual | button-name, aria-allowed-attr, aria-required-attr, aria-valid-attr ... | MT-SR-07 |
| 4.1.3 Status Messages | AA | Manual | - | MT-SR-08 |

## Test environments

| Id | Environment | Notes |
|---|---|---|
| nvda-firefox | NVDA (current) + Firefox (current) on Windows 11 | Primary screen reader pass |
| jaws-chrome | JAWS (current) + Chrome (current) on Windows 11 | Second screen reader pass; differences from NVDA are noted, not fixed around |
| voiceover-ios | VoiceOver + Safari on iOS, iPhone at 360 px and iPad at 768 px | Touch and rotor navigation |
| keyboard-only | Chrome and Firefox on Windows, pointer unplugged | Tab, Shift+Tab, Enter, Space, Escape, arrows |
| zoom-400 | Chrome at 400% zoom, 1280 px window (320 CSS px) and 200% zoom | Reflow and resize text |
| forced-colors | Windows High Contrast (forced-colors: active), Edge and Firefox | Status shapes, focus rings, chart lines |
| cvd-sim | Chrome DevTools Rendering > Emulate vision deficiencies (protanopia, deuteranopia, tritanopia, achromatopsia) | Status chips, markers, chart series |
| reduced-motion | OS "reduce motion" on | Live updates, transitions |

Record the browser and AT versions in `manual_attestation.yaml` under `assistive_technology`.

## Routes and components under test

Each script below is run on every route. The components that need specific attention are:

- Lock map and lock table (`/public/locks`): markers with status shape + text, popovers, list view, sort and filter.
- Charts (`/`, `/financial`, `/workforce`, `/schedule`, `/facilities`): every chart has a "View as table" control.
- Data table filters (`/programs`, `/projects`, `/projects/:p2`, `/facilities`): filter inputs, result counts, sortable headers, pagination.
- Forms (`/admin`): data source edits, validation, confirmation.
- SSE live updates (`/`, `/public/locks`, `/public/srp`): as-of badges and rows that change while the page is open.
- Status vocabulary everywhere: green circle Operating, yellow triangle Delayed, red octagon Closed, grey hatched ring Stale, each with a text label.

## Scripts

Each step has an expected result. Pass means every step met expectations on every route in scope; record
exceptions in `notes` with the route and the component.

### Screen reader (NVDA + Firefox, JAWS + Chrome, VoiceOver iOS)

| Id | Steps | Expected |
|---|---|---|
| MT-SR-01 Non-text content | Navigate to every image, icon, chart and map marker with the virtual cursor and the graphics shortcut (G) | Decorative icons are skipped. Status icons announce the status text once (not twice). Charts announce a name and a short description plus the "View as table" control. Map markers announce lock name and status. |
| MT-SR-02 Info and relationships | Open each data table with the table shortcut (T), move by cell (Ctrl+Alt+arrows) | Column and row headers are announced with each cell. Sort state announced on sortable headers. KPI tiles announce label then value. "View as table" tables have captions. |
| MT-SR-03 Meaningful sequence | Read each route top to bottom with the virtual cursor at 1280 px, then at 320 px | Reading order matches the visual order; nothing important is read before its heading; filter controls read before results. |
| MT-SR-04 Link purpose | List links (NVDA Insert+F7, JAWS Insert+F7, VoiceOver rotor) | Every link is understandable out of context (no bare "View", "More"); same text goes to the same place. |
| MT-SR-05 Headings, labels, navigation | List headings (Insert+F7 / rotor) on every route; compare the header and navigation across routes | One h1 per route matching the page title; logical heading levels; navigation items in the same order everywhere; same icon and label vocabulary for status and as-of badges. |
| MT-SR-06 Label in name | Use voice-style activation (JAWS "click &lt;label&gt;" or compare visible label with announced name) for every button and link | The visible text is at the start of the accessible name. |
| MT-SR-07 Name, role, value | Tab through custom widgets: sortable headers, status chips, filter chips, pagination, map markers, chart points, theme toggle, popover triggers | Role, name and state (pressed, expanded, selected, sort direction) announced; changes announced after activation. |
| MT-SR-08 Status messages | Change a filter; wait for a live (SSE) update; save a form in `/admin` | Result count announced politely without moving focus; as-of update announced once; save confirmation announced; nothing announced in a loop. |

### Keyboard only

| Id | Steps | Expected |
|---|---|---|
| MT-KBD-01 Keyboard | Operate every control with Tab, Shift+Tab, Enter, Space, arrows; in charts use arrows to move between points; on the map Tab to markers and press Enter | Everything the pointer can do, the keyboard can do, including map zoom and pan via buttons. |
| MT-KBD-02 No keyboard trap | Tab into and out of the modal, date picker, map canvas and any embedded widget | Focus always leaves with Tab or Escape; Escape returns focus to the trigger. |
| MT-KBD-03 Character key shortcuts | Type letters while focus is on the page body and inside inputs | No single-character shortcut fires outside its component. |
| MT-KBD-04 Content on hover or focus | Hover and focus every tooltip and popover trigger; press Escape; move the pointer onto the popover | Popover dismissible with Escape without moving focus; stays open while hovered; stays until dismissed. |
| MT-KBD-05 Bypass blocks | On page load press Tab once, then Enter | Skip link is the first stop, visible when focused, and moves focus to `main`. Landmarks banner, navigation, main and contentinfo are present once each. |
| MT-KBD-06 Focus order | Tab through filters, open and close a dialog, change route via navigation | Order follows visual order; after closing a dialog focus returns to its trigger; after a route change focus lands on the new h1 or main. |
| MT-KBD-07 Focus visible | Tab through every control in light and leadership themes, and in forced-colors mode | A visible indicator at every stop, at least 2 px, 3:1 against neighbours, never clipped by scroll containers, also on chart points and map markers. |
| MT-KBD-08 On focus | Tab onto each filter, select and toggle without activating | No navigation, submission or popup from focus alone. |

### Zoom and reflow

| Id | Steps | Expected |
|---|---|---|
| MT-ZOOM-01 Resize text | Set browser zoom to 200% on every route; also raise the OS font size | No clipped or overlapping text; no loss of content or function. |
| MT-ZOOM-02 Reflow | Set 400% zoom in a 1280 px window (320 CSS px) on every route, both themes | No horizontal scrolling of the page. Data tables and the Gantt may scroll in two dimensions inside their own region with visible scrollbars (`data-allow-2d-scroll`). Map keeps its controls reachable. |
| MT-ZOOM-03 Text spacing | Apply the WCAG text-spacing bookmarklet on every route | No clipping or overlap of text or controls. |

### Vision and colour

| Id | Steps | Expected |
|---|---|---|
| MT-VIS-01 Use of colour and sensory characteristics | With each CVD emulation and in greyscale, review status chips, lock markers, chart series, Gantt bars, as-of badges | Status is distinguishable from shape and text alone; chart series distinguishable by pattern, marker or direct label; instructions never rely on colour or position ("the green button", "on the right"). |
| MT-VIS-02 Text contrast | Check chart axis labels, data labels and map labels (SVG or canvas) with a contrast picker in both themes | At least 4.5:1 (3:1 for large text). |
| MT-VIS-03 Images of text | Review every raster image | None contain text except the USACE and EVS logos. |
| MT-VIS-04 Non-text contrast | Measure focus rings, input borders, chart lines and markers, map markers against the basemap, in both themes | At least 3:1 against adjacent colours. |
| MT-RESP-01 Orientation | On the tablet rotate between portrait and landscape on every route | No content locked to one orientation. |

### Forms and timing

| Id | Steps | Expected |
|---|---|---|
| MT-FORM-01 Identify input purpose | Inspect login and profile fields | `autocomplete` tokens present where a token exists. |
| MT-FORM-02 On input | Change filters, selects and toggles | Results update predictably; no auto-submit or navigation without warning. |
| MT-FORM-03 Error identification | Submit `/admin` forms with invalid and missing values | Errors described in text next to the field and in a summary; field has `aria-invalid` and `aria-describedby`; focus moves to the summary or first error. |
| MT-FORM-04 Labels or instructions | Review every field | Visible label, required marker in text, format hints before the field. |
| MT-FORM-05 Error suggestion | Enter a wrong format (date, number) | The error says what is expected and gives an example. |
| MT-FORM-06 Error prevention | Change a data source setting in `/admin` and save | Confirmation step or undo; destructive actions ask twice. |
| MT-TIME-01 Timing adjustable | Let the session approach timeout; watch the live feed refresh | Timeout warning with an extend option at least 20 seconds before; feed refresh never moves focus or resets filters. |

### Motion and live updates

| Id | Steps | Expected |
|---|---|---|
| MT-MOTION-01 Pause, stop, hide | Watch live SSE updates on `/`, `/public/locks`, `/public/srp` with and without reduced motion | A pause control stops row and marker updates; with reduced motion on, transitions and marker animations are removed. |
| MT-MOTION-02 Flashing | Review all animations and live indicators | Nothing flashes more than three times per second. |

### Touch and pointer

| Id | Steps | Expected |
|---|---|---|
| MT-TOUCH-01 Pointer gestures | On the map try pinch and two-finger pan; on the Gantt try drag | Zoom and pan buttons exist; drag has a non-drag alternative; nothing needs a path-based gesture. |
| MT-TOUCH-02 Pointer cancellation | Press on a control, move off, release | No action fires; actions fire on release, drags can be cancelled with Escape. |

## Functional performance criteria (Revised 508 Chapter 3)

Attest 302.1 to 302.9 from the scripts above: 302.1 from the screen reader pass, 302.2 from zoom and
contrast, 302.3 from MT-VIS-01, 302.7 and 302.8 from keyboard and touch, 302.9 from MT-SR-05, MT-FORM-02
and MT-FORM-05. 302.4, 302.5 and 302.6 are not applicable (no audio, no speech). Support documentation rows
602.2, 602.3, 603.2 and 603.3 are attested once this README, the manual plan and the `/accessibility` page
are reviewed with a screen reader.

## Recording results

Edit `manual_attestation.yaml`: set `status`, `tester`, `date`, `assistive_tech` (ids from the environments
table) and `notes` for the criterion. Use `partially-supports` with a description of the workaround for an
open defect, `does-not-support` for a blocking defect, and leave `not-evaluated` for anything not run. Run
`uv run evs-acr-gen` in `tools/acr` and commit the regenerated report together with the attestation.
