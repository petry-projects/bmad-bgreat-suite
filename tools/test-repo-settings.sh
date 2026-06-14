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
elif ! grep -E -q '"secret_scanning_ai_detection"[[:space:]]*:[[:space:]]*\{[[:space:]]*"status"[[:space:]]*:[[:space:]]*"enabled"[[:space:]]*\}' "$SCRIPT"; then
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
echo "Check 5: CodeQL default setup is configured"
if ! grep -q 'code-scanning/default-setup' "$SCRIPT"; then
  error "$SCRIPT does not contain a code-scanning/default-setup API call"
elif ! grep -E -q 'state=configured|"state":"configured"' "$SCRIPT"; then
  error "$SCRIPT references code-scanning/default-setup but does not set state to configured"
elif ! grep -E -q 'query_suite=default|"query_suite":"default"' "$SCRIPT"; then
  error "$SCRIPT references code-scanning/default-setup but does not set query_suite to default"
fi
echo "  done."

echo ""

# Check that secret_scanning_non_provider_patterns is enabled in the script
echo "Check 3: secret_scanning_non_provider_patterns is set to enabled"
if ! grep -q 'secret_scanning_non_provider_patterns' "$SCRIPT"; then
  error "$SCRIPT does not contain a secret_scanning_non_provider_patterns API call"
elif ! grep -E -q '"secret_scanning_non_provider_patterns"[[:space:]]*:[[:space:]]*\{[[:space:]]*"status"[[:space:]]*:[[:space:]]*"enabled"[[:space:]]*\}' "$SCRIPT"; then
  error "$SCRIPT references secret_scanning_non_provider_patterns but does not set status to enabled"
fi
echo "  done."

# Check that every permissions: scope in the workflow is a valid GitHub Actions
# scope. An invalid scope (e.g. `administration`, which is not a GITHUB_TOKEN
# permission) makes the whole file an "invalid workflow file" that fails at
# startup with 0s duration on every run.
echo ""
echo "Check 6: apply-repo-settings.yml uses only valid permissions scopes"
if [[ ! -f "$WORKFLOW" ]]; then
  error "Missing $WORKFLOW"
elif ! command -v python3 >/dev/null 2>&1 || ! python3 -c "import yaml" >/dev/null 2>&1; then
  echo "  python3/PyYAML unavailable — skipping permissions-scope validation"
else
  invalid_scopes=$(python3 - "$WORKFLOW" <<'PY'
import sys, yaml

# Valid GITHUB_TOKEN permission scopes accepted in a workflow `permissions:` block.
ALLOWED = {
    "actions", "attestations", "checks", "contents", "deployments",
    "discussions", "id-token", "issues", "models", "packages", "pages",
    "pull-requests", "repository-projects", "security-events", "statuses",
}

with open(sys.argv[1]) as fh:
    wf = yaml.safe_load(fh)

if not isinstance(wf, dict):
    wf = {}

def scopes(perms):
    # A mapping of scope -> level; a bare string ("read-all"/"write-all") or
    # empty mapping declares no individual scopes to validate.
    return set(perms) if isinstance(perms, dict) else set()

bad = set()
bad |= scopes(wf.get("permissions"))
jobs = wf.get("jobs")
if isinstance(jobs, dict):
    for job in jobs.values():
        if isinstance(job, dict):
            bad |= scopes(job.get("permissions"))
bad -= ALLOWED
print("\n".join(sorted(bad)))
PY
)
  if [[ -n "$invalid_scopes" ]]; then
    while IFS= read -r scope; do
      [[ -z "$scope" ]] && continue
      error "$WORKFLOW declares invalid permissions scope '$scope' — GitHub rejects this as an invalid workflow file, causing every run to fail at startup"
    done <<< "$invalid_scopes"
  fi
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
