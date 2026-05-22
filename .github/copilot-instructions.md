# Copilot Instructions — bmad-bgreat-suite

> **Note:** This file applies to the `petry-projects/bmad-bgreat-suite` repository only. Org-wide rules are in [`petry-projects/.github/copilot-instructions.md`](https://github.com/petry-projects/.github/blob/main/.github/copilot-instructions.md). This file covers only what is specific to bmad-bgreat-suite.

## About

BMad BGreat Suite is a custom BMad Method plugin providing three specialized agents (Morgan SRE Lead, Riley DevOps Lead, Sam Security) and guided operational workflows (Observability Plan, Incident Response Plan, Infrastructure Plan, Pipeline Plan, Chaos Gameday Plan, Capacity Plan, Cost Optimization Plan) for the petry-projects org.

## Tech Stack

- **Runtime:** None (content-only plugin package)
- **Framework:** BMad Method plugin system (installed via `npx bmad-method install`)
- **Testing:** N/A
- **Linting:** markdownlint (Markdown files)
- **Key tools:** `npx bmad-method` CLI for installation

## Project Structure

```text
src/
  agents/
    bgr-agent-morgan-sre/     # Morgan — SRE Lead agent profile + SKILL.md
    bgr-agent-riley-devops/   # Riley — DevOps Lead agent profile + SKILL.md
    bgr-agent-sam-security/   # Sam — Security agent profile + SKILL.md
  skills/
    bgr-ops-review/           # Ops review skill + report template
  workflows/
    bgr-3-create-capacity-plan/
    bgr-3-create-chaos-gameday-plan/
    bgr-3-create-cost-optimization-plan/
    bgr-3-create-infrastructure-plan/
    bgr-3-create-observability-plan/
    bgr-3-create-incident-response-plan/
    bgr-3-create-pipeline-plan/
  templates/
    bgr-production-readiness-checklist-template.md
  module.yaml                 # BMad module manifest
  module-help.csv             # Help index for module discovery
```

## Local Dev Commands

- Install plugin: `npx bmad-method install --custom-content /path/to/bmad-bgreat-suite/src`
- No build, test, or lint commands (content-only package)

## Required Environment Variables

_None — this is a content-only package with no runtime._

## Testing Framework

- Runner: N/A
- Coverage: N/A
- Mutation testing: N/A

## Repo-Specific Overrides

**Content-only repo.** All `SKILL.md`, `workflow.md`, `bmad-skill-manifest.yaml`, `template.md`, and `step-*.md` files are BMad plugin artifacts defining agent behavior and workflow steps — they are not executable code. Follow BMad Method conventions for frontmatter and content structure when editing these files. Do not add a test suite, build toolchain, or CI lint beyond what is already configured.

## Org Standards

See [petry-projects/.github — AGENTS.md](https://github.com/petry-projects/.github/blob/main/AGENTS.md).
