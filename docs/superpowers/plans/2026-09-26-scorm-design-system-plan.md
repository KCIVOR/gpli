# SCORM Add-on Design System Alignment — Implementation Plan

**Goal:** Every SCORM add-on screen (course-type upload modal, curriculum panel, preview modal, live student player) renders with the Geese Project design system's colors and looks correct in both light and dark mode — no leftover hardcoded hex/rgb, no unthemed Bootstrap-default alert/badge tones.

**Root cause:** The SCORM views (`scorm_course_uploading_form.php`, `scorm_curriculum.php`, the two `preview_scorm_course.php` files, `scorm_course_content_body.php`) predate the design-system (DS) migration and were never wired into it: they use raw Hyper/Bootstrap classes (`badge-info-lighten`, `alert-light`) that no DS rule targets, aren't wrapped in the container classes (`.gp-courses-modal`, `.gp-course-wizard`) that the DS's existing CSS keys off, and one shared stylesheet (`assets/backend/css/main.css:338-366`) hardcodes `rgb(0, 208, 79)` / `#bcbcbc` with no dark-mode value at all.

**Approach:** CSS- and class-level restyling only. Add a handful of new `.gp-ds`-scoped CSS rules (reusing existing `--gp-*` tokens) and swap a few class names / add wrapper `<div>`s in the 7 affected view files. No PHP logic, controller, model, route, or layout change; no field/button/action removed. This directly continues `SCORM_DESIGN_SYSTEM_TRACKER.md` (repo root), correcting two of its proposed fixes after deeper audit (see Audit finding 3 and 4 below).

**Tech stack:** CodeIgniter 3 (PHP, `application/views/**`), plain CSS custom properties under `.gp-ds` (`assets/design-system/*.css`), no build step, no PHP unit test suite (see Audit finding 6). Verification uses this project's own established pattern of one-off Playwright `.mjs` scripts (see `tmp/p7/*.mjs`, `tmp/responsive-audit/*.png` from prior DS phases) plus `php -l` and `git diff --check`.

**Source:** `SCORM_DESIGN_SYSTEM_TRACKER.md` (created this session from a `/legacy-ui-redesign` audit), user request: "align the theme only, like color, apply darkmode properly... create a .md tracker for transforming those into system design aligned" → this plan executes that tracker's 8 checklist rows.

---

## Open questions (resolve before implementing)

| # | Question | Why it matters | Recommended answer |
| --- | --- | --- | --- |
| 1 | The instructor-side `application/views/backend/user/course_edit.php` never got the `.gp-course-wizard` wrapper that the admin side has (confirmed absent — Audit finding 4). That means **every** addon tab pane for instructors (assignment, noticeboard, live-class, course_analytics — not just SCORM) misses the themed alert/badge/table rules that key off `.gp-course-wizard`. Do you want a SCORM-only workaround now (this plan's Phase 3, scoped to `#curriculum` only) with the broader instructor-wide gap logged separately, or should this plan also add the `.gp-course-wizard` class to `user/course_edit.php` (one line, fixes all instructor addon tabs, but is bigger than "SCORM only")? | Changes the blast radius of Phase 3 and whether other addons get fixed as a side effect | SCORM-only workaround now (Phase 3 below); flag the wrapper gap as a follow-up item, since fixing it site-wide for every addon is a separate, larger review |

(If no answer is given, this plan proceeds with the recommended SCORM-only workaround.)

---

## Audit findings

1. **Buttons already themed globally.** `.btn-primary/.btn-success/.btn-info/.btn-danger` are themed under `.gp-ds` regardless of container (`assets/design-system/gp-components-core.css:32-208`). The Preview/Update/Remove buttons in `scorm_curriculum.php:42,45,48` need no change.
2. **`#curriculum`-scoped alert theming exists, but only under `.gp-course-wizard`.** `assets/design-system/gp-admin-courses.css:1752-1787` themes `.alert`, `.alert-warning/info/success/danger`, `.alert-heading`, and `.alert p` — but every selector is `.gp-ds .gp-course-wizard :is(#assignment, …, .gp-addon-tab, #curriculum) …`. Admin's `course_edit.php:21` opens `<div class="gp-course-wizard">` around the whole tab set (closed at `:762`); **instructor's `course_edit.php` has no such element anywhere in the file** (grepped, zero matches) even though it does call `gp_ds_page_title()` at line 4 and is otherwise DS-active. This is a real, pre-existing asymmetry between the two roles, not specific to SCORM — see Open question 1.
3. **Correction to tracker item 4/5 — `gp_ds_alert()` cannot be used here.** The tracker (row 4, row 5) proposed replacing the raw `alert-success`/`alert-light` markup with `gp_ds_alert(...)`. Reading the actual partial (`application/views/components/design-system/alert.php:9-12`) shows `$body` is passed through `html_escape()` before being echoed inside a fixed `<div class="dot">…<p>{body}</p></div>` structure. The current instruction box's body contains literal `<br>` line breaks between four numbered steps, and the "current provider" box contains a `<strong>` tag — both would render as visible escaped tag text (`&lt;br&gt;`) if pushed through this helper. Using `gp_ds_alert()` would visibly break the page, not just re-theme it. **Fix instead:** keep the existing raw markup and (a) add the standard Bootstrap `alert-heading` class to the `<h5>` so it matches the CSS selector that already exists at `gp-admin-courses.css:1778-1783`, and (b) swap the `alert-light` class for `alert-info` (both `scorm_curriculum.php:21` and `:37`), which is already a covered tone (`gp-admin-courses.css:1760-1764`, and via the finding-2 workaround for the instructor page). No HTML structure changes, so the `<br>` steps and `<strong>` provider name keep rendering exactly as before.
4. **Correction to tracker item 3 — no new badge CSS/helper needed.** `assets/design-system/gp-admin-courses.css:1314-1319` already themes `.gp-courses-modal .badge-info` (a *different*, already-covered class from the `badge-info-lighten` currently used at `scorm_course_uploading_form.php:60`). Renaming `badge-info-lighten` → `badge-info` in the markup, combined with Phase 2's `.gp-courses-modal` wrap, covers it with zero new CSS. `badge-light` (used at `:58-59`) is *already* a covered class (`gp-admin-courses.css:1321-1326`) once the modal wrapper is added — no class change needed for those two.
5. **`.course-provider-logo` is SCORM-only.** Grepped `application/` — only `backend/admin/scorm_course_uploading_form.php` and `backend/user/scorm_course_uploading_form.php` reference this class. Its only CSS is the unscoped, hardcoded `assets/backend/css/main.css:338-366` (`rgb(0, 208, 79)` border, `#bcbcbc` shadow, no dark-mode value). Safe to leave `main.css` untouched and add a higher-specificity `.gp-ds`-scoped override in `gp-admin-courses.css` (2-class selector beats `main.css`'s 1-class selector regardless of load order — `main.css` loads first anyway per `application/views/backend/includes_top.php:17` vs `:50`).
6. **No PHP test runner exercises these views.** `composer.json` only lists `phpunit` as a dev dependency for the CodeIgniter core, with no test suite targeting `application/views/**`. This repo's actual verification convention for prior DS phases is ad-hoc Playwright `.mjs` scripts under `tmp/` (e.g. `tmp/p7/collapse.mjs`, using `storageState: 'tmp/auth/admin.json'` against `http://localhost/academy/...`) plus manual screenshots (`tmp/responsive-audit/*.png`). This plan's regression checks follow that same pattern rather than inventing a test framework the project doesn't have.
7. **Admin/instructor SCORM partials are near-duplicates.** `diff` confirms `scorm_curriculum.php` and `scorm_course_uploading_form.php` are byte-identical between `backend/admin/` and `backend/user/`; `preview_scorm_course.php` and `scorm_scripts.php` differ only in an unrelated fallback filename / quote-style, not in markup classes. Every markup fix below is applied to both copies identically.
8. **Prior-decision check.** `application/helpers/design_system_helper.php:4-13` documents a "Phase R8" mandate: "Existing pages are not rewritten just to comply" with the new DS helpers. This plan does not treat that as a blocker — the user explicitly requested this SCORM rework via `/legacy-ui-redesign` this session, which is deliberate scoped work, not an incidental "just to comply" rewrite. `gp-tokens.css:23-26` also flags `--gp-ink`/`--gp-text` as dark-mode-dead; none of the new rules below use them (only `--gp-success`, `--gp-info`, `--gp-fg*`, `--gp-shadow-card`, `--gp-surface-sunk`, `--gp-border`, `--gp-radius`, all of which carry dark-mode values per `gp-tokens.css:79-192`).
9. **Variant coverage table.**

| Variant | Currently themed? | Change needed |
| --- | --- | --- |
| Admin — course-type upload modal | No (`.custom-file`/`badge-info-lighten` uncovered) | Phase 2 |
| Instructor — course-type upload modal | No (same gap, identical markup) | Phase 2 |
| Admin — curriculum panel alerts | No (`h5` uncovered, `alert-light` uncovered) | Phase 3 |
| Instructor — curriculum panel alerts | No (same gap **plus** no `.gp-course-wizard` ancestor at all — finding 2) | Phase 3 (wizard-independent selector) |
| Admin/instructor — preview modal iframe | No surrounding theme | Phase 4 |
| Student — live SCORM player iframe | No surrounding theme | Phase 4 |
| Admin/instructor — provider-logo tiles | No (hardcoded, no dark value) | Phase 1 |
| Light mode | Must not regress | Covered by using existing token values already validated in light mode elsewhere |
| Dark mode | Currently broken/unthemed on every row above | Fixed by token-based rules that already carry `[data-theme="dark"]` values |

---

## Scope and constraints

### In scope
- `assets/design-system/gp-admin-courses.css` — new scoped rules only, nothing existing edited.
- `assets/design-system/gp-shell.css` — new scoped rule only.
- `application/views/backend/{admin,user}/scorm_course_uploading_form.php` — wrapper div + one class rename.
- `application/views/backend/{admin,user}/scorm_curriculum.php` — one class addition, one class rename.
- `application/views/backend/{admin,user}/preview_scorm_course.php` — wrapper div around the `<iframe>`.
- `application/views/lessons/scorm_course_content_body.php` — wrapper div around the `<iframe>`.

### Out of scope: do not change
- `application/controllers/addons/Scorm.php`, `application/models/addons/scorm_model.php` — no logic touched.
- `assets/backend/css/main.css` — left as-is; overridden via higher specificity elsewhere (finding 5).
- The instructor-wide `.gp-course-wizard` wrapper gap (finding 2) beyond the SCORM-only workaround — see Open question 1.
- The HTML rendered **inside** the SCORM iframe (third-party iSpring/Articulate/Captivate package output).
- `scorm_scripts.php`'s `NotificationApp.send(..., "rgba(0,0,0,0.2)", "error")` call — shared pattern used by every other addon.
- `course_add.php` / `course_edit.php` / `course_add_shortcut.php` course-type `<select>` — already themed via the site-wide Select2 skin.

### Non-negotiable safety constraints
- No controller/model/route/schema changes.
- No removed fields, buttons, dialogs, or JS hooks (`showAjaxModal`, `showLargeModal`, `confirm_modal`, `#scorm_iframe` id, form field `name`s).
- CSS stays scoped under `.gp-ds`; no global/unscoped selectors added.
- No new phrase keys invented; no `get_phrase()` call sites removed or added beyond what already exists (the pre-existing missing-`get_phrase()` bug on the two size badges at `scorm_course_uploading_form.php:58-59` is left exactly as-is — it's a content bug, not a theme bug, and fixing it is not part of this request).

### Acceptance cases

| Case | Actor | Screen | Required outcome |
| --- | --- | --- | --- |
| Provider tile hover/selected, light | Admin or instructor | Upload modal | Border/shadow render via `--gp-success` / `--gp-shadow-card`, matching other light-mode DS accents |
| Provider tile hover/selected, dark | Admin or instructor | Upload modal | Same tokens resolve to their dark-mode values (`gp-tokens.css:79-192`); no bright unthemed green/gray box |
| Upload modal file picker + size badges, both themes | Admin or instructor | Upload modal | `.custom-file`, `.badge-light`, `.badge-info` render via `.gp-courses-modal` rules in both themes |
| Curriculum instruction box heading, both themes | Admin or instructor | Curriculum panel, no SCORM uploaded yet | `<h5>` heading renders in `--gp-fg`, not default/inherited color |
| Curriculum "current provider" box, both themes | Admin or instructor | Curriculum panel, SCORM already uploaded | Renders with `--gp-info` tone, `<strong>` provider name still bold and visible |
| Preview modal / live player iframe surround, both themes | Admin, instructor, or student | Preview modal / lesson player | Wrapper background/border match `--gp-surface-sunk`/`--gp-border`; no plain-white flash in dark mode |
| Existing functionality | All | All SCORM screens | Upload, update, remove, preview still work; no JS console errors; no changed form field names/ids |

---

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `assets/design-system/gp-admin-courses.css` | Add 3 new rule blocks (provider-logo tokens, curriculum-alert wizard-independent fallback, `.gp-scorm-frame-wrap`) | Admin/instructor backend theming |
| `assets/design-system/gp-shell.css` | Add `.gp-scorm-frame-wrap` rule for the frontend lesson shell | Student-facing player theming |
| `application/views/backend/admin/scorm_course_uploading_form.php` | Wrap root markup in `.gp-courses-modal`; rename `badge-info-lighten` → `badge-info` | Admin upload modal |
| `application/views/backend/user/scorm_course_uploading_form.php` | Same as above | Instructor upload modal |
| `application/views/backend/admin/scorm_curriculum.php` | Add `alert-heading` to instruction `<h5>`; rename `alert-light` → `alert-info` | Admin curriculum panel |
| `application/views/backend/user/scorm_curriculum.php` | Same as above | Instructor curriculum panel |
| `application/views/backend/admin/preview_scorm_course.php` | Wrap `<iframe>` in `.gp-scorm-frame-wrap` | Admin preview modal |
| `application/views/backend/user/preview_scorm_course.php` | Wrap `<iframe>` in `.gp-scorm-frame-wrap` | Instructor preview modal |
| `application/views/lessons/scorm_course_content_body.php` | Wrap `<iframe>` in `.gp-scorm-frame-wrap` | Student live player |

---

## Phase 1: Provider-logo tiles — replace hardcoded colors with DS tokens

**Files:** `assets/design-system/gp-admin-courses.css`

### Task 1.1: Add the scoped override
- [ ] Append to the end of `gp-admin-courses.css`:
```css
/* SCORM provider-tile selection — replace leftover Hyper rgb(0,208,79)/#bcbcbc
   (assets/backend/css/main.css:357-366) with DS tokens; higher specificity
   than main.css's unscoped rule wins regardless of stylesheet load order. */
.gp-ds .course-provider-logo:hover,
.gp-ds .course-provider-logo-checked {
  border: 1px solid var(--gp-success);
  box-shadow: var(--gp-shadow-card);
}
```
- [ ] Regression check — run from repo root:
```powershell
node -e "const fs=require('fs'),assert=require('assert'); const css=fs.readFileSync('assets/design-system/gp-admin-courses.css','utf8'); assert.ok(css.includes('.gp-ds .course-provider-logo-checked') && css.includes('var(--gp-success)') && css.includes('var(--gp-shadow-card)'), 'provider-logo override must use DS tokens'); console.log('PASS: provider-logo tokens present');"
```
Expected: `PASS: provider-logo tokens present`.
- [ ] Manual check: open the upload modal (admin and instructor) on `http://localhost/academy/admin/course_form/course_edit/<a scorm course id>`, toggle `data-theme` light/dark, hover and click each of the 3 provider tiles — border/shadow should visibly shift with the theme, no bright green/gray flash in dark mode.

**Phase constraints:** `main.css` itself is not edited.

---

## Phase 2: Upload modal — wrap in `.gp-courses-modal`, fix the uncovered badge

**Files:** `application/views/backend/admin/scorm_course_uploading_form.php`, `application/views/backend/user/scorm_course_uploading_form.php` (identical change, both files)

### Task 2.1: Wrap the visual markup
- [ ] Change the opening `<div class="row">` (currently line 11) to:
```php
<div class="gp-courses-modal">
<div class="row">
```
- [ ] Change the closing `</div>` that currently ends the outer row (currently line 76, immediately before the blank line and `<script type="text/javascript">`) to:
```php
</div>
</div>
```
  (the `<script>` block stays outside the new wrapper, matching `lesson_add.php:80-82`)
- [ ] In the same file, rename the third badge's class from `badge-info-lighten` to `badge-info` (currently line 60):
```php
<small class="badge badge-info"><?php echo '"post_max_size" '.get_phrase("has_to_be_bigger_than").' "upload_max_filesize"'; ?></small>
```
  (the two `badge-light` badges on the preceding lines are unchanged — already covered once wrapped)

### Task 2.2: Regression check
```powershell
node -e "const fs=require('fs'),assert=require('assert'); for (const f of ['application/views/backend/admin/scorm_course_uploading_form.php','application/views/backend/user/scorm_course_uploading_form.php']) { const s=fs.readFileSync(f,'utf8'); assert.ok(/<div class=\"gp-courses-modal\">\s*<div class=\"row\">/.test(s), f+': missing gp-courses-modal wrap'); assert.ok(!s.includes('badge-info-lighten'), f+': badge-info-lighten still present'); assert.ok(s.includes('badge badge-info\"'), f+': badge-info rename missing'); } console.log('PASS: upload form modal wrap + badge rename');"
```
Expected: `PASS: upload form modal wrap + badge rename`.

### Task 2.3: Syntax and whitespace check
```powershell
php -l application\views\backend\admin\scorm_course_uploading_form.php
php -l application\views\backend\user\scorm_course_uploading_form.php
git diff --check -- application/views/backend/admin/scorm_course_uploading_form.php application/views/backend/user/scorm_course_uploading_form.php
```
Expected: both report no syntax errors; `git diff --check` prints nothing.

- [ ] Manual check: open the upload modal in both themes (admin and instructor) — file-picker button and both size badges should match the DS modal skin, not raw white Bootstrap defaults, in dark mode.

**Phase constraints:** form field `name`/`id` attributes (`scorm_zip`, `scorm_provider`, radio ids) are untouched; `onchange`/`onclick` hooks untouched.

---

## Phase 3: Curriculum panel — fix the alert heading and uncovered `alert-light` tone

**Files:** `application/views/backend/admin/scorm_curriculum.php`, `application/views/backend/user/scorm_curriculum.php`; `assets/design-system/gp-admin-courses.css`

### Task 3.1: Add the wizard-independent CSS fallback (fixes finding 2 for SCORM only)
- [ ] Append to `gp-admin-courses.css`:
```css
/* SCORM curriculum-panel alerts — instructor course_edit.php has no
   .gp-course-wizard ancestor (unlike admin's, course_edit.php:21/:762), so the
   existing .gp-course-wizard :is(#curriculum, ...) rules (line ~1752) never
   match there. This duplicate, wizard-independent rule covers #curriculum on
   both admin and instructor pages; on admin it's redundant with the existing
   rule (same values, higher-specificity original still wins, no conflict). */
.gp-ds #curriculum .alert-success {
  background: var(--gp-success-soft);
  border-color: var(--gp-success-border);
  color: var(--gp-success);
}
.gp-ds #curriculum .alert-info {
  background: var(--gp-info-soft);
  border-color: var(--gp-info-border);
  color: var(--gp-info);
}
.gp-ds #curriculum .alert-heading {
  font-family: var(--gp-font-head);
  font-weight: 800;
  color: var(--gp-fg);
}
.gp-ds #curriculum .alert p {
  color: var(--gp-fg-muted);
}
```

### Task 3.2: Fix the markup in both `scorm_curriculum.php` files
- [ ] Change the instruction heading (currently line 21) from:
```php
<h5 class="text-center"><?php echo get_phrase('instruction'); ?></h5>
```
  to:
```php
<h5 class="text-center alert-heading"><?php echo get_phrase('instruction'); ?></h5>
```
- [ ] Change the "current provider" box (currently line 37) from:
```php
<div class="alert alert-light text-center" role="alert">
```
  to:
```php
<div class="alert alert-info text-center" role="alert">
```

### Task 3.3: Regression check
```powershell
node -e "const fs=require('fs'),assert=require('assert'); const css=fs.readFileSync('assets/design-system/gp-admin-courses.css','utf8'); assert.ok(css.includes('.gp-ds #curriculum .alert-heading') && css.includes('.gp-ds #curriculum .alert-info'), 'wizard-independent curriculum alert rules missing'); for (const f of ['application/views/backend/admin/scorm_curriculum.php','application/views/backend/user/scorm_curriculum.php']) { const s=fs.readFileSync(f,'utf8'); assert.ok(s.includes('text-center alert-heading'), f+': alert-heading class missing on h5'); assert.ok(!s.includes('alert-light'), f+': alert-light still present'); assert.ok(s.includes('alert alert-info text-center'), f+': alert-info rename missing'); } console.log('PASS: curriculum panel alert fixes');"
```
Expected: `PASS: curriculum panel alert fixes`.

### Task 3.4: Syntax check
```powershell
php -l application\views\backend\admin\scorm_curriculum.php
php -l application\views\backend\user\scorm_curriculum.php
git diff --check -- application/views/backend/admin/scorm_curriculum.php application/views/backend/user/scorm_curriculum.php assets/design-system/gp-admin-courses.css
```
Expected: no syntax errors, no whitespace errors.

- [ ] Manual check: on the **instructor** course-edit page specifically (the page missing `.gp-course-wizard`), open a SCORM course's curriculum tab in both themes and confirm the instruction heading and "current provider" box are themed — this is the case that would silently fail without Task 3.1.

**Phase constraints:** `<strong>` provider name and the numbered `<br>`-separated steps keep their exact current HTML (per audit finding 3, not routed through `gp_ds_alert()`).

---

## Phase 4: Themed container around the SCORM iframe (preview + live player)

**Files:** `application/views/backend/admin/preview_scorm_course.php`, `application/views/backend/user/preview_scorm_course.php`, `application/views/lessons/scorm_course_content_body.php`; `assets/design-system/gp-admin-courses.css`, `assets/design-system/gp-shell.css`

### Task 4.1: Add the wrapper CSS (admin/instructor context)
- [ ] Append to `gp-admin-courses.css`:
```css
/* SCORM preview/player iframe surround — avoid a plain-white gutter/flash
   around the third-party iframe content in dark mode. */
.gp-ds .gp-scorm-frame-wrap {
  display: block;
  background: var(--gp-surface-sunk);
  border: 1px solid var(--gp-border);
  border-radius: var(--gp-radius);
  overflow: hidden;
}
.gp-ds .gp-scorm-frame-wrap iframe {
  display: block;
  border: 0;
}
```

### Task 4.2: Add the same wrapper CSS to the frontend lesson shell
- [ ] Append to `gp-shell.css` (same rule, independent stylesheet loaded on the frontend lesson page per `application/views/lessons/includes_top.php:36`):
```css
.gp-ds .gp-scorm-frame-wrap {
  display: block;
  background: var(--gp-surface-sunk);
  border: 1px solid var(--gp-border);
  border-radius: var(--gp-radius);
  overflow: hidden;
}
.gp-ds .gp-scorm-frame-wrap iframe {
  display: block;
  border: 0;
}
```

### Task 4.3: Wrap the `<iframe>` in all 3 view files
- [ ] In `backend/admin/preview_scorm_course.php`, `backend/user/preview_scorm_course.php`, and `lessons/scorm_course_content_body.php`, change:
```php
<iframe sandbox="allow-scripts allow-forms allow-pointer-lock allow-same-origin" id="scorm_iframe" frameBorder="0" src="<?= base_url($scorm_course_content_url); ?>" width="100%" title="Scorm course"></iframe>
```
  to:
```php
<div class="gp-scorm-frame-wrap">
<iframe sandbox="allow-scripts allow-forms allow-pointer-lock allow-same-origin" id="scorm_iframe" frameBorder="0" src="<?= base_url($scorm_course_content_url); ?>" width="100%" title="Scorm course"></iframe>
</div>
```
  (the `id="scorm_iframe"` stays unchanged — the existing resize script in the same file selects it by id, unaffected by the new wrapper)

### Task 4.4: Regression check
```powershell
node -e "const fs=require('fs'),assert=require('assert'); const a=fs.readFileSync('assets/design-system/gp-admin-courses.css','utf8'); const s=fs.readFileSync('assets/design-system/gp-shell.css','utf8'); assert.ok(a.includes('.gp-ds .gp-scorm-frame-wrap'), 'admin-courses.css missing frame wrap'); assert.ok(s.includes('.gp-ds .gp-scorm-frame-wrap'), 'gp-shell.css missing frame wrap'); for (const f of ['application/views/backend/admin/preview_scorm_course.php','application/views/backend/user/preview_scorm_course.php','application/views/lessons/scorm_course_content_body.php']) { const v=fs.readFileSync(f,'utf8'); assert.ok(/<div class=\"gp-scorm-frame-wrap\">\s*<iframe[^>]*id=\"scorm_iframe\"/.test(v), f+': iframe not wrapped'); } console.log('PASS: scorm iframe wrapper');"
```
Expected: `PASS: scorm iframe wrapper`.

### Task 4.5: Syntax check
```powershell
php -l application\views\backend\admin\preview_scorm_course.php
php -l application\views\backend\user\preview_scorm_course.php
php -l application\views\lessons\scorm_course_content_body.php
git diff --check -- application/views/backend/admin/preview_scorm_course.php application/views/backend/user/preview_scorm_course.php application/views/lessons/scorm_course_content_body.php assets/design-system/gp-shell.css assets/design-system/gp-admin-courses.css
```
Expected: no syntax errors, no whitespace errors.

- [ ] Manual check: open the preview modal (admin + instructor) and an actual SCORM lesson as a student, in both themes. Confirm the `#scorm_iframe` resize script (`width/2` height calc) still runs without console errors and the iframe still fills its previous width — only the surrounding gutter should look different.

**Phase constraints:** SCORM package HTML rendered inside the iframe is untouched; `sandbox`, `title`, and the resize `<script>` are untouched.

---

## Phase last: Regression verification and rollout

- [ ] Run every regression check from Phases 1–4 in sequence (all should print `PASS: ...`).
- [ ] Run `php -l` over all 9 touched files (commands listed above) — all must report no syntax errors.
- [ ] Run `git diff --check` over the full changed-file set — must print nothing.
- [ ] Manual light/dark walkthrough (following this project's existing `tmp/*.mjs` Playwright convention — e.g. modeled on `tmp/p7/collapse.mjs`'s `storageState`/`chromium.launch()` pattern): for both an admin session and an instructor session, visit a SCORM course's edit page, open the upload modal, open the preview modal, and (as a student) open a SCORM lesson. Toggle `data-theme` via the existing `gp-theme-boot.js` / theme buttons at each screen and screenshot both states.
- [ ] Smoke-test table:

| Role | Screen | Light | Dark |
| --- | --- | --- | --- |
| Admin | Upload modal | ☐ | ☐ |
| Admin | Curriculum panel (no SCORM yet) | ☐ | ☐ |
| Admin | Curriculum panel (SCORM uploaded) | ☐ | ☐ |
| Admin | Preview modal | ☐ | ☐ |
| Instructor | Upload modal | ☐ | ☐ |
| Instructor | Curriculum panel (no SCORM yet) | ☐ | ☐ |
| Instructor | Curriculum panel (SCORM uploaded) | ☐ | ☐ |
| Instructor | Preview modal | ☐ | ☐ |
| Student | Live SCORM lesson player | ☐ | ☐ |

- [ ] Confirm no functional regression: upload a SCORM zip, update it, remove it, and preview it once each (admin and instructor), exactly as before this change.

---

## Rollback

1. `git revert` the commit(s) from this plan — every change is additive CSS plus small class/wrapper edits, safe to revert as a unit.
2. No migration, no stored data — nothing written during rollout needs cleanup.
3. If only one phase needs rolling back (e.g. Phase 4's iframe wrapper causes an unexpected layout shift), revert just that phase's file changes; the other phases are independent (different files, no shared state).

## Commit

```powershell
git add assets/design-system/gp-admin-courses.css assets/design-system/gp-shell.css application/views/backend/admin/scorm_course_uploading_form.php application/views/backend/user/scorm_course_uploading_form.php application/views/backend/admin/scorm_curriculum.php application/views/backend/user/scorm_curriculum.php application/views/backend/admin/preview_scorm_course.php application/views/backend/user/preview_scorm_course.php application/views/lessons/scorm_course_content_body.php
git commit -m "fix: align SCORM add-on screens with the design system in light and dark mode"
```

## Self-review

1. **Contradictions:** None found — "In scope" lists exactly the 9 files also listed in the Files table and touched across Phases 1–4; "Out of scope" items (controllers, `main.css`, iframe-internal content) are never referenced as targets in any phase.
2. **Goal reachability, existing + future:** Existing SCORM courses (provider already uploaded) are covered by the "current provider" alert-info fix and the preview-modal wrapper; future uploads go through the same `scorm_course_uploading_form.php` markup, so no separate "new record" path exists to miss — CodeIgniter renders this view fresh on every request, there's no cached/stored copy of the markup to go stale.
3. **Bypass:** The only other way to reach these screens is directly hitting `modal/popup/scorm_course_uploading_form/<id>` or `modal/popup/preview_scorm_course/<id>` — both render the exact same view files this plan edits, so there's no alternate rendering path that skips the fix.
4. **Existence:** Every file path, line number, class name, and CSS selector cited above was read directly from the repository this session (see Audit findings 1–7 for citations); `gp_ds_alert`/`gp_ds_badge` signatures were read from `application/views/components/design-system/{alert,badge}.php` before being ruled out for Phase 3, not assumed.
5. **Consistency:** Files table (9 rows) matches the files touched across Phases 1–4 and the final `git add` list exactly.
6. **Duplication:** Phase 3's `#curriculum`-scoped rule duplicates values already present in the `.gp-course-wizard`-scoped rule for the admin case — this is a deliberate, documented duplication (finding 2) to cover the instructor page, not an accidental second source of truth; both rules use identical token values so they can never visually disagree.
7. **Placeholders:** None left — every code block is literal, every file path and line number is concrete.

**Audit-checklist sections not applicable:** B (writers/readers), C (live data), D (authorization) — this change touches no database column, no RLS/permission logic, and no data write path; it is CSS/markup-only restyling of existing screens. G (test runner/lint) was applied and found there is no PHP test suite for views in this repo (finding 6); the plan substitutes the project's actual established Playwright/`php -l`/`git diff --check` verification convention instead of inventing one.
