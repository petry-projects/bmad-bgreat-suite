# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating completeness and coherence of the incident response plan
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

- Complete incident response plan with all sections is available
- All severity levels, procedures, runbook standards, and postmortem process are defined
- Focus on validation, gap analysis, and completeness checking
- Prepare for handoff to operational use

## YOUR TASK:

Validate the complete incident response plan for coherence, completeness, and operational readiness. Present a summary and finalize the document.

## VALIDATION SEQUENCE:

### 1. Quality Gates Checklist

Run through each quality gate and assess pass/fail:

**Severity Classification:**
- [ ] Severity levels (SEV1-SEV4) defined with clear, unambiguous criteria
- [ ] Response time SLAs specified for each severity level
- [ ] SLAs are realistic for the team size and structure

**Escalation:**
- [ ] Escalation paths documented for each severity level
- [ ] Time-based escalation triggers defined
- [ ] Escalation contacts identified (by role or name)
- [ ] Communication channels mapped per severity

**On-Call & Response:**
- [ ] On-call rotation schedule and handoff procedures defined
- [ ] Incident commander role and responsibilities documented
- [ ] End-to-end response workflow documented (detect → postmortem)
- [ ] Fatigue management and on-call wellness addressed

**Communication:**
- [ ] Internal status update template ready
- [ ] Customer-facing status page template ready
- [ ] Stakeholder notification template ready
- [ ] Communication cadence defined per severity

**Runbooks:**
- [ ] Runbook standard structure documented
- [ ] Initial runbooks identified with owners
- [ ] Runbook maintenance process defined
- [ ] Runbook template available for creating new runbooks

**Postmortems:**
- [ ] Postmortem trigger criteria defined and tied to severity levels
- [ ] Postmortem timeline and ownership documented
- [ ] Postmortem template available with all required sections
- [ ] Action item tracking process established
- [ ] Blameless culture principles documented

**War Room:**
- [ ] War room activation criteria defined
- [ ] War room roles documented
- [ ] War room procedures and rules established

### 2. Coherence Validation

Check that all sections work together:

- Do escalation paths align with severity definitions?
- Do communication templates match the severity-specific cadences?
- Does the on-call rotation support the response time SLAs?
- Do postmortem triggers reference the correct severity levels?
- Are runbook categories consistent with the architecture?

### 3. Gap Analysis

Identify any missing elements:

**Critical Gaps** (block operational readiness):
- Missing severity criteria that would cause classification confusion
- Escalation paths that lead to undefined roles
- Response SLAs that the team cannot meet

**Important Gaps** (should be addressed soon):
- Runbooks identified but not yet written
- Communication templates that need customization
- Training or drill schedule not defined

**Enhancement Opportunities** (improve over time):
- Automation opportunities for incident detection and response
- Integration with observability and alerting systems
- Game day and tabletop exercise planning

### 4. Present Validation Summary

Present the complete validation to user:

"I've completed a comprehensive validation of your Incident Response Plan.

**Quality Gates:**

{{checklist_results_with_pass_fail_status}}

**Coherence Check:**
- {{assessment_of_how_all_sections_work_together}}

**Gap Analysis:**

**Critical:** {{critical_gaps_or_none_found}}
**Important:** {{important_gaps}}
**Enhancements:** {{enhancement_opportunities}}

### 5. Generate Validation & Training Content

Prepare the final content to append to the document:

#### Content Structure:

```markdown
## 8. Training & Drills

- **Tabletop exercises**: {{frequency_and_scenario_recommendations}}
- **Game days**: {{chaos_engineering_and_failure_injection_recommendations}}
- **Onboarding**: {{how_new_team_members_learn_incident_response}}

## Validation Results

### Quality Gates

{{quality_gates_checklist_with_status}}

### Plan Completeness

**Overall Status:** {{READY_FOR_USE / NEEDS_ATTENTION}}

**Strengths:**
{{list_of_plan_strengths}}

**Areas for Improvement:**
{{areas_that_should_be_addressed}}

### Recommended Next Steps

{{prioritized_list_of_next_actions}}
```

### 6. Present Content and Menu

Show the generated content and present choices:

"I've completed the validation. Here's the final section to add:

[Show the complete markdown content from step 5]

**What would you like to do?**
[C] Continue - Save and finalize the incident response plan
[R] Revise - Let's address gaps or adjust any section of the plan"

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask what specific areas need adjustment
- Navigate back to relevant sections if needed
- Collaborate on revisions
- Re-run validation if significant changes made
- Present updated content
- Return to [C]/[R] menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/incident-response.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4, 5]`
- Update frontmatter: `status: complete`
- Update frontmatter: `lastUpdated` to current date
- Save the final document

### 8. Update Production Readiness Checklist

After saving the incident response plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it from `../../templates/bgr-production-readiness-checklist-template.md`
2. Update the **Incident Response Plan** row in the Workflow Completion Status table:
   - Status: `Complete`
   - Completion Date: `{{current_date}}`
   - Output Document: `{bgr_artifacts}/incident-response.md`
3. Update section **2.2 Incident Response Plan** with key decisions:
   - Severity levels defined (SEV1-SEV4 summary)
   - On-call rotation model chosen
   - Postmortem process established
   - Communication templates created
4. Check for cross-plan dependency gaps:
   - If Observability Plan exists: Verify severity classification aligns with alerting thresholds and burn-rate windows
   - If Infrastructure Plan exists: Verify runbook procedures reference correct environment topology and access paths
   - If Pipeline Plan exists: Verify escalation procedures account for deployment rollback capabilities
   - Record any inconsistencies in section **4.3 Consistency Issues**
5. Update the `completedWorkflows` array in checklist frontmatter to include `incident-response`
6. If all 4 workflows are now complete, update **Overall Status** to `READY` (if no critical gaps remain)
7. Save the updated checklist

### 9. Finalization Report

After saving, present the completion summary:

"Your Incident Response Plan is complete and saved to `{bgr_artifacts}/incident-response.md`.

**What you have:**
- Severity classification with clear criteria and response SLAs
- Escalation matrix with time-based triggers
- On-call rotation and handoff procedures
- End-to-end response workflow
- Communication templates for all audiences
- War room procedures
- Runbook standards and initial runbook inventory
- Postmortem process with blameless culture principles
- Training and drill recommendations

**Recommended next steps:**
1. Create individual runbooks using the `../templates/runbook-template.md` template
2. Set up alerting tied to severity levels (use `bgr-3-create-observability` workflow)
3. Configure on-call rotation in your alerting tool
4. Schedule your first tabletop exercise
5. Share this plan with the team and get feedback

**Templates available:**
- `../templates/runbook-template.md` — for creating service-specific runbooks
- `../templates/postmortem-template.md` — for documenting incidents

Thank you for building this plan together, {{user_name}}! A well-practiced incident response plan is what separates a team that panics from a team that resolves."

## SUCCESS METRICS:

✅ All quality gates evaluated with clear pass/fail
✅ Coherence between all sections validated
✅ Gaps identified and communicated with priority levels
✅ Training and drill recommendations included
✅ Final document saved with complete frontmatter
✅ Actionable next steps provided
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected
✅ Production readiness checklist updated with completion status and key decisions
✅ Cross-plan dependency gaps identified and recorded in checklist

## FAILURE MODES:

❌ Rubber-stamping validation without thorough checks
❌ Missing critical gaps that would cause confusion during a real incident
❌ Not checking coherence between sections
❌ Finalizing without user confirmation
❌ Not providing actionable next steps
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## WORKFLOW COMPLETE:

This is the final step. After finalization, the incident response workflow is complete. The user can invoke additional workflows or return to the agent menu.
