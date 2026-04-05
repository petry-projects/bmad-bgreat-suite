# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating completeness and coherence of the resilience plan
- ✅ VALIDATE all critical areas are covered and cross-workflow consistency is maintained
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ✅ Run comprehensive validation checks on the complete plan
- ⚠️ Present [C]ontinue / [R]evise menu after generating validation results
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4, 5]` and set `status: complete` before finalizing
- 🚫 FORBIDDEN to finalize until C is selected

## CONTEXT BOUNDARIES:

- Complete resilience plan with all sections is available
- Steady-state hypotheses, failure catalog, experiment designs, and game day plan are defined
- Observability and incident response plans may be available from step 1
- Focus on validation, gap analysis, cross-workflow consistency, and implementation roadmap

## YOUR TASK:

Validate the complete resilience testing plan for coherence, completeness, and cross-workflow consistency. Present a summary and finalize the document.

## VALIDATION SEQUENCE:

### 1. Quality Gates Checklist

Run through each quality gate and assess pass/fail:

**Steady-State Hypotheses:**
- [ ] Steady-state hypotheses defined for all critical services
- [ ] Each hypothesis has measurable conditions with specific thresholds
- [ ] Measurement sources identified for each metric
- [ ] Failure boundaries defined per user journey
- [ ] Baseline verification protocol established

**Failure Catalog:**
- [ ] Failure modes identified across all relevant infrastructure layers (compute, network, storage, dependencies)
- [ ] Each experiment has a clear hypothesis
- [ ] Blast radius controls defined for every experiment
- [ ] Abort criteria specified for every experiment
- [ ] Runback procedures documented for every experiment
- [ ] Experiments prioritized by risk and learning value

**Game Day Plan:**
- [ ] Game day format appropriate to team maturity level
- [ ] Tabletop exercises designed for top-priority scenarios (if applicable)
- [ ] Live game day structure with pre/during/post checklists
- [ ] Roles defined and adapted to team size
- [ ] Safety observer role explicitly assigned
- [ ] Sustainable experiment scheduling cadence established
- [ ] Experiment backlog owner defined

### 2. Cross-Workflow Consistency

Check that the resilience plan is consistent with other completed workflow plans:

**Observability Plan Consistency:**
- Do steady-state hypotheses use the same SLO targets defined in the observability plan?
- Do experiment observability requirements reference dashboards and alerts defined in the observability plan?
- Will experiment signals (deviations from steady state) be captured by existing alerting?
- Are there gaps in observability coverage for the failure modes in the catalog?

**Incident Response Plan Consistency:**
- Do abort criteria align with severity classification in the incident response plan?
- Does the game day roles structure (Experiment Lead, Safety Observer) align with incident response roles (Incident Commander, Communications Lead)?
- Does the experiment runback procedure follow the same decision path as incident mitigation?
- Are game day communication procedures aligned with incident response communication templates?

**Infrastructure Plan Consistency (if available):**
- Do failure modes cover all infrastructure layers present in the infrastructure plan?
- Do environment choices (staging vs. production) match the environment topology in the infrastructure plan?
- Are blast radius controls feasible given the infrastructure described?

**Security Plan Consistency (if available):**
- Are STRIDE-mapped failure modes from step 3 represented in the experiment catalog?
- Do experiments targeting security-relevant failure modes have appropriate blast radius controls and approval requirements?

Surface any inconsistencies to the user:
"I've checked the resilience plan against your other completed workflow plans. Here's what I found: {findings}"

### 3. Gap Analysis

Identify any missing elements:

**Critical Gaps** (block operational readiness):
- Experiments without abort criteria — cannot be run safely
- Steady-state hypotheses without measurable conditions — cannot verify hypothesis
- No safety observer role — no independent monitoring during live experiments
- No runback procedures — no way to restore normal state if experiment goes wrong

**Important Gaps** (should be addressed before first game day):
- Failure modes with no tooling identified for injection
- Observability coverage gaps for experiment monitoring
- Communication plan for stakeholders not defined
- No training or onboarding plan for new team members

**Enhancement Opportunities** (improve resilience program over time):
- Automated chaos testing pipeline integration
- Chaos experiment results database for trend analysis
- External chaos engineering tooling evaluation (Gremlin, Chaos Monkey, LitmusChaos)
- Game day results feeding back into SLO refinement

### 4. Generate Implementation Roadmap

Based on the maturity level and experiment catalog, generate a phased implementation roadmap:

**Phase 1 — Foundation (Immediate):**
- Complete any critical gaps identified in gap analysis
- Conduct first tabletop exercise for highest-priority scenario
- Verify observability coverage for steady-state metrics
- Establish game day communication channel

**Phase 2 — First Live Experiments:**
- Run first live experiment in staging for top-priority scenario
- Validate abort criteria and runback procedures with a real test
- Debrief and update failure catalog with findings

**Phase 3 — Production Experiments:**
- Graduate top-priority experiment to production (canary scope)
- Establish recurring experiment cadence
- Begin building automation for baseline verification

**Phase 4 — Continuous Resilience:**
- Automated chaos testing in staging/CI pipeline
- Regular quarterly game days with increasing scope
- Experiment results feeding back into steady-state hypothesis refinement

Discuss with user:
"Here's a phased roadmap based on your current maturity ({maturityLevel}). Should we adjust the phases based on your team's capacity or upcoming commitments?"

### 5. Present Validation Summary

Present the complete validation to user:

"I've completed a comprehensive validation of your Resilience Testing Plan.

**Quality Gates:**

{{checklist_results_with_pass_fail_status}}

**Cross-Workflow Consistency:**
- Observability Plan: {{consistent_or_gaps}}
- Incident Response Plan: {{consistent_or_gaps}}
- Infrastructure Plan: {{consistent_or_not_available}}
- Security Plan: {{consistent_or_not_available}}

**Gap Analysis:**

**Critical:** {{critical_gaps_or_none_found}}
**Important:** {{important_gaps}}
**Enhancements:** {{enhancement_opportunities}}

**Implementation Roadmap:**

{{phased_roadmap_summary}}

What would you like to do?
[C] Continue - Save validation results and finalize the plan
[R] Revise - Let's address gaps or adjust any section of the plan"

### 6. Generate Validation & Roadmap Content

Prepare the final content to append to the document:

#### Content Structure:

```markdown
## 5. Implementation Roadmap

### 5.1 Phased Implementation

#### Phase 1 — Foundation
{{phase_1_actions}}

#### Phase 2 — First Live Experiments
{{phase_2_actions}}

#### Phase 3 — Production Experiments
{{phase_3_actions}}

#### Phase 4 — Continuous Resilience
{{phase_4_actions}}

## Validation Results

### Quality Gates

{{quality_gates_checklist_with_status}}

### Cross-Workflow Consistency

| Workflow Plan | Status | Notes |
|--------------|--------|-------|
| Observability Plan | {{status}} | {{notes}} |
| Incident Response Plan | {{status}} | {{notes}} |
| Infrastructure Plan | {{status}} | {{notes}} |
| Security Plan | {{status}} | {{notes}} |

### Plan Completeness

**Overall Status:** {{READY_FOR_FIRST_GAME_DAY / NEEDS_ATTENTION}}

**Strengths:**
{{list_of_plan_strengths}}

**Areas for Improvement:**
{{areas_that_should_be_addressed}}

### Recommended Next Steps

{{prioritized_list_of_next_actions}}
```

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask what specific areas need adjustment
- Navigate back to relevant sections if needed
- Collaborate on revisions
- Re-run validation if significant changes made
- Present updated content
- Return to [C]/[R] menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/resilience-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4, 5]`
- Update frontmatter: `status: complete`
- Update frontmatter: `lastUpdated` to current date
- Save the final document

### 8. Update Production Readiness Checklist

After saving the resilience plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it from `../../../templates/bgr-production-readiness-checklist-template.md`
2. Update the **Resilience Testing Plan** row in the Workflow Completion Status table (add row if not present):
   - Status: `Complete`
   - Completion Date: `{{current_date}}`
   - Output Document: `{bgr_artifacts}/resilience-plan.md`
3. Add or update section **2.x Resilience Testing Plan** detail fields and key decisions:
   - Set **Status** to `Complete`
   - Set **Completion Date** to `{{current_date}}`
   - Set **Output Document** to `{bgr_artifacts}/resilience-plan.md`
   - Resilience maturity level assessed
   - Number of critical services with steady-state hypotheses
   - Number of experiments designed and prioritized
   - Game day format and cadence established
   - Update checklist `lastUpdated` in both frontmatter and the Overview section
4. Check for cross-plan dependency gaps (verify each plan's `status` field before validating):
   - If Observability Plan exists and status is `complete`: Verify steady-state hypotheses use the same SLO targets. If status is `draft`, note validation is deferred pending finalization.
   - If Incident Response Plan exists and status is `complete`: Verify abort criteria align with severity classification and game day roles align with incident response roles. If status is `draft`, note validation is deferred pending finalization.
   - If Infrastructure Plan exists and status is `complete` or `approved`: Verify failure modes cover all infrastructure layers and environment choices are consistent. If status is `draft`, note validation is deferred pending finalization.
   - Record any inconsistencies or deferred validations in section **4.3 Consistency Issues**
5. Update the `completedWorkflows` array in checklist frontmatter to include `resilience-plan`. Add this workflow only if it is not already present (use set-style uniqueness to prevent duplicate entries on re-run).
6. Save the updated checklist

### 9. Finalization Report

After saving, present the completion summary:

"Your Resilience Testing Plan is complete and saved to `{bgr_artifacts}/resilience-plan.md`.

**What you have:**
- Steady-state hypotheses with measurable conditions for all critical services
- Failure catalog covering compute, network, storage, and dependency layers
- Prioritized experiment designs with blast radius controls and abort criteria
- Game day structure with roles, communication plan, and runback procedures
- Experiment scheduling cadence
- Phased implementation roadmap

**Recommended next steps:**
1. Review the plan with your team and get buy-in on the first game day scenario
2. Verify observability coverage for all steady-state metrics before proceeding
3. Schedule your first tabletop exercise for the highest-priority scenario
4. Identify and onboard your Chaos Operator and Safety Observer for live experiments
5. Set up your experiment communication channel

**Tooling to evaluate:**
- Gremlin — commercial chaos platform with blast radius controls
- LitmusChaos — open-source chaos engineering for Kubernetes
- AWS Fault Injection Simulator (FIS) — native chaos for AWS infrastructure
- Chaos Toolkit — open-source framework with many drivers
- Netflix Chaos Monkey — VM/instance termination for AWS Auto Scaling Groups

Thank you for building this plan together, {{user_name}}! A team that proactively tests failure modes is a team that earns the right to be confident in their system's resilience."

## SUCCESS METRICS:

✅ All quality gates evaluated with clear pass/fail
✅ Cross-workflow consistency validated against observability, incident response, infrastructure, and security plans
✅ Gaps identified and communicated with priority levels
✅ Phased implementation roadmap generated
✅ Final document saved with complete frontmatter
✅ Actionable next steps provided with tooling recommendations
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected
✅ Production readiness checklist updated with completion status and key decisions

## FAILURE MODES:

❌ Rubber-stamping validation without thorough checks
❌ Missing critical gaps that would make experiments unsafe
❌ Not checking cross-workflow consistency
❌ Finalizing without user confirmation
❌ Not providing actionable next steps and tooling recommendations
❌ Not presenting [C]/[R] menu after content generation
❌ Not updating production readiness checklist

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## WORKFLOW COMPLETE:

This is the final step. After finalization, the resilience testing workflow is complete. The user can invoke additional workflows or return to the agent menu.
