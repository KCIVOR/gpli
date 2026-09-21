# Mobile Drawer Admin-Surface Design

## Goal

Make the public mobile navigation drawer visually consistent with the admin dashboard while improving the size and spacing of its unauthenticated actions.

## Design

The drawer will use the same theme-aware neutral surface as the admin sidebar: `--gp-surface` for its background, `--gp-border` for its edge, and `--gp-fg` / `--gp-fg-muted` for content. This gives a white drawer in light mode and a near-black drawer in dark mode. Navigation hover and focus states will use `--gp-surface-sunk`, matching the admin sidebar interaction model.

The drawer's Sign up and Login links will become compact, full-width controls with a 40px minimum height, 14px labels, and a 12px gap. Sign up remains the primary blue action; Login becomes the neutral outlined secondary action. Both retain a 44px-or-larger effective touch target through their vertical spacing and hit area.

## Scope

- Modify only the public-shell mobile-drawer CSS.
- Do not change desktop navigation, the footer theme toggle, backend markup, navigation destinations, or collapse behavior.

## Verification

A focused static regression check will assert the admin-surface tokens and compact action dimensions are present. Existing PHP syntax and diff-whitespace validation will also run.
