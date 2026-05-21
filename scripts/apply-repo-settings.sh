#!/usr/bin/env bash
# Applies required GitHub repository settings for petry-projects repos.
# Disables check suite auto-trigger for known apps that create permanently-queued
# check suites (e.g. CodeRabbit/347564), which would otherwise block auto-merge.
#
# Usage: bash scripts/apply-repo-settings.sh <repo-name>
#   repo-name: repository name without owner (e.g. bmad-bgreat-suite)
#
# Requires: gh CLI authenticated with repo admin scope.

set -euo pipefail

ORG="petry-projects"

if [[ $# -lt 1 || -z "${1:-}" ]]; then
  echo "Usage: $0 <repo-name>" >&2
  exit 1
fi

REPO_NAME="$1"
REPO="${ORG}/${REPO_NAME}"

# App IDs whose check suite auto-trigger must be disabled.
# 347564 = CodeRabbit: creates queued suites that never complete, blocking auto-merge.
DISABLE_APP_IDS=(347564)

echo "Applying repo settings to ${REPO} ..."

payload='{"auto_trigger_checks":['
first=true
for app_id in "${DISABLE_APP_IDS[@]}"; do
  if [[ "$first" == true ]]; then
    first=false
  else
    payload+=','
  fi
  payload+="{\"app_id\":${app_id},\"setting\":false}"
done
payload+=']}'

gh api \
  --method PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/repos/${REPO}/check-suites/preferences" \
  --input - <<< "$payload"

echo "Done. Check suite auto-trigger disabled for app IDs: ${DISABLE_APP_IDS[*]}"
