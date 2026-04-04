# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between infrastructure peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating completeness, coherence, and implementation readiness
- ✅ VALIDATE all infrastructure decisions are coherent and complete
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ✅ Run comprehensive validation checks on the complete infrastructure plan
- ⚠️ Present [C]ontinue / [R]evise menu after generating validation results
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4, 5]` and `status: approved` before completing
- 🚫 FORBIDDEN to complete workflow until C is selected

## CONTEXT BOUNDARIES:

- Complete infrastructure document with all sections is available
- All infrastructure decisions from steps 2-4 are defined
- Focus on validation, gap analysis, and coherence checking
- Prepare for handoff to pipeline planning phase

## YOUR TASK:

Validate the complete infrastructure plan for coherence, completeness, and readiness to guide implementation.

## VALIDATION SEQUENCE:

### 1. Quality Gate Checks

Run through each quality gate and report pass/fail:

**IaC Strategy Gates:**

- [ ] IaC tool selected with clear rationale
- [ ] State management strategy defined (backend, locking, per-environment)
- [ ] Module/component strategy documented (granularity, versioning, registry)
- [ ] Policy-as-code approach defined (tools, categories, enforcement levels)
- [ ] Drift detection and remediation strategy documented

**Environment Strategy Gates:**

- [ ] Environment topology documented with purpose for each environment
- [ ] Environment parity rules defined (identical vs different)
- [ ] Configuration management strategy documented
- [ ] Secrets management strategy defined (backend, rotation, injection)
- [ ] Cost management approach documented (non-prod controls, prod optimization)

**Network Architecture Gates:**

- [ ] VPC/VNet design documented
- [ ] Subnet strategy defined
- [ ] DNS and load balancing approach documented
- [ ] Network security strategy defined

**Container Strategy Gates:**

- [ ] Container strategy defined (or explicitly deferred with rationale)
- [ ] If containers: cluster architecture, image strategy, and security documented
- [ ] If containers: service mesh evaluated with complexity-vs-value assessment

### 2. Coherence Validation

Check that all infrastructure decisions work together:

**Decision Compatibility:**

- Do IaC tool choices align with the container platform?
- Does state management strategy support the environment topology?
- Are policy-as-code tools compatible with the chosen IaC framework?
- Does the secrets management approach integrate with the container platform?

**Cross-Section Consistency:**

- Does the network architecture support the environment topology?
- Are cost controls consistent across IaC and environment sections?
- Does drift detection cover both IaC resources and container configuration?
- Are security decisions consistent across network, container, and secrets sections?

### 3. Architecture Alignment

Verify infrastructure decisions support the source architecture document:

- Do compute decisions match the architecture's scale requirements?
- Does the network design support the architecture's communication patterns?
- Are security requirements from the architecture fully addressed?
- Does the environment strategy support the deployment model from the architecture?

### 4. Gap Analysis

Identify any remaining gaps:

**Critical Gaps** — Missing decisions that block implementation:
{{critical_gaps_or_none_found}}

**Important Gaps** — Areas needing more detail:
{{important_gaps_or_none_found}}

**Nice-to-Have Gaps** — Optional improvements:
{{nice_to_have_gaps_or_none_found}}

### 5. Generate Implementation Sequence

Prepare a recommended implementation order:

```markdown
## 6. Implementation Sequence

| Phase | Description | Dependencies | Owner |
|-------|-------------|-------------|-------|
| 1 | Bootstrap IaC backend and state management | None | {{owner}} |
| 2 | Provision network foundation (VPC, subnets, DNS) | Phase 1 | {{owner}} |
| 3 | Deploy secrets management infrastructure | Phase 2 | {{owner}} |
| 4 | Provision compute platform (K8s clusters / serverless) | Phase 2, 3 | {{owner}} |
| 5 | Configure policy-as-code and drift detection | Phase 1 | {{owner}} |
| 6 | Set up non-production environments | Phase 2, 3, 4 | {{owner}} |
| 7 | Set up production environment | Phase 6 validated | {{owner}} |
```

### 6. Present Validation Summary

Present the complete validation to the user:

"I've completed validation of your Infrastructure Plan.

**Quality Gate Results:**

- IaC Strategy: {{pass_count}}/{{total_count}} gates passed
- Environment Strategy: {{pass_count}}/{{total_count}} gates passed
- Network Architecture: {{pass_count}}/{{total_count}} gates passed
- Container Strategy: {{pass_count}}/{{total_count}} gates passed

**Coherence Check:** {{coherent_or_issues_found}}

**Architecture Alignment:** {{aligned_or_gaps_found}}

{if_gaps_found}
**Gaps Found:**
{{gap_summary}}
{/if_gaps_found}

**Implementation Sequence:**
[Show the implementation sequence table]

**What would you like to do?**
[C] Continue - Finalize the infrastructure plan
[R] Revise - Address gaps or adjust decisions before finalizing"

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask: "Which area would you like to address? (Quality gates / Coherence issues / Gaps / Implementation sequence)"
- Navigate back to the appropriate step or discuss inline
- Update the content based on feedback
- Return to [C] / [R] menu

#### If 'C' (Continue):

- Append validation results and implementation sequence to `{bgr_artifacts}/infrastructure.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4, 5]`, `status: approved`
- Update the Overview section (section 1) with project details gathered during the workflow
- Save the final document

### 8. Update Production Readiness Checklist

After saving the infrastructure plan, update the cross-workflow production readiness checklist:

1. Load `{bgr_artifacts}/production-readiness-checklist.md`
   - If it does not exist, create it from `../../templates/bgr-production-readiness-checklist-template.md`
2. Update the **Infrastructure Plan** row in the Workflow Completion Status table:
   - Status: `Complete`
   - Completion Date: `{{current_date}}`
   - Output Document: `{bgr_artifacts}/infrastructure.md`
3. Update section **2.3 Infrastructure Plan** with key decisions:
   - IaC tool selected
   - Cloud provider
   - Container orchestration platform
   - Environment topology summary
4. Check for cross-plan dependency gaps:
   - If Observability Plan exists: Verify infrastructure provisions resources for monitoring agents, collectors, and telemetry data egress
   - If Incident Response Plan exists: Verify environment access controls support on-call responder access and war room procedures
   - If Pipeline Plan exists: Verify environment topology matches pipeline deployment targets and runner infrastructure needs
   - Record any inconsistencies in section **4.3 Consistency Issues**
5. Update the `completedWorkflows` array in checklist frontmatter to include `infrastructure`
6. If all 4 workflows are now complete, update **Overall Status** to `READY` (if no critical gaps remain)
7. Save the updated checklist

### 9. Completion Message

After saving:

"Your Infrastructure Plan has been finalized and saved to `{bgr_artifacts}/infrastructure.md`.

**Summary of Decisions:**

- **IaC Tool:** {{selected_tool}}
- **Environments:** {{environment_list}}
- **Container Platform:** {{container_platform_or_deferred}}
- **Secrets Backend:** {{secrets_backend}}
- **Key Policies:** {{policy_summary}}

**Recommended Next Step:**
Create Pipeline Plan (CP) — Define CI/CD pipelines that deploy to the infrastructure you've just planned.

Thank you for the collaboration, {{user_name}}!"

## APPEND TO DOCUMENT:

When user selects 'C', append the validation results and implementation sequence to the document, and update the Overview section with gathered project details.

## SUCCESS METRICS:

✅ All quality gates evaluated and reported
✅ Coherence validated across all infrastructure sections
✅ Architecture alignment verified
✅ Gap analysis completed with prioritized findings
✅ Implementation sequence defined
✅ Final document saved with approved status
✅ Next workflow recommended to user
✅ Production readiness checklist updated with completion status and key decisions
✅ Cross-plan dependency gaps identified and recorded in checklist

## FAILURE MODES:

❌ Skipping quality gate checks
❌ Not validating coherence across sections
❌ Missing gap analysis
❌ Not providing implementation sequence
❌ Not updating frontmatter status to approved
❌ Not recommending next workflow step

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## WORKFLOW COMPLETE:

After the completion message is delivered, this workflow is finished. The infrastructure plan is saved and ready to inform the Pipeline workflow.
