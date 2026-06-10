#!/usr/bin/env bash
# Validates that scripts/apply-repo-settings.sh contains required GitHub API
# calls for repository security settings.
set -euo pipefail

ERRORS=0
SCRIPT="scripts/apply-repo-settings.sh"

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== apply-repo-settings.sh — settings coverage check ==="
echo ""

if [[ ! -f "$SCRIPT" ]]; then
  error "Missing $SCRIPT"
  exit 1
fi

# Check that secret_scanning_ai_detection is enabled in the script
echo "Check 1: secret_scanning_ai_detection is set to enabled"
if ! grep -q 'secret_scanning_ai_detection' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning_ai_detection API call"
elif ! grep -q '"secret_scanning_ai_detection":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning_ai_detection but does not set status to enabled"
fi
echo "  done."

# Check that check-suite auto-trigger is disabled for Claude app (1236702)
echo ""
echo "Check 2: check-suite auto-trigger disabled for Claude app (1236702)"
if ! grep -q 'check-suites/preferences' "$SCRIPT"; then
  error "$SCRIPT does not contain a check-suite preferences API call"
elif ! grep -E -q '"app_id"[[:space:]]*:[[:space:]]*1236702' "$SCRIPT"; then
  error "$SCRIPT references check-suites/preferences but does not configure app_id 1236702"
elif ! grep -E -q '"app_id"[[:space:]]*:[[:space:]]*1236702[[:space:]]*,[[:space:]]*"setting"[[:space:]]*:[[:space:]]*false' "$SCRIPT"; then
  error "$SCRIPT configures app_id 1236702 but does not set setting to false"
fi
echo "  done."

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "Settings coverage check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "All settings coverage checks passed"
  exit 0
fi
