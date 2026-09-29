# Courses by Function — Manual Cards with System Toggle — Implementation Plan

**Goal:** The landing page's "Courses by Function" section shows the 8 business functions from the reference design (name, description, course count) as typed by the admin, with a switch to go back to the live categories once migration is done.
**Root cause:** The section lists only sub-categories that have courses (`home_gpli.php`, "CATEGORIES (real data)" block, via `get_top_categories(8, 'sub_category_id', …)`), so it shows the 3 migrated groups instead of GPLI's 8 functions. Only 18 of the 100+ courses have been migrated.
**Approach:** Add admin-editable cards plus a Manual / From the system switch to Home Page Builder; Manual renders the reference's non-clickable function cards, From the system keeps today's clickable category chips.
**Tech stack:** PHP 8.3, CodeIgniter 3.1.9, MySQL; no automated test suite.
**Source:** User, 2026-09-29: new Home Page Builder section where the admin adds the courses shown on the landing page, not clickable, with a toggle "to choose either show the hardcoded or based on the system". Decisions: start with the reference's 8 cards; toggle starts on the hardcoded (Manual) setting.

## Open questions (resolve before implementing)

None — both decisions answered by the user (pre-fill 8 reference cards; default Manual).

---

## Live database/system validation: 2026-09-29

- `landing_page_extras` is one JSON value in `frontend_settings`, read via `gp_landing_extras()` (`application/helpers/landing_helper.php:4`) and saved by `Crud_model::update_landing_page_extras()` (`application/models/Crud_model.php:5418`), which merges the post onto current values with `array_replace_recursive` (`:5425`).
- Live JSON has no `function_cards` key yet, so defaults apply on first load (verified via SSH read of the setting, 2026-09-29).
- Card CSS already shipped: `.fn-card`, `.fn-icon`, `.fn-count`, `.g4` in `assets/design-system/gp-landing-lms.css:418-632`.

## Audit findings

1. Reference markup: section `#lms-courses`, eyebrow "The Library", heading "Courses by Function", intro "Function-specific courses carefully curated to match your company requirements.", 8 `.fn-card` items each with an icon, `h3`, `p`, and `.fn-count` "N courses →" (`gpli-lms-landing-package/index.html`).
2. List merge hazard: `array_replace_recursive` merges lists by index, so a saved list shorter than the defaults would regain default cards, and a deleted card would come back on save. Both the reader (`landing_helper.php:75`) and the saver (`Crud_model.php:5425`) must replace `function_cards` wholesale.
3. Existing "Courses by function — blurbs" admin block (`home_page_builder.php:440-448`) feeds `components/main/function_grid.php` (other templates) — left alone.
4. Section visibility is gated by frontend setting `top_category_section`; keep that gate for both modes.

---

## Scope and constraints

### In scope
- `function_cards_mode` (`manual` | `system`, default `manual`) and `function_cards` (list of `title`, `text`, `count`) in `landing_page_extras`, defaulting to the reference's 8 cards.
- Home Page Builder block: mode dropdown, editable rows for existing cards plus 4 blank rows; clearing a title removes that card.
- Landing: Manual → reference card grid, not clickable; System → current chips unchanged.

### Out of scope: do not change
- Categories, courses, the blurbs block, other templates, `get_top_categories`.

### Non-negotiable safety constraints
- Every admin value printed through `htmlspecialchars()`.
- Mode accepts only `manual` or `system`; anything else falls back to `manual`.

### Contract

| Case | Actor | Input | Required outcome |
| --- | --- | --- | --- |
| 1 | Visitor | Nothing saved yet | 8 reference cards, not clickable |
| 2 | Admin | Edits HR count to 17, saves | Card shows "17 courses" |
| 3 | Admin | Clears a card's title, saves | That card disappears and stays gone |
| 4 | Admin | Fills a blank row, saves | New card appears last |
| 5 | Admin | Switches to From the system | Clickable category chips with live counts |
| 6 | Admin | Enters `<script>` in a field | Shown as text |
| 7 | Admin | Saves any other Home Page Builder field | Cards and mode unchanged |

## Files

| File | Change | Responsibility |
| --- | --- | --- |
| `application/helpers/landing_helper.php` | Modify | Defaults (8 cards, manual); saved list replaces defaults |
| `application/models/Crud_model.php` | Modify | Save cards list wholesale, drop blank rows, validate mode |
| `application/views/backend/admin/home_page_builder.php` | Modify | Mode dropdown + card rows |
| `application/views/frontend/default-new/home_gpli.php` | Modify | Manual card grid vs system chips |

## Phase 1: Data defaults and saving
- [ ] `landing_helper.php`: add defaults `'function_cards_mode' => 'manual'` and `'function_cards' => [8 reference cards]`; after the merge, `if (isset($data['function_cards']) && is_array($data['function_cards'])) $merged['function_cards'] = array_values($data['function_cards']);`
- [ ] `Crud_model::update_landing_page_extras`: after the merge, if `$posted['function_cards']` is an array, keep rows with a non-empty trimmed title, `array_values`, assign to `$merged['function_cards']`; force `function_cards_mode` into `manual|system`.
- [ ] `php -l` both files.

## Phase 2: Admin form
- [ ] After the blurbs block in `home_page_builder.php`: heading "Courses by function — landing cards", a `<select name="landing[function_cards_mode]">` (Manual cards / From the system), then one row per saved card plus 4 blank rows, each with Title, Description, Course count inputs named `landing[function_cards][i][title|text|count]`; help text "Clear a title to remove that card."
- [ ] `php -l`.

## Phase 3: Landing render
- [ ] In `home_gpli.php`'s categories block: if mode is `manual`, render the reference section (`section-pad gp-landing`, `id="lms-courses"`, eyebrow "The Library", `.g4` grid of `.fn-card`, icon cycled from the reference's 8 SVGs, `h3`, `p`, `<span class="fn-count">N courses →</span>` — a span, not a link); else keep the existing chips block unchanged.
- [ ] `php -l`.

## Phase last: Verification
- Local `http://localhost/academy/`: case 1 (8 cards, no links inside the section); edit a count and save in Admin → Home Page Builder (case 2); clear a title (case 3); switch mode (case 5); save another field (case 7).
- After push: check https://gpli.tech shows the 8 cards.

## Rollback
1. `git revert <commit>` and push. The extra JSON keys are ignored by the old code, so no data clean-up is needed.

## Commit
```bash
git add application/helpers/landing_helper.php application/models/Crud_model.php application/views/backend/admin/home_page_builder.php application/views/frontend/default-new/home_gpli.php docs/superpowers/plans/2026-09-29-courses-by-function-manual-cards-plan.md
git commit -m "feat: admin-managed Courses by Function cards with system toggle"
```

## Self-review
1. Contradictions: none; system mode is today's behaviour, unchanged.
2. Goal reachability: live has no saved cards, so defaults render immediately after deploy; later edits persist via the wholesale-replace rule.
3. Bypass: display-only; saving stays behind the existing admin-only Home Page Builder route.
4. Existence: `gp_landing_extras`, `update_landing_page_extras`, `top_category_section`, CSS classes — all verified above.
5. Consistency: Files table = phases = commit list.
6. Duplication: the blurbs block remains for other templates; the GPLI landing uses the new cards. Noted, accepted.
7. Placeholders: none.
