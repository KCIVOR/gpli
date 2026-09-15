# How This Site Deploys

This explains, in plain language, what happens every time code is pushed to `main`, why it's set up this way, and what to watch out for.

---

## The short version

Every time someone pushes code to the `main` branch on GitHub, the live site at `lms.startuplab.cc` updates itself automatically, usually within about 10–15 seconds. No one needs to log into the server or upload anything by hand.

---

## What actually happens, step by step

1. **You push code to `main`** on GitHub — same as any normal commit.
2. **GitHub sends two quick messages to the hosting server**, saying "go get the latest code" and then "now put it live." This happens automatically, with no one clicking anything.
3. **The hosting server fetches the new code itself**, directly from GitHub, into a private folder that isn't part of the live website (`repositories/gpli`).
4. **The server then copies the right files from that private folder into the live website folder** (`public_html/lms`) — like dragging files from one folder to another on the same computer, not uploading them over the internet. This is why it's fast.
5. **Certain files are deliberately skipped during that copy** — internal planning documents, scratch/reference pages, and anything already sensitive on the server (uploaded files, the database configuration, backup files). These are protected and never touched by the deploy process, in either direction.
6. **The site is now live with the update.**

If something in step 2 or 4 fails, the process stops and reports an error — it does not leave the site half-updated.

---

## Why it's built this way

The hosting account this site runs on has **Terminal access turned off** (a security setting some hosts use to reduce risk on shared servers). Normally, automated deploys use a Terminal-based tool called SSH; without it, most of the "standard" ways to automate deployment don't work here.

This setup instead uses a **built-in feature of the hosting control panel (cPanel) called Git Version Control**. It doesn't need Terminal access — it's a separate, more limited mechanism that only knows how to do two things: fetch code from GitHub, and run one specific, pre-written set of copy instructions. It can't run arbitrary commands the way Terminal access could.

---

## Security notice — please read

This automation works by giving GitHub a **secret key** (an "API token") that lets it tell the hosting control panel to fetch and deploy code. This is the single most sensitive piece of this whole setup, and it deserves real care:

- **This key currently has full access to the hosting account** — the hosting control panel doesn't offer a way to limit it to "just deployments." Whoever has this key could, in principle, do anything you could do by logging into the control panel yourself (view/change files, access the database, manage email accounts, etc.).
- **It's stored as a GitHub "Secret"** — encrypted, never shown in logs, and not visible to anyone browsing the repository, including people with read access.
- **Anyone who can push code to `main` (or edit the deploy workflow file) can effectively use this key**, since the key is only ever used by that workflow. This is the most realistic way this could go wrong — not a stranger breaking in from outside, but someone who already has legitimate access to this repository doing something careless or malicious, or someone's GitHub account itself getting compromised (stolen password, phishing, etc.).

**What to do if you ever suspect this key has leaked or been misused:**

1. Go to cPanel → **Manage API Tokens** → find the token named `github-deploy` → click **Revoke The Token**. This instantly cuts off access — no waiting.
2. Create a new token and update the `CPANEL_TOKEN` secret in GitHub (Settings → Secrets and variables → Actions) with the new value.
3. Check for anything unexpected on the server — files with recent changes you didn't make, new email accounts, unusual activity.

**Ongoing good habits:**

- Only give people write access to this GitHub repository if you genuinely trust them with this level of access — that trust *is* the real security boundary here, more than any setting in cPanel.
- Consider requiring a review before changes can be merged into `main` (a "branch protection rule" in GitHub) — this means no single person, or no single compromised account, can quietly change the deploy process without someone else noticing first.
- Don't ever paste this key into chat messages, screenshots, or documents — treat it the way you'd treat a password.

---

## What never gets touched by this process

These are protected on the server and are never overwritten, deleted, or replaced by a deploy, no matter what:

- Files that real users have uploaded (photos, documents, etc.)
- The site's database connection settings
- Backup files
- A couple of legacy files found on the server that aren't part of the tracked project (flagged and deliberately left alone)

## What's intentionally left out of every deploy

Internal working documents (planning notes, phase reports, design-system scratch pages) are tracked in the project's history for the team's own reference, but are deliberately excluded from ever being copied to the live, public-facing folder — they're not meant to be something a visitor could stumble onto by guessing a URL.

## Database changes

This automation **never** touches the database. Any change to the site's actual data structure (adding a table, a column, etc.) is done by hand, reviewed carefully, with a backup taken first — on purpose, so a mistake in an automated script can never damage real user data.

## If the automation ever seems broken

The manual fallback still works: log into cPanel → **Git™ Version Control** → open the `gpli` repository → click **Update from Remote**, then **Deploy HEAD Commit**. This does exactly what the automation does, just triggered by a click instead of happening on its own.
