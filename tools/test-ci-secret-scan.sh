#!/usr/bin/env bash
# Validates that .github/workflows/ci.yml contains a compliant secret-scan job
# per the org push-protection standard.
# See: https://github.com/petry-projects/.github/blob/main/standards/push-protection.md#required-ci-job
set -euo pipefail

ERRORS=0
CI_FILE=".github/workflows/ci.yml"

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== ci.yml — secret-scan job compliance check ==="
echo ""

if [[ ! -f "$CI_FILE" ]]; then
  error "Missing $CI_FILE"
  exit 1
fi

# Check 1: secret-scan job key is present
echo "Check 1: secret-scan job is defined"
if ! grep -q '^  secret-scan:' "$CI_FILE"; then
  error "$CI_FILE does not contain a 'secret-scan' job"
fi
echo "  done."

# Extract only the secret-scan job block (from its job key to the next top-level
# job entry) so checks 2-4 cannot be satisfied by content in other jobs or by
# comments that merely mention the action string elsewhere in the file.
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT
awk '/^  secret-scan:/{p=1} p && /^  [a-zA-Z]/ && !/^  secret-scan:/{exit} p{print}' "$CI_FILE" > "$TMPFILE"

# Check 2: gitleaks/gitleaks-action is used (scoped to secret-scan job)
echo "Check 2: secret-scan job uses gitleaks/gitleaks-action"
if ! grep -q 'gitleaks/gitleaks-action' "$TMPFILE"; then
  error "secret-scan job does not reference gitleaks/gitleaks-action"
fi
echo "  done."

# Check 3: fetch-depth: 0 is set for full history scanning (scoped to secret-scan job)
echo "Check 3: secret-scan checkout uses fetch-depth: 0"
if ! grep -q 'fetch-depth: 0' "$TMPFILE"; then
  error "secret-scan job does not set fetch-depth: 0 (required for full git history scan)"
fi
echo "  done."

# Check 4: continue-on-error must NOT be set on the gitleaks step
# (having it would allow gitleaks findings to silently pass the build)
echo "Check 4: gitleaks step does not use continue-on-error"
# Use /^[[:space:]]+-[[:space:]]/ as the step delimiter so the check is
# order-independent: continue-on-error is caught whether it appears before or
# after the uses: line within the same step.
if awk '/^[[:space:]]+-[[:space:]]/ { if (gitleaks && cont) { found=1; exit } gitleaks=0; cont=0 } /gitleaks\/gitleaks-action/ { gitleaks=1 } /continue-on-error/ { cont=1 } END { if (gitleaks && cont || found) exit 1 }' "$TMPFILE"; then
  : # no continue-on-error found on the gitleaks step
else
  error "secret-scan job has 'continue-on-error' on the gitleaks step — findings will not fail the build"
fi
echo "  done."

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "secret-scan compliance check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "All secret-scan compliance checks passed"
  exit 0
fi
