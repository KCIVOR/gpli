# GPLI landing page layout refresh implementation plan

**Goal:** Apply the approved layout in `docs/superpowers/previews/gpli-landing-improved.html` to the live GPLI homepage. Only the CSS changes. Every section, Home Page Builder field and data source stays the same.

**Source of truth:** the preview file above. It mirrors the markup `home_gpli.php` renders today: every class in the preview exists in the current template. The preview hardcodes colors and defines its own buttons, header and footer so it can run on its own. Those parts are not ported (see Phase 1).

**Architecture:** All rules go into `assets/design-system/gp-landing-lms.css`. Today that file is loaded only by `home_gpli_assets.php` (the homepage), and every rule in it is scoped under `.gp-ds .gpli-home`. Light/dark mode works through `--gp-*` tokens in `gp-tokens.css`. The file has no explicit dark-mode selectors and must not gain any.

**Stack:** CodeIgniter 3 PHP views, CSS custom properties, Bootstrap 5, existing `gp-landing-reveal.js` scroll reveal.

**Execution:** Work on a branch off `develop`. Execute phase by phase with the executing-plans workflow. One commit per phase, so any phase can be reverted on its own.

## Hard constraints

These apply to every phase. A change that breaks one of them is out of scope, even if it looks like an improvement.

1. **Only two files may change:**
   - `assets/design-system/gp-landing-lms.css` (all layout work)
   - `application/views/frontend/default-new/home_gpli_assets.php`: the `?v=` cache key on the `gp-landing-lms.css` link only. No other edit to that file.
2. **Do not modify:** `home_gpli.php`; any controller, model or helper (including `gp_landing_extras()` and `gp_landing_toggle()` in `common_helper.php`); any Home Page Builder admin view; the database or uploaded files; `gp-landing.css` (shared with the page-builder components in `application/views/components/main/`); `gp-tokens.css`, `gp-base.css`, `gp-components-core.css`, `gp-public-shell.css`; `includes_top.php` / `includes_bottom.php`; header, footer, or any page other than the homepage; any JS file.
3. **Scope every selector** with `.gp-ds .gpli-home`. No bare element selectors, no global `.btn`, `.container` or `body` rules.
4. **No new markup or classes.** Style only what the template renders. Where the template sets a value inline (hero background position/size, the feature-trio padding, the media-strip `padding-top`, the CTA footnote), override it with `!important` and a `/* inline override */` comment, not by editing the template.
5. **Colors come from tokens only** (mapping table below), so dark mode keeps working. Allowed literals: `#fff` and `rgba(255,255,255,…)` for text and hairlines on the navy bands, and `rgba(15,30,61,…)` for photo scrims and shadows. No red anywhere: the facilitator card moves from `--gp-secondary` to `--gp-accent-2`.
6. **Keep the design-system buttons.** Do not port the preview's `.btn`, `.btn-primary`, `.btn-outline-blue` or `.btn-white` rules. Button sizing on this page keeps coming from the existing button block in `gp-landing-lms.css` and `gp-components-core.css`.
7. **No new fonts, images, icons or scripts.** Manrope and Inter are already loaded.
8. **Motion:** the only new animation allowed is the hero stat-card entrance, and it must sit behind `prefers-reduced-motion`. If `gp-landing-reveal.js` already animates the hero, drop the new keyframe instead of stacking two animations.
9. **Edit in place.** Replace the existing rules inside each section block of `gp-landing-lms.css` (Hero, Section headings, Feature trio, …) instead of appending overrides at the end, so two rule sets never fight in the cascade. Leave the Top course card (`.tc-*`) and Category chips (`.cat-chip*`) blocks untouched.

## Token mapping (preview → production)

| Preview variable | Production token | Notes |
|---|---|---|
| `--ink` `#1B2A4A` | `var(--gp-heading)` | Flips to `#EDEBE6` in dark |
| `--body` `#1F2937` | `var(--gp-fg)` | |
| `--muted` `#6B7280` | `var(--gp-fg-muted)` | |
| `--blue` `#2563EB` | `var(--gp-action)` for fills, `var(--gp-link)` for text | Link flips to `#93B4FF` in dark |
| `--blue-deep` `#1D4ED8` | `var(--gp-action-hover)` | |
| `--blue-soft` `#93B4FF` | `var(--gp-primary-3)` | Accent text on navy bands |
| `--navy` `#0F1E3D` | `var(--gp-accent-2)` | Same value in both themes, intended for dark bands |
| `--page` `#F8FAFC` | `var(--gp-bg)` | Hero left panel must use this so it flips |
| `--surface` `#FFFFFF` | `var(--gp-surface)` | Cards, stat card, catalog panel |
| `--line` `#E5E7EB` | `var(--gp-border)` | |
| `--tint` `#EEF3FE` | `var(--gp-info-soft)` | Icon tiles, eyebrow pill |
| `--star` `#F5A524` | Keep the current `.testi .stars` color | Ratings keep their own role color |
| Card shadow | `var(--gp-shadow-card)` | The hero stat card may keep its deeper scrim-tinted shadow |
| `--radius` | `var(--gp-radius)` where the preview uses 10px; keep 14–22px for large panels | |

## Phase 0: Isolate and record a baseline

Run this before any landing CSS changes, so the landing diff isn't mixed with earlier unfinished work.

- [ ] Commit the outstanding color-refresh work currently uncommitted on `develop`, in its own commit(s). Confirm `git status --short` is clean.
- [ ] Create `feature/landing-layout-refresh` from `develop`.
- [ ] Record which homepage sections are switched on (Home Page Builder toggles plus `top_category_section`, `top_course_section`, `top_instructor_section`, `review_section`) and whether Courses by Function is in manual or auto mode. Today Top Courses is off and Courses by Function is manual.
- [ ] Capture baseline screenshots of `http://localhost/academy/` at 1440, 1024, 768 and 390 px in light and dark. Save them under `tmp/landing-refresh/before/`.
- [ ] Record the current `?v=` value on the `gp-landing-lms.css` link (`gpli-red-audit-1` at the time of writing).

**Exit check:** clean tree, branch created, baseline captured.

## Phase 1: Shared foundations

- [ ] Section rhythm: `.section-pad` padding 104px (72px under 900px). Sections that follow a band (`section:has(.lms-strip)`, `:has(.quiz-banner)`, `:has(.dual-cta)`, `:has(.testi-grid)`) drop their top padding.
- [ ] `.section-head` becomes a two-column grid: eyebrow and `h2` on the left, description on the right, bottom-aligned. One column under 900px. It must still work when there's no eyebrow (testimonials).
- [ ] `.section-eyebrow` and `.eyebrow`: sentence case (`text-transform: none`), with the flock chevron `::before` glyph replacing the current dash/line.
- [ ] `h2` scale and tracking as in the preview. `.gp-two-tone-blue` and `.gp-two-tone-red` both use `var(--gp-link)`.
- [ ] Container stays at the current `1290px` unless the review in Phase 7 asks for 1200px. Decide once and note the decision here.

**Exit check:** every section heading on the page uses the new arrangement in both themes. No other section has changed yet.

## Phase 2: Hero

- [ ] Split layout only when a photo is uploaded (`.page-hero.has-bg-photo`): `::before` paints `var(--gp-bg)` over the left 56%, the photo shows on the right, and `::after` adds the bottom scrim on the photo half. Replace the current full-width tint overlay.
- [ ] **Without a photo** (no `.has-bg-photo`): no split and no `::before` panel. The copy and stat card sit on the current gradient background. This must render cleanly.
- [ ] `background-position`/`size` overrides use `!important` (inline override).
- [ ] `.ph-grid`: 7/5 columns, `min-height: 760px`, bottom padding 44px. `.hero-stats` becomes a 2×2 card on `var(--gp-surface)` with internal `var(--gp-border)` dividers, pulled 64px left across the seam.
- [ ] `.hero-search` becomes the compact attached field with an icon. It must stay below the two action buttons in visual weight.
- [ ] Mobile (≤900px): the photo becomes a 260px band drawn by `::after` with `background: inherit`, so any uploaded aspect ratio works. Copy follows, then the stat card at full width.
- [ ] Check that no face or key subject in the current hero photo sits under the stat card at 1440 and 1024. If a future photo puts a subject there, the admin re-crops the photo; the CSS doesn't change.

**Exit check:** hero matches the preview with and without a photo. No horizontal overflow at 390px.

## Phase 3: Feature trio and Courses by Function

- [ ] `.gp-landing-compact` becomes a full-width ruled strip on `var(--gp-surface)`: three columns with vertical dividers, icon left of the title. `padding: 0 !important` (inline override). Stacks under 900px.
- [ ] `.g4` with `.fn-card` (manual mode) becomes a single bordered catalog panel with shared dividers: 4 → 2 → 1 columns, with the border resets per breakpoint. `.fn-count` is pinned to the card bottom.
- [ ] No hover effects on `.fn-card`. The cards aren't links in the template, so they must not look clickable.
- [ ] Auto mode (`.cat-chips`): no change. Verify it still renders after Phase 1, by switching the mode in the admin on a test copy or reading it in the template; do not change saved settings on the shared database.

**Exit check:** 8 cards render correctly at 4/2/1 columns. The grid still holds with 1 to 7 cards (test by hiding cards in devtools, not by editing CMS data).

## Phase 4: Photo / video strip

- [ ] `.lms-strip` becomes a 1.55fr / 1fr grid: the first item spans two rows, the other two stack. One column under 900px.
- [ ] `.strip-media` gets rounded corners and a 16/10 ratio. The first item fills its column, with a 400px minimum height.
- [ ] `.video-tag` is a sentence-case pill. `.play` is a white circle with an `--gp-action` triangle.
- [ ] Edge cases: slots without a video (no tag, play button or caption) and the section toggled off.

**Exit check:** layout holds for 0, 1, 2 and 3 video slots.

## Phase 5: Leadership quiz and Why GPLI

- [ ] `.quiz-banner`: two-column dark panel over the uploaded photo with a left-to-right `rgba(15,30,61,…)` scrim. Without a photo, it falls back to `var(--gp-accent-2)`. Accent heading text uses `var(--gp-primary-3)`. `.quiz-badge` becomes a framed lockup.
- [ ] `.ph-chevron`: draw the V with `::before` so the inline `transform: scale()` on the element still works. Use a low-opacity stroke.
- [ ] Why GPLI (`.bg-blue-soft`): the container becomes a two-column grid. The section head spans both columns. `.g3` tiles become a ruled list on the left, and `.why-stats` becomes a 2×2 panel on `var(--gp-accent-2)` on the right. One column under 900px.
- [ ] The `.bg-blue-soft .g3` override must not affect the Top Courses `.g3` grid.

**Exit check:** both sections match the preview, with and without the quiz photo, in both themes.

## Phase 6: Facilitators, dual CTA, testimonials and CTA band

- [ ] `.instr-grid`: 4 / 2 columns, square avatars (`aspect-ratio: 1`). Names use `text-transform: capitalize`. Check the layout with 1 to 4 instructors.
- [ ] `.dual-card.learner` uses `var(--gp-action)` and `.dual-card.facilitator` uses `var(--gp-accent-2)` (removes the red). Buttons are pinned to the card bottom.
- [ ] `.testi-grid` becomes CSS columns (3 / 2 / 1). Remove the red top border from `.testi`. `.who` uses `var(--gp-heading)`. Check the layout with 1 to 6 reviews and with the section off.
- [ ] `.cta-band`: heading and copy on the left, buttons bottom-right, footnote full width under a hairline. The footnote is targeted with `.container > p:last-child` because it has no class. Without a photo, it falls back to `var(--gp-accent-2)`.
- [ ] Top Courses (`.tc-*`): unchanged. Switch it on in a test environment and confirm the Phase 1 section rhythm and section head still look right with it.

**Exit check:** every section from the preview is in place. Top Courses and auto-mode categories still render.

## Phase 7: Dark mode, responsive and accessibility pass

- [ ] Toggle dark mode. Every surface, border, heading and body color must flip through tokens. Search the new rules for hex values: only the literals allowed by constraint 5 may remain.
- [ ] Widths 1440, 1280, 1024, 900, 768, 560, 390, 360: no horizontal overflow (`document.documentElement.scrollWidth === innerWidth`), no text overlapping photos, the stat card never covering the hero copy.
- [ ] Keyboard: visible focus on the hero buttons, search field and button, and every link and button down the page.
- [ ] `prefers-reduced-motion`: no entrance animation.
- [ ] Run `node scripts/audit-responsive-design-system.mjs --base-url http://localhost/academy --theme both` for the home route, and inspect the results.
- [ ] Bump the `gp-landing-lms.css` cache key in `home_gpli_assets.php` (for example `?v=landing-layout-1`).
- [ ] Delete rules made dead by this work inside the edited blocks only.

**Exit check:** after screenshots in `tmp/landing-refresh/after/` at the same widths and themes as Phase 0.

## Phase 8: Scope verification and closeout

- [ ] `git diff --name-only develop...` lists exactly `assets/design-system/gp-landing-lms.css` and `application/views/frontend/default-new/home_gpli_assets.php`.
- [ ] `git diff develop... -- application/views/frontend/default-new/home_gpli_assets.php` shows only the `?v=` value changing.
- [ ] Every selector in `gp-landing-lms.css` is scoped under `.gp-ds .gpli-home`, including those inside `@media` blocks. Check with:
  `grep -nE '^\s*[.#a-zA-Z:\[][^;{}]*[{,]\s*$' assets/design-system/gp-landing-lms.css | grep -vE '\.gp-ds \.gpli-home|^\s*[0-9]+:\s*(from|to)\s*\{'`
  Before this work it returns only two comment lines (around lines 109 and 257). Any other hit is an unscoped selector to fix.
- [ ] Brace balance check on `gp-landing-lms.css`.
- [ ] Spot-check pages that must not change: course catalog, course detail, login and a page-builder custom page. Compare against baseline; no difference.
- [ ] Record before/after evidence, any deviations, and the container-width decision in an execution record at the bottom of this file.

## Rollback

Each phase is one commit, so revert the commit for the phase that regressed. Reverting everything means reverting `gp-landing-lms.css` and the cache key. No data or settings need restoring, because none are touched.

## Content fixes (admin tasks, not part of this code change)

These show in the preview but are CMS content, edited in the admin by whoever manages the site:

- Second featured video title is `test`.
- Three of four facilitators have no profile photo.
- The testimonials heading phrase reads "What the people thinks about us". Fix it in Language settings.
- One review contains a mis-encoded dash (`ÔÇö`).
- The footer still shows the template's "Creativeitem" copyright, demo phone number and demo email.

## Execution record, 6 November 2026

All nine phases were executed on `feature/landing-layout-refresh`, one commit per phase:

| Phase | Commit | Result |
|---|---|---|
| 0 | `ccb0bfe`, `0982bfb` (on `develop`), `17f49f7` | Pending palette work committed separately on `develop`. Branch created. Baseline metrics saved to `tmp/landing-refresh/before/metrics-1440.json`. Cache key was `gpli-red-audit-1`. |
| 1 | `0b11dd3` | Section rhythm, two-column section heads, sentence-case labels with the flock chevron. |
| 2 | `e6a715e` | Split hero with bridging stat card; no-photo fallback, dark mode and the 390px band verified. |
| 3 | `bafa11c` | Ruled feature strip; single-panel catalog. Dividers verified at 4 and 2 columns with 8 and 6 cards. |
| 4 | `38fd13e` | Asymmetric media strip. Works with live slots (1 and 3 video, 2 photo). |
| 5 | `394bd1e` | Quiz banner, Why GPLI, V-formation chevrons. |
| 6 | `9a65a2c` | Facilitators, navy facilitator card (red removed), masonry testimonials, split CTA band. |
| 7 | `1f3366d` | Contrast fixes; cache key bumped to `landing-layout-1`. |

**Verification**
- Code files changed vs `develop`: exactly `gp-landing-lms.css` and `home_gpli_assets.php` (cache key line only). The other two branch files are this plan and the preview.
- Selector scope check: one hit, a comment line. No unscoped selectors. Braces balanced (234/234).
- Top course card, category chip and button blocks are byte-identical to `develop`.
- No horizontal overflow at 1440, 1280, 1024, 900, 768, 560, 390 and 360 px.
- Contrast check over every text element on the page passes in light and dark after the Phase 7 fixes.
- Keyboard: hero buttons show a 3px focus ring; the search field shows a focus border and ring.
- Only literal colors left in the file: `#fff`, white rgba on navy, navy rgba scrims/shadows, plus one pre-existing shadow in the untouched Top course card block. No `--gp-secondary` (red) left.
- `/home/courses`, `/login` and `/home/shopping_cart` return 200 and do not load the landing stylesheet.

**Decisions and deviations**
- Container width kept at 1290px.
- `.bg-muted` sections now use the page background (transparent), so a band following another section reads as one surface.
- `.gp-landing` sections on this page opt out of the 48vh floor from `gp-landing.css`, via a scoped rule. `gp-landing.css` itself is unchanged.
- Testimonial stars now use `--gp-link` instead of `--gp-gold-deep`. The old token has no dark-mode value and measured 1.57:1 on the dark surface. This deviates from "keep the current star color".
- The hero label pill uses a half-strength `--gp-info-soft` tint (`color-mix`) so the link blue stays above 4.5:1 in light mode.
- The hero search input selector matches the specificity of the shared text-input rule in `gp-components-core.css`, so the field keeps its shape without editing that file.
- The feature media photo fills its box instead of sizing it, so uploaded images of any shape don't stretch the strip.
- Baseline and after screenshots could not be saved as files: the browser pane can't write to disk, and the device shell can't reach `localhost`. Layout metrics were saved as JSON instead, and screenshots were reviewed during the session. For the same reason `scripts/audit-responsive-design-system.mjs` was not run; the overflow, contrast and focus checks above replace it.
- Not exercised live: Top Courses (off) and auto-mode category chips (manual mode is active). Their CSS blocks are unchanged, but they now inherit the left-aligned section head and the new section rhythm. Check both when either is switched on.
- During Phase 0 the palette commit was first stored with CRLF line endings in 37 files. It was fixed forward in `0982bfb` (content unchanged). Every later commit was made with `core.autocrlf=true` and checked for CRLF before committing.
