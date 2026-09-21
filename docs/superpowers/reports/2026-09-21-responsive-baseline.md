# Responsive Baseline — Phase 0 (2026-09-21)

Read-only audit of 7 public routes x 5 viewports x 2 themes (70 rows) against `http://localhost/academy`.
Tooling: `scripts/responsive-route-manifest.mjs`, `scripts/audit-responsive-design-system.mjs`.
Raw output (local only, not committed): `tmp/responsive-audit/results-{light,dark}.json` plus screenshots.

```powershell
npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme light
npx -p playwright node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme dark
```

## Routes covered

| Name | Path | Wrapper | Owner CSS |
|---|---|---|---|
| home | `/` | `.gp-landing` | gp-landing.css |
| catalog | `/home/courses` | `.gp-catalog-page` | gp-courses.css |
| course-detail | `/home/course/introduction-to-time-blocking/75` | `.gp-course-page` | gp-course-detail.css |
| faq | `/home/faq` | `.gp-faq-page` | gp-faq.css |
| about | `/home/about_us` | `.gp-policy-page` | gp-legal-pages.css |
| contact | `/home/contact_us` | `.gp-contact-grid` | gp-contact-us.css |
| blog | `/blog` | `.gp-blog-hero` | gp-blog.css |

Note: `/faq`, `/about_us`, `/contact_us` return a "404 not found" page with HTTP 200 — the real routes are under `/home/`.

## Results

- Light: 34/35 pass. Dark: 34/35 pass.
- `gp-ds` class present, wrapper present, and theme applied on every row.
- Authenticated, payment and admin routes: **not covered** (blocked until Phase 4+ fixtures).

## Failures

### F1 — Catalog page overflows by 2px at 360px (both themes)

| Field | Value |
|---|---|
| Route / viewport | `/home/courses`, 360x800 (also 361px; 362px and wider pass) |
| Assertion | `scrollWidth 362 > innerWidth 360` |
| Computed property | `.gp-catalog-main` width 342px inside `.gp-catalog-layout` content box 336px; the `.row` inside `.courses-card` (margin -8px) then reaches x=362 |
| Winning selector | `.gp-ds .gp-catalog-layout { grid-template-columns: 1fr }` at `@media (max-width: 991px)` — `gp-courses.css:98`. **This is a DS rule, not a legacy conflict**: `1fr` means `minmax(auto, 1fr)`, so the single track grows to its child's min-content width. The desktop rule (line 74) already uses `minmax(0, 1fr)`. |
| Intended DS counterpart | Same selector in `gp-courses.css` (mobile breakpoint) |
| Smallest triggering width | 361px |
| Fix phase | Phase 2 (course discovery) |
| Likely fix | Change the ≤991px track to `minmax(0, 1fr)`; then re-check for the child that sets the 342px min-content width. |

## Audit limitations (to address in later phases)

- The Phase 0 audit checks DS activation, wrapper presence, theme and page overflow. It does not yet detect a **legacy visual system returning** (e.g. old-brand button or font styles). Phase 1/2 probes must add computed-style checks (font family, colours, radius) per component and record the winning legacy selector.
- No console-error capture yet; add before Phase 1 sign-off.
- Populated blog/community/cart states are not covered.

## Phase 0 outcome

Baseline recorded. No CSS, controller, view or JS files changed.
