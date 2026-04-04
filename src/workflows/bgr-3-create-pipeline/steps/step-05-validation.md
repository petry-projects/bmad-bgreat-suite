# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 5.1 Quality Gate Checklist

Review the pipeline plan against these quality gates. Present each item with a pass/fail status:

| # | Quality Gate | Status |
|---|-------------|--------|
| 1 | CI/CD platform selected with pipeline-as-code approach | |
| 2 | Branching strategy defined with trigger mapping | |
| 3 | All pipeline stages documented with pass/fail criteria | |
| 4 | Security scanning integrated (SAST, dependencies, containers, secrets) | |
| 5 | Deployment strategy defined per service type | |
| 6 | Rollback procedures documented | |
| 7 | Database migration strategy addressed | |
| 8 | Artifact management and retention defined | |

For any gate that fails, note what is missing and discuss with the user whether to address it now or defer.

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

## 5.5 Recommend Next Steps

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

✅ **Workflow complete.** The pipeline plan has been saved to `{bgr_artifacts}/pipeline.md`.
