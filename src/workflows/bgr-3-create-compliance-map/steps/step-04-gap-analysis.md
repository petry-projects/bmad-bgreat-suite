# Step 4: Gap Analysis & Remediation Planning

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between compliance peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on identifying unmet requirements and designing remediation actions
- 🎯 BUILD on the control mapping from step 3
- ⚠️ NO TASK DURATION ESTIMATES (e.g. "this will take 3 days") — AI development speed has fundamentally changed. Timeline planning using target quarters for remediation milestones is acceptable and expected.
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating gap analysis and remediation content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the gap analysis, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with Framework Selection and Control Mapping is available
- All framework requirements and existing controls are documented
- Focus on what's missing and how to close each gap
- This is where compliance mapping becomes actionable

## YOUR TASK:

Identify unmet requirements per framework, risk-score each gap, design remediation actions with owners and timelines, and create an evidence collection plan.

## GAP ANALYSIS SEQUENCE:

### 1. Identify Unmet Requirements

For each applicable framework, systematically compare requirements against mapped controls:

**Gap Identification Process:**
- Review each framework requirement from step 3
- For requirements with "Status: Unmapped" or "Status: Partial" — these are gaps
- For requirements with "Status: Mapped" — verify the control actually satisfies the requirement fully
- Document the specific deficiency for each gap

**SOC 2 Gaps (if applicable):**

| TSC ID | Requirement | Gap Description | Current State | Required State |
|--------|-------------|----------------|---------------|----------------|
| CC6.2 | Prior to issuing system credentials, registered and authorized | No formal provisioning workflow | Manual account creation | Automated provisioning with approval |
| CC7.1 | Detect and monitor configuration changes | No configuration drift detection | Manual reviews | Automated config scanning |

**HIPAA Gaps (if applicable):**

| Section | Requirement | Gap Description | Current State | Required State |
|---------|-------------|----------------|---------------|----------------|
| 164.308(a)(1) | Risk analysis | No formal risk assessment | Ad-hoc reviews | Annual formal assessment |
| 164.310(d)(1) | Device and media controls | No media disposal policy | Undefined process | Documented disposal SOP |

**PCI-DSS Gaps (if applicable):**

| Req ID | Requirement | Gap Description | Current State | Required State |
|--------|-------------|----------------|---------------|----------------|
| 6.5 | Address common coding vulnerabilities | No SAST/DAST in pipeline | Manual code review only | Automated security scanning |
| 11.2 | Run network vulnerability scans | No regular scanning | Ad-hoc | Quarterly external scans |

**GDPR Gaps (if applicable):**

| Article | Requirement | Gap Description | Current State | Required State |
|---------|-------------|----------------|---------------|----------------|
| Art. 15 | Right of access | No self-service data export | Manual requests | Automated data subject portal |
| Art. 17 | Right to erasure | No automated deletion | Manual process | Automated erasure workflow |

**NIST CSF Gaps (if applicable):**

| Function | Category | Gap Description | Current State | Required State |
|----------|----------|----------------|---------------|----------------|
| Identify | ID.RA-1 | Asset vulnerabilities not identified | Partial inventory | Automated vulnerability discovery |
| Recover | RC.RP-1 | Recovery plan not executed | Documented only | Tested annually |

### 2. Risk-Score Each Gap

Apply a consistent risk scoring methodology to every identified gap:

**Risk Scoring Framework:**

| Factor | Weight | 1 (Low) | 2 (Medium) | 3 (High) | 4 (Critical) |
|--------|--------|---------|------------|-----------|---------------|
| Likelihood of exploitation | 30% | Unlikely | Possible | Likely | Almost certain |
| Impact if exploited | 30% | Minor | Moderate | Major | Severe |
| Regulatory penalty exposure | 20% | Low fines | Moderate fines | Significant fines | Max penalties |
| Business impact | 20% | Minimal | Operational | Strategic | Existential |

**Risk Score Calculation:**
- Weighted score = (Likelihood x 0.3) + (Impact x 0.3) + (Penalty x 0.2) + (Business x 0.2)
- Risk Level: 1.0-1.5 = Low | 1.6-2.5 = Medium | 2.6-3.5 = High | 3.6-4.0 = Critical

**Gap Risk Register:**

| Gap ID | Framework | Requirement | Risk Score | Risk Level | Justification |
|--------|-----------|-------------|------------|------------|---------------|
| GAP-001 | PCI-DSS | 6.5 | 3.2 | High | No automated security scanning in CI/CD |
| GAP-002 | HIPAA | 164.308(a)(1) | 2.8 | High | No formal risk assessment process |
| GAP-003 | GDPR | Art. 17 | 2.4 | Medium | Manual erasure process exists but not automated |

### 3. Design Remediation Actions

For each gap, design a specific remediation action:

**Remediation Plan Structure:**

| Gap ID | Remediation Action | Owner | Timeline | Effort | Dependencies | Validation |
|--------|-------------------|-------|----------|--------|-------------|------------|
| GAP-001 | Integrate SAST/DAST tools into CI/CD pipeline | Security Lead | Q2 | Medium | CI/CD access, tool selection | Scan results in pipeline |
| GAP-002 | Establish formal risk assessment program | CISO | Q1 | High | Risk framework selection | Completed assessment doc |
| GAP-003 | Build automated data subject erasure workflow | Engineering Lead | Q3 | High | Data mapping, API development | Erasure request processing |

**For each remediation action, define:**
- **What**: Specific deliverable or control to implement
- **Who**: Role responsible for implementation (not person-dependent)
- **When**: Target quarter or milestone (not specific dates)
- **How**: Implementation approach at a high level
- **Effort**: Low / Medium / High
- **Dependencies**: What must be in place first
- **Validation**: How to verify the gap is closed
- **Frameworks addressed**: Which frameworks this remediation satisfies

### 4. Create Remediation Roadmap

Organize remediation actions into a prioritized roadmap:

**Priority Tier 1 — Critical (implement immediately):**
- Gaps with Critical or High risk scores
- Gaps blocking certification or audit readiness
- Gaps with active regulatory exposure
- Quick wins that close multiple framework gaps simultaneously

**Priority Tier 2 — Important (implement next quarter):**
- Gaps with Medium risk scores
- Gaps that enhance existing partial controls
- Gaps required for certification timeline
- Controls that enable other remediations

**Priority Tier 3 — Planned (implement within 6 months):**
- Gaps with Low risk scores
- Maturity improvements to existing controls
- Nice-to-have enhancements
- Long-term automation initiatives

**Priority Tier 4 — Continuous (ongoing improvements):**
- Process maturity improvements
- Automation of manual controls
- Regular review and update cycles
- Emerging framework requirement tracking

### 5. Design Evidence Collection Plan

Define how compliance evidence will be gathered and maintained:

**Evidence Categories:**

| Category | Examples | Collection Method | Frequency | Storage |
|----------|---------|-------------------|-----------|---------|
| Configuration evidence | IAM policies, firewall rules, encryption configs | Automated IaC scanning | Per deployment | Compliance repository |
| Process evidence | Change approvals, access reviews, training records | Workflow tool export | Per occurrence | GRC platform |
| Testing evidence | Pen test reports, vulnerability scans, DR test results | Test execution reports | Quarterly | Compliance repository |
| Monitoring evidence | Audit logs, alert histories, incident records | SIEM/log export | Monthly | Log archive |
| Policy evidence | Security policies, procedures, standards | Document management | Annually | Policy repository |

**Evidence Lifecycle:**
- **Collection**: Automated where possible, manual with defined SOPs
- **Review**: Regular review for completeness and accuracy
- **Storage**: Centralized, access-controlled, tamper-evident
- **Retention**: Aligned with framework requirements (typically 1-7 years)
- **Disposal**: Documented destruction per retention policy

**Automation Opportunities:**
- Infrastructure-as-code scans for configuration evidence
- CI/CD pipeline artifacts for testing evidence
- Automated access review reports from IdP
- Continuous compliance monitoring dashboards
- Automated evidence collection for audit packages

### 6. Present Gap Analysis

Reflect the gap analysis and remediation plan back to the user:

"Here's the Gap Analysis & Remediation Plan I've drafted for {{project_name}}.

**Gap Summary:**
- {N} total gaps identified across all frameworks
- Critical: {count} | High: {count} | Medium: {count} | Low: {count}

**Framework Gap Distribution:**
- SOC 2: {count} gaps ({percentage} coverage)
- HIPAA: {count} gaps (if applicable)
- PCI-DSS: {count} gaps (if applicable)
- GDPR: {count} gaps (if applicable)
- NIST: {count} gaps (if applicable)

**Remediation Roadmap:**
- Tier 1 (Critical): {count} actions
- Tier 2 (Important): {count} actions
- Tier 3 (Planned): {count} actions
- Tier 4 (Continuous): {count} actions

**Evidence Collection:**
- {N} evidence categories defined
- Automated collection for {percentage} of evidence types

Does this gap analysis look accurate? Any gaps I missed or risk scores to adjust?"

### 7. Generate Gap Analysis Content

Prepare the content to replace the existing placeholder sections 5, 6, and 7 in the document:

#### Content Structure:

```markdown
## 5. Gap Analysis

### Compliance Gaps by Framework

| Gap ID | Framework | Requirement | Gap Description | Risk Score | Risk Level |
|--------|-----------|-------------|----------------|------------|------------|
{{gap_register_entries}}

### Risk Scoring Summary

{{risk_distribution_summary}}

## 6. Remediation Roadmap

### Priority Tier 1: Critical

| Gap ID | Remediation Action | Owner | Timeline | Effort | Dependencies |
|--------|-------------------|-------|----------|--------|-------------|
{{tier_1_entries}}

### Priority Tier 2: Important

| Gap ID | Remediation Action | Owner | Timeline | Effort | Dependencies |
|--------|-------------------|-------|----------|--------|-------------|
{{tier_2_entries}}

### Priority Tier 3: Planned

| Gap ID | Remediation Action | Owner | Timeline | Effort | Dependencies |
|--------|-------------------|-------|----------|--------|-------------|
{{tier_3_entries}}

### Priority Tier 4: Continuous

{{tier_4_entries}}

## 7. Evidence Collection Plan

### Evidence Matrix

| Category | Evidence Type | Collection Method | Frequency | Storage | Owner |
|----------|-------------|-------------------|-----------|---------|-------|
{{evidence_matrix_entries}}

### Evidence Automation

{{automation_opportunities_and_tooling}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Gap Analysis & Remediation Plan covering identified gaps, risk scoring, remediation roadmap, and evidence collection plan.

**Here's what I'll add to the compliance map:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this analysis and proceed to validation
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Replace the existing placeholder sections 5, 6, and 7 in `{bgr_artifacts}/compliance-map.md` with the final content
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4]`
- Load `./step-05-validation.md`

## UPDATE DOCUMENT:

When user selects 'C', replace the existing placeholder sections 5, 6, and 7 in the document with the content from step 7.

## SUCCESS METRICS:

✅ All unmet requirements identified per applicable framework
✅ Gaps risk-scored with consistent methodology
✅ Remediation actions designed with owners, timelines, and validation criteria
✅ Remediation roadmap prioritized into tiers
✅ Evidence collection plan covers all control types
✅ Automation opportunities identified for evidence gathering
✅ User confirmation of gap analysis and remediation plan
✅ C/R menu presented and handled correctly
✅ Content properly replaces placeholder sections in document when C selected

## FAILURE MODES:

❌ Missing gaps by not systematically comparing every requirement
❌ Inconsistent risk scoring across gaps
❌ Remediation actions without clear owners or validation criteria
❌ Not prioritizing remediation by risk and business impact
❌ Evidence collection plan missing key compliance evidence types
❌ Not validating gap analysis with user

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-05-validation.md` to validate completeness and finalize the compliance map.

Remember: Do NOT proceed to step-05 until user explicitly selects 'C' from the C/R menu and content is saved!
