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

echo ""
echo "Check 2: check-suite auto-trigger is disabled via check-suites/preferences API"
if ! grep -q 'check-suites/preferences' "$SCRIPT"; then
  error "$SCRIPT does not call the check-suites/preferences API endpoint"
elif ! grep -q 'auto_trigger_checks' "$SCRIPT"; then
  error "$SCRIPT does not set auto_trigger_checks in the check-suites/preferences payload"
fi
echo "  done."

echo ""
echo "Check 3: auto-trigger is disabled for CodeRabbit (347564) and Claude GitHub App (1236702)"
if ! grep -q '"app_id":347564' "$SCRIPT" && ! grep -q '"app_id": 347564' "$SCRIPT"; then
  error "$SCRIPT does not disable auto-trigger for CodeRabbit (app_id 347564)"
elif ! grep -q '"setting":false' "$SCRIPT" && ! grep -q '"setting": false' "$SCRIPT"; then
  error "$SCRIPT references app_id 347564 but does not set setting to false"
fi
if ! grep -q '"app_id":1236702' "$SCRIPT" && ! grep -q '"app_id": 1236702' "$SCRIPT"; then
  error "$SCRIPT does not disable auto-trigger for Claude GitHub App (app_id 1236702)"
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
