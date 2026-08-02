#!/usr/bin/env bash
# Validates that dependency installs are hardened against the SonarCloud
# GitHub Actions / dependency-hardening findings (issue #358):
#   - githubactions:S8541 — pip install must pass --only-binary :all: so no
#     source-distribution setup script is executed during CI.
#   - githubactions:S8544 — pip install must pin a resolved version
#     (pyyaml==X.Y.Z), not float to the latest release.
#   - text:S8564 — package.json must ship a committed lock file
#     (package-lock.json) so npm resolves predictable versions.
# This guard catches a regression in PR CI instead of waiting for the next
# SonarCloud audit run.
set -euo pipefail

ERRORS=0
CI_FILE=".github/workflows/ci.yml"
LOCK_FILE="package-lock.json"
readonly DONE_MSG="  done."

error() {
  local message="$1"
  printf "ERROR: %s\n" "$message" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== dependency hardening check ==="
echo ""

if [[ ! -f "$CI_FILE" ]]; then
  error "Missing $CI_FILE"
  exit 1
fi

# Collect every `pip install` invocation in the CI workflow so each one is held
# to the same hardening bar (no unpinned / source-buildable install slips in).
mapfile -t PIP_LINES < <(grep -nE 'pip[[:space:]]+install' "$CI_FILE" | grep -vE '^[0-9]+:[[:space:]]*#' || true)

echo "Check 1: at least one pip install step exists to validate"
if [[ ${#PIP_LINES[@]} -eq 0 ]]; then
  error "$CI_FILE has no 'pip install' step — expected the PyYAML install"
fi
echo "$DONE_MSG"

echo "Check 2: every pip install passes --only-binary :all: (S8541)"
for entry in "${PIP_LINES[@]}"; do
  if ! grep -qE -- '--only-binary([[:space:]]+|=):all:' <<< "$entry"; then
    error "pip install missing '--only-binary :all:': ${entry#*:}"
  fi
done
echo "$DONE_MSG"

echo "Check 3: every pip install pins an exact version with == (S8544)"
for entry in "${PIP_LINES[@]}"; do
  # Strip the leading "<lineno>:" prefix, then require a name==version token.
  if ! grep -qE '[A-Za-z0-9_.-]+==[0-9][0-9A-Za-z.]*' <<< "${entry#*:}"; then
    error "pip install does not pin a version (name==X.Y.Z): ${entry#*:}"
  fi
done
echo "$DONE_MSG"

echo "Check 4: a committed lock file accompanies package.json (S8564)"
if [[ -f "package.json" && ! -f "$LOCK_FILE" ]]; then
  error "Missing $LOCK_FILE — package.json needs a committed lock file"
fi
echo "$DONE_MSG"

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "dependency hardening check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "All dependency hardening checks passed"
  exit 0
fi
