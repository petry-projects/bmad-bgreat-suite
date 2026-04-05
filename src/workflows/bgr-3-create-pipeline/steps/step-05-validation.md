# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 5.1 Quality Gate Checklist

Check `{bgr_maturity}` before evaluating gates. Gates are marked with the minimum maturity level at which they are **required**:
- 🟢 **All** — Required at every maturity level
- 🟡 **Growing+** — Required for growing, established, and advanced teams
- 🟠 **Established+** — Required for established and advanced teams
- 🔴 **Advanced** — Advanced teams only

Review the pipeline plan against these quality gates. Present each item with a pass/fail status (or "deferred — not required at this maturity level" for gates above the team's current tier):

| # | Quality Gate | Maturity | Status |
|---|-------------|----------|--------|
| 1 | CI/CD platform selected with pipeline-as-code approach | 🟢 All | |
| 2 | Branching strategy defined with trigger mapping | 🟢 All | |
| 3 | Core pipeline stages documented with pass/fail criteria | 🟢 All | |
| 4 | Dependency scanning (SCA) and secrets detection integrated | 🟢 All | |
| 5 | Deployment strategy defined per service type | 🟢 All | |
| 6 | Rollback procedures documented | 🟢 All | |
| 7 | SAST and container image scanning integrated | 🟡 Growing+ | |
| 8 | E2E tests on staging environment | 🟡 Growing+ | |
| 9 | Database migration strategy addressed | 🟡 Growing+ | |
| 10 | Artifact management and retention defined | 🟡 Growing+ | |
| 11 | Performance tests gating production deployments | 🟠 Established+ | |
| 12 | DAST integrated on pre-production environment | 🟠 Established+ | |
| 13 | Canary or blue-green deployment strategy with automated analysis | 🟠 Established+ | |
| 14 | Supply chain security: SBOM generation and artifact signing | 🔴 Advanced | |
| 15 | ML-based anomaly detection for automated rollback triggers | 🔴 Advanced | |

For any required gate that fails, note what is missing and discuss with the user whether to address it now or defer.

## 5.2 Present Validation Summary

Present a concise summary of the complete pipeline plan:

- 🏗️ **Platform & Architecture** — CI/CD platform, branching strategy, runner strategy
- 🔄 **Pipeline Stages** — Number of stages, key stage gates, estimated pipeline duration
- 🔒 **Security** — Scanning tools integrated, blocking vs advisory findings
- 🚀 **Deployment** — Strategy per service, rollback approach, zero-downtime requirements
- 📦 **Release** — Versioning scheme, changelog automation, approval process

## 5.3 Address Gaps

If any quality gates failed:

- Discuss with the user whether to fill gaps now or document them as follow-up items
- For deferred items, add them to section 6 (Implementation Sequence) as future phases

## 5.4 Finalize Document

- Update `status` in frontmatter from `draft` to `complete`
- Update `lastUpdated` to today's date
- Save the final document to `{bgr_artifacts}/pipeline.md`

## 5.5 Update Production Readiness Checklist

After saving the pipeline plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it from `../../../templates/bgr-production-readiness-checklist-template.md`
2. Update the **CI/CD Pipeline Plan** row in the Workflow Completion Status table:
   - Status: `Complete`
   - Completion Date: today's date
   - Output Document: `{bgr_artifacts}/pipeline.md`
3. Update section **2.4 CI/CD Pipeline Plan** detail fields and key decisions:
   - Set **Status** to `Complete`
   - Set **Completion Date** to today's date
   - Set **Output Document** to `{bgr_artifacts}/pipeline.md`
   - CI/CD platform selected
   - Branching strategy chosen
   - Deployment strategy per service type
   - Security scanning approach
   - Update checklist `lastUpdated` in both frontmatter and the Overview section
4. Check for cross-plan dependency gaps (verify each plan's `status` field before validating):
   - If Observability Plan exists and status is `complete`: Verify post-deploy verification gates reference the correct health check metrics and SLO thresholds. If status is `draft`, defer validation until plan is finalized.
   - If Incident Response Plan exists and status is `complete`: Verify rollback automation triggers align with incident severity classification and escalation procedures. If status is `draft`, defer validation until plan is finalized.
   - If Infrastructure Plan exists and status is `complete` or `approved`: Verify pipeline deployment targets match the defined environment topology, and runner infrastructure is provisioned. If status is `draft`, defer validation until plan is finalized.
   - Record any inconsistencies or deferred validations in section **4.3 Consistency Issues**
5. Update the `completedWorkflows` array in checklist frontmatter to include `pipeline`. Add this workflow only if it is not already present (use set-style uniqueness to prevent duplicate entries on re-run).
6. If all 4 workflows are now complete, update **Overall Status** to `READY` (if no critical gaps remain). A **critical gap** is a missing workflow artifact, an unresolved cross-plan dependency, or a key decision conflict between plans that would block production readiness (e.g., mismatched environment topologies, missing rollback alignment, or undefined alerting-to-severity mappings).
7. Save the updated checklist

## 5.6 Recommend Next Steps

Suggest logical follow-up actions:

- 📋 Create infrastructure plan (if not yet done) to support the pipeline architecture
- 📋 Create observability plan to monitor pipeline and deployment health
- 📋 Create incident response plan for deployment failures
- 🔧 Implement pipeline configuration files based on this plan
- 🔧 Set up pipeline secrets and credential management
- 🔧 Configure notification integrations (Slack, PagerDuty, email)

---

**Menu:**

- **[C]omplete** — Finalize and save the pipeline plan
- **[R]evise** — Return to a specific step to make changes

🔄 **Before completing:** Update `stepsCompleted` in frontmatter to include `"step-05-validation"`.

🔄 **Before completing:** Update the production readiness checklist per step 5.5.

✅ **Workflow complete.** The pipeline plan has been saved to `{bgr_artifacts}/pipeline.md`. The production readiness checklist has been updated with completion status and cross-plan dependency analysis.
