# Step 3: Pipeline Stages

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## MATURITY-ADAPTIVE GUIDANCE:

Check `{bgr_maturity}` before designing pipeline stages. Right-size pipeline complexity to match the team's current capabilities:

| Maturity | Stage Focus | Testing | Security Scanning | Deployment Strategy |
|----------|-------------|---------|------------------|---------------------|
| **greenfield** | Core 5 stages: Source → Build → Test → Package → Deploy. Keep it simple and fast. | Unit tests gate the build. Defer E2E and performance tests to a future phase. | Dependency scanning (SCA) and secrets detection are the minimum bar. | Simple rolling deploy to staging, then manual-approved deploy to production. |
| **growing** | Add Staging Verification stage. Separate deploy-to-staging from post-deploy validation. | Add integration tests. E2E tests against staging. Define test data strategy. | Add SAST. Container image scanning if using containers. Set severity block thresholds. | Blue-green for stateless services. Database migration strategy required. |
| **established** | Full 9-stage pipeline. Add dedicated performance gating stage before production. | Performance tests with baseline comparison. Contract tests for microservices. | Full suite: SAST, SCA, container scanning, DAST on staging, secrets detection. | Canary deployments with automated analysis. Traffic shifting with validation at each increment. |
| **advanced** | Multi-pipeline architecture per service type. Parallel pipeline stages where safe. | Chaos engineering in pre-production. Synthetic monitoring in production verification. ML-based anomaly detection for automated rollback triggers. | Supply chain security: SBOM generation, artifact signing, provenance verification. | Multi-region deployments with global traffic management. Feature-flag-controlled rollouts. |

When reviewing pipeline stages with the user, focus on what's appropriate for their maturity tier. For greenfield teams, explicitly defer advanced stages (performance tests, canary deployments, chaos) as "future phases" to avoid overwhelming them. For advanced teams, challenge whether they have supply chain security and ML-driven rollback in place.

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
