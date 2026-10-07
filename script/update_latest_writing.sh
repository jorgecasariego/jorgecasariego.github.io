#!/usr/bin/env bash
# Manual, one-command way to refresh "Latest Writing" on the live site.
#
# Run this from the repo root (or anywhere, it cds to the repo root itself)
# after publishing a new post on either Substack. It runs the same sync
# script GitHub Actions runs, and if anything actually changed, commits
# and pushes it straight to master so the live homepage updates within a
# minute or two (GitHub Pages rebuilds automatically on push).
#
# Why this exists: GitHub Actions' own scheduled run of this same script
# is currently blocked by Substack (403 from a datacenter-IP block), so
# this is the reliable path until that's resolved.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Fetching latest posts from Substack..."
ruby script/sync_latest_writing.rb

if git diff --quiet -- _data/latest_writing.yml; then
    echo "==> No changes — _data/latest_writing.yml already up to date. Nothing to push."
    exit 0
fi

echo "==> Changes found, committing and pushing..."
git add _data/latest_writing.yml
git commit -m "Sync latest writing from Substack (manual)"
git push origin master

echo "==> Done. The live site will update automatically in a minute or two."
