# Step 2: Pipeline Architecture

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 2.1 CI/CD Platform Selection

Present platform options and discuss trade-offs with the user:

| Platform | Strengths | Considerations |
|----------|-----------|---------------|
| GitHub Actions | Native GitHub integration, marketplace, managed runners | GitHub lock-in, runner minute limits |
| GitLab CI | Built-in container registry, auto DevOps | Self-hosted complexity, resource usage |
| Jenkins | Maximum flexibility, plugin ecosystem | Maintenance burden, security patching |
| CircleCI | Fast builds, good caching, Docker-native | Cost at scale, limited self-hosted |
| Azure DevOps | Enterprise features, Azure integration | Microsoft ecosystem coupling |
| Buildkite | Hybrid model, self-hosted agents, scale | Smaller community, agent management |

Consider with the user:

- Team expertise and existing familiarity
- Existing infrastructure and cloud provider alignment
- Cost model (managed runners vs self-hosted)
- Ecosystem integrations (container registries, artifact stores, notification systems)
- Self-hosted vs managed runner requirements
- Multi-platform or combination approaches

## 2.2 Branching Strategy

Define the branching strategy and how it maps to pipeline triggers:

- **Trunk-based development** — Short-lived feature branches, frequent merges to main, CI runs on every push
- **GitFlow** — Develop/release/hotfix branches, CI/CD per branch type, release branches trigger staging deploys
- **GitHub Flow** — Feature branches + main, PR-triggered CI, merge-to-main triggers deploy

For each branch type, define:
- Pipeline trigger rules (push, PR, tag, schedule)
- Which stages execute (e.g., PRs run build+test, main runs full pipeline)
- Environment mapping (feature branch -> ephemeral, main -> staging, tag -> production)

## 2.3 Runner/Agent Strategy

Define the compute strategy for pipeline execution:

- **Managed vs self-hosted** — Cost, performance, security trade-offs
- **Runner sizing** — CPU/memory for build, test, and deploy jobs
- **Caching strategy** — Dependency caches, build caches, Docker layer caches
- **Security isolation** — Secrets access, network segmentation, ephemeral runners
- **Scaling** — Auto-scaling policies, queue management, concurrency limits

## 2.4 Artifact Management

Define artifact handling across the pipeline:

- **Container registry** — Where images are stored, tagging strategy, vulnerability scanning
- **Package registry** — Language-specific packages (npm, PyPI, Maven, etc.)
- **Artifact storage** — Build outputs, test reports, coverage data
- **Retention policies** — How long artifacts are kept, cleanup automation

## 2.5 Pipeline-as-Code Approach

Define how pipelines are defined and managed:

- YAML definitions stored in the repository
- Shared templates / reusable workflows for common patterns
- Versioning strategy for pipeline definitions
- Pipeline validation and linting

## 2.6 Discuss and Document

Present the proposed pipeline architecture to the user. Update section 2 of the pipeline plan with agreed decisions.

---

**Menu:**

- **[C]ontinue** — Proceed to pipeline stages design
- **[R]evise** — Adjust pipeline architecture decisions

🔄 **Before transitioning:** Update `stepsCompleted` in frontmatter to include `"step-02-pipeline-architecture"`.

➡️ **NEXT:** `./step-03-pipeline-stages.md`
