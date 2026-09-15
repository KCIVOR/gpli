# Design System Standardization Plan — Phases S1–S7

**Status:** Planning document. No production code has been changed by this document.
**Operating mode:** Surgical, incremental, reversible, evidence-driven, one concern per commit.
**Builds on:** `DESIGN_SYSTEM_IMPLEMENTATION_PLAN.md` (Phases 0–6, shipped 2026-09-12).
**Runs in parallel with, and must not collide with:** `DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md` (Phases R0–R8, R7 shipped and R8 "in force for new markup" as of 2026-09-12 — see `application/helpers/design_system_helper.php:4-13`). This plan is deliberately labeled **S1–S7** ("Standardization"), not "Phase 7+", specifically so it never collides with that plan's own numbering. **Before writing any new markup in any phase below, check the R-series component table (`DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md` §0) — if a `gp_ds_*` PHP helper already exists for the pattern being touched, call it; only hand-write CSS classes for patterns the R-series explicitly marked CSS-only (pagination, tabs/accordion, dropdowns/tooltips/popovers, modals/offcanvas, list/button groups, carousel).**

Validated 2026-09-15 against the live codebase: every file/line reference below was re-confirmed at validation time, and this revision corrects three things the first draft got wrong (see "Corrections from v1" at the bottom).

---

## 0. What this plan fixes (traceability table)

| # | Finding | File(s) | Phase |
|---|---|---|---|
| 1 | Invalid CSS: selector list bleeds into an `@media` prelude, rule is silently dropped | `assets/design-system/gp-tooltip.css:150-152` | S1 |
| 2 | Dark-mode header dropdowns hardcode `#25242c` instead of a token | `assets/design-system/gp-public-shell.css:687,691,698,723,730` | S1 |
| 3 | `--gp-ink` / `--gp-text` have no dark-mode value and are safe today only by accidental pairing — standing project rule (confirmed, not a question) says never use them for anything new | `assets/design-system/gp-tokens.css:23-24`, comment already at `gp-landing.css:5-6` | S1 |
| 4 | One-off card/badge/icon-button CSS reimplemented from scratch in a live, currently-`.gp-ds`-active admin page — wrong brand colors, zero dark-mode support | `application/views/backend/admin/custom_field.php:1-80` | S2 |
| 5 | Legacy admin theme never migrated: 560 hardcoded hex colors combined, zero dark-mode rules, zero shared-component reuse, still loaded on every admin page underneath the tokens | `assets/backend/css/hyper-admin-theme.css`, `assets/backend/css/main.css` | S3 |
| 6 | Public website never migrated: 296 hardcoded hex colors combined, zero dark-mode rules, zero shared-component reuse | `assets/frontend/default-new/css/custom.css`, `new-style.css`, `responsive.css` | S4 |
| 7 | Login screen never migrated: 6 hardcoded colors, zero dark-mode | `assets/backend/login/style.css` | S5 |
| 8 | Lesson/course player + lessons never migrated: 62 hardcoded colors combined, zero dark-mode | `assets/playing-page/css/style.css`, `assets/lessons/css/custom.css` | S5 |
| 9 | Checkout never migrated: 14 hardcoded colors, zero dark-mode | `assets/payment/css/stripe.css` | S5 |
| 10 | Documented-but-unfixed cross-file conflicts (`!important` patches fighting leftover Hyper/old-frontend colors) | `gp-admin-courses.css:797,801`, `gp-admin-report.css:142,160`, `gp-admin-settings.css:360`, `gp-homepage-builder.css:21-27` | S6 |
| 11 | No mechanism stops the next new page/PR from hardcoding another hex color | (process, not a file) | S7 |

---

## 1. Non-negotiable constraints (apply to every phase)

1. **Scope every change to `.gp-ds`.** The token system and shared components only activate inside the `.gp-ds` wrapper.
2. **Prefer the `gp_ds_*` PHP helper over hand-written classes.** Confirmed live in `application/helpers/design_system_helper.php`: `gp_ds_button()`, `gp_ds_badge()`, `gp_ds_alert()`, `gp_ds_card()`, `gp_ds_table()`, `gp_ds_page_title()`. Per the R8 mandate already in force, any *new or replaced* button/badge/alert/card/table/page-title markup written while executing this plan must call the helper, not hand-type `class="btn-primary"` etc. Reserve hand-written CSS classes for the patterns the R-series marked CSS-only (see header note above).
3. **Never touch JS behavior hooks.** Before changing any `class=""`, grep that exact class name across `.js` files and inline `<script>` blocks in the same view. If it's a hook (jQuery selector, data-attribute target, Owl/Slick/summernote init target), the class stays; only add new classes alongside it, never rename in place.
4. **Never touch markup structure or PHP logic beyond what's needed to call a `gp_ds_*` helper.** No template restructuring, no route changes, no controller changes, unless a phase says otherwise explicitly.
5. **Default theme stays light.** No phase may change the default rendered theme for any page. Dark mode remains opt-in (`data-theme="dark"` or `prefers-color-scheme` under `[data-theme="system"]`), exactly as today.
6. **One file (or one tightly-related group) per commit.**
7. **Re-verify before every phase, don't trust this document's numbers.** Re-grep the specific file immediately before editing it.
8. **Screenshot before/after, both themes, both breakpoints** (light desktop, dark desktop, light mobile 375px, dark mobile) for every page touched.
9. **No new hardcoded hex colors, ever, in a `.gp-ds`-scoped rule.** If a color is genuinely new and not in `gp-tokens.css`, stop and flag it for a token decision.
10. **Contrast cannot be verified by reading source.** Any claim that a color pairing "passes" must be checked with an actual contrast tool against the rendered page, not asserted from hex values alone.
11. **Per-page rollback lever already exists — use it.** `.gp-ds` activation is shell-level and opt-out, controlled by `application/config/design_system_pages.php` (`$config['gp_ds_exclude_pages']`, currently empty — confirmed live). If a specific page regresses after a Phase S3–S5 migration, the fastest safe rollback is adding that page's `page_name` to `gp_ds_exclude_pages`, **in addition to** the normal git revert of the CSS change — the config change instantly stops that one page from receiving `.gp-ds` styling without touching any other page.

---

## Phase S1 — Fix the three verified design-system bugs (no migration, pure bugfix)

**Risk: near-zero.** Self-contained fixes inside files the design system already owns.

### S1a. Fix the broken tooltip dark-mode rule
`gp-tooltip.css:150-152` currently is:
```css
[data-theme="dark"] .gp-ds .tooltip-inner,
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .gp-ds .tooltip-inner {
    background: var(--gp-ink);
    color: #fff;
  }
}
```
Fix — separate the explicit dark-theme selector from the system-preference media query:
```css
[data-theme="dark"] .gp-ds .tooltip-inner {
  background: var(--gp-ink);
  color: #fff;
}

@media (prefers-color-scheme: dark) {
  .gp-ds[data-theme="system"] .tooltip-inner {
    background: var(--gp-ink);
    color: #fff;
  }
}
```
Use `.gp-ds[data-theme="system"]`, matching the pattern used everywhere else in this codebase (e.g. `gp-tokens.css:76`), not the bare `:root:not(...)` that was there.
**Verification:** the base (theme-less) rule already sets identical values, so this fix should be visually a no-op — confirm with a pixel-identical before/after screenshot, plus a CSS validator check that the rule now parses.

### S1b. Replace hardcoded `#25242c` with a token
`gp-public-shell.css:687,691,698,723,730` — all five inside dark-mode-only blocks, paired with `var(--gp-fg)`/`var(--gp-border-strong)`. Replace `#25242c` with `var(--gp-surface-sunk)` (dark value `#0c0c10`) or `var(--gp-border)` (`#2b2a32`) — render both candidates in dark mode and pick whichever matches closest; do not guess. If neither is close enough, flag it rather than forcing a mismatched token.
**Verification:** dark-mode header dropdown screenshot before vs. after must look the same (or a deliberately-approved shift, called out to the user).

### S1c. Stop using `--gp-ink` / `--gp-text` in any new rule
This is **not an open decision** — the project has already decided it. `gp-landing.css:5-6` states the standing rule verbatim: *"Text uses --gp-fg / --gp-fg-muted / --gp-fg-faint — never --gp-ink / --gp-text, which have no dark-mode override."* Action for this phase:
1. Add the same warning comment directly above the `--gp-ink`/`--gp-text` definitions in `gp-tokens.css:23-24`, so the rule is visible at the source, not only in one consumer file.
2. Leave the two existing frozen pairings alone (`gp-admin-shell.css:419`'s gold badge, `gp-tooltip.css`'s ink-background bubble) — both pair the token with an equally-unthemed partner, confirmed safe, not worth touching.
3. Do **not** add dark-mode values to these two tokens — that would silently change the two frozen pairings' appearance in dark mode for no benefit, contradicting the project's own stated intent to retire them rather than fix them.
4. Add both token names to the Phase S7 CI grep guard's watch-list (see below) so a future PR can't reintroduce them.

---

## Phase S2 — Fix `custom_field.php`'s one-off component reimplementation

**Risk: low, single file.** **Note the urgency correction from validation:** `custom_field.php` is an admin view, and `.gp-ds` activation is shell-level and opt-out (`gp_ds_exclude_pages` is currently empty) — this page is **already rendering inside `.gp-ds` today**, in production, right now. This is not a "confirm it gets wrapped" task; the bug is live.

1. Re-grep `custom_field.php` for the exact classes (`eControll`, `fa-edit`, `fa-trash`, `bg-card`, `dragable-item`, `notes`, `singleFaq`) in every `.js` file and inline `<script>` in the same view (the `.dragable-item` + `.ui-sortable-placeholder` pair strongly suggests a jQuery UI Sortable hook). **Do not rename or remove any class confirmed as a JS hook.**
2. For classes that are pure styling (not hooks), replace with the `gp_ds_*` helper, not a hand-typed class, per constraint #2:
   - `.eControll .fa-edit` (`background:#1982FE`) → wrap using `gp_ds_button()` with the appropriate tone, or if it must stay an icon-only affordance embedded in existing markup, reference `var(--gp-primary)` instead of the off-brand `#1982FE`.
   - `.eControll .fa-trash` (`background:#ff4625`) → `gp_ds_badge('...', 'danger')` or reference `var(--gp-danger)` (`#CD182A`) instead of the off-brand `#ff4625`.
   - `.bg-card` → `gp_ds_card([...])` instead of the hardcoded `background:#fff` wrapper.
3. Delete the now-redundant hardcoded rules from the `<style>` block rather than leaving them as dead weight.

**Verification:** screenshot the custom-fields admin page, light and dark, before and after. Take the "before" shot first as evidence of the current live bug.

---

## Phase S3 — Migrate the legacy admin theme (`hyper-admin-theme.css`, `main.css`)

**Risk: highest in this plan.** Loaded on every admin page (`application/views/backend/includes_top.php:14,17`), underneath the design-system files. 560 hardcoded colors combined.

**Correction from validation:** the task here is **not** "get these pages wrapped in `.gp-ds`" — they already are, by default, shell-level. The actual problem is that `hyper-admin-theme.css` and `main.css` themselves never reference `.gp-ds` or any `--gp-*` token, so their hardcoded rules render regardless of theme and regardless of the wrapper being present. The fix is migrating *these files' rules*, not the pages' markup.

### S3a. Inventory pass (no code change)
Re-run the hex-color count per file, then group `hyper-admin-theme.css`'s rules by the admin page/section they apply to (sidebar, top bar, tables, forms, calendar, chart widgets, etc.) — 4,436 lines, migrate in sections, not one shot.

### S3b. Migrate one section at a time
For each section:
1. Identify every hardcoded color rule for that section.
2. Check whether a `gp-*.css` file already has an equivalent rule currently losing the cascade fight — the audit already found `!important` patches fighting Hyper leftovers in `gp-admin-courses.css`, `gp-admin-report.css`, `gp-admin-settings.css`. Where a design-system override already exists and wins, **delete the dead Hyper rule** — it's unreachable.
3. Where no design-system equivalent exists, port the rule into the appropriate `gp-*.css` file using tokens (checking first whether a `gp_ds_*` helper covers it, per constraint #2), then delete it from `hyper-admin-theme.css`/`main.css`.
4. After each section, spot-check 2-3 unrelated admin pages for regressions.
5. **If a section regression can't be isolated quickly, use the `gp_ds_exclude_pages` rollback (constraint #11) on the affected page(s) while investigating**, rather than reverting the whole section's commit.

### S3c. Exit condition
Zero hex colors outside comments, or the remainder is formally accepted as out-of-scope legacy (e.g. a vendor-calendar skin) and explicitly listed as "kept, not migrated" with a reason.

**This sub-phase alone is large enough to be tracked as its own multi-session effort, mirroring `PHASE_2A_ACCORDION_*`'s batch-plus-completion-report pattern in the existing plan.**

---

## Phase S4 — Migrate the public website (`custom.css`, `new-style.css`, `responsive.css`)

**Risk: high — public-facing, highest-traffic pages.** 296 hardcoded colors combined, five mismatched hardcoded fonts (Inter, Clash Grotesk, SF Pro Display, Basier Square, Poppins).

1. **Font consolidation first, colors second.** Grep every `font-family:` in the three files, map each to `var(--gp-font-head)` or `var(--gp-font-body)` — confirm with the user which pages currently show which font before assuming which is "correct"; some may be intentional per-section branding.
2. **Color migration, page-by-page** (homepage, course listing, course detail, instructor page, blog, FAQ, contact). For each:
   - Confirm current `gp-*.css` coverage (some sections may already be patched — `gp-homepage-builder.css:21-27` is a precedent).
   - Port remaining hardcoded rules into the matching `gp-*.css` file (`gp-landing.css`, `gp-blog.css`, `gp-faq.css`, `gp-course-detail.css`, `gp-instructor-page.css` already exist for this).
   - Delete the migrated rule from the source frontend file.
3. Reuse the exact page-by-page batching pattern already proven in Phases 1–6 (`PHASE_1_PILOT_BASELINE.md`, `PHASE_2A_ACCORDION_BATCH_*`).

**Exit condition:** zero hardcoded colors/fonts inside any selector nested under a `.gp-ds`-wrapped page, or the remainder explicitly listed as deferred with a reason.

---

## Phase S5 — Migrate login, lesson player, lessons, and checkout

**Risk: medium.** Smaller files (6–62 hardcoded colors each), but each is conversion-critical or completion-critical — extra manual QA applies even though the diffs are small.

- **S5a — Login (`assets/backend/login/style.css`, 6 colors):** lowest risk, do first as a dry run.
- **S5b — Lessons (`assets/lessons/css/custom.css`, 10 colors):** small, do second.
- **S5c — Course/lesson player (`assets/playing-page/css/style.css`, 52 colors):** test video controls, progress bar, and sidebar nav explicitly after migration, both themes.
- **S5d — Checkout (`assets/payment/css/stripe.css`, 14 colors):** extra caution — payment UI. After migration, manually walk a full test transaction (Stripe test mode) in both light and dark. Do not rely on screenshots alone here — click through it.

Each gets its own commit and its own before/after screenshot set (both themes). Do not combine S5a–S5d into one commit — checkout must be revertible in isolation.

---

## Phase S6 — Remove the `!important` patch layer

Once Phases S3/S4 delete the legacy rules these patches were suppressing, the following become dead code — verify dead, not just old, before deleting each:
- `gp-admin-courses.css:797,801`
- `gp-admin-report.css:142,160`
- `gp-admin-settings.css:360`
- `gp-homepage-builder.css:21-27`

**Must run after, not before, Phases S3/S4 remove the underlying legacy rule** — deleting the patch first would immediately regress the page to the old hardcoded look.

---

## Phase S7 — Prevent regression (process, not code)

**Status: implemented.** `scripts/check-design-system-consistency.sh`:
- Default mode reads a unified diff on stdin and fails (exit 1) if an *added* line introduces a hardcoded hex color or a new `--gp-ink`/`--gp-text` usage outside the two frozen exceptions. Run it in CI against a PR/commit diff: `git diff --cached -- 'assets/design-system/*.css' | scripts/check-design-system-consistency.sh`.
- `--tree` mode is a one-time baseline audit (not a gate) — it will show many pre-existing, already-reviewed hits (e.g. white button text against a background that never changes between themes) and deliberately excludes `gp-tokens.css` itself, since that file's job is defining the hex-to-token mapping.
- A line can be excluded with a trailing `/* gp-check:allow ... */` comment for a documented, reviewed exception (see `gp-landing.css`'s dark-only gold accent).
- **Caught during implementation, worth recording:** the first version piped grep output directly into the checking function (`grep ... | scan_lines`) — in bash, the right side of a pipe runs in a subshell, so the function's `fail=1` never reached the parent shell and the script always reported "passed" regardless of findings. Fixed by capturing grep's output into a variable first and passing it as an argument instead of over a pipe. Worth remembering if this script is ever extended.

**A one-paragraph rule** worth adding to this repo's contribution notes: "New UI work styles through `gp-tokens.css` variables and calls the `gp_ds_*` helpers in `application/helpers/design_system_helper.php` for buttons/badges/alerts/cards/tables/page-titles. Hardcoded hex colors or ad-hoc `<style>` blocks in view files are not acceptable for anything wrapped in `.gp-ds`."

**Flagged for your decision:** whether to retroactively force `.gp-ds` on the still-unmigrated legacy areas immediately versus waiting for full per-file migration. **Recommendation: do not** — `.gp-ds` is already shell-level default-on for these pages (per constraint #11), so forcing anything early isn't necessary; the actual remaining work is migrating the legacy CSS files' rules, which Phases S3–S5 already do section-by-section. Forcing anything sooner just removes the granular rollback lever those phases depend on.

---

## Suggested execution order

S1 → S2 → S5a (dry run) → S3 (largest, do early while attention is fresh) → S4 → S5b → S5c → S5d → S6 → S7.

S3 is scheduled before S4 despite being larger: it's higher-traffic (every admin page, every day) and the design system is already actively fighting it via `!important` patches — leaving it last lets those patches keep accumulating.

---

## What this plan explicitly does NOT do

- Does not touch third-party vendor CSS (Bootstrap, FontAwesome, jQuery UI, DataTables, Summernote, Select2, etc.).
- Does not redesign any component's *look* — this is a token/consistency/helper migration, not a visual refresh. Any page that looks different after migration (beyond deliberate dark-mode fixes) is a bug in that phase, not a feature.
- Does not change the reference source-of-truth file path or its content (`C:\Users\Rovick\Downloads\geeseprojdesignsystem (1).html`) — if a phase needs a value that file doesn't define, stop and flag it rather than inventing one.
- Does not duplicate or compete with the R-series (`DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md`) — where an R-series helper already covers a pattern, this plan uses it rather than re-solving the same problem with hand-written CSS.

---

## Corrections from v1 (validated 2026-09-15)

1. **Renumbered Phase 7–13 → S1–S7** to stop colliding with the already-in-force R0–R8 series (`DESIGN_SYSTEM_REUSABLE_COMPONENTS_PLAN.md`).
2. **Added constraint #2**: use the confirmed-live `gp_ds_*` PHP helpers (`application/helpers/design_system_helper.php`) instead of hand-written CSS classes wherever the R-series already extracted one, per the R8 "new markup" mandate.
3. **Corrected the activation-mechanism description in S2/S3**: pages are already `.gp-ds`-active by shell-level default (`gp_ds_exclude_pages` is empty, confirmed live) — the remaining work is migrating legacy CSS files' rules, not wrapping pages.
4. **Added constraint #11**: the existing `gp_ds_exclude_pages` config array is a faster, safer per-page rollback lever than a full git revert, and should be used alongside it during Phases S3–S5.
5. **Resolved S1c** (formerly "7c") from an open Option A/B question into a direct instruction: the project has already decided to deprecate `--gp-ink`/`--gp-text` in favor of `--gp-fg`/`--gp-fg-muted`/`--gp-fg-faint`, per the standing comment in `gp-landing.css:5-6`.
