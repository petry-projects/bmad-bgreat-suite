#!/usr/bin/env bash
# validate-repo-settings.sh — Validates that apply-repo-settings.sh includes
# all required GitHub security_and_analysis API calls.
# Exit 0 = all checks pass, Exit 1 = failures found.
set -euo pipefail

SCRIPT="scripts/apply-repo-settings.sh"
ERRORS=0

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== Repo Settings Validator ==="
echo ""

if [[ ! -f "$SCRIPT" ]]; then
  error "Missing $SCRIPT"
  exit 1
fi

# ---------------------------------------------------------------------------
# Check: secret_scanning_non_provider_patterns must be enabled
# ---------------------------------------------------------------------------
echo "Check: secret_scanning_non_provider_patterns is enabled in $SCRIPT"
if ! grep -q 'secret_scanning_non_provider_patterns' "$SCRIPT"; then
  error "$SCRIPT does not configure secret_scanning_non_provider_patterns"
elif ! grep -q '"secret_scanning_non_provider_patterns":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT does not set secret_scanning_non_provider_patterns to \"enabled\""
fi
echo "  done."

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "Validation failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "All repo-settings checks passed"
  exit 0
fi
