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

# Check that secret_scanning_non_provider_patterns is enabled in the script
echo "Check 2: secret_scanning_non_provider_patterns is set to enabled"
if ! grep -q 'secret_scanning_non_provider_patterns' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning_non_provider_patterns API call"
elif ! grep -q '"secret_scanning_non_provider_patterns":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning_non_provider_patterns but does not set status to enabled"
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
