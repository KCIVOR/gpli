# Responsive Phase 2 — Course discovery and commerce (2026-09-22)

Routes: catalog, course detail, cart (empty), compare (empty and 2 courses). Owner CSS: `gp-courses.css`, `gp-compare.css`. Cache versions bumped in frontend `includes_top.php` (catalog-13, compare-4).

## Conflicts fixed

| # | Symptom | Cause | DS fix |
|---|---|---|---|
| 1 | Catalog overflows 2px at 360px (Phase 0 F1) | DS's own `≤991px` rule used `grid-template-columns: 1fr` (= `minmax(auto,1fr)`), so the track grew to content width | `minmax(0, 1fr)` in `gp-courses.css` |
| 2 | Checked filter radios purple | `style.css` `.form-check-input:checked` (`--color-4`) | `.gp-ds .gp-catalog .form-check-input:checked` primary |
| 3 | Unchecked filter radios lavender fill | `style.css` `.course-all-category .form-check-input` (`--bg-white-2`) | surface fill |
| 4 | Compare placeholder icon purple | `custom.css` `.compare-empty-state i` | `--gp-fg-faint` |
| 5 | Compare table wrapper lavender border, lavender label column | `custom.css`/`style.css` `.compare-2 .compare-2-table`, `.compare-table .table th` | DS border/shadow/radius; `th` paper |
| 6 | Compare toolbar/empty-state lavender, course cards keep lavender border | `custom.css` `.compare-toolbar`, `.compare-empty-state`, `.courses-card-body { ... !important }` | DS tokens; one documented `!important` |

The compare table's horizontal scroll inside its own box at narrow widths is intentional contained scrolling and was kept.

## Audit additions
Content-wide legacy scan (old purple plus its lavender surface/border tints) outside the shell; `--widths` option for breakpoint sweeps (991/576/420 etc.).

## Result
All shell and content probes pass on catalog, cart and compare at 1440/1024/768/390/360 (+991/576/420 for the catalog) in both themes. Guard passes.

Open items: course-detail JavaScript errors (pre-existing, `Unexpected token '}'`, `VenoBox is not defined`); populated cart and wishlist not inspected (adding items mutates session/data; wishlist needs a student login). One transient `ERR_NO_BUFFER_SPACE` (FAQ, dark, 576px) appeared when four audits ran concurrently on Windows; not reproducible sequentially.
