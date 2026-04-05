# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating completeness and cross-workflow consistency of the resilience plan
- ✅ VALIDATE all critical areas are covered before finalizing
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
- Steady-state hypotheses, failure catalog, experiments, and game day program are all defined
- Focus on validation, cross-workflow consistency, and completeness checking
- Prepare for handoff to operational use

## YOUR TASK:

Validate the complete resilience testing plan for coherence, completeness, and cross-workflow consistency. Generate an implementation roadmap. Present a summary and finalize the document.

## VALIDATION SEQUENCE:

### 1. Quality Gates Checklist

Run through each quality gate and assess pass/fail:

**Steady-State Hypotheses:**
- [ ] All critical user journeys identified
- [ ] Steady-state defined with specific, measurable metrics for each service
- [ ] Failure boundaries defined for each metric (serve as abort criteria)
- [ ] All metrics are observable through current monitoring stack
- [ ] Recovery time objectives (RTOs) established per service

**Failure Scenario Design:**
- [ ] Failure modes identified across all relevant infrastructure layers
- [ ] At least one experiment designed per critical user journey
- [ ] Every experiment has a complete blast radius control definition
- [ ] Rollback procedures defined and executable within 60 seconds
- [ ] Abort criteria tied to steady-state failure boundaries
- [ ] Experiment catalog prioritized by risk × learning value

**Game Day Program:**
- [ ] At least one tabletop exercise designed
- [ ] Live experiments have complete game day plans
- [ ] Safety Monitor role defined and separate from Experiment Lead
- [ ] Communication plan covers pre/during/post experiment
- [ ] Scheduling cadence established
- [ ] Runback procedures documented for all experiments
- [ ] Escalation path defined if recovery fails

### 2. Cross-Workflow Consistency

Check that the resilience plan is consistent with other completed workflows:

**Observability Alignment:**
- Do the steady-state metrics in this plan match the SLOs defined in the observability plan?
- Are the monitoring dashboards and alert names referenced in experiments correct?
- Do the experiment abort criteria reference the same metric names and thresholds as observability alerts?

**Incident Response Alignment:**
- Do the game day abort criteria align with severity classification from the incident response plan?
- If an experiment escalates to a real incident, do the escalation paths match?
- Are the game day roles consistent with incident response roles?
- Are communication templates for game day consistent with incident communication templates?

**Infrastructure Alignment:**
- Are the failure injection points realistic for the defined infrastructure topology?
- Do rollback procedures reference the correct infrastructure components and commands?
- Are environment names consistent between plans?

Surface any inconsistencies to the user with specific recommendations to resolve.

### 3. Gap Analysis

Identify any missing elements:

**Critical Gaps** (block operational readiness for resilience testing):
- Experiments with no blast radius controls
- Steady-state metrics not observable in current monitoring
- No runback procedures for any experiment
- No abort criteria defined

**Important Gaps** (should be addressed soon):
- Experiments designed but not yet scheduled
- Tooling for failure injection not yet provisioned
- Team not yet trained on game day procedures
- No postmortem-equivalent process for learning from experiments

**Enhancement Opportunities** (improve over time):
- Automated chaos engineering in CI/CD pipeline
- Continuous automated steady-state validation
- Chaos engineering in lower environments as part of every release
- Shared experiment results with the broader team

### 4. Generate Implementation Roadmap

Based on the plan and maturity assessment from step 1, generate a phased roadmap:

**Phase 1 — Foundation (First 30 days):**
- Run first tabletop exercise with the team
- Validate all monitoring and alerting for steady-state metrics
- Provision failure injection tooling in staging environment
- Run first staging-only experiment

**Phase 2 — Building Confidence (30-90 days):**
- Complete tabletop exercises for all high-priority scenarios
- Run 3-5 staging experiments with full game day procedures
- First production canary experiment with high blast-radius controls
- Document learnings and update experiment designs

**Phase 3 — Operational (90+ days):**
- Establish regular game day cadence per schedule
- First production experiments for highest-priority scenarios
- Begin evaluating automation opportunities
- Share results with team and stakeholders as proof of resilience

### 5. Present Validation Summary

Present the complete validation to user:

"I've completed a comprehensive validation of your Resilience Testing Plan.

**Quality Gates:**

{{checklist_results_with_pass_fail_status}}

**Cross-Workflow Consistency:**
- Observability: {{alignment_status_and_any_gaps}}
- Incident Response: {{alignment_status_and_any_gaps}}
- Infrastructure: {{alignment_status_and_any_gaps}}

**Gap Analysis:**

**Critical:** {{critical_gaps_or_none_found}}
**Important:** {{important_gaps}}
**Enhancements:** {{enhancement_opportunities}}

**Implementation Roadmap:**
{{phased_roadmap_summary}}

What would you like to address before finalizing?"

### 6. Generate Validation & Roadmap Content

Prepare the final content to append to the document:

#### Content Structure:

```markdown
## 5. Implementation Roadmap

### 5.1 Phased Approach

{{phased_roadmap_with_objectives_and_key_experiments_per_phase}}

### 5.2 Tooling Requirements

| Tool | Purpose | Phase Needed | Status |
|------|---------|-------------|--------|
{{tooling_table}}

## Validation Results

### Quality Gates

{{quality_gates_checklist_with_pass_fail}}

### Cross-Workflow Consistency

{{consistency_check_results_per_workflow}}

### Plan Completeness

**Overall Status:** {{READY_FOR_USE / NEEDS_ATTENTION}}

**Strengths:**
{{list_of_plan_strengths}}

**Areas for Improvement:**
{{areas_that_should_be_addressed}}

### Recommended Next Steps

{{prioritized_list_of_next_actions}}
```

### 7. Present Content and Menu

Show the generated content and present choices:

"I've completed the validation. Here's the final section to add:

[Show the complete markdown content from step 6]

**What would you like to do?**
[C] Continue - Save and finalize the resilience testing plan
[R] Revise - Let's address gaps or adjust any section of the plan"

### 8. Handle Menu Selection

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

### 9. Update Production Readiness Checklist

After saving the resilience plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it from `../../../templates/bgr-production-readiness-checklist-template.md`
2. Update the **Resilience Testing Plan** row in the Workflow Completion Status table:
   - Status: `Complete`
   - Completion Date: `{{current_date}}`
   - Output Document: `{bgr_artifacts}/resilience-plan.md`
3. Update section **2.X Resilience Testing Plan** detail fields and key decisions:
   - Set **Status** to `Complete`
   - Set **Completion Date** to `{{current_date}}`
   - Set **Output Document** to `{bgr_artifacts}/resilience-plan.md`
   - Resilience maturity level assessed
   - Number of steady-state hypotheses defined
   - Number of experiments designed
   - First game day scheduled (date or "TBD")
   - Update checklist `lastUpdated` in both frontmatter and the Overview section
4. Check for cross-plan dependency gaps (verify each plan's `status` field before validating):
   - If Observability Plan exists and status is `complete`: Verify steady-state metrics align with SLO definitions and alert thresholds. If status is `draft`, note validation is deferred pending finalization.
   - If Incident Response Plan exists and status is `complete`: Verify game day abort criteria align with severity classification and escalation paths match. If status is `draft`, note validation is deferred pending finalization.
   - If Infrastructure Plan exists and status is `complete` or `approved`: Verify failure injection points reference correct infrastructure topology and rollback procedures match infrastructure commands. If status is `draft`, note validation is deferred pending finalization.
   - Record any inconsistencies or deferred validations in section **4.3 Consistency Issues**
5. Update the `completedWorkflows` array in checklist frontmatter to include `resilience`. Add this workflow only if it is not already present (use set-style uniqueness to prevent duplicate entries on re-run).
6. If all workflows are now complete, update **Overall Status** to `READY` (if no critical gaps remain). A **critical gap** is a missing workflow artifact, an unresolved cross-plan dependency, or a key decision conflict between plans that would block production readiness.
7. Save the updated checklist

### 10. Finalization Report

After saving, present the completion summary:

"Your Resilience Testing Plan is complete and saved to `{bgr_artifacts}/resilience-plan.md`.

**What you have:**
- Resilience maturity assessment with growth path
- Steady-state hypotheses for all critical services
- Failure catalog across all infrastructure layers
- {{N}} experiments designed with blast radius controls and rollback procedures
- Tabletop and live game day program with scheduling cadence
- Implementation roadmap in three phases

**Recommended next steps:**
1. Run your first tabletop exercise — pick the highest-risk scenario from the catalog
2. Validate your steady-state monitoring — confirm every metric is observable before testing
3. Provision failure injection tooling in staging (Chaos Monkey, AWS FIS, tc netem, etc.)
4. Schedule your first staging experiment with the full team
5. After staging validation, schedule your first production canary experiment

**Templates available:**
- `../templates/resilience-plan-template.md` — for creating additional resilience plans

Thank you for building this plan together, {{user_name}}! A well-practiced resilience testing program is the difference between teams that hope their systems are reliable and teams that know they are."

## SUCCESS METRICS:

✅ All quality gates evaluated with clear pass/fail
✅ Cross-workflow consistency validated against observability, incident response, and infrastructure plans
✅ Gaps identified and communicated with priority levels
✅ Implementation roadmap generated with phased approach
✅ Final document saved with complete frontmatter
✅ Actionable next steps provided
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected
✅ Production readiness checklist updated with completion status and key decisions
✅ Cross-plan dependency gaps identified and recorded in checklist

## FAILURE MODES:

❌ Rubber-stamping validation without thorough checks
❌ Missing critical gaps — experiments without blast radius controls are dangerous
❌ Not checking cross-workflow consistency
❌ Finalizing without user confirmation
❌ Not providing actionable next steps and a realistic roadmap
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## WORKFLOW COMPLETE:

This is the final step. After finalization, the resilience testing workflow is complete. The user can invoke additional workflows or return to the agent menu.
