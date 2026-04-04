# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between compliance peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating compliance mapping completeness and generating implementation backlog
- ✅ VALIDATE all applicable frameworks have full control coverage or documented gaps
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ✅ Run comprehensive validation checks on the complete compliance map
- ⚠️ Present C/R menu after generating validation results
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4, 5]` and `status: complete` before finishing
- 🚫 FORBIDDEN to finalize until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the validation results and finalize the compliance map
- **R (Revise)**: Discuss changes, address gaps, then re-present the menu

## CONTEXT BOUNDARIES:

- Complete compliance map document with all sections is available
- All framework selections, control mappings, gap analyses, and remediation plans are defined
- Focus on validation, completeness checks, and generating implementation backlog
- This is the final step — ensure the compliance map is actionable and audit-ready

## YOUR TASK:

Validate the complete compliance map for coverage, coherence, and actionability. Generate a prioritized implementation backlog and finalize the document.

## VALIDATION SEQUENCE:

### 1. Quality Gates Checklist

Run through each quality gate systematically:

**Gate 1: Framework Coverage Completeness**
- [ ] Every applicable framework identified in step 2 has a requirements mapping
- [ ] Every framework requirement is either mapped to a control or documented as a gap
- [ ] Framework prioritization is justified with risk and business impact rationale
- [ ] Compliance scope boundaries are clearly defined (systems, data, users)
- [ ] No framework requirements are unaccounted for (mapped, gapped, or explicitly excluded)

**Gate 2: Control Inventory Accuracy**
- [ ] All existing security controls are cataloged with type and maturity classification
- [ ] Every control has a designated owner and evidence source
- [ ] Control-to-requirement mappings are specific (not generic or aspirational)
- [ ] Shared controls across frameworks are identified for efficiency
- [ ] Control maturity levels are honestly assessed (not inflated)
- [ ] Evidence collection methods are defined for every mapped control

**Gate 3: Gap Analysis Rigor**
- [ ] All unmet requirements are identified with specific gap descriptions
- [ ] Risk scores are applied consistently using the defined methodology
- [ ] Gap descriptions clearly state current state vs required state
- [ ] No "Status: Partial" controls are left without a gap entry for the unmet portion
- [ ] Risk justifications are documented (not just scores)

**Gate 4: Remediation Plan Actionability**
- [ ] Every gap has a remediation action with a designated owner
- [ ] Remediation actions specify validation criteria (how to verify closure)
- [ ] Dependencies between remediations are identified and sequenced
- [ ] Effort estimates are realistic and aligned with priority tiers
- [ ] Remediation roadmap covers all Critical and High risk gaps in Tier 1/2
- [ ] No remediation action is orphaned (assigned to non-existent role)

**Gate 5: Evidence & Audit Readiness**
- [ ] Evidence collection plan covers all control categories
- [ ] Evidence automation opportunities are identified
- [ ] Evidence storage and retention align with framework requirements
- [ ] Audit readiness checklist exists per applicable framework
- [ ] Evidence collection frequency matches control monitoring needs

**Gate 6: Continuous Compliance Strategy**
- [ ] Ongoing monitoring approach is defined (not just point-in-time assessment)
- [ ] Policy-as-code or automated compliance checking is considered
- [ ] Framework update tracking process is defined
- [ ] Regular review cadence is established (quarterly, annually)
- [ ] Drift detection mechanisms are specified for critical controls

### 2. Present Validation Summary

Report the validation results to the user:

"Here's the validation summary for the {{project_name}} Compliance Map.

**Quality Gate Results:**

| Gate | Status | Notes |
|------|--------|-------|
| Framework Coverage | {PASS/FAIL} | {details} |
| Control Inventory | {PASS/FAIL} | {details} |
| Gap Analysis Rigor | {PASS/FAIL} | {details} |
| Remediation Actionability | {PASS/FAIL} | {details} |
| Evidence & Audit Readiness | {PASS/FAIL} | {details} |
| Continuous Compliance | {PASS/FAIL} | {details} |

{if_any_failures}
**Issues to Address:**
{list of failed gates with specific gaps}

Would you like to address these before finalizing?
{/if_any_failures}

{if_all_pass}
All quality gates passed. The compliance map is comprehensive and ready for implementation.
{/if_all_pass}"

### 3. Address Validation Issues

If any quality gates failed:

- Present the specific gaps clearly
- Collaborate with the user to resolve each gap
- Update the relevant document sections
- Re-run the failed quality gates to confirm resolution

### 4. Generate Implementation Backlog

Create a prioritized list of implementation tasks:

**Priority 1 — Foundation (implement first):**
- Close all Critical risk gaps immediately
- Establish evidence collection infrastructure
- Implement shared controls that cover multiple frameworks
- Set up continuous compliance monitoring baseline

**Priority 2 — Certification Readiness (implement second):**
- Close all High risk gaps
- Complete framework-specific control implementations
- Build audit evidence packages for primary framework
- Conduct internal readiness assessment

**Priority 3 — Full Coverage (implement third):**
- Close Medium risk gaps
- Extend controls to secondary frameworks
- Automate evidence collection and reporting
- Implement policy-as-code for critical controls

**Priority 4 — Maturity (implement ongoing):**
- Close Low risk gaps
- Establish regular compliance review cadence
- Implement continuous compliance monitoring
- Track framework updates and emerging requirements

### 5. Generate Validation Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## Validation Results

### Quality Gates

| Gate | Status | Notes |
|------|--------|-------|
{{quality_gate_results}}

### Compliance Completeness Checklist

**✅ Framework Coverage**

- [x] All applicable frameworks identified and prioritized
- [x] Every requirement mapped to control or documented as gap
- [x] Compliance scope boundaries clearly defined

**✅ Control Inventory**

- [x] All existing controls cataloged with ownership
- [x] Control-to-requirement mappings verified
- [x] Shared controls identified across frameworks
- [x] Evidence sources documented

**✅ Gap Analysis**

- [x] All unmet requirements identified and risk-scored
- [x] Current state vs required state documented per gap
- [x] Risk scoring methodology consistently applied

**✅ Remediation Plan**

- [x] Every gap has a remediation action with owner
- [x] Actions prioritized into implementation tiers
- [x] Validation criteria defined for each remediation
- [x] Dependencies mapped and sequenced

**✅ Evidence & Audit**

- [x] Evidence collection plan covers all control categories
- [x] Automation opportunities identified
- [x] Retention aligned with framework requirements

**✅ Continuous Compliance**

- [x] Ongoing monitoring approach defined
- [x] Review cadence established
- [x] Drift detection mechanisms specified

## 8. Audit Readiness Checklist

### Per-Framework Readiness

| Framework | Controls Mapped | Gaps Remaining | Evidence Ready | Audit Ready |
|-----------|----------------|---------------|----------------|-------------|
{{audit_readiness_per_framework}}

## 9. Continuous Compliance Strategy

### Automated Monitoring

{{automated_monitoring_approach}}

### Policy-as-Code

{{policy_as_code_strategy}}

### Drift Detection

{{drift_detection_mechanisms}}

### Review Cadence

{{review_schedule_and_ownership}}

## 10. Cost Estimation

| Component | Tool/Service | Tier | Monthly Cost (Est.) | Annual Cost (Est.) | Notes |
|-----------|-------------|------|---------------------|--------------------|-------|
{{cost_estimation_entries}}

### 10.1 Cost Breakdown by Category

- **GRC platform / compliance tooling**:
- **Audit fees (external)**:
- **Certification costs**:
- **Remediation implementation**:
- **Ongoing compliance operations**:
- **Total estimated annual cost**:
- **Cost per framework**:

### 10.2 Cost Optimization Strategies

- Shared controls reduce per-framework cost:
- Automation reduces manual evidence collection:
- Phased implementation aligns spend with priority:

## 11. Decision Rationale

### 11.1 Framework Prioritization Rationale

{{framework_prioritization_decisions}}

### 11.2 Tool Selection Rationale

| Category | Chosen Tool | Alternatives Evaluated | Key Deciding Factors |
|----------|-------------|----------------------|---------------------|
{{tool_selection_rationale}}

### 11.3 Trade-Off Summary

| Decision | Benefit Gained | Trade-Off Accepted |
|----------|---------------|-------------------|
{{tradeoff_summary}}

## 12. Implementation Roadmap

| Milestone | Description | Owner | Target Date |
|-----------|-------------|-------|-------------|
{{implementation_backlog_entries}}

### Priority 1: Foundation

{{foundation_tasks}}

### Priority 2: Certification Readiness

{{certification_readiness_tasks}}

### Priority 3: Full Coverage

{{full_coverage_tasks}}

### Priority 4: Maturity

{{maturity_tasks}}
```

### 6. Save Final Document

- Append the validation and implementation content to `{bgr_artifacts}/compliance-map.md`
- Update frontmatter:
  - `stepsCompleted: [1, 2, 3, 4, 5]`
  - `status: complete`
  - `lastUpdated: {{current_date}}`

### 7. Present Content and Menu

Show the generated content and present choices:

"I've completed the validation and generated the implementation roadmap.

**Here's what I'll add to finalize the compliance map:**

[Show the complete markdown content from step 5]

**What would you like to do?**
[C] Continue - Save and finalize the compliance map
[R] Revise - Let's address issues before finalizing"

### 8. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-run relevant quality gates
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Save the final content to `{bgr_artifacts}/compliance-map.md`
- Update frontmatter to mark workflow as complete
- Present completion summary and next steps

### 9. Completion Summary

After saving, present the final summary:

"The Compliance Map for {{project_name}} is complete and saved to `{bgr_artifacts}/compliance-map.md`.

**Summary:**
- {N} regulatory frameworks assessed and prioritized
- {N} existing controls mapped across frameworks
- {N} compliance gaps identified and risk-scored
- {N} remediation actions with owners in a prioritized roadmap
- Evidence collection plan with automation opportunities
- Continuous compliance strategy with drift detection

**Recommended Next Steps:**
- **Create Security Plan** — Define comprehensive security architecture and policies
- **Create Incident Response Plan** — Define severity classification, runbooks, and response procedures
- **Return to agent menu** — Explore other capabilities

Thank you for collaborating on this, {{user_name}}. Your compliance posture is mapped and actionable."

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 5.

## SUCCESS METRICS:

✅ All quality gates evaluated systematically
✅ Any failures identified and addressed with user
✅ Implementation backlog generated with clear priorities
✅ Final document saved with complete frontmatter
✅ User presented with clear next steps
✅ C/R menu presented and handled correctly
✅ Workflow marked as complete

## FAILURE MODES:

❌ Rubber-stamping quality gates without thorough checking
❌ Not addressing failed quality gates before finalizing
❌ Generating a backlog without prioritization
❌ Not saving the final document with updated frontmatter
❌ Not presenting recommended next steps
❌ Finalizing without user confirmation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols
