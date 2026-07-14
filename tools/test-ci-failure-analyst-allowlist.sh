#!/usr/bin/env bash
# Validates that every workflow named in the ci-failure-analyst.yml
# `workflow_run.workflows` allowlist corresponds to a real workflow file in
# .github/workflows/ (matched on its `name:` value). The allowlist is an
# explicit opt-in list; an entry with no backing workflow is dead configuration
# that silently never fires — most often a workflow that was renamed or removed
# (e.g. the deprecated `claude.yml` / "Claude Code", removed org-wide 2026-05).
set -euo pipefail

ERRORS=0
ANALYST=".github/workflows/ci-failure-analyst.yml"
WORKFLOW_DIR=".github/workflows"

error() {
  echo "ERROR: $1" >&2
  ERRORS=$((ERRORS + 1))
}

echo "=== ci-failure-analyst.yml — workflow_run allowlist check ==="
echo ""

if [[ ! -f "$ANALYST" ]]; then
  error "Missing $ANALYST"
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

# Every allowlist entry must match the `name:` of some workflow file in this
# repo. Orphaned entries (no backing file) are reported so they can be removed.
echo "Check: every allowlist entry maps to a real workflow name"
if python3 - "$ANALYST" "$WORKFLOW_DIR" << 'PY'; then
import glob
import os
import sys

import yaml

analyst_path = sys.argv[1]
workflow_dir = sys.argv[2]


def workflow_names(directory):
    names = set()
    for path in glob.glob(os.path.join(directory, "*.yml")) + glob.glob(
        os.path.join(directory, "*.yaml")
    ):
        try:
            with open(path, encoding="utf-8") as fh:
                doc = yaml.safe_load(fh)
        except yaml.YAMLError as exc:
            print(f"Invalid YAML syntax in {path}: {exc}", file=sys.stderr)
            sys.exit(1)
        if isinstance(doc, dict) and doc.get("name"):
            names.add(doc["name"])
    return names


try:
    with open(analyst_path, encoding="utf-8") as fh:
        analyst = yaml.safe_load(fh)
except yaml.YAMLError as exc:
    print(f"Invalid YAML syntax in {analyst_path}: {exc}", file=sys.stderr)
    sys.exit(1)

if not isinstance(analyst, dict):
    print("ci-failure-analyst.yml did not parse to a mapping", file=sys.stderr)
    sys.exit(1)

# PyYAML parses the bare `on:` key as the boolean True.
on = analyst.get("on")
if on is None:
    on = analyst.get(True)
if not isinstance(on, dict):
    print("could not find the `on:` block", file=sys.stderr)
    sys.exit(1)

workflow_run = on.get("workflow_run")
if not isinstance(workflow_run, dict):
    print("could not find the `on.workflow_run` block", file=sys.stderr)
    sys.exit(1)

allowlist = workflow_run.get("workflows")
if not isinstance(allowlist, list):
    print("could not find the `on.workflow_run.workflows` list", file=sys.stderr)
    sys.exit(1)

known = workflow_names(workflow_dir)
orphans = [entry for entry in allowlist if entry not in known]
if orphans:
    for entry in orphans:
        print(
            f"orphaned allowlist entry {entry!r} — no workflow file in "
            f"{workflow_dir} declares `name: {entry}`. Remove it or add the "
            "workflow.",
            file=sys.stderr,
        )
    sys.exit(1)
PY
  echo "  done."
else
  error "ci-failure-analyst.yml validation failed"
fi

echo ""
if [[ "$ERRORS" -gt 0 ]]; then
  echo "ci-failure-analyst allowlist check failed with $ERRORS error(s)" >&2
  exit 1
else
  echo "ci-failure-analyst allowlist check passed"
  exit 0
fi
