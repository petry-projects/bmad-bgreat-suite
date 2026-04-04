# Step 3: Pipeline Stages

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 3.1 Design End-to-End Pipeline Stages

Walk through each stage with the user, defining configuration, pass/fail criteria, timeouts, retry policies, and notifications.

### Stage 1: Source

- Trigger rules (push, PR, tag, schedule, manual)
- Branch filters (which branches trigger which pipelines)
- Path filters (only trigger on relevant file changes)
- Webhook configuration and event filtering

### Stage 2: Build

- Compilation and dependency resolution
- Caching strategy (dependency cache, build cache, Docker layer cache)
- Build parallelization and matrix builds
- Build artifact output and versioning

### Stage 3: Test

Define the testing pyramid with stage gates:

| Test Type | Stage Gate | Timeout | Retry | Notes |
|-----------|-----------|---------|-------|-------|
| Unit tests | Fast — gate the build | | | Run on every push |
| Integration tests | Parallel execution | | | Service dependencies mocked or containerized |
| E2E tests | Staging environment | | | Run against deployed staging |
| Performance tests | Gate production | | | Baseline comparison, regression detection |

For each test type, define:
- Pass/fail thresholds (coverage minimums, performance budgets)
- Parallelization strategy
- Test data management
- Flaky test handling

### Stage 4: Security Scanning

| Scan Type | Tool | Stage | Blocking | Notes |
|-----------|------|-------|----------|-------|
| SAST | | Build | | Static analysis of source code |
| Dependency scanning | | Build | | Known vulnerability detection |
| Container image scanning | | Package | | Image vulnerability assessment |
| Secrets detection | | Source | | Prevent credential leaks |

For each scan type, define:
- Severity thresholds (which findings block the pipeline)
- Exception/suppression workflow
- Reporting and notification

### Stage 5: Package

- Container image build (multi-stage, minimal base images)
- Artifact versioning (semantic version, git SHA, build number)
- Image/artifact signing for supply chain security
- Registry push and tagging strategy

### Stage 6: Deploy to Staging

- Automated deployment triggered by successful package stage
- Environment provisioning (infrastructure-as-code, ephemeral environments)
- Data seeding and database migration execution
- Configuration management (environment-specific secrets, feature flags)

### Stage 7: Staging Verification

- Smoke tests against deployed staging environment
- Synthetic monitoring and health checks
- Manual QA checkpoint (if applicable)
- Performance validation against baseline

### Stage 8: Production Promotion

- Approval gates (manual approval, automated policy checks)
- Deployment strategy execution (canary, blue-green, rolling)
- Traffic shifting schedule and validation at each increment
- Communication and change management notifications

### Stage 9: Post-Deploy Verification

- Production smoke tests (critical path validation)
- SLO monitoring (error rate, latency, availability)
- Automated rollback triggers (metric thresholds, anomaly detection)
- Post-deploy notification and status reporting

## 3.2 Discuss and Document

Present the complete pipeline stages to the user. Update section 3 of the pipeline plan with all stage definitions, including the test and security scanning tables.

---

**Menu:**

- **[C]ontinue** — Proceed to deployment strategy
- **[R]evise** — Adjust pipeline stages

🔄 **Before transitioning:** Update `stepsCompleted` in frontmatter to include `"step-03-pipeline-stages"`.

➡️ **NEXT:** `./step-04-deployment-strategy.md`
