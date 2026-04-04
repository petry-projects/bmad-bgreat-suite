# Contributing to BMad Operations Suite

Thanks for your interest in contributing! This module is designed to grow — new agents, workflows, and templates are welcome.

## Getting Started

1. Fork the repository
2. Create a feature branch from `main`
3. Make your changes
4. Submit a pull request with a clear description

## Adding a New Agent

Create a directory under `src/agents/` following the naming pattern `ops-agent-{name}/` with:

- `SKILL.md` — Agent persona, expertise, capabilities table, and activation sequence
- `bmad-skill-manifest.yaml` — Agent metadata (`type: agent`, name, displayName, title, icon, etc.)

Register the agent in `src/module-help.csv` with a unique 2-letter menu code.

## Adding a New Workflow

Create a directory under `src/workflows/` following the pattern `ops-{phase}-{name}/` with:

- `SKILL.md` — Frontmatter with name and description, body delegates to `./workflow.md`
- `bmad-skill-manifest.yaml` — Just `type: skill`
- `workflow.md` — Workflow orchestrator with micro-file architecture, step processing rules, and activation
- `steps/` — Sequential step files (`step-01-init.md`, `step-01b-continue.md`, `step-02-*.md`, etc.)
- `templates/` — Output document templates with frontmatter tracking

Register the workflow in `src/module-help.csv` and update `.claude-plugin/marketplace.json`.

## Conventions

- Follow the existing step file structure: `# Step N: Title`, MANDATORY EXECUTION RULES, EXECUTION PROTOCOLS, CONTEXT BOUNDARIES, task content, and `[C]ontinue / [R]evise` menus
- Use `{ops_artifacts}` for output paths
- Config loads from `{project-root}/_bmad/ops/config.yaml`
- Steps update `stepsCompleted` in document frontmatter before loading the next step
- Templates use YAML frontmatter for state tracking (`status`, `stepsCompleted`, `inputDocuments`, dates)

## Code of Conduct

Be respectful and constructive. We follow the spirit of the [Contributor Covenant](https://www.contributor-covenant.org/).

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
