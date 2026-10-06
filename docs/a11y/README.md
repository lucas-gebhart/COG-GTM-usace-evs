# EVS accessibility read-out

This folder holds the Section 508 evidence for the Enterprise Visibility Suite demo: the automated results
collected in CI, the manual attestation file testers fill in, and the OpenACR (VPAT 2.5 compatible) report
generated from both. EVS is a demonstration build; nothing here describes a production deployment.

## What is produced and how

| Artefact | Produced by | Where |
|---|---|---|
| axe-core result per matrix cell | `apps/web/e2e/a11y.spec.ts` (Playwright + `@axe-core/playwright`) | `apps/web/a11y-results/axe/<route>__<viewport>__<theme>__<motion>.json` |
| Keyboard traversal smoke | `apps/web/e2e/keyboard.spec.ts` | `apps/web/a11y-results/keyboard/<route>.json` |
| 320 px reflow smoke (400% zoom equivalent) | `apps/web/e2e/reflow.spec.ts` | `apps/web/a11y-results/reflow/<route>__<theme>.json` |
| pa11y-ci report (axe runner, WCAG2AA) | `pnpm a11y:pa11y` (`apps/web/.pa11yci.cjs`) | `apps/web/a11y-results/pa11y.json` |
| Lighthouse CI (accessibility category, budget 1.0) | `pnpm a11y:lhci` (`apps/web/lighthouserc.cjs`) | `apps/web/a11y-results/lighthouse/` |
| Manual attestation | testers, by hand | `docs/a11y/manual_attestation.yaml` |
| OpenACR YAML | `evs-acr-gen` (`tools/acr`) | `docs/a11y/evs-openacr.yaml` |
| ACR Markdown and HTML | `evs-acr-gen` | `docs/a11y/evs-acr.md`, `docs/a11y/evs-acr.html` |
| API read-out fixture | `evs-acr-gen` | `apps/api/fixtures/accessibility.json` (`AccessibilityReadout`, served at `/api/accessibility/readout`, shown on `/accessibility`) |

### The matrix

Every route listed in `apps/web/src/app/routes.ts` (the dynamic `/projects/:p2` route uses the first project
in `apps/api/fixtures/projects.json`) is scanned at four viewports (360x800, 768x1024, 1280x800, 1920x1080),
in both themes (`light`, `leadership` via `html[data-theme]`) and with `prefers-reduced-motion` off and on.
That is 12 x 4 x 2 x 2 = 192 cells per run. A cell fails when axe reports a violation tagged WCAG 2.1 A or AA
(`wcag2a`, `wcag2aa`, `wcag21a`, `wcag21aa`). WCAG 2.2 and best-practice findings are recorded as advisories
and do not fail the build. Incomplete (needs review) checks are kept in the JSON and never counted as passes.

The suite runs against the Vite preview build. With `VITE_MOCK=1` and WP4a's MSW handlers present the pages
render fixture data; without them the API calls report "unavailable" and the page chrome is still scanned.
In CI the API is started in fixtures mode (`EVS_AUTH_DISABLED=true`) so route content is exercised.

### Running locally

```bash
cd apps/web
pnpm build
pnpm test:a11y        # Playwright matrix, keyboard and reflow smoke (starts vite preview on :4173)
pnpm preview --port 4173 &
pnpm a11y:pa11y       # pa11y-ci, writes a11y-results/pa11y.json
pnpm a11y:lhci        # Lighthouse CI, writes a11y-results/lighthouse/

cd ../../tools/acr
uv sync --extra dev
uv run evs-acr-gen    # writes docs/a11y/evs-openacr.yaml, evs-acr.md, evs-acr.html and apps/api/fixtures/accessibility.json
uv run pytest -q
npx @openacr/openacr validate -f ../../docs/a11y/evs-openacr.yaml -c evs_acr/data/catalog-2.5-edition-wcag-2.1-508-en.yaml
```

`evs-acr-gen --strict` exits non-zero while any WCAG A/AA row is `not-evaluated`; it is the release gate, not
the CI default. `--fail-on-violations` exits non-zero when any row is `does-not-support` or
`partially-supports`.

### In CI

`.github/workflows/ci.yml` has two accessibility jobs:

- `a11y` builds the web app, starts the API in fixtures mode, runs the Playwright matrix (gating), then
  pa11y-ci and Lighthouse CI, and uploads `apps/web/a11y-results` as the `a11y-results` artefact.
- `acr` downloads that artefact, runs `evs-acr-gen`, validates the YAML with `@openacr/openacr validate`,
  runs the generator tests and uploads `evs-openacr.yaml`, `evs-acr.md`, `evs-acr.html` and
  `accessibility.json` as the `acr` artefact. On pull requests from this repository it also commits the
  regenerated `docs/a11y/*` and `apps/api/fixtures/accessibility.json` back to the branch when they changed
  (commit message `chore(a11y): regenerate ACR from CI evidence`), so the API fixture always reflects the
  last CI run of that branch. Forks and `main` get artefacts only.

The commit-back path was chosen over "API fetches the artefact" because the API serves fixtures from disk in
every environment (local Compose, Fly.io, GovCloud) with no GitHub dependency at runtime.

## How a row gets its level

`tools/acr/evs_acr/data/wcag_mapping.yaml` maps each of the 48 WCAG 2.1 A/AA criteria to axe rule ids, to
manual test ids from `MANUAL_TEST_PLAN.md`, or to a not-applicable reason. The generator applies this rule:

| Level | Condition |
|---|---|
| Supports | every automated cell in the run passes for the mapped rules AND, where the criterion lists manual tests, the attestation says `supports` |
| Partially Supports | a moderate or minor axe violation, a failed keyboard or reflow smoke check, or an attested partial |
| Does Not Support | a critical or serious violation (axe, Lighthouse or pa11y) or an attested failure |
| Not Applicable | the criterion concerns content EVS does not ship (audio, video, motion actuation) |
| Not Evaluated | evidence missing: no CI run, or manual tests not yet attested |

The committed sample report therefore shows 4 rows `supports` (2.4.2, 3.1.1, 3.1.2, 4.1.1: automated only,
no manual test required), 5 `not-applicable` and 39 `not-evaluated`. It will stay that way until testers
complete the manual plan and record results in `manual_attestation.yaml`. The generator never raises a
row above what the weaker of the two evidence sources allows.

## What is claimed and what is not

Claimed: the demo build at the commit named in the report passed the automated checks listed in the row
notes, on the cells counted there, and the manual attestations recorded with tester, date and assistive
technology.

Not claimed: WCAG 2.1 AA conformance, Section 508 conformance, or any level for a row marked
`not-evaluated`. Automated tools find roughly a third of WCAG issues; the manual plan covers the rest. The
report covers the web application only. Hardware, software (Chapter 5) and authoring-tool rows are marked
not applicable per VPAT 2.5 guidance for web content evaluated against WCAG. AAA rows are listed and marked
not evaluated because AAA is not a target. Legacy APEX pages and third-party sites linked from EVS are out
of scope.

## WCAG 2.2 criteria adopted as design rules

The report is produced against the WCAG 2.1 edition of the GSA catalog (the current OpenACR catalog). Three
WCAG 2.2 AA criteria are adopted as design rules and checked in review and in the keyboard smoke test, but
are not reported in the ACR:

- 2.4.11 Focus Appearance: focus indicator at least 2 CSS px thick, 3:1 against adjacent colours, never
  clipped by overflow containers (tables, Gantt, map). USWDS `focus-outline` tokens are used everywhere;
  the keyboard smoke test records any focus stop without a visible indicator.
- 2.5.7 Dragging Movements: every drag (map pan, Gantt bar move, column reorder) has a single-pointer
  alternative (zoom and pan buttons, date inputs, move up/down menu items).
- 2.5.8 Target Size (Minimum): interactive targets are at least 24x24 CSS px with spacing; EVS uses 44 px
  for primary controls and map markers at mobile widths.

## Related documents

- `MANUAL_TEST_PLAN.md`: assistive technology scripts and the 19/24/5 criteria split.
- `manual_attestation.yaml`: the file testers edit.
- `../research/evs_508_and_design_report.md`: the research behind the testing set and the ACR rules.
- `../research/evs_openacr_skeleton.yaml`: the hand-written starting point the generator replaced.
