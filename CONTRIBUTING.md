# Contributing to BMad BGreat Suite

## Overview

The BMad BGreat Suite is a BMAD Method extension module providing specialized AI agents (Morgan/SRE, Riley/DevOps, Sam/Security) and seven guided workflows for production readiness planning. The codebase is content-only: markdown workflow definitions, YAML configuration, and output templates.

## Architecture

- **Micro-file architecture:** each workflow = `SKILL.md` + manifest + `workflow.md` + `steps/` + `templates/`
- **Step processing:** sequential, user-controlled, append-only document building
- **Config variables:** resolved from `{project-root}/_bmad/bgr/config.yaml`
- **Output:** planning artifacts saved to `{bgr_artifacts}/`

```text
src/
├── agents/           # Agent personas (SKILL.md + manifest)
├── workflows/        # Guided multi-step workflows
│   └── {name}/
│       ├── SKILL.md
│       ├── bmad-skill-manifest.yaml
│       ├── workflow.md
│       ├── steps/
│       └── templates/
├── templates/        # Shared templates (production readiness checklist)
├── module.yaml       # Module configuration
└── module-help.csv   # Skill registry
```

## Adding a New Workflow

Every workflow lives in `src/workflows/bgr-3-<name>/` and requires:

| File | Purpose |
|------|---------|
| `SKILL.md` | Trigger phrases and pointer to workflow.md |
| `bmad-skill-manifest.yaml` | Metadata (`type: skill`) |
| `workflow.md` | Goal, role, architecture, activation |
| `steps/step-01-init.md` | Initialization and input discovery |
| `steps/step-01b-continue.md` | Continuation handler |
| `steps/step-02-*.md` through `step-04-*.md` | Domain-specific steps |
| `steps/step-05-validation.md` | Quality gates and cross-workflow checks |
| `templates/<name>-template.md` | Output template with frontmatter |

After creating files:
1. Update `src/module.yaml` description and subheader workflow count
2. Update `src/module-help.csv` with a new entry (unique 2-char menu code)
3. Update `AGENTS.md` workflow count

## Adding a New Agent

Agent personas live in `src/agents/bgr-agent-<name>/` and require:

| File | Purpose |
|------|---------|
| `SKILL.md` | Full persona: identity, principles, capabilities, expertise, on-activation |
| `bmad-skill-manifest.yaml` | Full metadata |

Register in `src/module-help.csv` with correct phase, dependencies, and menu code.

## Step File Contract

New step files should follow this structure (existing files may vary — use newer workflows like infrastructure or capacity plan as references):

1. **MANDATORY EXECUTION RULES** — behavioral constraints (no content without user input, read complete step, facilitator role)
2. **EXECUTION PROTOCOLS** — action requirements (show analysis, update frontmatter, gate next step)
3. **CONTEXT BOUNDARIES** — what's in scope (loaded documents, frontmatter state)
4. Sequential numbered task sections with discovery questions and decision tables
5. Content generation template matching the output template sections
6. **[C]ontinue / [R]evise menu** — halt for user input before proceeding
7. **SUCCESS METRICS** and **FAILURE MODES**

Update `stepsCompleted` as a numeric array (e.g., `[1, 2, 3]`) before transitioning. Some older workflows use string step IDs — numeric arrays are the preferred convention going forward.

## Frontmatter Schema

All output templates must include this YAML frontmatter:

```yaml
---
status: draft                # draft | complete | approved
stepsCompleted: []           # numeric array, e.g. [1, 2, 3]
createdDate: ""
lastUpdated: ""
inputDocuments: []           # discovered input docs (allowed empty)
crossWorkflowContext: []     # cross-workflow references (allowed empty)
---
```

## Module-Help.csv Format

| Field | Description |
|-------|-------------|
| `module` | Always `BGreat Suite` |
| `skill` | Skill ID (e.g., `bgr-3-create-observability`) |
| `display-name` | Human-readable name |
| `menu-code` | Unique 2-character code (e.g., `CO`, `CR`) |
| `description` | One-line description |
| `action` | Leave blank for workflows |
| `args` | Leave blank |
| `phase` | BMAD phase (e.g., `3-solutioning`) |
| `after` | Dependency skill ID |
| `before` | Leave blank |
| `required` | `true` or `false` |
| `output-location` | `bgr_artifacts` for workflows |
| `outputs` | Artifact name |

## Config Variables

**Module-specific** (defined in `module.yaml`):

| Variable | Description |
|----------|-------------|
| `{bgr_artifacts}` | Output directory for planning artifacts |
| `{bgr_maturity}` | Operations maturity level |
| `{cloud_preference}` | Primary cloud provider |
| `{container_orchestration}` | Container platform |

**Inherited from core:**

`{user_name}`, `{communication_language}`, `{document_output_language}`, `{project_knowledge}`, `{output_folder}`

## AI-Generated Code Policy

- Read 2+ existing reference workflows before writing new ones
- Follow all naming conventions and structural patterns documented above
- Run `bash tools/validate-skills.sh` before submitting (added in PR #66)
- AI-generated contributions receive the same review scrutiny as human contributions

## PR Checklist

- [ ] Skill validator passes (if applicable)
- [ ] `module.yaml` counts and description updated
- [ ] `module-help.csv` entry added with unique 2-char menu code
- [ ] `AGENTS.md` counts updated
- [ ] Production readiness checklist template updated (if adding a workflow)
- [ ] Step files follow naming convention and include all required sections
- [ ] Templates include required frontmatter fields (`status`, `stepsCompleted`, `createdDate`, `lastUpdated`)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
