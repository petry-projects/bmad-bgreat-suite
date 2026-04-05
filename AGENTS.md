# BMad BGreat Suite — Agent Development Standards

> Extends the org-level standards at [petry-projects/.github/AGENTS.md](https://github.com/petry-projects/.github/blob/main/AGENTS.md).
> This file defines project-specific conventions for the BGreat Suite module.

## Project Overview

The BMad BGreat Suite is a BMAD Method extension module providing three
specialized AI agents (Morgan/SRE, Riley/DevOps, Sam/Security) and eight
guided workflows for production readiness planning. The codebase is
content-only: markdown workflow definitions, YAML configuration, and
output templates.

## Repository Structure

```
src/
├── agents/           # Agent persona definitions (SKILL.md + manifest)
├── workflows/        # Guided multi-step workflows
│   └── {name}/
│       ├── SKILL.md              # Entry point
│       ├── bmad-skill-manifest.yaml
│       ├── workflow.md           # Orchestrator
│       ├── steps/                # Sequential step files
│       └── templates/            # Output document templates
├── templates/        # Shared templates (production readiness checklist)
├── module.yaml       # Module configuration
└── module-help.csv   # Skill registry
```

## Development Standards

### Skill File Conventions

- Every SKILL.md MUST have YAML frontmatter with `name` and `description` fields
- Every workflow directory MUST contain: SKILL.md, bmad-skill-manifest.yaml, workflow.md, steps/, templates/
- Every agent and workflow MUST be registered in `module-help.csv`
- Step files are numbered sequentially: `step-01-init.md`, `step-02-*.md`, etc.
- Step files MUST include mandatory execution rules block
- Step files MUST present [C]ontinue / [R]evise menus and halt for user input

### Content Quality

- Markdown tables must use standard syntax (`| col | col |`) — no double pipes
- YAML frontmatter must be valid (parseable by standard YAML parsers)
- Template variables use `{{variable}}` or `{variable}` syntax consistently
- Config variables reference `{bgr_artifacts}`, `{bgr_maturity}`, `{communication_language}`, etc.

### Cross-Workflow Consistency

- Workflows that reference other workflow outputs must use the discovery pattern (sharded-first logic)
- Quality gates in step-05-validation must be verifiable and specific
- Cross-workflow coherence checks must reference actual artifacts, not hypothetical ones
- The production readiness checklist must be updated by every workflow's validation step

### Module Registration

- New agents must be added to module-help.csv with correct phase, dependencies, and menu code
- New workflows must specify `after:` dependencies accurately
- Module.yaml must reflect the correct agent/workflow counts

### Security

- No secrets, API keys, or credentials in any file
- No `dangerouslySkipPermissions` or permission bypass directives
- Agent configs must not include overly permissive tool authorizations
- SKILL.md files must not instruct agents to bypass security controls

## CI Checks

All PRs must pass:
- **CI Validate** — YAML validation, module structure, module-help.csv consistency
- **AgentShield** — Agent config security (secrets scan, permission bypass detection, frontmatter validation)
- **CodeQL** — SAST scanning for GitHub Actions
- **SonarCloud** — Code quality analysis
- **Claude Code** — AI-assisted PR review
