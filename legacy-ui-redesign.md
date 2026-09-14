---
name: legacy-ui-redesign
description: Redesigns messy, outdated admin panel / dashboard UIs into clean, modern layouts using the project's own design system. Trigger this whenever the user shares a screenshot of an existing screen and says things like "fix this layout," "redesign this," "clean up this UI," "this looks ugly/messy," or points out bad spacing, sidebar, navigation order, or overall layout problems — even if they don't explicitly say "redesign." Also trigger when the user mentions rebuilding an old system's UI/UX, improving a dashboard, or reworking a sidebar/navbar/main-content area. Always check for a design system file in the project before proposing changes.
---

# Legacy UI Redesign

Turns a screenshot of an old, messy interface into a redesigned layout that follows the project's existing design system — not a generic redesign, but one that reuses the project's real tokens, components, and spacing scale.

## When to use this

Use this skill whenever the user:
- Shares a screenshot of a current screen and asks to fix/improve/redesign it
- Complains about layout being "messy," "ugly," "cluttered," or "inconsistent"
- Asks to reorganize a sidebar, navigation order, spacing, or main content area
- Says "make this look modern" or similar about an existing UI
- Asks to redesign all pages under a nav section (audit first, then a phase plan)

Don't wait for the word "redesign" — layout complaints + a screenshot are enough to trigger this.

## Step 1: Locate the design system

Before proposing any layout, find the design system to design against. In order:

1. If the user names a file/folder (e.g. "use Meridian," "check `design-system.md`"), read that first.
2. In this repo, prefer `geeseprojdesignsystem.html` (or `assets/design-system/reference/geeseprojdesignsystem.html`) and `--gp-*` tokens in `assets/design-system/gp-tokens.css`.
3. If not named, look for common locations in the project: `design-system.md`, `DESIGN_SYSTEM.md`, `/docs/design-system/`, `tailwind.config.*` (for tokens), `/styles/tokens.*`, a Storybook config, or a `theme.ts`/`theme.js` file.
4. If nothing is found, ask the user directly: "What's the design system file or reference I should follow for colors, spacing, and components?" Do not invent a new visual style from scratch — this skill's whole point is consistency with what already exists.

Extract from the design system before touching layout:
- Color tokens (primary, surface, border, text, states)
- Spacing scale (e.g. 4/8/12/16/24/32px steps)
- Typography scale (headings, body, labels)
- Existing component patterns (cards, tables, buttons, nav items) — reuse these, don't invent new ones unless the design system has a gap

## Step 2: Audit the screenshot

Go through the screenshot systematically and note concrete issues, not vague ones. Check against this list:

**Sidebar / navigation**
- Is the nav item order logical (most-used or most-important first, related items grouped)?
- Are icons and labels aligned and consistently sized?
- Is there a clear active/hover state?
- Is spacing between nav items consistent?

**Top bar**
- Is it cluttered with unrelated elements (browser bookmarks aside — focus on app chrome only)?
- Are user/account controls, notifications, and actions clearly separated and right-aligned or grouped sensibly?

**Main content**
- Is there a clear content hierarchy (page title → key metrics/summary → detail)?
- Is everything stacked full-width in a single column when it could be split into columns (e.g. primary content + side panel, or a multi-column card grid)?
- Is whitespace/padding consistent around cards, charts, and sections?
- Are empty/flat states (like a flat-line chart with no data) handled gracefully, or do they look broken?
- Do cards/widgets align to a grid instead of floating at inconsistent widths?

**Overall**
- Is the visual hierarchy clear (what's most important draws the eye first)?
- Is there consistent border-radius, shadow, and spacing language across components?

## Step 3: Propose the redesign

Output a working code implementation, not just a description — the user runs this in Claude Code / Cursor to apply directly. Match the project's actual stack (check `package.json` / existing components for React, Vue, plain HTML, etc. — don't assume).

Apply modern admin/dashboard layout conventions as the structural target, then style everything using the design system's tokens (never invent new colors/spacing outside it):
- Card-based sections with consistent padding and subtle elevation, instead of raw unboxed content floating on the page
- Clear visual hierarchy: page title/breadcrumb at top, key metrics/summary row, then detail content below
- Generous, consistent whitespace between sections — old systems usually cram things together
- Collapsible or fixed sidebar with grouped nav sections (not one long flat list)
- Sticky top bar so navigation/actions stay accessible on scroll
- Responsive grid that reflows to fewer columns on smaller screens, rather than a fixed-width layout

For each part changed, apply:
- **Sidebar**: reordered nav (state why, briefly), consistent icon+label spacing, clear active state using the design system's tokens
- **Top bar**: decluttered, grouped logically, using design system spacing/tokens
- **Main content**: don't just tidy up what's there — actively consider restructuring it into a better column layout. Common fixes:
  - Split a long single-column stack into a 2- or 3-column grid (e.g. key stats/summary cards in one row, main chart/table taking the wider column, secondary info in a narrower side column)
  - Move supporting widgets (recent activity, quick actions, notices) into a sidebar-style column next to the primary content instead of stacking everything full-width
  - Group related cards/widgets into a shared grid instead of leaving them as isolated full-width blocks
  - Use the design system's grid/breakpoint tokens for column widths and gutters, not arbitrary fractions
  - Also apply: consistent padding using the spacing scale, clear hierarchy (title → summary/stats → details), proper empty-state handling for charts/tables with no data

Always reference the actual token/class names from the design system (e.g. `bg-surface-100`, `spacing-4`) rather than arbitrary hex codes or pixel values. If a color or spacing is missing, add it to the token file (`assets/design-system/gp-tokens.css`) — do not invent leftover Hyper hex (`#727cf5`, `#0acf97`, `#39afd1`).

## Standing constraints (Academy LMS)

These apply on every redesign of admin Courses / Category pages and any later UI pass that uses this skill. Do not skip them.

**0. First constraint — design system over leftover / foreign UI**

If a control is leftover Hyper, Bootstrap-default, or any other foreign look, use the Geese Project design system equivalent. Do this before any other restyle decision. Do not keep the old skin. Do not invent a third style.

- Source of truth: `geeseprojdesignsystem.html` + `--gp-*` in `gp-tokens.css`.
- Helpers: existing `gp_ds_*` only (`button`, `badge`, `alert`, `card`, `table`, `page_title`).
- CSS-only DS when there is no helper: pagination → `gp-pagination.css` (not leftover Hyper circular pager), tabs, list-group, modal, accordion.
- If a leftover widget must stay for JS hooks (DataTables, Select2, daterangepicker), restyle it with `--gp-*` until it matches the DS.

**Process**
- Audit first. List every live page in the nav section before changing markup.
- Work phase by phase. Stop after each phase for a visual check.
- Use `geeseprojdesignsystem.html` as the source of truth. Re-read the matching section before writing CSS.
- New markup uses existing `gp_ds_*` helpers (`button`, `badge`, `alert`, `card`, `table`, `page_title`). Button variants only: `primary`, `secondary`, `outline`, `quiet`.
- **Strict — design system only.** Every visible control on a redesigned page must use the Geese Project design system (tokens + `gp_ds_*` or the matching CSS-only DS pattern). Do not ship leftover Hyper look: leftover date-range menus, leftover search pills, leftover cyan/pink buttons, leftover circular pagination, leftover confirm dialogs, leftover `btn-info` / `btn-danger`, leftover hex (`#08c`, `#357ebd`, `#727cf5`, `#39afd1`). If a leftover widget must stay for JS hooks (daterangepicker, DataTables, Select2), restyle it with `--gp-*` until it matches the DS. Audit the live page, not just the PHP, before calling a phase done. Do not invent a new helper if CSS-only is enough.
- Admin chrome buttons stay compact (aligned to nearby text), not the marketing §05 size.
- Confirm dialogs use the design-system modal (header / body / footer). Keep `confirm_modal()`, `#alert-modal`, and `#update_link`.
- Compose mashed `get_phrase()` labels with spaces, or use an existing complete key. Do not invent new phrase keys.
- CSS stays scoped under `.gp-ds`. Do not restyle the whole app. Do not rebuild unrelated files.
- When the user asks for a multi-phase rollout, implement via subagent-driven development with spec + quality review after each phase.
- Do not commit unless the user asks.

**UI only — restyle, do not remove**
- Only change UI/UX (look, layout, spacing, tokens, component fit). Do not remove existing features, actions, fields, buttons, dialogs, tabs, filters, or flows — restyle them in place.
- Do not edit controllers, models, routes, auth, payments, schema, or DataTables JS (`common_scripts.php`).
- Do not change form `name`, `id`, or `action`.
- Keep JS hooks: `confirm_modal`, `showAjaxModal`, `showLargeModal`, DataTables ids, Select2 ids, wizard `#basicwizard` and tab hrefs, category `#category-edit-btn-{id}` / `#category-delete-btn-{id}`.
- If a visual change appears to need a logic change or a removal: stop and report it.

**Scope**
- Do not expand into instructor `application/views/backend/user/**` or public `/home/courses` unless the user asks.
- Add constraints so unrelated code does not break. Touch only the views and scoped CSS for the current phase.

## Step 4: Explain the changes

Summarize what changed and why in plain, non-technical, executive-level language — a short list of "what was wrong → what changed," not a line-by-line code walkthrough. Example tone:

> - Sidebar: reordered so Dashboard, Courses, and Enrollments (most-used) come first; grouped reporting-related items together.
> - Top bar: removed clutter, grouped account/notification controls to the right.
> - Main content: aligned dashboard cards to a consistent grid with even spacing; fixed the flat-line chart to show a proper empty state instead of a dead straight line.

Then offer to go deeper on any specific part if the user wants more technical detail.

## Notes

- Never redesign against a generic/default style (e.g. plain shadcn defaults) if a project design system exists — that defeats the purpose.
- If the screenshot shows a partial view (e.g. above the fold only), say so and ask if there's more to see before finalizing, rather than guessing at what's below.
- If the user is mid-project on a specific system (e.g. they've mentioned a named design system before), prefer that over asking again.
