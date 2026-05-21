#!/usr/bin/env bash
# apply-repo-settings.sh — applies required GitHub repository settings
# Usage: bash scripts/apply-repo-settings.sh <repo-name>
#
# Env vars:
#   GH_TOKEN  — GitHub token with repo admin scope (picked up automatically by gh)
#   ORG       — GitHub org (default: petry-projects)

set -euo pipefail

ORG="${ORG:-petry-projects}"
REPO="${1:?Usage: $0 <repo-name>}"
FULL_REPO="${ORG}/${REPO}"

echo "=== Apply Repo Settings: ${FULL_REPO} ==="

# Disable check-suite auto-trigger for Claude app (ID 1236702).
# When enabled, GitHub creates a queued check suite on every push that is
# never completed, permanently blocking auto-merge.
echo "Disabling check-suite auto-trigger for Claude app (1236702)..."
printf '{"auto_trigger_checks":[{"app_id":1236702,"setting":false}]}' | \
  gh api "repos/${FULL_REPO}/check-suites/preferences" \
    --method PATCH \
    --input - \
    --silent

echo "  Done: auto-trigger disabled for app 1236702."
echo ""
echo "=== Settings applied to ${FULL_REPO} ==="
