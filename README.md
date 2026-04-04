# BMad BGreat Suite

SRE and DevOps agents and workflows for the [BMad Method](https://github.com/bmad-code-org/BMAD-METHOD) ecosystem.

Two specialized agents — **Morgan** (SRE Lead) and **Riley** (DevOps Lead) — with four guided workflows that produce production-readiness artifacts alongside your architecture planning.

## What's Included

### Agents

| Agent | Role | Expertise |
|-------|------|-----------|
| **Morgan** (SRE Lead) | Observability, incident response, SLO/SLI, reliability | Golden Signals, RED/USE methods, OpenTelemetry, error budgets, chaos engineering, blameless postmortems |
| **Riley** (DevOps Lead) | Infrastructure, CI/CD, deployment, platform engineering | Terraform/Pulumi, Kubernetes, GitOps, pipeline design, blue-green/canary deployments |

### Workflows

| Workflow | Menu Code | Owner | Output |
|----------|-----------|-------|--------|
| Create Observability Plan | `CO` | Morgan | Metrics, logging, tracing, SLOs, dashboards, alerting strategy |
| Create Incident Response Plan | `CR` | Morgan | Severity levels, runbooks, on-call procedures, postmortem templates |
| Create Infrastructure Plan | `CI` | Riley | IaC strategy, environment topology, containers, networking |
| Create Pipeline Plan | `CP` | Riley | CI/CD stages, security scanning, deployment strategy, release gates |

### Recommended Workflow Order

```
Architecture (bmm) --> Infrastructure (CI) --> Pipeline (CP)
                   --> Observability (CO) --> Incident Response (CR)
```

Both tracks can run in parallel after the architecture is defined.

## Installation

### As a custom module (local path)

```bash
npx bmad-method install --custom-content /path/to/bmad-bgreat-suite/src
```

### As an npm package (once published)

```bash
npm install bmad-bgreat-suite
npx bmad-method install
# Select "BMad BGreat Suite" from the module list
```

## Configuration

During installation, the module will ask:

- **bgr_artifacts** — Where to store operations planning artifacts (default: `_bmad-output/bgr-artifacts`)
- **bgr_maturity** — Your current operations maturity level (greenfield through advanced)
- **cloud_preference** — Primary cloud provider
- **container_orchestration** — Container platform (Kubernetes, ECS, Cloud Run, etc.)

These settings shape how Morgan and Riley tailor their guidance.

## Usage

### Wake an agent

From the BMad help menu, select:
- `MG` — Wake Morgan (SRE Lead)
- `RL` — Wake Riley (DevOps Lead)

### Run a workflow directly

Invoke any workflow by menu code:
- `CO` — Create Observability Plan
- `CR` — Create Incident Response Plan
- `CI` — Create Infrastructure Plan
- `CP` — Create Pipeline Plan

### Cross-module collaboration

Morgan and Riley can both invoke the Architecture (`CA`) and Implementation Readiness (`IR`) workflows from the core BMad Method module, bringing their operational expertise into those conversations.

## Module Structure

```
src/
  module.yaml              # Module configuration and install prompts
  module-help.csv          # Capability registry
  agents/
    bgr-agent-morgan-sre/  # SRE Lead persona
    bgr-agent-riley-devops/# DevOps Lead persona
  workflows/
    bgr-3-create-observability/
    bgr-3-create-incident-response/
    bgr-3-create-infrastructure/
    bgr-3-create-pipeline/
```

Each workflow follows BMAD's micro-file architecture: a `workflow.md` orchestrator, sequential `steps/` for guided discovery, and `templates/` for output documents.

## Requirements

- [BMad Method](https://github.com/bmad-code-org/BMAD-METHOD) v6+
- Core module (required)
- BMad Method module (recommended — enables CA and IR cross-references)

## Attribution

This module incorporates ideas from these MIT-licensed projects in the BMad ecosystem:

- [Ricoledan/bmad-architecture-agent](https://github.com/Ricoledan/bmad-architecture-agent) — Platform Engineering expansion pack patterns (agent "Sam")
- [bacoco/BMad-Skills](https://github.com/bacoco/BMad-Skills) — Observability readiness skill structure and reference patterns

## Contributing

Contributions welcome. This module is designed to grow — new agents and workflows can be added following the patterns in `src/agents/` and `src/workflows/`.

1. Fork the repo
2. Create a feature branch
3. Follow existing conventions (SKILL.md, bmad-skill-manifest.yaml, workflow.md, steps/)
4. Submit a PR with a clear description

## License

MIT
