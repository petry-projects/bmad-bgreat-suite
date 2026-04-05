# Step 4: Deployment Strategy

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 4.1 Deployment Model per Service Type

For each service identified in the architecture, select and configure a deployment model:

| Strategy | Best For | Trade-offs |
|----------|----------|------------|
| **Rolling** | Stateless services | Configure maxUnavailable/maxSurge; gradual rollout; lower resource cost |
| **Blue-Green** | Zero-downtime with instant rollback | Higher resource cost (2x capacity); instant switchover |
| **Canary** | Progressive validation | Traffic shifting (1% -> 5% -> 25% -> 100%) with automated analysis at each step |
| **Feature Flags** | Decoupling deploy from release | Runtime toggle; granular rollout; requires flag management platform |

Discuss with the user which strategy fits each service and document the rationale.

## 4.2 Rollback Strategy

Define rollback procedures for each deployment model:

- **Automated triggers** — Error rate spike, latency degradation, failed health checks, SLO breach
- **Automated rollback** — Conditions under which the system automatically reverts (canary failure, health check timeout)
- **Operator-initiated rollback** — Step-by-step process for triggering rollback through the pipeline UI (redeploy previous artifact). All rollbacks are pipeline-driven — never via SSH, console, or direct infrastructure changes.
- **Data migration rollback** — How to handle database changes when rolling back application code
- **Rollback verification** — How to confirm rollback was successful

## 4.3 Database Migration Strategy

Define how database changes are managed alongside application deployments:

- **Forward-only migrations** — All migrations move forward; rollback via compensating migrations
- **Backward-compatible changes** — Schema changes must work with both old and new application versions
- **Migration verification** — Pre-deploy checks, dry-run capability, row count validation
- **Migration ordering** — Run migrations before, during, or after application deployment
- **Large migration handling** — Background migrations, online DDL, migration windows

## 4.4 Zero-Downtime Deployment Requirements

Define requirements for maintaining availability during deployments:

- **Connection draining** — Graceful handling of in-flight requests during pod/instance termination
- **Graceful shutdown** — SIGTERM handling, shutdown timeout, cleanup procedures
- **Health check timing** — Startup probes, readiness probes, liveness probes, and their timing
- **Dependency readiness** — Ensuring downstream services and caches are warm before accepting traffic
- **Session handling** — Sticky sessions, session migration, or stateless design

## 4.5 Environment Promotion Gates

Define mandatory gates at each environment boundary:

- **Automated quality gates** — Tests, security scans, policy checks that must pass before promotion
- **Gate thresholds per boundary**:
  - Dev → Staging: unit tests pass, SAST clean (no critical/high), dependency scan clean, IaC plan validated
  - Staging → Production: all of above PLUS integration/e2e tests pass, performance baseline met, SLO compliance verified, container scan clean
  - Hotfix path: smoke tests + security scan + manual signoff, with mandatory post-deploy review within 24 hours
- **Signoff requirements** — Production promotion requires approval from at least one reviewer who did not author the change; signoff recorded in pipeline audit trail
- **No-bypass enforcement** — Pipeline configuration MUST prevent skipping gates, even for admins. No direct pushes to deployment branches. No manual image tag updates.
- **Audit trail** — All promotions logged with timestamp, approver identity, artifact version, and gate results

**Anti-Pattern Check:**

Before finalizing, explicitly verify:
- There is NO path to production that bypasses the pipeline
- There is NO mechanism to skip quality gates
- Rollbacks are executed through the pipeline, not manually
- Emergency changes use the hotfix pipeline, not console/SSH access

## 4.6 Release Management

Define the release management process:

- **Semantic versioning** — Version numbering scheme and when to bump major/minor/patch
- **Changelog generation** — Automated from commit messages, conventional commits, release tooling
- **Release notes automation** — What to include, audience, distribution
- **Release approval process** — Who approves, what criteria, emergency release procedures

## 4.7 Discuss and Document

Present the deployment strategy to the user. Update sections 4 and 5 of the pipeline plan with all deployment, promotion gate, and release management decisions.

---

**Menu:**

- **[C]ontinue** — Proceed to validation and finalization
- **[R]evise** — Adjust deployment strategy

🔄 **Before transitioning:** Update `stepsCompleted` in frontmatter to include `"step-04-deployment-strategy"`.

➡️ **NEXT:** `./step-05-validation.md`
