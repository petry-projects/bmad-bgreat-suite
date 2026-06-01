# Copilot Instructions — BMad BGreat Suite

## About

BMad BGreat Suite is a content-only BMAD Method extension module providing three specialized AI agents (Morgan/SRE, Riley/DevOps, Sam/Security) and eight guided workflows for production readiness planning.

## Tech Stack

- **Runtime:** None — content-only repository (Markdown + YAML; no compiled language)
- **Format:** Markdown workflow definitions, YAML configuration and manifests
- **Module system:** BMAD Method module (entry point: `src/module.yaml`)
- **Validation:** PyYAML (YAML syntax), Bash scripts (structure and integrity checks)
- **CI:** GitHub Actions

## Project Structure

```
src/
  agents/           # Agent persona definitions (SKILL.md + bmad-skill-manifest.yaml)
  workflows/        # Guided multi-step workflows
    {name}/
      SKILL.md                   # Entry point
      bmad-skill-manifest.yaml   # Manifest
      workflow.md                # Orchestrator
      steps/                     # Sequential step files (step-NN-*.md)
      templates/                 # Output document templates
  templates/        # Shared templates (production readiness checklist)
  module.yaml       # Module configuration and install prompts
  module-help.csv   # Skill registry (all agents and workflows)
.github/
  workflows/        # CI/CD pipeline definitions
tools/
  validate-skills.sh  # Structural integrity validator
```

## Local Dev Commands

- Validate YAML:    `pip install pyyaml && find . \( -name '*.yaml' -o -name '*.yml' \) -not -path '*/.git/*' | xargs -I{} python3 -c "import yaml, sys; yaml.safe_load(open(sys.argv[1]))" {}`
- Validate skills:  `bash tools/validate-skills.sh`

## Required Environment Variables

None — this is a content-only repository with no runtime or server process.

## Testing Framework

- No test runner (content-only repo)
- YAML syntax validation via `python3` + PyYAML (run in CI)
- Structural integrity checks via `tools/validate-skills.sh` (bash)
- All validation runs as part of the CI `validate` job

## Repo-Specific Overrides

- This repo contains no source code — do not suggest language-specific patterns, dependencies, or build tooling
- Markdown tables must use standard pipe syntax (`| col | col |`) — no double pipes
- YAML frontmatter in SKILL.md files must include `name` and `description` fields
- Template variables use `{{variable}}` or `{variable}` syntax (not `${}` or `<>`)

## Org Standards

See [petry-projects/.github — AGENTS.md](https://github.com/petry-projects/.github/blob/main/AGENTS.md) for full development standards.
