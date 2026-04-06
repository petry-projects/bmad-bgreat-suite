#!/usr/bin/env bash
# Skill Validator for BMad BGreat Suite
# Runs deterministic structural checks on all skills and workflows.
# Exit 0 = all checks pass, Exit 1 = failures found.
set -euo pipefail

ERRORS=0
SRC="src"

error() {
  echo "ERROR: $1"
  ERRORS=$((ERRORS + 1))
}

echo "=== BMad BGreat Suite — Skill Validator ==="
echo ""

# ---------------------------------------------------------------------------
# Check 1: Every workflow directory has SKILL.md and bmad-skill-manifest.yaml
# ---------------------------------------------------------------------------
echo "Check 1: Workflow directories have SKILL.md and bmad-skill-manifest.yaml"
for dir in "$SRC"/workflows/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -f "$dir/SKILL.md" ]; then
    error "Missing SKILL.md in workflows/$name"
  fi
  if [ ! -f "$dir/bmad-skill-manifest.yaml" ]; then
    error "Missing bmad-skill-manifest.yaml in workflows/$name"
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 2: Every workflow directory has workflow.md
# ---------------------------------------------------------------------------
echo "Check 2: Workflow directories have workflow.md"
for dir in "$SRC"/workflows/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -f "$dir/workflow.md" ]; then
    error "Missing workflow.md in workflows/$name"
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 3: Every workflow directory has a steps/ directory with at least step-01-init.md
# ---------------------------------------------------------------------------
echo "Check 3: Workflow directories have steps/step-01-init.md"
for dir in "$SRC"/workflows/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -d "$dir/steps" ]; then
    error "Missing steps/ directory in workflows/$name"
  elif [ ! -f "$dir/steps/step-01-init.md" ]; then
    error "Missing steps/step-01-init.md in workflows/$name"
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 4: Every workflow directory has a templates/ directory with at least one template
# ---------------------------------------------------------------------------
echo "Check 4: Workflow directories have templates/ with at least one file"
for dir in "$SRC"/workflows/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -d "$dir/templates" ]; then
    error "Missing templates/ directory in workflows/$name"
  else
    count=$(find "$dir/templates" -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
    if [ "$count" -eq 0 ]; then
      error "No template files found in workflows/$name/templates/"
    fi
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 5: Step files follow naming convention (step-NN-*.md or step-NNb-*.md)
# ---------------------------------------------------------------------------
echo "Check 5: Step file naming convention"
for dir in "$SRC"/workflows/*/steps; do
  [ -d "$dir" ] || continue
  wf_name=$(basename "$(dirname "$dir")")
  for file in "$dir"/*; do
    [ -f "$file" ] || continue
    fname=$(basename "$file")
    if ! echo "$fname" | grep -qE '^step-[0-9]{2}[a-z]?-.*\.md$'; then
      error "Invalid step file name '$fname' in workflows/$wf_name/steps/ (expected step-NN-*.md or step-NNb-*.md)"
    fi
  done
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 6: All relative path references in step files resolve to real files
#   Patterns: `../templates/X`, `./steps/X`, `../../../templates/X`
#   Also checks workflow.md for `./steps/X` and `./templates/X`
# ---------------------------------------------------------------------------
echo "Check 6: Relative path references resolve to real files"
for dir in "$SRC"/workflows/*/; do
  [ -d "$dir" ] || continue
  wf_name=$(basename "$dir")

  # Check workflow.md for ./steps/ and ./templates/ references
  if [ -f "$dir/workflow.md" ]; then
    while IFS= read -r ref; do
      target="$dir/$ref"
      if [ ! -f "$target" ]; then
        error "Broken reference '$ref' in workflows/$wf_name/workflow.md (file not found: $target)"
      fi
    done < <(grep -oE '\./steps/[A-Za-z0-9_-]+\.md|\./templates/[A-Za-z0-9_-]+\.md' "$dir/workflow.md" 2>/dev/null || true)
  fi

  # Check step files for ../templates/ and ../../../templates/ references
  for stepfile in "$dir"/steps/*.md; do
    [ -f "$stepfile" ] || continue
    step_fname=$(basename "$stepfile")
    while IFS= read -r ref; do
      # Resolve relative to the step file's directory
      target="$dir/steps/$ref"
      resolved=$(cd "$dir/steps" && realpath -q "$ref" 2>/dev/null || echo "")
      if [ -z "$resolved" ] || [ ! -f "$resolved" ]; then
        error "Broken reference '$ref' in workflows/$wf_name/steps/$step_fname (file not found)"
      fi
    done < <(grep -oE '\.\./templates/[A-Za-z0-9_-]+\.md|\.\./\.\./\.\./templates/[A-Za-z0-9_-]+\.md' "$stepfile" 2>/dev/null || true)
  done
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 7: All templates have required frontmatter fields (status, stepsCompleted)
#   Note: Some templates (runbook, postmortem) are fill-in templates without
#   workflow frontmatter. We only require frontmatter on the primary template
#   (the one with YAML frontmatter delimiters).
# ---------------------------------------------------------------------------
echo "Check 7: Template frontmatter required fields"
for dir in "$SRC"/workflows/*/templates; do
  [ -d "$dir" ] || continue
  wf_name=$(basename "$(dirname "$dir")")
  for tmpl in "$dir"/*.md; do
    [ -f "$tmpl" ] || continue
    tmpl_name=$(basename "$tmpl")
    # Check if file starts with YAML frontmatter
    first_line=$(head -1 "$tmpl")
    if [ "$first_line" = "---" ]; then
      # Extract frontmatter (between first and second ---)
      frontmatter=$(sed -n '1,/^---$/{ /^---$/d; p; }' "$tmpl" | sed '1d')
      # The sed above skips the first --- then collects until the next ---
      # Re-extract more carefully:
      frontmatter=$(awk 'BEGIN{f=0} /^---$/{f++; next} f==1{print} f>=2{exit}' "$tmpl")
      if ! echo "$frontmatter" | grep -q '^status:'; then
        error "Missing 'status' in frontmatter of workflows/$wf_name/templates/$tmpl_name"
      fi
      if ! echo "$frontmatter" | grep -q '^stepsCompleted:'; then
        error "Missing 'stepsCompleted' in frontmatter of workflows/$wf_name/templates/$tmpl_name"
      fi
    fi
  done
done
# Also check shared templates
for tmpl in "$SRC"/templates/*.md; do
  [ -f "$tmpl" ] || continue
  tmpl_name=$(basename "$tmpl")
  first_line=$(head -1 "$tmpl")
  if [ "$first_line" = "---" ]; then
    frontmatter=$(awk 'BEGIN{f=0} /^---$/{f++; next} f==1{print} f>=2{exit}' "$tmpl")
    if ! echo "$frontmatter" | grep -q '^status:'; then
      error "Missing 'status' in frontmatter of templates/$tmpl_name"
    fi
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 8: module-help.csv menu codes are unique and exactly 2 characters
# ---------------------------------------------------------------------------
echo "Check 8: module-help.csv menu code uniqueness and format"
if [ -f "$SRC/module-help.csv" ]; then
  # Skip header row, extract menu-code (field 4)
  tail -n +2 "$SRC/module-help.csv" | while IFS=',' read -r _module _skill _display menu_code _rest; do
    menu_code=$(echo "$menu_code" | tr -d '[:space:]')
    [ -z "$menu_code" ] && continue
    if ! echo "$menu_code" | grep -qE '^[A-Za-z0-9]{2}$'; then
      error "Menu code '$menu_code' is not exactly 2 characters in module-help.csv"
    fi
  done

  # Check uniqueness
  dupes=$(tail -n +2 "$SRC/module-help.csv" | awk -F',' '{gsub(/[[:space:]]/, "", $4); if ($4 != "") print $4}' | sort | uniq -d)
  if [ -n "$dupes" ]; then
    for d in $dupes; do
      error "Duplicate menu code '$d' in module-help.csv"
    done
  fi
else
  error "Missing $SRC/module-help.csv"
fi
echo "  done."

# ---------------------------------------------------------------------------
# Check 9: Every agent directory has SKILL.md and bmad-skill-manifest.yaml
# ---------------------------------------------------------------------------
echo "Check 9: Agent directories have SKILL.md and bmad-skill-manifest.yaml"
for dir in "$SRC"/agents/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -f "$dir/SKILL.md" ]; then
    error "Missing SKILL.md in agents/$name"
  fi
  if [ ! -f "$dir/bmad-skill-manifest.yaml" ]; then
    error "Missing bmad-skill-manifest.yaml in agents/$name"
  fi
done
echo "  done."

# ---------------------------------------------------------------------------
# Check 10: Config variables referenced in step files exist in module.yaml
#   Only checks backtick-quoted config references like `{var_name}` which
#   indicate actual config variable usage. Bare {var_name} patterns in
#   document content are template placeholders and are not checked.
# ---------------------------------------------------------------------------
echo "Check 10: Config variable references exist in module.yaml"

# Build list of known config variables from module.yaml
# Includes both defined keys and commented inherited keys
known_vars=""
if [ -f "$SRC/module.yaml" ]; then
  # Top-level keys (bgr_artifacts, bgr_maturity, cloud_preference, container_orchestration)
  yaml_keys=$(grep -E '^[a-z][a-z_]+:' "$SRC/module.yaml" | sed 's/:.*//' || true)
  # Commented inherited keys (## user_name, ## communication_language, etc.)
  inherited_keys=$(grep -E '^## [a-z]' "$SRC/module.yaml" | sed 's/^## //' || true)
  known_vars="$yaml_keys"$'\n'"$inherited_keys"
fi

# Known non-config placeholders to skip
skip_pattern='^(project-root)$'

for stepfile in "$SRC"/workflows/*/steps/*.md "$SRC"/workflows/*/workflow.md "$SRC"/agents/*/SKILL.md; do
  [ -f "$stepfile" ] || continue
  # Extract only backtick-quoted config refs: `{var_name}`
  refs=$(grep -oE '`\{[a-z][a-z_-]*\}`' "$stepfile" 2>/dev/null | sed 's/[`{}]//g' | sort -u || true)
  for var in $refs; do
    if echo "$var" | grep -qE "$skip_pattern"; then
      continue
    fi
    if ! echo "$known_vars" | grep -qx "$var"; then
      rel_path=${stepfile#"$SRC"/}
      error "Config variable '{$var}' referenced in $rel_path not found in module.yaml"
    fi
  done
done
echo "  done."

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "Validation failed with $ERRORS error(s)"
  exit 1
else
  echo "All validation checks passed"
  exit 0
fi
