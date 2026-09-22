# Mobile Drawer Admin-Surface Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the public mobile drawer use the admin dashboard's theme-aware neutral surface and give its Sign up/Login actions compact mobile dimensions.

**Architecture:** Keep the change in the public-shell CSS layer, where existing mobile-drawer overrides already resolve legacy frontend styles. Override only mobile-drawer selectors with design tokens shared by the admin sidebar, then extend the focused static regression check used for the preceding drawer fixes.

**Tech Stack:** PHP views, CSS custom properties, Node.js static assertions, PHP CLI.

---

### Task 1: Cover the drawer surface and authentication-control contract

**Files:**
- Modify: `assets/design-system/gp-public-shell.css:751-900`
- Test: one-off Node.js regression assertion run from the repository root

- [ ] **Step 1: Write the failing regression check**

```powershell
node -e 'const fs=require("fs"),assert=require("assert"); const css=fs.readFileSync("assets/design-system/gp-public-shell.css","utf8"); assert.ok(css.includes(".mobile-view-offcanves .offcanvas") && css.includes("background: var(--gp-surface) !important;"),"drawer must use the admin sidebar surface token"); assert.ok(css.includes(".offcanves-btn .signUp-btn") && css.includes("min-height: 40px;") && css.includes("font-size: 14px;"),"drawer authentication actions must use compact mobile dimensions"); console.log("PASS: mobile drawer admin-surface contract");'
```

- [ ] **Step 2: Run the regression check and confirm it fails**

Run the command from Step 1. Expected: an assertion failure because the drawer still uses `var(--gp-accent)` and the compact action declarations do not exist.

- [ ] **Step 3: Implement the smallest scoped CSS override**

Replace the fixed navy drawer background with `var(--gp-surface)`, replace its fixed white menu text with `var(--gp-fg)`, and make hover/focus states use `var(--gp-surface-sunk)`. Set both authentication links to `min-height: 40px`, `padding: 8px 14px`, `font-size: 14px`, and a `12px` vertical gap; keep Sign up as `var(--gp-primary)` with `var(--gp-on-primary)` text, and Login as an outlined neutral action.

- [ ] **Step 4: Run the regression check and confirm it passes**

Run the command from Step 1. Expected: `PASS: mobile drawer admin-surface contract`.

- [ ] **Step 5: Check markup and whitespace integrity**

```powershell
php -l application\views\frontend\default-new\header_sm_device.php
git diff --check -- assets\design-system\gp-public-shell.css application\views\frontend\default-new\header_sm_device.php
```

Expected: PHP reports no syntax errors and `git diff --check` prints no whitespace errors.

- [ ] **Step 6: Commit the implementation**

```powershell
git add assets/design-system/gp-public-shell.css application/views/frontend/default-new/header_sm_device.php
git commit -m "fix: align mobile drawer with admin surface"
```
