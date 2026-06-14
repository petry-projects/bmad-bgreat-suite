#!/usr/bin/env bash
# Validates that .github/workflows/dev-lead.yml declares a concurrency block so
# bursts of triggering events serialize instead of running in parallel and
# exhausting the shared Claude API quota (HTTP 429), which was the root cause of
# the dev-lead workflow's degraded failure rate (issue #308).
set -euo pipefail

ERRORS=0
WORKFLOW=".github/workflows/dev-lead.yml"

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== dev-lead.yml — concurrency guard check ==="
echo ""

if [[ ! -f "$WORKFLOW" ]]; then
  error "Missing $WORKFLOW"
  exit 1
fi

if ! command -v python3 > /dev/null 2>&1; then
  error "python3 is required but not installed."
  exit 1
fi

if ! python3 -c "import yaml" > /dev/null 2>&1; then
  error "Python 'pyyaml' package is required but not installed. Please install it (e.g., pip install pyyaml)."
  exit 1
fi

# Check 1: the workflow parses as valid YAML and declares a top-level
# concurrency block with a non-empty group and cancel-in-progress: false.
echo "Check 1: top-level concurrency block with group and cancel-in-progress: false"
if python3 - "$WORKFLOW" << 'PY'; then
import sys
import yaml

try:
    with open(sys.argv[1]) as fh:
        doc = yaml.safe_load(fh)
except yaml.YAMLError as e:
    print(f"Invalid YAML syntax: {e}", file=sys.stderr)
    sys.exit(1)

if not isinstance(doc, dict):
    print("workflow did not parse to a mapping", file=sys.stderr)
    sys.exit(1)

concurrency = doc.get("concurrency")
if concurrency is None:
    print("no top-level 'concurrency:' key", file=sys.stderr)
    sys.exit(1)

if not isinstance(concurrency, dict):
    print("'concurrency:' must be a mapping with group/cancel-in-progress", file=sys.stderr)
    sys.exit(1)

group = concurrency.get("group")
if not isinstance(group, str) or not group.strip():
    print("'concurrency.group' must be a non-empty string", file=sys.stderr)
    sys.exit(1)

# In-flight dev-lead runs write commits and open PRs; cancelling them mid-run
# would strand partial work. Overflow must queue, not cancel.
if concurrency.get("cancel-in-progress") is not False:
    print("'concurrency.cancel-in-progress' must be false", file=sys.stderr)
    sys.exit(1)
PY
  echo "  done."
else
  error "dev-lead.yml concurrency block missing or malformed"
fi

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "dev-lead concurrency guard check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "dev-lead concurrency guard check passed"
  exit 0
fi
