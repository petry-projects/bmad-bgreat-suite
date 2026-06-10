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

# Check that check-suite auto-trigger is disabled for CodeRabbit (app_id 347564)
echo ""
echo "Check 3: check-suite auto-trigger disabled for CodeRabbit (app_id 347564)"
if ! grep -q 'check-suites/preferences' "$SCRIPT"; then
  error "$SCRIPT does not contain a check-suites/preferences API call"
elif ! grep -E -q '"app_id"[[:space:]]*:[[:space:]]*347564' "$SCRIPT"; then
  error "$SCRIPT does not configure auto-trigger for CodeRabbit (app_id 347564)"
elif ! grep -E -q '"app_id"[[:space:]]*:[[:space:]]*347564[[:space:]]*,[[:space:]]*"setting"[[:space:]]*:[[:space:]]*false' "$SCRIPT"; then
  error "$SCRIPT does not disable auto-trigger for CodeRabbit (app_id 347564)"
fi
echo "  done."

echo ""

# Check that CodeQL default setup is configured in the script
echo "Check 4: CodeQL default setup is configured"
if ! grep -q 'code-scanning/default-setup' "$SCRIPT"; then
  error "$SCRIPT does not contain a code-scanning/default-setup API call"
elif ! grep -E -q 'state=configured|"state":"configured"' "$SCRIPT"; then
  error "$SCRIPT references code-scanning/default-setup but does not set state to configured"
elif ! grep -E -q 'query_suite=default|"query_suite":"default"' "$SCRIPT"; then
  error "$SCRIPT references code-scanning/default-setup but does not set query_suite to default"
fi
echo "  done."

echo ""
echo "Check 3: secret_scanning is set to enabled"
if ! grep -q '"secret_scanning":' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning API call"
elif ! grep -q '"secret_scanning":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning but does not set status to enabled"
fi
echo "  done."

echo ""
echo "Check 4: secret_scanning_push_protection is set to enabled"
if ! grep -q 'secret_scanning_push_protection' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning_push_protection API call"
elif ! grep -q '"secret_scanning_push_protection":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning_push_protection but does not set status to enabled"
fi
echo "  done."

echo ""
echo "Check 5: secret_scanning_non_provider_patterns is set to enabled"
if ! grep -q 'secret_scanning_non_provider_patterns' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning_non_provider_patterns API call"
elif ! grep -q '"secret_scanning_non_provider_patterns":{"status":"enabled"}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning_non_provider_patterns but does not set status to enabled"
fi
echo "  done."

echo ""
echo "Check 6: dependabot automated security fixes are enabled"
if ! grep -q 'automated-security-fixes' "$SCRIPT"; then
  error "$SCRIPT does not contain an automated-security-fixes API call"
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
