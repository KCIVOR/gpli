# Responsive Phase 3 — Public marketing, content and account pages (2026-09-22)

Routes added to the manifest (all proven reachable): login, sign-up, forgot-password, privacy policy, terms, refund policy, cookie policy, community posts. Together with home, FAQ, About, Contact and Blog from Phase 0: 13 public routes.
Owner CSS touched: `gp-legal-pages.css` (legal-3), `gp-community.css` (community-2).

## Conflicts fixed

| # | Route | Symptom | Cause | Fix |
|---|---|---|---|---|
| 1 | cookie-policy | Bare white section, oversized duplicate heading, unstyled list, card missing (other three legal pages are cards) | `cookie_policy.php` still uses the pre-DS `.privacy-policy > .container > .row > .col-12` markup (`style.css`: white background only) | Existing prose/card rules in `gp-legal-pages.css` extended with `:is(.gp-policy-page-card, .privacy-policy .col-12)`; row gutter and `.my-5` neutralised (one documented `!important`). View untouched. |
| 2 | community-posts | Old lavender card border and grey shadow on the profile/menu card | `custom.css` `.course-all-category { border-color, box-shadow ... !important }` beat the DS card rule | `.gp-ds .courses-list-view .course-all-category` with two documented `!important` |

## Result
All 13 public routes: 0 failures across shell probes, legacy-colour scan, overflow and console checks at 1440/1024/768/390/360 in light and dark (community/legal routes fully re-run after the fixes; the remaining eight re-run sequentially). Consistency guard passes.

## Not covered / observations
- `home/become_an_instructor` renders empty for guests: needs a student session (manifest entry is `role: student`, reported as blocked).
- Learner dashboard, wishlist and other student pages: need a student session.
- Blog list is empty in the local data, so blog cards were not inspected; the community page had two populated posts and was inspected.
- The blog hero purple is an admin-uploaded banner image (`uploads/blog/page-banner/blog-page.png`), not CSS.
- Contact form has uneven vertical gaps between fields at 390px (reserved validation-message space); left as is, cosmetic.
