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

# Check 2: gitleaks/gitleaks-action is used
echo "Check 2: job uses gitleaks/gitleaks-action"
if ! grep -q 'gitleaks/gitleaks-action' "$CI_FILE"; then
  error "$CI_FILE does not reference gitleaks/gitleaks-action"
fi
echo "  done."

# Check 3: fetch-depth: 0 is set for full history scanning
echo "Check 3: checkout uses fetch-depth: 0"
if ! grep -q 'fetch-depth: 0' "$CI_FILE"; then
  error "$CI_FILE does not set fetch-depth: 0 (required for full git history scan)"
fi
echo "  done."

# Check 4: continue-on-error must NOT be set on the gitleaks step
# (having it would allow gitleaks findings to silently pass the build)
echo "Check 4: gitleaks step does not use continue-on-error"
# Track step boundaries (lines starting with "      - ") so that continue-on-error
# is detected regardless of whether it appears before or after the uses: line.
if awk '
  /^      - / {
    if (has_gitleaks && has_coe) exit 1
    has_gitleaks = 0; has_coe = 0
  }
  /gitleaks\/gitleaks-action/ { has_gitleaks = 1 }
  /continue-on-error/ { has_coe = 1 }
  END { if (has_gitleaks && has_coe) exit 1 }
' "$CI_FILE"; then
  : # no continue-on-error found on the gitleaks step
else
  error "$CI_FILE has 'continue-on-error' on the gitleaks step — findings will not fail the build"
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
