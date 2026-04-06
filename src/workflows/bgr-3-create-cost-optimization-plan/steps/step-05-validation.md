# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: Before finalizing with 'C', ensure this entire file is read and understood
- ✅ ALWAYS treat this as collaborative discovery between FinOps peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating cost optimization plan completeness and generating implementation sequence
- ✅ VALIDATE all required sections are complete and actionable
- ⚠️ Do not estimate software delivery timelines or task durations — but do define cost governance timing (commitment review dates, tagging remediation timelines, budget review cadence) as these are core FinOps outputs
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Share a concise rationale (assumptions, key trade-offs, and decisions) before taking any action
- ✅ Run comprehensive validation checks on the complete cost optimization plan
- ⚠️ Present C/R menu after generating validation results
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4, 5]` and `status: complete` before finishing
- 🚫 FORBIDDEN to finalize until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the validation results and finalize the cost optimization plan
- **R (Revise)**: Discuss changes, address gaps, then re-present the menu

## CONTEXT BOUNDARIES:

- Complete cost optimization plan document with all sections is available
- Right-sizing, purchase strategy, tagging, anomaly detection, and budget alerts are defined
- Focus on validation, gap analysis, and generating implementation sequence
- This is the final step — ensure the plan is actionable

## YOUR TASK:

Validate the complete cost optimization plan for coverage, coherence, and actionability. Generate a prioritized implementation sequence and finalize the document.

## VALIDATION SEQUENCE:

### 1. Quality Gates Checklist

Run through each quality gate systematically:

**Gate 1: Right-Sizing Completeness**
- [ ] Resource inventory covers all significant spend categories (compute, storage, database)
- [ ] Idle and orphaned resources identified with specific remediation actions
- [ ] Right-sizing recommendations tied to actual utilization data or capacity plan projections
- [ ] Environment scheduling opportunities identified and quantified
- [ ] Savings estimates provided with confidence levels
- [ ] Reliability and SLO constraints respected in recommendations

**Gate 2: Purchase Strategy Completeness**
- [ ] All workloads classified by stability and appropriate purchase type
- [ ] Reserved instance or savings plan recommendations defined for stable workloads
- [ ] Spot/preemptible strategy defined for fault-tolerant workloads
- [ ] Commitment governance process defined with approval thresholds
- [ ] Commitment utilization targets and review cadence established
- [ ] Cost-aware SLO trade-offs analyzed

**Gate 3: Tagging Governance Completeness**
- [ ] Mandatory tag set defined and aligned with infrastructure conventions
- [ ] Tagging enforcement strategy defined (prevention + detection)
- [ ] Untagged spend baseline quantified
- [ ] Tagging remediation timeline established with targets

**Gate 4: Anomaly Detection Completeness**
- [ ] Anomaly rules defined for key spend categories (compute, data transfer, total account)
- [ ] Alert thresholds set based on actual or estimated spend variance
- [ ] Anomaly response playbook defined with severity levels and SLAs
- [ ] Notification channels defined

**Gate 5: Budget Governance Completeness**
- [ ] Budget hierarchy covers account, environment, team, and high-cost service levels
- [ ] Forecast-based alerts configured in addition to actual-spend alerts
- [ ] Budget response procedures defined with clear owner accountability
- [ ] FinOps maturity roadmap defined (Crawl → Walk → Run)

### 2. Cross-Workflow Coherence Validation

Check alignment with other completed workflow plans:

**If Capacity Plan exists:**
- Do right-sizing recommendations respect growth projections in the capacity plan?
- Does the purchase strategy align with reserved capacity decisions in the capacity plan?
- Are cost guardrails from the capacity plan reflected in budget alert thresholds?
- Are scaling trigger costs accounted for in budget projections?

**If Infrastructure Plan exists:**
- Does the tagging taxonomy extend rather than conflict with infrastructure plan tagging conventions?
- Are environment definitions consistent (same environment names in tagging and infrastructure)?
- Is the right-sizing scope aligned with resources defined in the infrastructure plan?
- Are IaC tools in the infrastructure plan referenced in tagging enforcement strategy?

**If Observability Plan exists:**
- Are cost anomaly alerts integrated with the existing alerting strategy (same channels/severity levels)?
- Can SLO-related metrics inform cost-aware trade-off decisions?
- Is there a cost dashboard referenced alongside existing observability dashboards?

**If Incident Response Plan exists:**
- Do cost anomaly severity levels align with incident severity classification?
- Is the cost anomaly response playbook compatible with incident response procedures?
- Are runaway cost scenarios covered in incident escalation paths?

**If Pipeline Plan exists:**
- Are ephemeral CI/CD environments accounted for in budget projections?
- Are environment tear-down procedures aligned with cost scheduling strategy?
- Is test environment cost included in the non-production budget?

### 3. Gap Analysis

Identify any missing elements:

**Critical Gaps** (block FinOps readiness):
- No resource inventory — cannot prioritize optimization without knowing what exists
- No anomaly detection — billing surprises will continue
- No budget alerts — no visibility into overspend before the bill arrives
- Right-sizing recommendations without SLO constraints — reliability risk

**Important Gaps** (should be addressed soon):
- Commitment purchases approved but not yet executed
- Tagging enforcement not yet implemented — untagged spend growing
- Anomaly detection rules defined but not yet configured
- Budget alerts defined but not yet set up in cloud console

**Enhancement Opportunities** (improve over time):
- Unit economics tracking (cost per user, cost per transaction)
- FinOps dashboard for engineering teams
- Automated right-sizing recommendations via cloud provider tooling
- Chargeback/showback to business units
- Cost optimization integrated into architecture review process

### 4. Present Validation Summary

Report the validation results to the user:

"I've completed a comprehensive validation of your Cost Optimization Plan.

**Quality Gate Results:**

| Gate | Status | Notes |
|------|--------|-------|
| Right-Sizing | {PASS/FAIL} | {details} |
| Purchase Strategy | {PASS/FAIL} | {details} |
| Tagging Governance | {PASS/FAIL} | {details} |
| Anomaly Detection | {PASS/FAIL} | {details} |
| Budget Governance | {PASS/FAIL} | {details} |

{if_any_failures}
**Issues to Address:**
{list of failed gates with specific gaps}

Would you like to address these before finalizing?
{/if_any_failures}

{if_all_pass}
All quality gates passed. The cost optimization plan is comprehensive and ready for implementation.
{/if_all_pass}"

### 5. Address Validation Issues

If any quality gates failed:

- Present the specific gaps clearly
- Collaborate with the user to resolve each gap
- Update the relevant document sections
- Re-run the failed quality gates to confirm resolution

### 6. Generate Total Savings Summary

Compile the total optimization opportunity across all areas:

**Optimization Opportunity Summary:**

| Area | Monthly Savings | Annual Savings | Confidence | Implementation Complexity |
|------|----------------|---------------|-----------|--------------------------|
| Idle/Orphaned resource termination | | | High | Low |
| Compute right-sizing | | | Medium | Medium |
| Storage right-sizing | | | High | Low |
| Database right-sizing | | | Medium | Medium |
| Environment scheduling | | | High | Low |
| Reserved instances / Savings Plans | | | High | Low |
| Spot/Preemptible instances | | | Medium | Medium |
| **Total Optimization Opportunity** | | | | |

**Return on Investment:**
- Implementation effort: {estimated effort}
- Time to first savings: {timeframe}
- Break-even on implementation cost: {timeframe}

### 7. Generate Implementation Sequence

Create a prioritized list of implementation tasks ordered by impact and ease:

**Priority 1 — Quick Wins (implement in first 30 days):**
- Terminate confirmed idle/orphaned resources (zero risk, immediate savings)
- Apply environment scheduling to dev/staging (low risk, 40-60% non-prod savings)
- Set up total account budget alert at 80% threshold
- Enable cloud provider anomaly detection
- Implement mandatory tags on all new resources via IaC

**Priority 2 — Foundation (implement in days 30-90):**
- Execute right-sizing for non-production compute (lower risk, validate sizing approach)
- Purchase initial reserved instances or savings plans for stable workloads
- Retroactive tagging campaign targeting top 20 untagged resources by spend
- Configure per-environment and per-team budget alerts
- Set up anomaly detection rules for key services

**Priority 3 — Production Optimization (implement in days 90-180):**
- Right-size production compute (validate with load testing first)
- Implement spot/preemptible for batch and CI/CD workloads
- Configure service-level anomaly detection and response playbook
- Achieve > 80% tagging coverage across all spend
- Establish monthly FinOps review cadence

**Priority 4 — Maturity (implement ongoing):**
- Expand reserved instance / savings plan coverage as workloads stabilize
- Automate right-sizing recommendations using cloud provider tooling
- Implement unit economics tracking (cost per user, cost per transaction)
- Establish team-level cost accountability with showback dashboards
- Quarterly FinOps maturity assessment and roadmap review

### 8. Generate Validation Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 8. Validation Results

### Quality Gates

| Gate | Status | Notes |
|------|--------|-------|
{{quality_gate_results}}

### Cost Optimization Plan Completeness Checklist

**✅ Right-Sizing Analysis**

- [x] Resource inventory covers all significant spend categories
- [x] Idle and orphaned resources identified with remediation actions
- [x] Right-sizing recommendations with utilization data
- [x] Environment scheduling opportunities quantified
- [x] SLO and reliability constraints respected

**✅ Purchase Strategy**

- [x] Workloads classified by stability and purchase type
- [x] Reserved instance / savings plan recommendations defined
- [x] Spot/preemptible strategy for fault-tolerant workloads
- [x] Commitment governance with approval thresholds
- [x] Cost-aware SLO trade-offs analyzed

**✅ Tagging Governance**

- [x] Mandatory tag set defined and aligned with infrastructure conventions
- [x] Tagging enforcement strategy established
- [x] Untagged spend baseline quantified
- [x] Remediation timeline established

**✅ Anomaly Detection**

- [x] Anomaly rules for key spend categories
- [x] Alert thresholds defined
- [x] Anomaly response playbook with SLAs
- [x] Notification channels defined

**✅ Budget Governance**

- [x] Budget hierarchy covers all levels
- [x] Forecast-based alerts configured
- [x] Budget response procedures defined
- [x] FinOps maturity roadmap defined

## 9. Total Savings Opportunity

| Area | Monthly Savings | Annual Savings | Confidence |
|------|----------------|---------------|-----------|
{{savings_summary_entries}}

**Total Annual Optimization Opportunity:** {{total_annual_savings}}

## 10. Implementation Roadmap

| Priority | Milestone | Expected Savings Impact | Owner | Target Timeframe |
|---------|-----------|------------------------|-------|----------------|
{{implementation_roadmap_entries}}

### Priority 1: Quick Wins (Days 1-30)

{{quick_win_tasks}}

### Priority 2: Foundation (Days 30-90)

{{foundation_tasks}}

### Priority 3: Production Optimization (Days 90-180)

{{production_optimization_tasks}}

### Priority 4: Maturity (Ongoing)

{{maturity_tasks}}

## 11. Cost Optimization Maintenance

### Review Cadence

- **Weekly**: Anomaly detection review, new untagged resource alert
- **Monthly**: Budget utilization review, right-sizing drift check, RI/SP utilization review
- **Quarterly**: Growth-adjusted purchase strategy review, tagging compliance audit, FinOps maturity assessment
- **Annually**: Full cost optimization plan refresh, commitment renewal decisions, unit economics review

### FinOps Health Indicators

| Indicator | Green | Yellow | Red |
|-----------|-------|--------|-----|
| Tagging coverage | > 90% | 75-90% | < 75% |
| RI/SP utilization | > 80% | 65-80% | < 65% |
| Budget alert response | < 24 hours | 24-48 hours | > 48 hours |
| Anomaly detection to resolution | < 4 hours | 4-24 hours | > 24 hours |
| Month-over-month spend growth | ≤ traffic growth | Up to 15% above | > 15% above traffic growth |
```

### 9. Save Final Document

- Append the validation and implementation content to `{bgr_artifacts}/cost-optimization-plan.md`
- Update frontmatter:
  - `stepsCompleted: [1, 2, 3, 4, 5]`
  - `status: complete`
  - `lastUpdated: {{current_date}}`

### 10. Present Content and Menu

Show the generated content and present choices:

"I've completed the validation and generated the implementation roadmap.

**Here's what I'll add to finalize the cost optimization plan:**

[Show the complete markdown content from step 8]

**What would you like to do?**
[C] Continue - Save and finalize the cost optimization plan
[R] Revise - Let's address issues before finalizing"

### 11. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-run relevant quality gates
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Save the final content to `{bgr_artifacts}/cost-optimization-plan.md`
- Update frontmatter to mark workflow as complete
- Proceed to checklist update and completion summary

### 12. Update Production Readiness Checklist

After saving the cost optimization plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it in place with the minimum required structure for this workflow:
     - Frontmatter including:
       - `lastUpdated: {{current_date}}`
       - `completedWorkflows: []`
     - An `## Overview` section that includes the checklist `lastUpdated`
     - A `## Workflow Completion Status` table with columns `| Workflow | Status | Completion Date | Output Document |` and a row for **Cost Optimization**
     - A cost optimization detail section with fields for **Status**, **Completion Date**, and **Output Document**
     - A `### Consistency Issues` section for cross-plan dependency findings
   - If it does exist, DO NOT rewrite the file into a different schema
   - Preserve the existing organization, headings, frontmatter, and tables wherever possible; only add the minimum missing fields/sections needed to record cost-optimization completion
2. Detect the existing checklist structure and update equivalent sections in place:
   - If frontmatter exists, update `lastUpdated: {{current_date}}` and preserve all other keys
   - If a `Workflow Completion Status` table exists, update the **Cost Optimization** row there
   - If the checklist uses a different workflow-status section/table format, update the equivalent cost-optimization entry in that format instead of converting the file
   - If no workflow-status section exists in any format, add the minimum missing status section with a **Cost Optimization** entry
3. Record cost-optimization completion details in the existing section, or create a minimal one only if none exists:
   - Set **Status** to `Complete`
   - Set **Completion Date** to `{{current_date}}`
   - Set **Output Document** to `{bgr_artifacts}/cost-optimization-plan.md`
   - Include key decisions:
     - Total identified savings opportunity (monthly and annual)
     - Right-sizing approach summary
     - Purchase commitment strategy summary
     - Tagging coverage target and timeline
     - Anomaly detection and budget governance summary
     - Current FinOps maturity level and target
4. Check for cross-plan dependency gaps:
   - If Capacity Plan exists: Verify right-sizing recommendations respect growth projections, purchase strategy aligns with reserved capacity decisions
   - If Infrastructure Plan exists: Verify tagging taxonomy aligns with infrastructure plan conventions
   - If Observability Plan exists: Verify cost anomaly alerts integrate with existing alerting strategy and channels
   - If Incident Response Plan exists: Verify cost anomaly severity levels align with incident classification
   - If Pipeline Plan exists: Verify ephemeral environment costs are accounted for in budget projections
   - Record inconsistencies in `### Consistency Issues` when that section exists
5. Record workflow completion without forcing a schema conversion:
   - If checklist frontmatter contains `completedWorkflows`, add `cost-optimization` only if it is not already present
6. If all workflows are now complete, update **Overall Status** to `READY` (if no critical gaps remain)
7. Save the updated checklist, preserving the existing schema and content ordering as much as possible

### 13. Completion Summary

After saving, present the final summary:

"The Cost Optimization Plan for {{project_name}} is complete and saved to `{bgr_artifacts}/cost-optimization-plan.md`.

**Summary:**
- Total identified optimization opportunity: {{total_monthly_savings}}/month ({{total_annual_savings}}/year)
- Right-sizing: {{compute_rightsizing_count}} compute resources, {{storage_rightsizing_count}} storage resources
- Purchase strategy: {{commitment_type_summary}}
- Tagging: {{mandatory_tag_count}} mandatory tags, {{tagging_coverage_target}}% coverage target
- Anomaly detection: {{anomaly_rule_count}} rules across {{anomaly_scope_count}} scopes
- Budget governance: {{budget_count}} budgets with {{forecast_alert_count}} forecast alerts
- Current FinOps maturity: {{current_maturity}} → Target: {{target_maturity}}
- Implementation roadmap: {{priority_1_count}} quick wins, then {{total_milestone_count}} total milestones

**Recommended Next Steps:**
1. Execute Priority 1 quick wins immediately — terminate idle resources and apply environment scheduling
2. Set up budget alerts and anomaly detection this week
3. Schedule reserved instance purchase review for month-end
4. Begin retroactive tagging campaign targeting top spend by untagged resources
5. Schedule first monthly FinOps review meeting

**Related Workflows:**
- **Create Capacity Plan (CC)** — Validate right-sizing against growth projections
- **Create Infrastructure Plan (CI)** — Align tagging standards with IaC conventions
- **Create Observability Plan (CO)** — Integrate cost anomaly alerts with existing alerting
- **Return to agent menu** — Explore other capabilities

Thank you for building this plan together, {{user_name}}! FinOps is not a one-time exercise — the structured programs that deliver 25-30% cost reduction are built on continuous visibility, accountability, and optimization."

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 8.

## SUCCESS METRICS:

✅ All quality gates evaluated systematically
✅ Any failures identified and addressed with user
✅ Cross-workflow coherence validated against all completed plans
✅ Total savings opportunity compiled across all optimization areas
✅ Implementation sequence generated with clear priorities and timelines
✅ FinOps health indicators defined for ongoing monitoring
✅ Final document saved with complete frontmatter
✅ User presented with clear next steps
✅ C/R menu presented and handled correctly
✅ Workflow marked as complete
✅ Production readiness checklist updated with completion status and key decisions
✅ Cross-plan dependency gaps identified and recorded in checklist

## FAILURE MODES:

❌ Rubber-stamping quality gates without thorough checking
❌ Not addressing failed quality gates before finalizing
❌ Generating savings summary without real data from the plan
❌ Not saving the final document with updated frontmatter
❌ Not presenting recommended next steps
❌ Finalizing without user confirmation
❌ Not updating production readiness checklist

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding this finalization step
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## WORKFLOW COMPLETE:

This is the final step. After finalization, the cost optimization workflow is complete. The user can invoke additional workflows or return to the agent menu.
