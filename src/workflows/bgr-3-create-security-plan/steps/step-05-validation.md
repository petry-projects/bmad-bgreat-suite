# Step 5: Validation & Finalization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between security peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on validating security completeness, supply chain security, and generating implementation backlog
- ✅ VALIDATE all critical threats have controls, all data has classification, all identities are governed
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ✅ Run comprehensive validation checks on the complete security plan
- ⚠️ Present C/R menu after generating validation results
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4, 5]` and `status: complete` before finishing
- 🚫 FORBIDDEN to finalize until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the validation results and finalize the security plan
- **R (Revise)**: Discuss changes, address gaps, then re-present the menu

## CONTEXT BOUNDARIES:

- Complete security document with all sections is available
- Threat model, security controls, identity management, and data protection are defined
- Focus on validation, supply chain security, security testing, incident response, and implementation backlog
- This is the final step — ensure the plan is actionable

## YOUR TASK:

Complete the security plan by covering supply chain security, security testing strategy, and incident response integration. Then validate the complete plan for coverage, coherence, and actionability. Generate a prioritized implementation backlog and finalize the document.

## VALIDATION & FINALIZATION SEQUENCE:

### 1. Supply Chain Security

Before validation, complete the supply chain security section:

**Dependency Management:**
- Dependency inventory and version tracking
- Automated vulnerability scanning (Dependabot, Snyk, Trivy, Grype)
- Dependency update policy (security patches within 24-72h, minor/major on cadence)
- License compliance scanning
- Private package registry for internal dependencies

**Software Bill of Materials (SBOM):**
- SBOM generation format (SPDX or CycloneDX)
- SBOM generation at build time for every release
- SBOM storage and versioning
- SBOM sharing with downstream consumers

**Container Security:**
- Base image policy (minimal, distroless, or hardened images only)
- Image scanning in CI pipeline before push to registry
- Image signing and verification (cosign, Notary)
- Runtime container security (no root, read-only filesystem, drop capabilities)
- Container registry access controls and vulnerability scanning

**CI/CD Pipeline Security:**
- Pipeline-as-code with version control and review
- Secrets in pipeline: vault integration, no environment variable secrets
- Build environment isolation (ephemeral build agents)
- Artifact signing and provenance attestation (SLSA framework)
- Branch protection and required reviews for deployment pipelines
- Supply chain attestation verification before deployment

### 2. Security Testing Strategy

Define the security testing approach:

**Static Application Security Testing (SAST):**
- Tool selection and integration in CI pipeline
- Rule configuration aligned with identified threats
- False positive management workflow
- Developer feedback loop (IDE integration, PR comments)

**Dynamic Application Security Testing (DAST):**
- Tool selection and scan scheduling
- Authenticated vs unauthenticated scanning
- Integration with staging/pre-production environments
- Finding triage and remediation workflow

**Software Composition Analysis (SCA):**
- Continuous monitoring of dependencies for new vulnerabilities
- CVE severity thresholds for build-breaking (Critical/High = block)
- Remediation SLAs by severity

**Penetration Testing Schedule:**

| Test Type | Frequency | Scope | Provider | Notes |
|-----------|-----------|-------|----------|-------|
| External penetration test | Annual | All external-facing services | Third-party | Compliance requirement |
| Internal penetration test | Annual | Internal network and services | Third-party | Include lateral movement |
| Web application pentest | Semi-annual | All web applications | Third-party or internal | Include OWASP Top 10 |
| Red team exercise | Annual | Full scope | Specialized firm | Include social engineering |
| Bug bounty program | Ongoing | Public-facing assets | Platform (HackerOne, etc.) | Responsible disclosure |

### 3. Incident Response Integration

Define how security events integrate with incident response:

**Security Event Classification:**

| Severity | Description | Examples | Response Time |
|----------|-------------|----------|---------------|
| SEV-1 (Critical) | Active breach or imminent threat | Data exfiltration, ransomware, credential compromise | Immediate (<15 min) |
| SEV-2 (High) | Confirmed vulnerability being exploited | Zero-day exploitation, unauthorized access detected | <1 hour |
| SEV-3 (Medium) | Potential security issue, investigation needed | Suspicious activity, failed pentest finding | <4 hours |
| SEV-4 (Low) | Security improvement, no active threat | Configuration drift, policy violation, audit finding | Next business day |

**SIEM/SOAR Integration:**
- Security event sources: WAF logs, authentication logs, API gateway logs, cloud audit logs
- Correlation rules for attack detection patterns
- Automated response playbooks (block IP, revoke token, isolate host)
- Security analyst dashboard and investigation tools
- Threat intelligence feed integration

### 4. Quality Gates Checklist

Run through each quality gate systematically:

**Gate 1: Threat Model Coverage**
- [ ] Every component from the architecture has been analyzed with STRIDE
- [ ] All trust boundaries are identified and documented
- [ ] Data flows are mapped with sensitivity classification
- [ ] Risk scores are calculated for all identified threats
- [ ] Attack trees cover top critical paths

**Gate 2: Security Controls Completeness**
- [ ] Zero-trust architecture is designed with identity, policy, and enforcement
- [ ] Network segmentation covers all tiers (public, application, data)
- [ ] WAF, DDoS protection, and egress controls are specified
- [ ] Application security addresses OWASP Top 10 categories
- [ ] API security covers authentication, authorization, and rate limiting
- [ ] Every Critical and High threat has at least one mapped control

**Gate 3: Identity & Access Management**
- [ ] RBAC/ABAC model is defined with role matrix
- [ ] MFA policy covers all human users with approved methods
- [ ] Service account governance with unique identities per service
- [ ] Least privilege verified with JIT/JEA for elevated access
- [ ] Access review cadence is established

**Gate 4: Secret & Key Management**
- [ ] Central vault strategy is defined with HA and DR
- [ ] Rotation policies cover all secret types with automation
- [ ] Secret scanning is integrated in pre-commit and CI pipeline
- [ ] Key management lifecycle covers generation through destruction
- [ ] Emergency rotation procedures are documented

**Gate 5: Data Protection**
- [ ] Data classification matrix with 4 levels and handling requirements
- [ ] Encryption at rest for all data stores (AES-256 minimum)
- [ ] Encryption in transit (TLS 1.2+ for external, mTLS for internal)
- [ ] Field-level encryption for Restricted data attributes
- [ ] DLP strategy is defined with monitoring and alerting

**Gate 6: Supply Chain & Testing**
- [ ] Dependency scanning integrated in CI/CD
- [ ] SBOM generation configured for all releases
- [ ] Container images scanned, signed, and verified
- [ ] CI/CD pipeline hardened with artifact signing
- [ ] SAST, DAST, and SCA integrated in development workflow
- [ ] Penetration testing schedule established

### 5. Present Validation Summary

Report the validation results to the user:

"Here's the validation summary for the {{project_name}} Security Plan.

**Quality Gate Results:**

| Gate | Status | Notes |
|------|--------|-------|
| Threat Model Coverage | {PASS/FAIL} | {details} |
| Security Controls Completeness | {PASS/FAIL} | {details} |
| Identity & Access Management | {PASS/FAIL} | {details} |
| Secret & Key Management | {PASS/FAIL} | {details} |
| Data Protection | {PASS/FAIL} | {details} |
| Supply Chain & Testing | {PASS/FAIL} | {details} |

{if_any_failures}
**Issues to Address:**
{list of failed gates with specific gaps}

Would you like to address these before finalizing?
{/if_any_failures}

{if_all_pass}
All quality gates passed. The security plan is comprehensive and ready for implementation.
{/if_all_pass}"

### 6. Address Validation Issues

If any quality gates failed:

- Present the specific gaps clearly
- Collaborate with the user to resolve each gap
- Update the relevant document sections
- Re-run the failed quality gates to confirm resolution

### 7. Generate Implementation Backlog

Create a prioritized list of implementation tasks:

**Priority 1 — Foundation (implement first):**
- Enable encryption at rest and in transit for all data stores
- Deploy centralized secret management (vault)
- Implement MFA for all human users
- Configure WAF and DDoS protection for public endpoints
- Integrate secret scanning in pre-commit hooks and CI pipeline
- Set up security event logging and centralized collection

**Priority 2 — Core Controls (implement second):**
- Implement zero-trust network segmentation and microsegmentation
- Deploy RBAC/ABAC with least privilege role definitions
- Configure API authentication, authorization, and rate limiting
- Integrate SAST and SCA in CI pipeline
- Set up container image scanning and signing

**Priority 3 — Advanced Protection (implement third):**
- Deploy service mesh with mTLS for internal communication
- Implement field-level encryption for Restricted data
- Configure SIEM with correlation rules and automated response
- Generate SBOM for all releases with provenance attestation
- Integrate DAST scanning in staging environment

**Priority 4 — Maturity (implement ongoing):**
- Establish penetration testing cadence (annual + event-driven)
- Launch bug bounty program
- Implement adaptive access controls (risk-based MFA, anomaly detection)
- Conduct red team exercises
- Establish security metrics and quarterly security reviews

### 8. Generate Validation Content

Prepare the content to replace the existing placeholder sections 7 through 12 in the document:

#### Content Structure:

```markdown
## 7. Supply Chain Security

### 7.1 Dependency Management

{{dependency_scanning_and_update_policies}}

### 7.2 Software Bill of Materials (SBOM)

{{sbom_generation_format_and_workflow}}

### 7.3 Container Security

{{container_image_policy_scanning_signing}}

### 7.4 CI/CD Pipeline Security

{{pipeline_hardening_and_attestation}}

## 8. Security Testing Strategy

### 8.1 SAST Integration

{{sast_tool_and_ci_integration}}

### 8.2 DAST Integration

{{dast_tool_and_scanning_schedule}}

### 8.3 Software Composition Analysis

{{sca_monitoring_and_remediation_slas}}

### 8.4 Penetration Testing Schedule

| Test Type | Frequency | Scope | Provider | Notes |
|-----------|-----------|-------|----------|-------|
{{pentest_schedule_entries}}

## 9. Incident Response Integration

### 9.1 Security Event Classification

| Severity | Description | Examples | Response Time |
|----------|-------------|----------|---------------|
{{security_event_classification_entries}}

### 9.2 SIEM/SOAR Integration

{{siem_sources_correlation_rules_playbooks}}

## Validation Results

### Quality Gates

| Gate | Status | Notes |
|------|--------|-------|
{{quality_gate_results}}

### Security Completeness Checklist

**Threat Model**

- [ ] STRIDE analysis for all components and trust boundaries
- [ ] Risk scoring with likelihood and impact
- [ ] Attack trees for critical paths

**Security Controls**

- [ ] Zero-trust architecture with microsegmentation
- [ ] Network security with WAF, DDoS, and egress controls
- [ ] Application security addressing OWASP Top 10
- [ ] API security with authentication, rate limiting, and validation

**Identity & Access Management**

- [ ] RBAC/ABAC model with least privilege
- [ ] MFA for all human users
- [ ] Service account governance with rotation

**Secrets & Encryption**

- [ ] Centralized vault with automated rotation
- [ ] Secret scanning in pre-commit and CI
- [ ] Encryption at rest and in transit
- [ ] Key management lifecycle defined

**Data Protection**

- [ ] Data classification with handling requirements
- [ ] Field-level encryption for Restricted data
- [ ] DLP strategy with monitoring

**Supply Chain & Testing**

- [ ] Dependency scanning and SBOM generation
- [ ] Container security with image signing
- [ ] SAST, DAST, SCA integrated
- [ ] Penetration testing schedule established

## 10. Cost Estimation

| Component | Tool/Service | Tier | Monthly Cost (Est.) | Annual Cost (Est.) | Notes |
|-----------|-------------|------|---------------------|--------------------|-------|
{{cost_estimation_entries}}

### 10.1 Cost Breakdown by Category

- **Secret management (vault)**:
- **WAF & DDoS protection**:
- **SIEM / SOAR platform**:
- **SAST / DAST / SCA tooling**:
- **Container scanning & signing**:
- **Identity provider / MFA**:
- **Key management (KMS/HSM)**:
- **Penetration testing**:
- **Total estimated monthly cost**:
- **Cost per service / per environment**:

### 10.2 Cost Optimization Strategies

- Consolidate security tooling where possible (platform vs point solutions):
- Leverage cloud-native security features (included in cloud spend):
- Risk-based investment (spend more on Critical/High threat areas):

## 11. Decision Rationale

### 11.1 Tool Selection Rationale

| Category | Chosen Tool | Alternatives Evaluated | Key Deciding Factors |
|----------|-------------|----------------------|---------------------|
{{tool_selection_entries}}

### 11.2 Architecture Decision Records

- **Identity provider**: Why {chosen} over {alternative}?
- **Secret management**: Why {chosen} over {alternative}?
- **SIEM platform**: Why {chosen} over {alternative}?
- **Container registry**: Why {chosen} over {alternative}?

### 11.3 Trade-Off Summary

| Decision | Benefit Gained | Trade-Off Accepted |
|----------|---------------|-------------------|
{{tradeoff_entries}}

## 12. Implementation Roadmap

| Milestone | Description | Owner | Target Date |
|-----------|-------------|-------|-------------|
{{implementation_backlog_entries}}

### Priority 1: Foundation

{{foundation_tasks}}

### Priority 2: Core Controls

{{core_controls_tasks}}

### Priority 3: Advanced Protection

{{advanced_protection_tasks}}

### Priority 4: Maturity

{{maturity_tasks}}
```

### 9. Present Content and Menu

Show the generated content and present choices:

"I've completed the validation, supply chain security, security testing, and implementation roadmap.

**Here's what I'll add to finalize the security plan:**

[Show the complete markdown content from step 8]

**What would you like to do?**
[C] Continue - Save and finalize the security plan
[R] Revise - Let's address issues before finalizing"

### 11. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-run relevant quality gates
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Replace the existing placeholder sections 7 through 12 in `{bgr_artifacts}/security-plan.md` with the final content
- Update frontmatter:
  - `stepsCompleted: [1, 2, 3, 4, 5]`
  - `status: complete`
  - `lastUpdated: {{current_date}}`
- Present completion summary and next steps

### 12. Completion Summary

After saving, present the final summary:

"The Security Plan for {{project_name}} is complete and saved to `{bgr_artifacts}/security-plan.md`.

**Summary:**
- {N} threats identified with STRIDE analysis across {N} components
- {N} security controls mapped to identified threats
- IAM strategy with {RBAC/ABAC} and MFA for all users
- Secret management with automated rotation for {N} secret types
- Data classification with encryption at rest and in transit
- Supply chain security with SBOM, container signing, and pipeline hardening
- Security testing strategy with SAST, DAST, SCA, and pentest schedule
- Prioritized implementation roadmap with {N} milestones

**Recommended Next Steps:**
- **Create Incident Response Plan** — Define detailed runbooks, war room procedures, and postmortem processes
- **Run Infrastructure Workflow** — If not already done, define the infrastructure that implements these security controls
- **Return to agent menu** — Explore other capabilities

Thank you for collaborating on this, {{user_name}}. Your system will be well-defended."

## UPDATE DOCUMENT:

When user selects 'C', replace the existing placeholder sections 7 through 12 in the document with the content from step 8.

## SUCCESS METRICS:

✅ Supply chain security fully defined (dependencies, SBOM, containers, CI/CD)
✅ Security testing strategy covers SAST, DAST, SCA, and pentesting
✅ Incident response integration with event classification and SIEM
✅ All quality gates evaluated systematically
✅ Any failures identified and addressed with user
✅ Implementation backlog generated with clear priorities
✅ Cost estimation and decision rationale sections populated
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
❌ Missing supply chain security coverage
❌ Not including cost estimation and decision rationale

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols
