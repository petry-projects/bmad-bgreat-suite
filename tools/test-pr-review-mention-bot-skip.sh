#!/usr/bin/env bash
# Validates that .github/workflows/pr-review-mention.yml skips bot-authored comments.
#
# The mention-trigger caller fires on issue_comment, pull_request_review_comment,
# and pull_request (review_requested) events. When a bot (e.g. GitHub Copilot,
# CodeRabbit) posts a review comment,
# GitHub gates the resulting workflow run as `action_required` (pending manual
# approval); it never runs, and Fleet Monitor counts it as a failure — which
# pushed the failure rate over threshold (issue #402). The mention trigger only
# needs to respond to human @-mentions, so the pr-review-mention job must carry an
# if: guard that skips comment events whose author is a Bot. This test asserts
# that guard is present. It uses the structural comment-author type field, not
# spoofable actor/identity fields (S6931).
set -euo pipefail

ERRORS=0
WORKFLOW=".github/workflows/pr-review-mention.yml"

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== pr-review-mention.yml — bot-comment skip guard check ==="
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

# Check 1: the pr-review-mention job declares an if: guard that skips bot-authored
# comment events. Bot review comments otherwise spawn action_required runs that
# Fleet Monitor counts as failures (see file header / issue #402).
echo "Check 1: pr-review-mention job skips bot-authored comments via an if: guard"
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

jobs = doc.get("jobs")
if not isinstance(jobs, dict) or "pr-review-mention" not in jobs:
    print("workflow has no 'pr-review-mention' job", file=sys.stderr)
    sys.exit(1)

job = jobs["pr-review-mention"]
guard = job.get("if")
if guard is None:
    print(
        "pr-review-mention job has no 'if:' guard — bot-authored comment events "
        "(e.g. Copilot) spawn action_required runs that Fleet Monitor counts as "
        "failures (issue #402). Add: if: \"${{ github.event.comment.user.type != 'Bot' }}\"",
        file=sys.stderr,
    )
    sys.exit(1)

# Normalise whitespace so the assertion is robust to formatting.
normalised = "".join(str(guard).split()).replace('"', "'")

if "github.event.comment.user.type" not in normalised:
    print(
        "pr-review-mention job 'if:' guard does not reference "
        "github.event.comment.user.type",
        file=sys.stderr,
    )
    sys.exit(1)

if "!='Bot'" not in normalised:
    print(
        "pr-review-mention job 'if:' guard does not skip bot-authored comments "
        "(expected github.event.comment.user.type != 'Bot')",
        file=sys.stderr,
    )
    sys.exit(1)
PY
  echo "  done."
else
  error "pr-review-mention.yml validation failed"
fi

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "pr-review-mention bot-comment skip guard check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "pr-review-mention bot-comment skip guard check passed"
  exit 0
fi
