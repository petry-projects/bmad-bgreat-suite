---
name: bgr-ops-review
description: 'Cross-agent operational health assessment. Reviews all BGreat Suite artifacts for consistency, coverage gaps, cross-reference validity, and staleness. Use when the user says "ops review", "check operational health", "review my plans", or "validate my bgr artifacts".'
---

# Operational Health Review

## Overview

You are performing an on-demand operational health assessment of the BGreat Suite planning artifacts. This skill reads all available workflow outputs, checks them for consistency and completeness, and produces a scored report. You are a neutral reviewer — not generating new content, but validating what exists.

## MANDATORY EXECUTION RULES

- 📖 READ all relevant artifacts before drawing any conclusions
- 🛑 DO NOT generate replacement content — this is a review, not a rewrite
- ✅ Base every finding on specific artifact content, not assumptions
- 📋 Report findings with artifact name, section, and specific detail
- 🚫 If an artifact does not exist, record it as a coverage gap — do not create it
- ✅ ALWAYS communicate in `{communication_language}`

## Activation

1. Load config from `{project-root}/_bmad/bgr/config.yaml` and resolve:
   - Use `{user_name}` for greeting
   - Use `{communication_language}` for all communications
   - Use `{bgr_artifacts}` for artifact scanning
   - Use `{project_knowledge}` for additional context

2. Greet `{user_name}` and explain that you will now scan `{bgr_artifacts}` for all BGreat Suite planning artifacts.

3. Proceed immediately to the **Artifact Discovery** phase without waiting for user input.

---

## Phase 1: Artifact Discovery

Scan `{bgr_artifacts}/` for the following workflow outputs. For each, check both a single-file and sharded-folder form (e.g., `*observability*.md` or `*observability*/index.md`):

| Workflow | Expected Artifact Pattern | Artifact Key |
|----------|--------------------------|--------------|
| Observability Plan | `*observability*.md` | `observability` |
| Incident Response Plan | `*incident-response*.md` | `incident-response` |
| Disaster Recovery Plan | `*disaster-recovery*.md` | `disaster-recovery` |
| Infrastructure Plan | `*infrastructure*.md` | `infrastructure` |
| Capacity Plan | `*capacity*.md` | `capacity` |
| Pipeline Plan | `*pipeline*.md` | `pipeline` |
| Security Plan | `*security*.md` | `security` |

For each artifact found:
- Load the complete file (no offset/limit)
- Note the last-modified date from frontmatter (`updatedAt` or `lastModified`) if present
- Note which workflow sections are marked complete

Report discovery results to the user in a table before proceeding:

```
Scanning {bgr_artifacts}...

| Artifact | Status | Last Updated |
|----------|--------|-------------|
| Observability Plan | Found / Missing | {date or —} |
| Incident Response Plan | Found / Missing | {date or —} |
| Disaster Recovery Plan | Found / Missing | {date or —} |
| Infrastructure Plan | Found / Missing | {date or —} |
| Capacity Plan | Found / Missing | {date or —} |
| Pipeline Plan | Found / Missing | {date or —} |
| Security Plan | Found / Missing | {date or —} |
```

**STOP and ask:**
> "I found {N}/7 artifacts. Shall I proceed with the health review? [C] Continue"

Wait for user confirmation before proceeding to Phase 2.

---

## Phase 2: Consistency Checks

For each pair of related artifacts that both exist, perform the checks below. Record each result as PASS, WARN, or FAIL with a specific finding.

### 2.1 Observability ↔ Incident Response

- **SLO/alert threshold alignment**: SLO targets defined in the observability plan should match or be referenced by the alert thresholds in the incident response plan. Flag if incident response defines response SLAs that are tighter than the SLOs that trigger them.
- **Severity classification coverage**: Every severity level defined in incident response (e.g., SEV-1 through SEV-3) should have at least one corresponding alert or SLO burn-rate rule in the observability plan.
- **On-call runbook coverage**: Runbooks referenced in the incident response plan should correspond to alerting rules in the observability plan.

### 2.2 Infrastructure ↔ Capacity Plan

- **Environment alignment**: Every environment defined in the infrastructure plan (e.g., prod, staging) should have corresponding capacity targets in the capacity plan.
- **Scaling trigger consistency**: Auto-scaling policies in the capacity plan should reference the same infrastructure resources (instance types, node pools) defined in the infrastructure plan.
- **Resource limits coverage**: Resource limits defined in infrastructure should not conflict with growth projections in the capacity plan.

### 2.3 Infrastructure ↔ Pipeline Plan

- **Deployment target alignment**: Deployment targets in the pipeline plan (environments, clusters, regions) should match those defined in the infrastructure plan.
- **Deployment strategy consistency**: If the infrastructure plan specifies blue/green or canary deployments, the pipeline plan should define corresponding stages.

### 2.4 Observability ↔ Disaster Recovery

- **Recovery metric coverage**: Metrics that validate RTO/RPO in the disaster recovery plan should be instrumentable from the observability plan (dashboards or runbooks reference them).
- **DR alert coverage**: Disaster recovery runbooks that depend on specific alerts should reference alerts defined in the observability plan.

### 2.5 Infrastructure ↔ Disaster Recovery

- **Backup target alignment**: Backup strategies in the disaster recovery plan should reference specific infrastructure resources (databases, storage) defined in the infrastructure plan.
- **Geographic failover consistency**: If disaster recovery defines regional failover, infrastructure should define multi-region topology.

### 2.6 Security Plan ↔ All Other Plans

- **Auth/access surface coverage**: Services or infrastructure components identified in the infrastructure plan should appear in the security plan's threat model or access control section.
- **Pipeline security gates**: Security controls required by the security plan (SAST, dependency scanning, secret scanning) should be reflected as stages in the pipeline plan.
- **Observability/security coverage**: Log retention and audit trail requirements in the security plan should be addressed by the observability plan.

---

## Phase 3: Coverage Gap Detection

Identify services or components that have incomplete coverage across workflows. For each gap, report which artifact is missing coverage and what the downstream risk is.

Common gap patterns to check:

- **Observable but not incident-ready**: A service has SLOs defined in the observability plan but no runbooks in the incident response plan.
- **Infrastructure without observability**: An environment or service is defined in infrastructure but has no corresponding monitoring targets in the observability plan.
- **Scaled but not recovered**: A service has capacity scaling policies but no entry in the disaster recovery plan's service tier classification.
- **Deployed but not secured**: A pipeline exists for a service with no security plan coverage for that service.
- **Capacity without infrastructure**: Capacity targets reference services or resources not defined in the infrastructure plan.

---

## Phase 4: Cross-Reference Validation

Scan all artifacts for explicit cross-references (e.g., "see Infrastructure Plan §3", "as defined in the Security Plan", "per the Observability runbook"). For each reference found:

1. Identify the target artifact and section
2. Verify the target section actually exists in the referenced artifact
3. Record as PASS if found, WARN if section title has changed, FAIL if artifact or section is missing

---

## Phase 5: Staleness Detection

For each artifact, assess staleness using available signals:

- **Frontmatter date**: If `updatedAt` or `lastModified` is present, flag artifacts not updated in the last 90 days as WARN, 180+ days as FAIL.
- **Git history**: If git history is accessible, check when the artifact file was last modified. Surface the date regardless of frontmatter.
- **Codebase drift signals**: Check `{project_knowledge}` and `{project-root}/docs/` for architecture documents or PRDs that postdate the artifact — flag as WARN if newer source documents exist.
- **Self-referential completeness**: If an artifact's frontmatter shows `stepsCompleted` that does not include the final validation step number (typically step 5), flag as WARN (workflow may be incomplete).

---

## Phase 6: Scorecard Output

Produce a final scorecard summarizing findings across all phases.

### Format

```markdown
# BGreat Suite Operational Health Review
**Date:** {today's date}
**Artifacts Reviewed:** {N}/7
**Reviewed by:** bgr-ops-review skill

---

## Coverage Summary

| Workflow Artifact | Present | Complete | Last Updated |
|-------------------|---------|----------|-------------|
| Observability Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Incident Response Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Disaster Recovery Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Infrastructure Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Capacity Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Pipeline Plan | ✅/❌ | ✅/⚠️/❌ | {date} |
| Security Plan | ✅/❌ | ✅/⚠️/❌ | {date} |

---

## Consistency Check Results

| Check | Status | Finding |
|-------|--------|---------|
| Observability ↔ Incident Response: SLO/alert alignment | PASS/WARN/FAIL | {detail} |
| Observability ↔ Incident Response: Severity coverage | PASS/WARN/FAIL | {detail} |
| Infrastructure ↔ Capacity: Environment alignment | PASS/WARN/FAIL | {detail} |
| Infrastructure ↔ Pipeline: Deployment targets | PASS/WARN/FAIL | {detail} |
| Observability ↔ Disaster Recovery: Recovery metrics | PASS/WARN/FAIL | {detail} |
| Infrastructure ↔ Disaster Recovery: Backup targets | PASS/WARN/FAIL | {detail} |
| Security ↔ Infrastructure: Access surface coverage | PASS/WARN/FAIL | {detail} |
| Security ↔ Pipeline: Security gate coverage | PASS/WARN/FAIL | {detail} |
| Security ↔ Observability: Audit trail coverage | PASS/WARN/FAIL | {detail} |

---

## Coverage Gaps

{List each gap as a bullet: which artifact is missing coverage, which artifact would supply it, and the downstream risk}

---

## Cross-Reference Issues

{List broken references: source artifact, reference text, target artifact/section, resolution status}

---

## Staleness Warnings

{List stale artifacts: artifact name, last-updated date, staleness signal}

---

## Overall Score

| Category | Score |
|----------|-------|
| Coverage (artifacts present) | {N}/7 |
| Consistency (checks passing) | {pass}/{total} |
| Cross-references valid | {pass}/{total} |
| Freshness (no stale artifacts) | {pass}/{total} |

**Overall Health:** 🟢 Healthy / 🟡 Needs Attention / 🔴 Action Required

---

## Recommended Actions

{Ordered list of highest-priority remediation actions, referencing specific artifacts and workflows to invoke}
```

Save the scorecard to `{bgr_artifacts}/ops-review-{YYYY-MM-DD}.md`.

Inform the user that the review is complete and the scorecard has been saved. Suggest which workflows to run next based on the highest-priority gaps found.
