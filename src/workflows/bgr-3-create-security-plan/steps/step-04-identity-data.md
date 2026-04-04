# Step 4: Identity Management & Data Protection

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between security peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on defining IAM strategy, secret management, and data protection
- 🎯 BUILD on the security controls from step 3
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating identity and data protection content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the strategy, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with Threat Model and Security Controls is available
- Zero-trust architecture and API authentication decisions are established
- Focus on identity governance, secrets lifecycle, data classification, and encryption
- This step makes identity and data protection operational

## YOUR TASK:

Define comprehensive IAM strategy with RBAC/ABAC, secret management with vault and rotation, data classification with encryption standards, and key management lifecycle.

## IDENTITY & DATA PROTECTION SEQUENCE:

### 1. Define IAM Strategy

Work with the user to establish identity and access management:

**Least Privilege Principle:**
- Default deny: No access unless explicitly granted
- Just-in-time (JIT) access for elevated privileges
- Just-enough-access (JEA) scoped to specific resources
- Regular access reviews and automated revocation
- Break-glass procedures for emergency access

**RBAC/ABAC Design:**

Collaborate to define the access control model:

**Role-Based Access Control (RBAC):**
- Define standard roles aligned with job functions
- Role hierarchy with inheritance where appropriate
- Separation of duties for critical operations
- Role assignment lifecycle (onboarding, transfer, offboarding)

| Role | Description | Permissions | Scope | Assignment |
|------|-------------|-------------|-------|------------|
| | | | | |

**Attribute-Based Access Control (ABAC):**
- When ABAC supplements RBAC (dynamic, context-aware decisions)
- Attributes: user department, resource classification, time of day, location, device posture
- Policy examples for complex access scenarios
- ABAC engine integration points

**RBAC vs ABAC Decision Matrix:**

| Scenario | Model | Rationale |
|----------|-------|-----------|
| Standard user access to application features | RBAC | Well-defined roles, predictable access patterns |
| Cross-team resource sharing | ABAC | Dynamic based on project assignment and classification |
| Administrative access to production | RBAC + ABAC | Role required + time-bound + approval workflow |
| API access for external partners | ABAC | Scope varies by partner agreement and data classification |

**Multi-Factor Authentication (MFA) Policy:**
- MFA required for all human users (no exceptions)
- MFA methods: Hardware keys (FIDO2/WebAuthn preferred), authenticator apps, push notifications
- SMS/email as backup only (not primary MFA)
- Step-up authentication for sensitive operations (password changes, payment, admin actions)
- MFA for VPN, SSH, and console access
- Conditional access: Risk-based MFA challenges (new device, unusual location, impossible travel)

### 2. Define Service Account Governance

**Service Account Principles:**
- Unique identity per service (no shared service accounts)
- Workload identity federation where possible (no long-lived credentials)
- Service account inventory with owner and purpose documented
- Automated credential rotation
- Monitoring for anomalous service account behavior

**Service Account Matrix:**

| Service | Account Type | Authentication | Scope | Rotation | Owner |
|---------|-------------|---------------|-------|----------|-------|
| | | | | | |

**Machine-to-Machine Authentication:**
- mTLS with workload identity (SPIFFE/SPIRE) for internal services
- OAuth 2.0 Client Credentials flow for API-to-API
- Cloud provider instance identity (IAM roles, managed identity) for cloud services
- Short-lived tokens over long-lived credentials

### 3. Define Secret Management Strategy

Collaborate on secrets lifecycle:

**Vault Strategy:**
- Central secret store (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault, etc.)
- Dynamic secrets where supported (database credentials, cloud tokens)
- Secret versioning with rollback capability
- High availability and disaster recovery for the vault itself
- Access audit logging for all secret operations

**Secret Types and Policies:**

| Secret Type | Storage | Rotation Period | Auto-Rotate | Access Pattern |
|-------------|---------|----------------|-------------|----------------|
| Database credentials | Vault (dynamic) | On-demand | Yes | Service identity |
| API keys (internal) | Vault | 90 days | Yes | Service identity |
| API keys (external) | Vault | Per partner policy | Manual | Designated service |
| TLS certificates | Cert manager | 90 days | Yes | Automated |
| Encryption keys | KMS | Annual | Yes | Service identity |
| SSH keys | Vault (signed) | Per-session | Yes | User identity + MFA |

**Rotation Policy:**
- Automated rotation for all machine credentials
- Zero-downtime rotation using dual-credential patterns
- Rotation verification (confirm new credential works before revoking old)
- Emergency rotation procedures for compromised credentials

**Secret Scanning Integration:**
- Pre-commit hooks to prevent secret commits (git-secrets, detect-secrets)
- CI pipeline scanning for secrets in code and configuration
- Repository scanning for historical secret exposure
- Alerting and automated revocation for detected leaks
- Developer education on secret handling best practices

### 4. Define Data Classification and Encryption

Collaborate on data protection standards:

**Data Classification Matrix:**

| Classification | Description | Examples | Handling Requirements |
|---------------|-------------|----------|----------------------|
| **Public** | No impact if disclosed | Marketing content, public docs | No restrictions |
| **Internal** | Low impact if disclosed | Internal processes, non-sensitive configs | Access control, no public sharing |
| **Confidential** | Moderate impact if disclosed | Business data, employee info, system configs | Encryption at rest and in transit, access logging |
| **Restricted** | Severe impact if disclosed | PII, financial data, credentials, health data | Encryption, access logging, DLP, retention limits |

**Encryption at Rest:**
- All data stores encrypted by default (databases, object storage, volumes)
- Encryption algorithm: AES-256-GCM minimum
- Customer-managed keys (CMK) for Restricted data
- Provider-managed keys acceptable for Internal/Confidential
- Field-level encryption for highly sensitive attributes (SSN, payment data)

**Encryption in Transit:**
- TLS 1.2 minimum, TLS 1.3 preferred for all external communication
- mTLS for service-to-service communication within the trust boundary
- Certificate pinning for mobile clients (with rotation strategy)
- HSTS enforcement with preload for all web endpoints
- Database connections encrypted (require SSL/TLS)

**Key Management Lifecycle:**

| Phase | Process | Responsible | Frequency |
|-------|---------|-------------|-----------|
| Generation | KMS or HSM with sufficient entropy | Security team | As needed |
| Distribution | Encrypted channels only, never plaintext | Automated (Vault/KMS) | On rotation |
| Storage | Hardware-backed (HSM) for master keys | Cloud KMS / HSM | Ongoing |
| Rotation | Automated with zero-downtime | Automated | Per policy |
| Revocation | Immediate on compromise, CRL/OCSP | Security team | On incident |
| Destruction | Cryptographic erasure, audit trail | Security team | Per retention |

**Data Loss Prevention (DLP):**
- Classify data at creation/ingestion
- Monitor for Restricted data in unauthorized locations
- Block unauthorized export of Restricted data
- Alert on data classification violations
- Regular DLP rule review and tuning

### 5. Supply Chain Security Preview

Briefly introduce supply chain security (detailed in step 5 validation):

**Dependency Management:**
- Software Bill of Materials (SBOM) generation for all deployments
- Dependency vulnerability scanning in CI/CD
- Container image scanning and signing
- CI/CD pipeline security and attestation

Note: Supply chain security details will be covered in the validation step.

### 6. Present Identity & Data Protection Strategy

Reflect the strategy back to the user:

"Here's the Identity & Data Protection strategy I've drafted for {{project_name}}.

**IAM Strategy:**
- Access model: {RBAC/ABAC/hybrid}
- Roles defined: {count}
- MFA: Required for all humans, {methods}
- Service accounts: {count} with {authentication approach}

**Secret Management:**
- Vault: {chosen solution}
- Rotation: Automated for {count} secret types
- Scanning: Pre-commit + CI pipeline + repo scanning

**Data Protection:**
- Classifications: 4 levels (Public, Internal, Confidential, Restricted)
- Encryption at rest: AES-256-GCM with {key management approach}
- Encryption in transit: TLS 1.2+ with mTLS for internal
- Key management: {KMS/HSM approach}

Does this strategy cover your identity and data protection needs? Anything to adjust?"

### 7. Generate Identity & Data Protection Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 4. Identity & Access Management

### 4.1 IAM Strategy

{{least_privilege_and_access_review_policies}}

### 4.2 RBAC/ABAC Matrix

| Role | Description | Permissions | Scope | Assignment |
|------|-------------|-------------|-------|------------|
{{role_definitions}}

### 4.3 MFA Policy

{{mfa_requirements_and_methods}}

### 4.4 Service Account Governance

| Service | Account Type | Authentication | Scope | Rotation | Owner |
|---------|-------------|---------------|-------|----------|-------|
{{service_account_entries}}

## 5. Secret Management

### 5.1 Vault Strategy

{{vault_architecture_and_ha_design}}

### 5.2 Rotation Policy

| Secret Type | Storage | Rotation Period | Auto-Rotate | Access Pattern |
|-------------|---------|----------------|-------------|----------------|
{{secret_rotation_entries}}

### 5.3 Secret Scanning Integration

{{scanning_tools_and_workflow_integration}}

## 6. Data Protection

### 6.1 Data Classification Matrix

| Classification | Description | Examples | Handling Requirements |
|---------------|-------------|----------|----------------------|
{{classification_entries}}

### 6.2 Encryption Standards

- **At Rest**: {{encryption_at_rest_approach}}
- **In Transit**: {{encryption_in_transit_approach}}
- **Field-Level**: {{field_level_encryption_for_sensitive_data}}

### 6.3 Key Management Lifecycle

| Phase | Process | Responsible | Frequency |
|-------|---------|-------------|-----------|
{{key_management_entries}}

### 6.4 Data Loss Prevention

{{dlp_strategy_and_rules}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Identity & Data Protection strategy covering IAM, secret management, data classification, encryption, and key management.

**Here's what I'll add to the security plan:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this strategy and proceed to validation & finalization
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/security-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4]`
- Load `./step-05-validation.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 7.

## SUCCESS METRICS:

✅ IAM strategy defined with least privilege, JIT/JEA, and access review cadence
✅ RBAC/ABAC model designed with clear role definitions and decision matrix
✅ MFA policy covers all human users with appropriate methods
✅ Service account governance with unique identities and rotation
✅ Secret management strategy with vault, rotation, and scanning
✅ Data classification matrix with handling requirements per level
✅ Encryption standards defined for at-rest, in-transit, and field-level
✅ Key management lifecycle covers generation through destruction
✅ User confirmation of identity and data protection strategy
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Defining roles without least privilege analysis
❌ Missing MFA for administrative or privileged access
❌ Not addressing service account governance (shared accounts)
❌ Secret management without rotation automation
❌ Data classification without handling requirements
❌ Encryption strategy without key management lifecycle
❌ Not validating strategy with user

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-05-validation.md` to validate completeness, cover supply chain security, and finalize the security plan.

Remember: Do NOT proceed to step-05 until user explicitly selects 'C' from the C/R menu and content is saved!
