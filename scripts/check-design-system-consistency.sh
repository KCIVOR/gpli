#!/usr/bin/env bash
# Design System Standardization Plan — Phase S7 guard.
#
# Flags hardcoded hex colors and deprecated tokens in the design-system CSS
# files (assets/design-system/*.css, excluding gp-tokens.css itself — that
# file's whole job is defining the hex-to-token mapping).
#
# Two modes:
#
#   --tree   Scans the whole codebase now. This is a ONE-TIME BASELINE audit,
#            not a pass/fail gate — expect many hits, since most existing
#            hex usages were already manually reviewed and confirmed safe
#            (e.g. white button text on a background that itself never
#            changes between themes). Use it to spot-check, not to block.
#
#   (default) Reads a unified diff on stdin and flags only ADDED lines —
#            this is the actual CI gate. Run it against a PR/commit diff:
#              git diff --cached -- 'assets/design-system/*.css' \
#                | scripts/check-design-system-consistency.sh
#
# A reviewed, deliberate exception can suppress a line with a trailing
# `/* gp-check:allow ... */` comment — see gp-landing.css's dark-only gold
# accent for an example.
#
# This is intentionally a simple grep-based check, not a full linter — see
# DESIGN_SYSTEM_STANDARDIZATION_PLAN.md Phase S7 for the reasoning.

set -uo pipefail

fail=0

# Reads candidate lines from $1 (a string, not stdin/a pipe — a function on
# the receiving end of a pipe runs in a subshell in bash, which would make
# `fail=1` invisible to the caller; passing by argument avoids that).
scan_lines() {
  local input="$1" hex_hits ink_hits

  hex_hits="$(printf '%s\n' "$input" \
    | grep -vE '\[[a-zA-Z-]+="#[0-9a-fA-F]{3,8}"\]' \
    | grep -vE '^\s*\*|/\*.*#[0-9a-fA-F]{3,8}' \
    | grep -vE 'gp-check:allow' \
    | grep -E ':[^;{]*#[0-9a-fA-F]{3,8}\b' || true)"
  if [ -n "$hex_hits" ]; then
    printf '%s\n' "$hex_hits"
    echo "^ Hardcoded hex color found. Use a --gp-* token from assets/design-system/gp-tokens.css instead." >&2
    fail=1
  fi

  ink_hits="$(printf '%s\n' "$input" \
    | grep -E '(var\(--gp-ink\)|var\(--gp-text\))' \
    | grep -v 'gp-admin-shell\.css\|gp-tooltip\.css' \
    | grep -vE 'gp-check:allow' || true)"
  if [ -n "$ink_hits" ]; then
    printf '%s\n' "$ink_hits"
    echo "^ Use of deprecated --gp-ink/--gp-text (no dark-mode value). Use --gp-fg / --gp-fg-muted / --gp-fg-faint instead." >&2
    fail=1
  fi
}

if [ "${1:-}" = "--tree" ]; then
  echo "NOTE: --tree is a baseline audit (expect many pre-reviewed hits), not a pass/fail gate." >&2
  candidates="$(grep -rnE '#[0-9a-fA-F]{3,8}\b|var\(--gp-ink\)|var\(--gp-text\)' assets/design-system/*.css 2>/dev/null \
    | grep -v '^assets/design-system/gp-tokens\.css:')"
  scan_lines "$candidates"
else
  candidates="$(cat | grep -E '^\+' | grep -vE '^\+\+\+')"
  scan_lines "$candidates"
fi

if [ "$fail" -eq 1 ] && [ "${1:-}" != "--tree" ]; then
  echo "" >&2
  echo "Design-system consistency check failed — see DESIGN_SYSTEM_STANDARDIZATION_PLAN.md." >&2
  exit 1
fi

if [ "${1:-}" != "--tree" ]; then
  echo "Design-system consistency check passed."
fi
