"""Restore each staged file's mtime to its real last-commit time.

`git archive` (like `git checkout`) stamps every extracted file with the
extraction time, not its actual last-changed date. Since the deploy
workflow's `mirror` decides what to re-upload by comparing size+mtime
against what's already on the server, a fresh checkout makes EVERY file
look "newer" than the last deploy -- so without this, every push
re-uploads the entire tree (thousands of files, including the ~2,900-file
AWS SDK vendor folder), which is what made deploys take 45+ minutes even
for a one-line change.

This walks `git log` once (not once per file -- that's slow enough at
thousands of files to be worth avoiding) and sets each staged file's mtime
to its real last-commit time, so unchanged files correctly look unchanged.
"""

import subprocess
import os
import sys

stage_dir = sys.argv[1] if len(sys.argv) > 1 else "deploy_stage"

out = subprocess.run(
    ["git", "log", "--name-only", "--no-renames", "--format=@@%ct"],
    capture_output=True, text=True, check=True
).stdout

mtimes = {}
current_ts = None
for line in out.splitlines():
    if line.startswith("@@"):
        current_ts = int(line[2:])
    elif line.strip() and current_ts is not None:
        mtimes.setdefault(line, current_ts)

applied = 0
for path, ts in mtimes.items():
    full = os.path.join(stage_dir, path)
    if os.path.isfile(full):
        os.utime(full, (ts, ts))
        applied += 1

print(f"Restored mtimes on {applied} staged files")
