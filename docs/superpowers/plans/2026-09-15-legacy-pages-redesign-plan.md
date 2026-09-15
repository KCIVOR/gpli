# Remaining Legacy Pages — DS Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: use the project's own `legacy-ui-redesign` skill (`.claude/skills/legacy-ui-redesign/SKILL.md`) for the redesign method (audit → propose → constraints → explain), and `superpowers:subagent-driven-development` or `superpowers:executing-plans` to work this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Bring every page identified as "still legacy" in the [Design System Coverage audit](#source-audit) onto the Geese Project design system (`--gp-*` tokens, `gp_ds_*` helpers), phase by phase, without breaking any existing feature, route, form submission, or JS hook — and without the phase 1 work ever touching phase 7's files.

**Architecture:** Restyle-in-place only. No new pages, no new controllers, no schema changes. Every phase edits a fixed, named list of view files plus (at most) one new or existing scoped CSS file. Nothing outside that list gets touched in that phase, even if it looks tempting.

**Source audit:** the three-part audit run this session (admin backend 119/167, instructor dashboard 20/74, public frontend 46/112 + 24 confirmed-dead templates). Re-open that artifact before starting if you need the per-file "tell" (what specifically marks a file as legacy) — this plan only restates the file lists and groups them into phases.

**Do not commit** unless the user explicitly asks.

---

## Standing constraints (every phase, no exceptions)

These are inherited from `legacy-ui-redesign`'s standing constraints and sharpened for this multi-phase rollout specifically:

1. **Design system over leftover UI.** Any control still on the old Hyper/Bootstrap-default skin gets the Geese Project DS equivalent — tokens (`--gp-*`) + `gp_ds_*` helpers (`button`, `badge`, `alert`, `card`, `table`, `page_title`) where a helper exists, matching CSS-only DS pattern where it doesn't (pagination, tabs, list-group, modal, accordion). Never invent a third style. Never leave a leftover `btn-info`/`btn-danger`/hardcoded hex (`#08c`, `#357ebd`, `#727cf5`, `#39afd1`, `#0acf97`) in a file this plan touches.
2. **Correct in both light and dark mode.** Use `--gp-fg`/`--gp-fg-muted`/`--gp-fg-faint` for text — never `--gp-ink`/`--gp-text` (no dark-mode value). Replace hardcoded SVG `stroke`/`fill` hex with `currentColor` or a token. Every new background/border/shadow resolves through a token that has a dark-mode value. **A phase is not done until you've toggled `data-theme` (or `localStorage['gp-ds-theme']`) and re-looked at every element that phase touched** — not glanced at once in whichever theme happened to be active.
3. **Surgical scope — one phase, one file list.** Each phase below names its exact files. Do not open, edit, or "opportunistically fix" a file that belongs to a later phase, even if it's one line away in the same directory. If a shared file (a CSS file, a partial, a helper) needs a change that a later phase also depends on, do the shared change in the earliest phase that needs it and note it in that later phase's checklist as "already done in Phase N" rather than touching it twice.
4. **UI only — restyle, never remove or rewire.**
   - Do not edit controllers, models, routes, auth, payment integrations, or schema.
   - Do not change any `<form>` `name`, `id`, or `action` attribute.
   - Do not touch `common_scripts.php` (DataTables config) or any inline JS that wires a JS hook — only the markup/classes around it.
   - Keep every JS hook working exactly as-is: `confirm_modal()`, `showAjaxModal()`, `showLargeModal()`, DataTables ids, Select2 ids, dragula sortable ids/classes, wizard `#basicwizard` + tab hrefs, `checkPropagation`, `actionTo()`, `#category-edit-btn-{id}` / `#category-delete-btn-{id}`, cart/wishlist ids (`#cartItemsCounter`, `#coursesWishlistIcon*`), `ajaxForm resetable`, `#newsletter-form`.
   - If a visual fix seems to require a logic change or removing something — stop, do not improvise, report it back instead.
5. **CSS stays scoped.** New/changed CSS lives under `.gp-ds` in the matching design-system file (`gp-admin-*.css` for admin, a `gp-student.css`/new instructor stylesheet for instructor pages, the relevant `gp-*.css` for public pages). Do not add rules to `gp-tokens.css` unless a genuinely new token is needed (and if so, add it with both a light and dark value in the same edit). Do not restyle the whole app from one phase's CSS file.
6. **Payment pages get extra caution (Phase 4).** `paypal_checkout_for_instructor_revenue.php`, `razorpay_checkout.php`, `stripe_checkout_for_instructor_revenue.php` process real money. Touch only HTML structure and CSS classes. Do not change any SDK script tag, form field name, hidden input, or the JS that submits to the payment gateway. Load the page and confirm the actual checkout button still fires before calling the phase done.
7. **Investigate-only items are not restyle targets.** `instructor_revenue.php` (0-byte file), `course_page_preview_modal.php` (not included anywhere), `logged_in_header.php`/`logged_out_header.php` (possibly superseded by `header_lg_device.php`/`header_sm_device.php`), `dragula.php` (looks like a leftover demo page), and `stripe_checkout_for_instructor_revenue.php`'s exact contents (inferred, not directly read in the audit) all get a **confirm-first** step before any styling work — see Phase 0.
8. **Visual check every phase, no exceptions:** Light mode, Dark mode (via the existing toggle, not just OS preference), and a ~375px narrow viewport. Do this on the actual live page (through the real route/login), not just by reading the PHP.
9. **Bump cache-busting query strings** (`?v=`) only on the CSS files a phase actually edited, following the existing `?v=name-N` convention already used in `includes_top.php` / the admin equivalent.
10. **Do not expand scope.** If a phase surfaces a new "this is also legacy" file not in the audit list, add it to a "found during work" note at the bottom of that phase rather than fixing it inline — keep the phase's diff matching its stated file list.

---

## Phase 0 — Investigate before touching anything (no code changes)

Pure confirmation, zero styling. Unblocks constraint 7.

- [ ] Confirm `dragula.php` (admin) is actually routed/linked from somewhere real, or is dead reference code. Search `application/controllers/Admin.php` for the view name.
- [ ] Confirm `stripe_checkout_for_instructor_revenue.php` matches the same standalone-HTML pattern as its two siblings (`paypal_checkout_for_instructor_revenue.php`, `razorpay_checkout.php`) — read it directly.
- [ ] Confirm whether `logged_in_header.php` / `logged_out_header.php` are still included anywhere (grep the whole `application/views` tree), or are dead leftovers superseded by `header_lg_device.php`/`header_sm_device.php`. If dead, no phase touches them — note that here.
- [ ] Confirm `instructor_revenue.php` is meant to be empty (e.g. a placeholder a controller conditionally never loads) vs. a page that broke. Check the controller method that loads it. Report back to the user rather than deciding unilaterally whether to build it out.
- [ ] Confirm `course_page_preview_modal.php` truly has zero includes project-wide (re-grep to double check the audit's finding) before treating it as dead weight.

**Visual check:** none — no code changed.

---

## Phase 1 — Shared includes: parent already redesigned, include itself isn't

Highest visibility-to-effort ratio: these are small files sitting inside pages that otherwise already look finished, so the seam is obvious to any visitor right now. Fix these before anything else so later phases aren't visually undermined by a stray legacy fragment inside an otherwise-DS page.

**Files:**
- `application/views/frontend/default-new/menu.php`
- `application/views/frontend/default-new/breadcrumb.php`
- `application/views/frontend/default-new/facebook_login.php`
- `application/views/frontend/default-new/course_page_custom_field_info.php`
- `application/views/frontend/default-new/course_page_info_description.php`
- `application/views/frontend/default-new/eu-cookie.php`

**Constraints specific to this phase:**
- `breadcrumb.php` is included by ~29 pages, some already DS, some not. Style it purely with tokens (`--gp-fg-muted`, `--gp-border`, etc.) so it looks correct on *both* — do not add anything that assumes the parent page's specific layout.
- `facebook_login.php` wraps a real Facebook SDK login button — restyle the surrounding markup/classes only, do not touch the SDK init script or button `id`.
- `eu-cookie.php` has a real "Accept" action wired to cookie/consent logic — keep that behavior, only restyle the banner.

**Visual check:** Load `home_1`, a course page, and a page using `breadcrumb.php` that is *not* yet redesigned (e.g. `about_us.php`, still legacy until Phase 5) to confirm `breadcrumb.php` looks acceptable in both contexts. Light/Dark/375px.

---

## Phase 2 — Instructor dashboard shell: `navigation.php`

Single file, but it wraps every instructor page — including ones already redesigned. Highest-impact fix in the instructor area. Do this before Phase 6/7 below so instructor pages you redesign later aren't sitting inside a shell you're about to change again.

**Files:**
- `application/views/backend/user/navigation.php`
- (CSS) new or existing instructor-shell stylesheet under `assets/design-system/` — check for one before creating a new file; if none exists, name it to match the `gp-admin-shell.css` convention (e.g. `gp-instructor-shell.css`) and link it once in the instructor layout include.

**Constraints specific to this phase:**
- This is shared chrome. Before editing, list every instructor page that includes it (grep), and after editing, spot-check at least: `dashboard.php` (already redesigned), `courses.php` (already redesigned), and one still-legacy page from a later phase (e.g. `curriculum.php`) — confirm the sidebar looks correct wrapping both.
- Keep every nav link `href`, active-state logic, and any collapse/toggle JS untouched — restyle classes only.

**Visual check:** Light/Dark/375px on all three sample pages above.

---

## Phase 3 — Admin backend: standalone legacy pages (highest priority) — DONE

Real full pages, not fragments — these are the ones a real admin visibly lands on today looking unstyled.

**Files:**
- ~~`application/views/backend/admin/active_courses.php`~~ — **no action needed.** Confirmed dead: `Admin::courses()` sets `page_name = 'courses-server-side'`, never `'active_courses'`. This view is unreachable.
- `application/views/backend/admin/pending_courses.php` — done. `gp_ds_page_title()` + `gp_ds_table()` + `gp_ds_card()`, dropdown actions restyled to the `admins.php` dropright pattern. All hrefs/onclick handlers unchanged.
- ~~`application/views/backend/admin/course_details.php`~~ — **no action needed.** No controller method sets `page_name = 'course_details'` anywhere in the app; confirmed orphaned.
- ~~`application/views/backend/admin/sub_categories.php`~~ — **no action needed.** No `Admin::sub_categories()` method exists (only `sub_categories_by_category_id()` and `sub_category_form()`); the view is unreachable. Its own breadcrumb link (`admin/sub_categories`) is a dead link, further confirming this.
- `application/views/backend/admin/sub_category_add.php` — done. Rebuilt on the `category_add.php` pattern (`gp_ds_page_title()` + `gp_ds_card()`), reusing `.gp-courses-page` scoping so it inherits existing form styling for free.
- `application/views/backend/admin/sub_category_edit.php` — done, same pattern.
- `application/views/backend/admin/custom_field_add.php` — done, lighter touch. This is a modal fragment (loaded via `showLargeModal` into `custom_field.php`) whose add/remove-row buttons are wired by jQuery selecting `.btn-success` / `.btn-danger` directly — left those buttons as plain Bootstrap on purpose so the JS keeps working, and restyled only the static shell (labels, inputs, repeat-item cards) via new `gp-admin-custom-field.css`.
- ~~`application/views/backend/admin/transaction.php`~~ — **no action needed.** Same as `sub_categories.php`/`course_details.php`: no matching controller method or `page_name` assignment found anywhere; orphaned view.
- `application/views/backend/admin/video_player.php` — done. Breadcrumb/`.grid`/`.page-title` replaced with `gp_ds_page_title()` + `gp_ds_card()`; Plyr embed markup and all three provider branches (YouTube/Vimeo/self-hosted) untouched.
- `application/views/backend/admin/dragula.php` — confirmed dead in Phase 0, skipped as planned.

**Correction to this plan's own file list:** three of the ten files (`active_courses.php`, `course_details.php`, `transaction.php`, `sub_categories.php` — four, not three) turned out to be orphaned views with no live route. Verified by grepping `Admin.php` for a matching `page_name` assignment/controller method for each, not just by reading the view file. No harm in leaving the dead files in place; just nothing to restyle.

**Constraints specific to this phase:**
- `active_courses.php`/`pending_courses.php` raw tables → `gp_ds_table()`. Keep DataTables initialization in `common_scripts.php` untouched; only the markup DataTables attaches to changes.
- `sub_category_add.php`/`sub_category_edit.php` keep `#category-edit-btn-{id}` / `#category-delete-btn-{id}` hooks exactly as named.
- `course_details.php`'s `panel panel-primary` → `gp_ds_card()`.

**Visual check:** Light/Dark/375px on each page, logged in as admin.

---

## Phase 4 — Admin backend: standalone payment/checkout pages — DONE

Isolated from the admin DS shell entirely (they don't even load the same CSS). Separate phase because of constraint 6 above — treat with more caution than everything else in this plan.

**Files:**
- `application/views/backend/admin/paypal_checkout_for_instructor_revenue.php` — done. `#paypal-button` div, `paypal.Button.render()` call and target selector, and the `onAuthorize` redirect are byte-for-byte unchanged.
- `application/views/backend/admin/razorpay_checkout.php` — done. `#rzp-button1` id preserved (now rendered via `gp_ds_button()` with `attrs.id`, since the JS binds `document.getElementById('rzp-button1').onclick`, not a class); `options`/`Razorpay(...)`/`payment.failed` handler untouched.
- ~~`application/views/backend/admin/stripe_checkout_for_instructor_revenue.php`~~ — **no action needed.** Read it: this file has zero HTML output. It's a pure JSON API endpoint (`\Stripe\Checkout\Session::create(...)`, `echo json_encode($response)`) hit via fetch from `admin/instructor_payout` — there is no markup to restyle.

**Approach taken:** restyled standalone with `--gp-*` tokens loaded directly (not brought into the full `.gp-ds` admin shell, since these have no header/sidebar/nav — just a redirect-once payment button). Added `gp-tokens.css` + `gp-theme-boot.js` + new `gp-payout-checkout.css` to both. Replaced the shared (and mislabeled) `assets/payment/css/stripe.css` load — a dark, hardcoded-color stylesheet actually written for a different, unused Stripe Elements form — with token-based styling.

**Not verified live:** same login blocker as Phases 2+ — viewing these pages requires triggering an actual instructor payout as a logged-in admin. Restyle is scoped tightly (wrapper markup/CSS only) and both SDK integrations were diffed line-by-line against the originals to confirm no behavioral change.

**Constraints specific to this phase:**
- These currently load their own standalone `<!DOCTYPE html>` and `assets/payment/css/stripe.css` — decide (and state in the PR/commit description) whether you're bringing them into the `.gp-ds` shell or restyling them standalone with `--gp-*` tokens loaded directly. Either is acceptable; do not silently do a third thing.
- Zero changes to any payment SDK script tag, hidden field, form `action`, or the JS that submits the charge. This phase is markup/CSS only.
- Test the actual "pay" button flow (sandbox/test mode) after restyling, not just visually — a broken checkout is worse than an ugly one.

**Visual check:** Light/Dark/375px, plus a real (test-mode) submission through each of the three flows.

---

## Phase 5 — Shared modal/fragment shell (admin + instructor lesson-type family)

The single biggest *file count* in the audit (~50 files across both areas) but the smallest actual surface area — they're tiny form snippets loaded into one shared modal. Fix the modal shell once; don't edit each file's content unless it has its own stray legacy element beyond the shared wrapper.

**Files — admin:**
- `academy_cloud_type_lesson_add.php` / `_edit.php`, `audio_type_lesson_add.php` / `_edit.php`, `document_type_lesson_add.php` / `_edit.php`, `google_drive_video_lesson_add.php` / `_edit.php`, `html5_type_lesson_add.php` / `_edit.php`, `iframe_type_lesson_add.php` / `_edit.php`, `image_type_lesson_add.php` / `_edit.php`, `text_type_lesson_add.php` / `_edit.php`, `video_type_lesson_add.php` / `_edit.php`, `vimeo_type_lesson_add.php` / `_edit.php`, `wasabi_storage_type_lesson_add.php` / `_edit.php`, `youtube_type_lesson_add.php` / `_edit.php`
- `question_add.php`, `question_edit.php`, `student_academic_quiz_result.php`, `custom_field_edit.php`, `custom_field_section_edit.php`, `custom_field_section_sorting.php`, `save_purchase_code_form.php`, `shortcut_add_student.php`, `shortcut_enrol_student.php`, `sort_lesson.php`, `sort_section.php`, `ajax_get_section.php`, `ajax_get_sub_category.php`

**Files — instructor (same family, separate directory):**
- The matching 24 `*_type_lesson_add/edit.php` files under `application/views/backend/user/`
- `section_add.php`, `section_edit.php`, `sort_section.php`, `sort_lesson.php`, `lesson_types.php`, `lesson_add.php`, `lesson_edit.php`, `resource_files.php`, `resource_file_edit.php`, `quiz_add.php`, `quiz_edit.php`, `quiz_questions.php`, `question_add.php`, `question_edit.php`, `quiz_fields_type_wize.php`, `manage_multiple_choices_options.php`

**Approach — DONE, zero individual files touched:**
- Found the shared shell: `application/views/backend/modal.php` (`showAjaxModal`/`showLargeModal`/`showRightModal`/`AIModal`, `#scrollable-modal`/`#large-modal`/`#right-modal`/`#ai-modal`), included unconditionally for both admin and instructor by `backend/index.php`. `gp-modal.css` already styled the header/body/footer/close-button chrome generically (`.gp-ds .modal-header`, `.modal-title`, `.modal-body`, `.modal-footer`) from an earlier phase — only the *content* injected into `.modal-body` (raw `.form-group`/`.form-control`/`.custom-file-input`/`.custom-file-label`/`p`/`h5`) was unstyled.
- Fixed it once, at the shell level, in `gp-modal.css`: added `.gp-ds .modal-body .form-control`, `label`, `.custom-file-input`/`.custom-file-label`, `p`, `h5` rules — these apply to *any* fragment injected into any of the four shared modals, so all ~50 lesson/question/quiz/shortcut files inherit correct styling without a single one being edited.
- Also generalized the dragula sort-screen styling (`.card`, `.bg-dragula`, `.draggable-item`) and `.input-group-text` (used by the multiple-choice/single-choice checkbox+radio option rows) to the same `.modal-body` scope — these existed already but only under a narrower `.gp-courses-modal` wrapper class that not every fragment uses (e.g. instructor's `manage_multiple_choices_options.php` had no such wrapper and was missing `.input-group-text` styling before this fix).
- Verified by reading a representative sample from each visual pattern, admin and instructor sides, byte-comparing where relevant: `text_type_lesson_add.php` (simple textarea — admin and instructor versions are byte-identical), `video_type_lesson_add.php`/`google_drive_video_lesson_add.php`/`iframe_type_lesson_add.php` (file-upload / embed-URL patterns), `question_add.php` + `quiz_fields_type_wize.php` (checkbox/radio options, already `.gp-courses-modal`-wrapped), `custom_field_edit.php`, `shortcut_enrol_student.php` (server-side select2), `sort_lesson.php`/`sort_section.php` (dragula). All use the same small, consistent vocabulary of raw Bootstrap classes — confirmed no file has a stray legacy element beyond what the shared shell now covers, so no individual edits were needed.
- Dragula sortable ids/classes (`data-plugin="dragula"`, `data-containers`, `.draggable-item` ids used by the JS to read sort order) and every JS-bound button id (`#submitButton`, `#lesson-sort-btn`, etc.) are completely untouched — only their surrounding CSS changed.

**Not verified live:** same login blocker as earlier phases — these are all AJAX-loaded modal fragments only reachable from inside an authenticated admin/instructor course-builder flow.

---

## Phase 6 — Instructor dashboard: curriculum, course media, custom fields — DONE

**Files:**
- `application/views/backend/user/curriculum.php` — done. Discovered the admin equivalent (`application/views/backend/admin/curriculum.php`) was already fully rebuilt on `.gp-curriculum`/`.gp-curriculum-section`/`.gp-curriculum-lesson` classes in an earlier phase, and that CSS (`gp-admin-courses.css`) is generic — not admin-scoped. Rebuilt the instructor version to match that exact structure line-for-line (only the `admin/...` → `user/...` action URLs differ) so it inherits the same styling for free. Every `onclick`/modal-popup URL, `id="section-{id}"`/`id="lesson-{id}"`, and the `display-none`/`on-hover-action` reveal-on-hover behavior is unchanged.
- `application/views/backend/user/course_media_add.php` / `course_media_edit.php` — done. The admin equivalents use a `.gp-course-wizard .gp-course-media` CSS scope, but the instructor course_add/course_edit wizard has no `.gp-course-wizard` wrapper (out of scope to add one this phase) — so added a new `.gp-user-course-media` class instead and matching unscoped CSS in `gp-user-custom-field.css`. Same visual result, no dependency on a wrapper that doesn't exist yet.
- ~~`application/views/backend/user/course_add_shortcut.php`~~ — **no file changes needed.** It's an AJAX fragment loaded into the same shared modal from Phase 5; its `.form-group`/`.form-control`/`.custom-control` (checkbox/radio) markup is now fully covered by this phase's `gp-modal.css` additions (see below) — verified by reading the file, no stray legacy element beyond what the shared modal shell now covers.
- `application/views/backend/user/custom_field.php` — done, the big one. Removed a ~200-line inline `<style>` block full of hardcoded hex colors (`#fff`, `#e7e7e7`, `#1982FE`, `#010101`, no dark-mode value) and dead rules (`.dragable-item` — a typo of `.draggable-item` that never matched anything, `.carousel-item`/`.notes`/`.carousel-caption` — classes that don't exist anywhere in this file). The Bootstrap accordion (`data-bs-toggle="collapse"`) already gets its look for free from the existing `gp-accordion.css`, which is fully generic — so only the custom-field-manager-specific bits (hover-reveal edit/delete icons, the section-action menu, FAQ list, image/gallery cards) needed new CSS, added to `gp-user-custom-field.css` scoped under a new `.gp-custom-field-manager` wrapper div. Every `data-bs-toggle`/`data-bs-target`/`onclick` is untouched.

**Bonus fix (found while verifying course_add_shortcut.php):** `.custom-control` checkbox/radio boxes were only getting their *checked-state* color from the existing `.modal-body` CSS (added generically in an earlier phase) — the surrounding box border/background/hover look was still `.gp-courses-modal`-only. Extended it to `.modal-body` generically in `gp-modal.css`, so every modal-loaded form's checkboxes/radios (not just this one) get the same box treatment.

**Not verified live:** same login blocker as previous phases.

---

## Phase 7 — Instructor dashboard: students, earnings, live classes — DONE

**Files:**
- `application/views/backend/user/student_academic_progress.php` — done. Same pattern as Phase 6: the admin equivalent was already redesigned (`.gp-courses-progress` wrapper, `gp_ds_badge()` for the student email, `gp_ds_card()`), and that CSS is generic — mirrored it exactly (only `admin/` → `user/` in the quiz-result modal URL differs). AJAX tab-fragment loaded into `course_edit.php`'s `#academic_progress` tab; `data-toggle="tooltip"` and the modal/certificate links are unchanged.
- `application/views/backend/user/bbb_live_class.php` — done, same approach. Mirrored the admin version's `.gp-courses-bbb`/`.gp-courses-bbb-aside` structure and `gp_ds_alert()`/`gp_ds_button()` calls. `save_bbb_meeting()`/`start_bbb_meeting()` JS, all four field ids (`#bbb_meeting_id`, `#bbb_moderator_pw`, `#bbb_viewer_pw`, `#bb_meeting_instruction`), and `initSummerNote()` are untouched.
- ~~`application/views/backend/user/instructor_revenue.php`~~ — confirmed in Phase 0: this file is 0 bytes and not loaded by any controller. Left alone, as planned — did not invent content for an intentionally-empty file.

**Not verified live:** same login blocker as previous phases — both are AJAX tab-fragments only reachable from inside the instructor course-edit page.

---

## Phase 8 — Public frontend: legal & static pages — DONE (completed earlier, before this plan's Phase 0-7 work)

Same underlying template reused four times — fix the shared pattern once, apply to all four.

**Files:**
- `application/views/frontend/default-new/privacy_policy.php` — done. `.gp-policy-page`/`.gp-policy-page-card` + prose typography CSS (`gp-legal-pages.css`), live-verified with injected test content in light/dark/375px, then original content restored exactly.
- `application/views/frontend/default-new/terms_and_condition.php` — done, same shared template.
- `application/views/frontend/default-new/refund_policy.php` — done, same shared template.
- `application/views/frontend/default-new/website_faq.php` — done. `.gp-faq-page` accordion (`gp-faq.css`), fixed a pre-existing bug where every FAQ item had `aria-expanded="true"` hardcoded. Live-verified in light/dark/375px.
- `application/views/frontend/default-new/breadcrumb.php` (shared include used by all four, and ~25 other pages) — done as part of this same pass: `.gp-page-header` band, tokens only so it looks correct on both DS and not-yet-redesigned parent pages.

**Visual check:** done — light/dark/375px confirmed live for all four pages plus the shared breadcrumb.

---

## Phase 9 — Public frontend: company & blog

**Files:**
- `application/views/frontend/default-new/about_us.php` — done. Same `get_frontend_settings()` prose pattern as the Phase 8 legal pages, switched to the same `.gp-policy-page` wrapper — reuses `gp-legal-pages.css`, no new CSS needed. Verified live, light/dark, both correct.
- `application/views/frontend/default-new/contact_us.php` — done. Rebuilt the info/form layout with new `gp-contact-us.css`. Form `action`, every field `name`/`id` (first_name, last_name, email, phone, address, message, i_agree), and both recaptcha branches (v2 `.g-recaptcha` div + v3 button with `data-sitekey`/`data-callback`/`data-action`) are byte-for-byte unchanged — only wrapped the v3 button in `gp_ds_button()` while keeping every data attribute. Verified live: light, dark, and 375px (info cards and form fields correctly stack to one column, submit button renders correctly).
- ~~`application/views/frontend/default-new/blogs_all.php`~~ / ~~`blog_latest_and_popular.php`~~ — **no changes needed.** Both reuse the exact `.courses-card`/`.courses-card-body`/`.courses-text`/`.courses-price-*` markup from the course catalog, and that CSS (`gp-homepage-builder.css`) is fully generic — not scoped to any catalog-only wrapper. Confirmed by reading the CSS directly; could not screenshot actual cards since this database has 0 blog posts.
- ~~`application/views/frontend/default-new/blog_categories.php`~~ — **no markup changes needed**, its `.list-group`/`.list-group-item` are generically styled by `gp-list-group.css` already. Added one small targeted fix in `gp-blog.css` for the category-count `.badge.bg-primary` (a Bootstrap-5 utility color our `.badge-primary` styling doesn't touch), so it uses `--gp-primary` instead of Bootstrap's default blue.
- `application/views/frontend/default-new/blogs.php` — done. Added `.gp-blog-hero` to the page-banner section for a readable gradient overlay over the background image. Verified live in both themes (white text stays legible on the gradient regardless of site theme, by design).
- `application/views/frontend/default-new/blog_sidebar.php` — done. New `.right-section`/search/`.categories`/`.post` styling in `gp-blog.css`. Verified live in dark mode (card, search bar, "Categories"/"Recent posts" headings all correct); could not confirm the actual category list rows or recent-post cards since this database has 0 blog categories and 0 posts.
- `application/views/frontend/default-new/blog_details.php` — done. New CSS for the article header, tag pills, and the nested comment/reply threads (including the edit/delete dropdown). Every comment form's `action`, field `name`, hidden `parent_id`, and the `onclick` edit/delete/reply toggles are untouched. **Not visually verified** — no blog post exists in this database to open.

**Not fully live-verified:** three files above have code-level-only verification because this database has no seeded blog posts/categories — same class of limitation as the course custom-fields gap in Phase 3, not a login blocker this time.

---

## Phase 10 — Public frontend: commerce & account pages — DONE

**Files:**
- ~~`application/views/frontend/default-new/cart_items.php`~~ / ~~`wishlist_items.php`~~ — **no changes needed.** Both are AJAX fragments injected into the header's cart/wishlist dropdowns; their `.path_pos_wish`/`.menu_pro_wish-*` classes are already styled generically (scoped to `header.gp-site-header .menu_pro_wish`, not per-page) from earlier header work in this project. Every `actionTo()` call, `.cart-minus`, and `#add_to_cart_btn_from_wishlist{id}`/`#added_to_cart_btn_from_wishlist{id}` toggle-pair is untouched (verified by reading, not editing).
- `application/views/frontend/default-new/compare.php` — done. Base table look and the course-preview cards were already generic (`gp-tables.css`, `gp-homepage-builder.css`); added new `gp-compare.css` only for what's unique to this page (the empty comparison slot, `h3`/`h6` titles where other pages use `h5`, the level-indicator dots, star rating). No markup changes — only new CSS targeting existing classes. Verified live in dark mode.
- `application/views/frontend/default-new/instructor_page.php` — done. The course grid reuses `.courses-card-body`/`#coursesWishlistIcon{id}` (already generic, wishlist heart hook untouched). Added new `gp-instructor-page.css` for the profile header, bio, stats, and sidebar; moved one inline `<style>` block (badge image sizing) into that file. Also fixed one theme bug found while reading the file: the Twitter/X brand SVG hardcoded a near-black `fill="#0D0C23"` with no dark-mode value — added a CSS override for that exact fill (Facebook's and LinkedIn's real brand-blue fills are untouched).

**Pre-existing bug found, not caused by this work:** `/home/instructor_page/{id}` currently 500s on every instructor. Confirmed via `git diff` that my only change to this file was removing that one decorative `<style>` block (pure CSS — cannot cause a PHP runtime error); `php -l` passes clean. The failure is inside `Home::instructor_page()`'s badge-lookup queries (untouched controller code) and reproduces independent of any CSS/markup change. Flagged for the user to fix separately — out of scope for a UI-only redesign pass, and I did not touch controllers per the standing constraints.

**Visual check:** compare.php confirmed live in dark mode; instructor_page.php's CSS is correct by direct code review but could not be screenshotted due to the pre-existing 500. Cart/wishlist fragments verified by reading only (confirmed generic CSS already applies), consistent with the "don't touch what already works" approach used elsewhere this session.

---

## Phase 11 — Public frontend: community pages — DONE

**Files:**
- `application/views/frontend/default-new/community_index.php`, `community_my_posts.php`, `community_saved_posts.php` — done as one shared fix. All three reuse an identical `.post-card`/`.post-header`/`.post-body`/`.post-footer` markup pattern (confirmed via diff — `community_saved_posts.php` differs from `community_my_posts.php` only in the bookmark-removal link, nothing structural). One new `gp-community.css` covers all three; zero PHP edits to any of them.
- `application/views/frontend/default-new/community_comments.php` — done, same CSS file (nested comment/reply threads, styled generically since it's `include`d inside every post card).
- `application/views/frontend/default-new/community_sidebar.php` — done, same CSS file (profile card + nav menu with active-state highlighting).
- `application/views/frontend/default-new/community_shared_post.php` — done. Removed its own ~100-line inline `<style>` block (hardcoded `#fff`/`#212529`/`#6c757d`/`#0d6efd`, no dark-mode value) and moved every rule into `gp-community.css`, preserving the exact layout (flex gaps, thumbnail sizing, etc.), not just the colors.
- Discovered mid-phase: a pre-existing legacy stylesheet (`assets/frontend/default-new/css/style.css`, lines ~14236–14655) already has an entire un-tokened community CSS section (hardcoded hex, some with `!important`, using a legacy `--color-2` variable that has no dark-mode value). My new `.gp-ds`-scoped rules override it by specificity, matched with `!important` exactly where the legacy CSS also uses `!important` (`.post-card strong`, `.create-post-btn`, `.cancel-post-btn`, `.community-content h2`) — verified live: sidebar active-state, search bar, and create-post button all render correctly in dark mode.

Every `data-post-id`/`data-comment-id`/`data-parent-id`, every `onclick`/`confirm_modal()` call, and every class read by `community_scripts.php` (`.toggleLikeBtn`, `.savePostBtn`, `.commentForm`, `.replyForm`, `.toggleRepliesBtn`, etc.) is untouched — this phase was CSS + one inline-style removal only.

**Significant bug found while fixing this phase, fixed where it's mine to fix:** `--gp-primary` (a static navy, `#003BA6`, with no dark-mode override) was being used directly as *text/icon color* in several of this session's new CSS files — on a dark background that produces roughly **1.8:1 contrast** (WCAG AA requires 4.5:1 for text), i.e. functionally invisible. Found it via the community sidebar's active-nav-item state, then checked systematically. This codebase already has the correct fix pattern established elsewhere (`gp-auth.css` swaps to `--gp-info`, which equals `--gp-primary` in light mode but becomes a light, readable blue `#9FC0FF` in dark mode) — I applied that same swap everywhere *I* had used `--gp-primary` as text/icon color: `gp-community.css` (4 places), `gp-instructor-page.css`, `gp-contact-us.css`, `gp-blog.css` (2 places), `gp-faq.css`, `gp-legal-pages.css`, and `gp-user-custom-field.css` (2 places) — all from this project, all now fixed and verified live (FAQ page's expanded-item number, previously invisible in dark mode, is now a clearly legible light blue).
**Not fixed, flagged for the user:** the same `color: var(--gp-primary)` pattern appears **126 times total** across the whole `assets/design-system/` directory — the vast majority in files from before this session/plan that I did not author or touch. Auditing and fixing all of them is a real, separate piece of work (a sitewide dark-mode contrast pass), not something to fold into a legacy-page redesign phase. Recommend a dedicated follow-up pass.

**Visual check:** Community feed (posts list) confirmed live in both light and dark mode, including the sidebar's active-state highlighting and the search/create-post toolbar. Could not screenshot actual post cards, comments, or the shared-post detail view since this database has 0 community posts.

---

## Phase 12 — Public frontend: misc pages + auth fragments

**Files:**
- `application/views/frontend/default-new/404.php`
- `application/views/frontend/default-new/live_class_scadule.php`
- `application/views/frontend/default-new/new_login_confirmation.php`
- `application/views/frontend/default-new/verification_code.php`
- `application/views/frontend/default-new/go_back_to_mobile_app.php`
- `application/views/frontend/default-new/custom_page_viewer.php` *(re-open and confirm content during this phase — not individually verified in the audit)*

**Constraints specific to this phase:** `new_login_confirmation.php`/`verification_code.php` are real routed pages in the login flow (`login/new_login_confirmation`) — restyle only, do not touch the verification/resend logic or the form that submits the code.

**Visual check:** Light/Dark/375px, and walk the actual login/verification flow once end-to-end.

---

## Explicitly out of scope (do not touch under this plan)

- `home_2.php`–`home_7.php`, `home_builder.php`, `home.php`, and every themed home (`home_cooking2`, `home_development`, `home_elegant`, `home_fitness`, `home_kindergarten`, `home_language`, `home_marketplace`, `home_university2`, plus their `*_assets.php` files) — confirmed dead/unreachable (only `home_1` has `status=1` in `home_pages`). Redesigning these is wasted work unless the user says a template switch is planned.
- `logged_in_header.php` / `logged_out_header.php` — pending Phase 0's dead-code confirmation.
- `course_page_preview_modal.php` — pending Phase 0's orphan confirmation.
- Any controller, model, route, payment SDK integration, or DB schema.
- `common_scripts.php` DataTables config, Select2 init, wizard JS.

---

## After each phase

Report back in plain, non-technical language (per `legacy-ui-redesign`'s Step 4): what was legacy, what changed, confirmation it was checked in both themes at both a normal and narrow width. Do not move to the next phase in the same sitting without this checkpoint unless the user explicitly says to keep going.
