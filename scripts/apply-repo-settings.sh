#!/usr/bin/env bash
set -euo pipefail
# apply-repo-settings.sh — Apply standard GitHub repository settings.
#
# Usage: bash scripts/apply-repo-settings.sh [repo]
#   repo  Repository name (e.g. "bmad-bgreat-suite" or "owner/repo").
#         Defaults to $GITHUB_REPOSITORY.
#
# Environment variables:
#   DRY_RUN=true  Print what would be changed without making API calls.
#
# Requires: gh CLI authenticated with a token that has admin:repo scope.

REPO="${1:-${GITHUB_REPOSITORY:-}}"
DRY_RUN="${DRY_RUN:-false}"

if [ -z "$REPO" ]; then
  echo "::error::Repository name required. Pass as argument or set GITHUB_REPOSITORY." >&2
  exit 1
fi

# Normalise to owner/repo form.
if [[ "$REPO" != */* ]]; then
  REPO="petry-projects/$REPO"
fi

if [ "$DRY_RUN" = "true" ]; then
  echo "[DRY RUN] Would apply repository settings to ${REPO}."
else
  echo "Applying repository settings to ${REPO}..."
fi

# ── Check-suite auto-trigger ──────────────────────────────────────────────────
# Disable auto-trigger for apps that enqueue phantom check suites on every push
# but never complete them, permanently blocking auto-merge:
#   - Claude GitHub App (ID 1236702)
#   - CodeRabbit (ID 347564)
payload='{"auto_trigger_checks":[{"app_id":1236702,"setting":false},{"app_id":347564,"setting":false}]}'

if [ "$DRY_RUN" = "true" ]; then
  echo "[DRY RUN] PATCH /repos/${REPO}/check-suites/preferences"
  echo "[DRY RUN] body: $payload"
else
  gh api \
    --method PATCH \
    --header "Accept: application/vnd.github+json" \
    "/repos/${REPO}/check-suites/preferences" \
    --input - <<< "$payload"
fi

if [ "$DRY_RUN" = "true" ]; then
  echo "[DRY RUN] Done. No changes were made."
else
  echo "Done: disabled check-suite auto-trigger for Claude app (1236702) and CodeRabbit (347564) on ${REPO}."
fi
