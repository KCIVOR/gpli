# S6 — Dead `!important` Sweep (Design System Standardization)

Tracks the final check that no `!important` patch is left defending against a
rule this project already deleted or fixed at its source. See
`DESIGN_SYSTEM_STANDARDIZATION_PLAN.md` for the full phase list this belongs to.

## Scope — why this isn't a re-audit of all `!important` usage

A full-codebase count shows **776 `!important` declarations** across 34
`assets/design-system/gp-*.css` files. The overwhelming majority of these are
legitimate and untouched by this session's work — they exist to beat specific
Bootstrap/Hyper-admin-theme/vendor-widget defaults (daterangepicker, Select2,
CodeMirror, accordion components, etc.) that are still present in the
legacy CSS on purpose (per the user: leaving `hyper-admin-theme.css`'s
remaining hardcoded colors alone is fine — our `.gp-ds`-scoped rules already
win on specificity regardless of what's left unedited there).

Re-verifying all 776 by hand is not a bounded task and isn't what "S6" means
in the plan. **S6 only checks the `!important` patches this session's own
edits could have made unnecessary** — i.e. every rule the plan deleted
outright, or every hardcoded color/font this session fixed directly at its
source file. If the thing an `!important` was defending against no longer
exists, the `!important` (or the whole patch rule) is dead weight; otherwise
it's still doing real work and must stay.

## Method

For each rule deleted or value fixed this session (list below), grep every
`assets/design-system/gp-*.css` file for `!important` declarations touching
the same selector/class, and confirm none remain unaddressed.

## Rules deleted this session (defended-against target gone)

| Deleted rule | Source file | Result |
|---|---|---|
| `daterangepicker td.active` (+ media-query duplicate) | `hyper-admin-theme.css` / `main.css` | No `!important` patch found anywhere targeting `daterangepicker`/`td.active`. Clean. |
| `.ranges li.active` (+ media-query duplicate) | `hyper-admin-theme.css` / `main.css` | `gp-admin-report.css`'s own `.ranges li.active` patch already had its now-unnecessary `!important` removed earlier this session (contrast-bug fix pass). Re-checked: clean, no `!important` remains on this selector. |
| `.start_ajax_loading` / `.ajax_loaderBar` | `main.css` | Replaced with a global rule in `gp-admin-shell.css:684-689` and a scoped one in `gp-admin-courses.css:792-802` — both confirmed to use **no** `!important`. Clean. |

## Values fixed at source this session (patch no longer needed for that class)

| Fixed class/value | Source file | Result |
|---|---|---|
| `.title-two .title`, `.title-one .title` (hardcoded near-black hex) | `new-style.css` | `gp-homepage-builder.css` already had its `!important` patch replaced with a comment noting the migration (done earlier this session). Re-checked: no live patch remains. Clean. |
| `#25242c` (5 instances) | `gp-public-shell.css` | Fixed directly to `var(--gp-border)`; grepped all `gp-*.css` for the old hex — zero hits anywhere. Clean. |
| Course player page fixes (body bg, headings, muted text, brand accent, Zoom callout, etc.) | `assets/playing-page/css/style.css` | No `gp-*.css` file has a patch specifically targeting `.course-playing-content`, `.btn_zoom`, `.live_class_note`, `.icon-upvot-comment`, or `.locked-card` — nothing to clean up, these were never separately patched. |

## Explicitly left alone (not S6's job)

- **`gp-dark-surfaces.css`** — a broad dark-mode compatibility layer
  (`.course-playing`, `.accordion-button`, `.course-content-items`, etc., all
  forced to `var(--gp-surface) !important`). Investigated whether any of
  these entries duplicate this session's source fixes: they don't — most of
  these classes have **no** background rule at all in their own source file
  (e.g. `.course-playing` is pure padding), meaning the white background
  these entries fight is either Bootstrap's own component default or
  something inherited, not a hardcoded value we already patched. This file's
  `!important`s are still doing real work and were left untouched.
- The remaining ~770 `!important` declarations across the other `gp-*.css`
  files — legitimately defending against legacy CSS that is still in place
  (per project decision to leave `hyper-admin-theme.css` etc. unswept for
  now). Not in scope for this pass; would need to be re-audited only if/when
  those legacy files are edited.

## Verdict

**Clean.** No dead `!important` was found still lingering from this
session's deletions/fixes. S6 is complete for the scope defined above.
