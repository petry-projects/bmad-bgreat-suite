#!/usr/bin/env bash
set -euo pipefail
# apply-repo-settings.sh — Apply standard GitHub repository settings.
#
# Usage: bash scripts/apply-repo-settings.sh [repo]
#   repo  Repository name (e.g. "bmad-bgreat-suite" or "owner/repo").
#         Defaults to $GITHUB_REPOSITORY.
#
# Requires: gh CLI authenticated with a token that has admin:repo scope.

REPO="${1:-${GITHUB_REPOSITORY:-}}"

if [ -z "$REPO" ]; then
  echo "::error::Repository name required. Pass as argument or set GITHUB_REPOSITORY." >&2
  exit 1
fi

# Normalise to owner/repo form.
if [[ "$REPO" != */* ]]; then
  REPO="petry-projects/$REPO"
fi

echo "Applying repository settings to ${REPO}..."

# ── Check-suite auto-trigger ──────────────────────────────────────────────────
# Two GitHub Apps create orphaned "queued" check suites on every push that are
# never completed, permanently blocking auto-merge. Disable auto-trigger for both:
#   1236702 = Claude (anthropics/claude-code-action)
#   347564  = CodeRabbit
# See: standards/github-settings.md#check-suite-auto-trigger
gh api \
  --method PATCH \
  --header "Accept: application/vnd.github+json" \
  "/repos/${REPO}/check-suites/preferences" \
  --input - <<'JSON'
{"auto_trigger_checks":[{"app_id":1236702,"setting":false},{"app_id":347564,"setting":false}]}
JSON

echo "Done: disabled check-suite auto-trigger for Claude (1236702) and CodeRabbit (347564) on ${REPO}."
