# BMad BGreat Suite

This repository contains the BMad BGreat Suite — a BMAD Method extension module
for SRE, DevOps, and Security production readiness planning.

## Agent Standards

Follow the development standards in [AGENTS.md](./AGENTS.md) and the
org-level standards at [petry-projects/.github/AGENTS.md](https://github.com/petry-projects/.github/blob/main/AGENTS.md).

## Project Context

- **Type:** BMAD Method extension module (content-only: markdown + YAML)
- **Agents:** Morgan (SRE), Riley (DevOps), Sam (Security)
- **Workflows:** 8 guided workflows for production readiness planning
- **Output:** Planning artifacts saved to `{bgr_artifacts}/` directory

## Key Files

- `src/module.yaml` — Module configuration and installation prompts
- `src/module-help.csv` — Complete skill registry with dependencies
- `src/agents/` — Agent persona definitions
- `src/workflows/` — Guided multi-step workflows

## Conventions

- All SKILL.md files require YAML frontmatter with `name` and `description`
- Workflow steps follow micro-file architecture (one step per file)
- Quality gates in validation steps must be verifiable and specific
- Cross-workflow references use sharded-first discovery pattern
