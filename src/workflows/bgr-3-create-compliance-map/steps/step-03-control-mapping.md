# Step 3: Control Inventory & Mapping

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between compliance peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on inventorying existing controls and mapping them to framework requirements
- 🎯 BUILD on the framework selection from step 2
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating control mapping content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the control mapping, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with Framework Selection & Scope from step 2 is available
- Architecture decisions, security plan, and infrastructure context are loaded
- Frameworks identified in step 2 drive the control mapping scope
- Focus on what controls exist today and how they map to requirements

## YOUR TASK:

Build a comprehensive control inventory by cataloging existing security controls, mapping them to framework requirements, identifying shared controls across frameworks, and documenting control ownership and evidence sources.

## CONTROL MAPPING SEQUENCE:

### 1. Inventory Existing Security Controls

Work with the user to catalog all existing controls:

**Technical Controls:**
- Authentication mechanisms (MFA, SSO, password policies)
- Authorization and access control (RBAC, ABAC, least privilege)
- Encryption (at rest, in transit, key management)
- Network security (firewalls, WAF, DDoS protection, segmentation)
- Vulnerability management (scanning, patching cadence)
- Logging and monitoring (SIEM, audit logs, intrusion detection)
- Backup and recovery (backup frequency, RTO, RPO)
- Endpoint security (EDR, device management)

**Administrative Controls:**
- Security policies (acceptable use, data handling, incident response)
- Risk assessment processes (frequency, methodology)
- Employee security training (onboarding, annual, phishing simulations)
- Vendor management (third-party risk assessments, SLA monitoring)
- Change management (approval workflows, rollback procedures)
- Business continuity planning (BCP/DR documentation, testing)

**Physical Controls (if applicable):**
- Data center security (if self-hosted)
- Cloud provider physical controls (inherited from AWS/GCP/Azure)
- Office security (badge access, visitor management)
- Media handling and disposal

### 2. Classify Control Types

For each control, classify:

| Control | Type | Category | Implementation | Maturity |
|---------|------|----------|---------------|----------|
| MFA for all users | Preventive | Technical | Implemented | Mature |
| Annual pen testing | Detective | Administrative | Implemented | Developing |
| WAF rules | Preventive | Technical | Partial | Initial |

**Control Types:**
- **Preventive**: Stops threats before they occur
- **Detective**: Identifies threats when they occur
- **Corrective**: Remediates after threat occurrence
- **Compensating**: Alternative control when primary is infeasible

**Maturity Levels:**
- **Initial**: Ad-hoc, undocumented
- **Developing**: Documented but inconsistently applied
- **Defined**: Standardized and consistently applied
- **Managed**: Measured and monitored
- **Optimized**: Continuously improved

### 3. Map Controls to Framework Requirements

For each applicable framework from step 2, create a control-to-requirement mapping:

**SOC 2 Trust Service Criteria Mapping:**

| TSC ID | Requirement | Mapped Control(s) | Evidence Source | Status |
|--------|-------------|-------------------|----------------|--------|
| CC1.1 | COSO Principle 1: Integrity and ethical values | Security policy, code of conduct | Policy docs, training records | Mapped |
| CC6.1 | Logical and physical access controls | RBAC, MFA, network segmentation | IAM config, MFA logs | Mapped |
| CC7.2 | Monitoring for anomalies | SIEM, audit logging | SIEM dashboards, alert configs | Partial |

**HIPAA Security Rule Mapping (if applicable):**

| Section | Requirement | Mapped Control(s) | Evidence Source | Status |
|---------|-------------|-------------------|----------------|--------|
| 164.312(a)(1) | Access control | RBAC, MFA | IAM config | Mapped |
| 164.312(a)(2)(iv) | Encryption and decryption | TLS 1.3, AES-256 | Cert configs, KMS | Mapped |
| 164.312(b) | Audit controls | Audit logging, SIEM | Log configs | Partial |

**PCI-DSS Requirements Mapping (if applicable):**

| Req ID | Requirement | Mapped Control(s) | Evidence Source | Status |
|--------|-------------|-------------------|----------------|--------|
| 1.1 | Firewall configuration standards | Network segmentation, WAF | Firewall rules | Mapped |
| 3.4 | Render PAN unreadable | Column encryption, tokenization | DB configs | Mapped |
| 8.3 | MFA for admin access | MFA, SSO | MFA enrollment | Mapped |

**GDPR Article Mapping (if applicable):**

| Article | Requirement | Mapped Control(s) | Evidence Source | Status |
|---------|-------------|-------------------|----------------|--------|
| Art. 25 | Data protection by design | Privacy impact assessment, minimization | PIA docs | Partial |
| Art. 32 | Security of processing | Encryption, access control, monitoring | Security configs | Mapped |
| Art. 33 | Breach notification | Incident response plan, notification SOP | IR playbook | Mapped |

**NIST CSF Mapping (if applicable):**

| Function | Category | Mapped Control(s) | Evidence Source | Status |
|----------|----------|-------------------|----------------|--------|
| Identify | ID.AM-1: Physical devices | Asset inventory | CMDB | Mapped |
| Protect | PR.AC-1: Identity management | IAM, MFA, SSO | IAM config | Mapped |
| Detect | DE.CM-1: Network monitoring | IDS/IPS, SIEM | Alert configs | Partial |

### 4. Identify Shared Controls Across Frameworks

Map controls that satisfy multiple frameworks simultaneously:

**Cross-Framework Control Matrix:**

| Control | SOC 2 | HIPAA | PCI-DSS | GDPR | NIST |
|---------|-------|-------|---------|------|------|
| MFA | CC6.1 | 164.312(d) | 8.3 | Art. 32 | PR.AC-7 |
| Encryption at rest | CC6.7 | 164.312(a)(2)(iv) | 3.4 | Art. 32 | PR.DS-1 |
| Audit logging | CC7.2 | 164.312(b) | 10.1 | Art. 30 | DE.CM-3 |
| Access control | CC6.3 | 164.312(a)(1) | 7.1 | Art. 25 | PR.AC-4 |
| Incident response | CC7.3 | 164.308(a)(6) | 12.10 | Art. 33 | RS.RP-1 |

**Efficiency Analysis:**
- Highlight controls that cover 3+ frameworks (high-value controls)
- Identify framework-specific controls that cannot be shared
- Calculate coverage percentage per framework from shared controls

### 5. Document Control Ownership and Evidence

For each control, document:

**Ownership Matrix:**

| Control | Owner (Role) | Operator (Team) | Review Frequency | Last Reviewed |
|---------|-------------|-----------------|-----------------|---------------|
| MFA | CISO | Identity team | Quarterly | 2024-Q4 |
| Encryption | Security Lead | Platform team | Annually | 2024-01 |
| Audit logging | Security Lead | SRE team | Monthly | 2024-12 |

**Evidence Sources:**

| Control | Evidence Type | Location | Collection Method | Frequency |
|---------|-------------|----------|-------------------|-----------|
| MFA | Enrollment report | IdP dashboard | Automated export | Monthly |
| Encryption | Configuration audit | Terraform state | IaC scan | Per deploy |
| Audit logging | Log sample review | SIEM platform | Manual review | Weekly |

### 6. Present Control Mapping

Reflect the control mapping back to the user:

"Here's the Control Inventory & Mapping I've drafted for {{project_name}}.

**Control Inventory:**
- {N} total controls cataloged
- Technical: {count} | Administrative: {count} | Physical: {count}
- Maturity: {distribution across maturity levels}

**Framework Coverage:**
- SOC 2: {percentage} of requirements mapped to existing controls
- HIPAA: {percentage} mapped (if applicable)
- PCI-DSS: {percentage} mapped (if applicable)
- GDPR: {percentage} mapped (if applicable)
- NIST: {percentage} mapped (if applicable)

**Shared Controls:**
- {N} controls serve multiple frameworks
- Highest-value controls: {top 3-5 shared controls}

**Unmapped Requirements:**
- {count} requirements across all frameworks have no mapped control
- These will be addressed in the Gap Analysis step

Does this inventory look complete? Any controls I missed or got wrong?"

### 7. Generate Control Mapping Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 3. Control Inventory

### Existing Controls

| Control | Type | Category | Owner | Maturity | Evidence Source | Frameworks |
|---------|------|----------|-------|----------|----------------|------------|
{{control_inventory_entries}}

### Control Maturity Distribution

{{maturity_distribution_summary}}

## 4. Framework Requirements Mapping

### SOC 2 Trust Service Criteria

| TSC ID | Requirement | Mapped Control(s) | Evidence | Status |
|--------|-------------|-------------------|----------|--------|
{{soc2_mapping_entries}}

### {{other_framework_name}} Requirements

| Req ID | Requirement | Mapped Control(s) | Evidence | Status |
|--------|-------------|-------------------|----------|--------|
{{framework_mapping_entries}}

### Cross-Framework Control Matrix

| Control | SOC 2 | HIPAA | PCI-DSS | GDPR | NIST |
|---------|-------|-------|---------|------|------|
{{cross_framework_matrix_entries}}

### Control Ownership

| Control | Owner | Operator | Review Frequency | Last Reviewed |
|---------|-------|----------|-----------------|---------------|
{{ownership_entries}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Control Inventory & Mapping covering existing controls, framework-specific mappings, and cross-framework analysis.

**Here's what I'll add to the compliance map:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this mapping and proceed to gap analysis
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/compliance-map.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3]`
- Load `./step-04-gap-analysis.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 7.

## SUCCESS METRICS:

✅ All existing security controls inventoried and classified
✅ Controls mapped to specific framework requirements with evidence
✅ Shared controls identified across frameworks for efficiency
✅ Control ownership and review cadence documented
✅ Evidence sources identified for each control
✅ Coverage gaps surfaced for gap analysis step
✅ User confirmation of control inventory completeness
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Missing existing controls that are already in place
❌ Not classifying controls by type and maturity
❌ Mapping controls without specifying evidence sources
❌ Not identifying shared controls across frameworks
❌ Not validating control inventory with user
❌ Generating content without building on step 2 framework selection

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-04-gap-analysis.md` to identify unmet requirements and build the remediation roadmap.

Remember: Do NOT proceed to step-04 until user explicitly selects 'C' from the C/R menu and content is saved!
