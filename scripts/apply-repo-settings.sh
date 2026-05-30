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
# Disable auto-trigger for apps that enqueue phantom check suites on every push
# but never complete them, permanently blocking auto-merge:
#   - Claude GitHub App (ID 1236702)
#   - CodeRabbit (ID 347564)
gh api \
  --method PATCH \
  --header "Accept: application/vnd.github+json" \
  "/repos/${REPO}/check-suites/preferences" \
  --input - <<'JSON'
{"auto_trigger_checks":[{"app_id":1236702,"setting":false},{"app_id":347564,"setting":false}]}
JSON

echo "Done: disabled check-suite auto-trigger for Claude app (1236702) and CodeRabbit (347564) on ${REPO}."

# ── Secret scanning — non-provider patterns ───────────────────────────────────
# Enable detection of non-provider secret patterns (e.g. generic API keys,
# private tokens) per the push-protection standard.
gh api \
  --method PATCH \
  --header "Accept: application/vnd.github+json" \
  "/repos/${REPO}" \
  --input - <<'JSON'
{"security_and_analysis":{"secret_scanning_non_provider_patterns":{"status":"enabled"}}}
JSON

echo "Done: enabled secret_scanning_non_provider_patterns on ${REPO}."
