#!/usr/bin/env bash
# Creates or updates all required GitHub labels defined in .github/labels.yml.
# Usage: ./tools/setup-labels.sh [--repo owner/repo]
#
# Requires: gh CLI authenticated with repo scope.
# Run once after initial setup or whenever .github/labels.yml changes.

set -euo pipefail

REPO_FLAG=""
if [[ "${1:-}" == "--repo" && -n "${2:-}" ]]; then
  REPO_FLAG="--repo $2"
fi

LABELS_FILE="$(dirname "$0")/../.github/labels.yml"

if [[ ! -f "$LABELS_FILE" ]]; then
  echo "Error: $LABELS_FILE not found" >&2
  exit 1
fi

# Parse simple YAML list: name/color/description triples
name="" color="" description=""
while IFS= read -r line; do
  if [[ "$line" =~ ^[[:space:]]*-[[:space:]]+name:[[:space:]]+\"?([^\"]+)\"? ]]; then
    name="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ ^[[:space:]]+color:[[:space:]]+\"?([^\"]+)\"? ]]; then
    color="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ ^[[:space:]]+description:[[:space:]]+\"?([^\"]+)\"? ]]; then
    description="${BASH_REMATCH[1]}"
    if [[ -n "$name" && -n "$color" ]]; then
      # shellcheck disable=SC2086
      if gh label create "$name" $REPO_FLAG \
          --color "$color" \
          --description "$description" \
          --force 2>/dev/null; then
        echo "Created/updated label: $name"
      else
        echo "Warning: could not create label '$name'" >&2
      fi
    fi
    name="" color="" description=""
  fi
done < "$LABELS_FILE"
