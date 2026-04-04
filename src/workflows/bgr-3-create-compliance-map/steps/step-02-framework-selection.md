# Step 2: Regulatory Framework Selection & Scoping

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between compliance peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on identifying applicable frameworks and scoping compliance boundaries
- 🎯 ANALYZE loaded documents, don't assume or generate requirements
- ⚠️ Do not estimate task durations or LOE — but do help the user set target dates and milestone timelines for planning purposes
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating framework selection content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the framework selection, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document and frontmatter from step 1 are available
- Input documents already loaded are in memory (architecture, security plan, infrastructure, PRD, etc.)
- Focus on identifying which frameworks apply and defining the compliance scope
- No control mapping yet - pure framework identification and scoping phase

## YOUR TASK:

Guide the user through identifying applicable regulatory frameworks, determining compliance scope, mapping business context to compliance obligations, and prioritizing frameworks by risk and timeline.

## FRAMEWORK SELECTION SEQUENCE:

### 1. Analyze Business Context for Regulatory Triggers

**From Architecture Document:**

- Identify data types processed (PII, PHI, cardholder data, financial records)
- Note geographic regions where data is stored or processed
- Extract authentication and authorization architecture
- Identify third-party integrations that may introduce compliance obligations
- Note encryption and data-at-rest/in-transit decisions

**From PRD (if available):**

- Extract target markets and user populations (EU citizens = GDPR, healthcare = HIPAA)
- Identify payment processing requirements (PCI-DSS triggers)
- Note any contractual compliance commitments mentioned
- Identify data retention requirements from business rules

**From Infrastructure Document (if available):**

- Identify cloud providers and regions (data residency implications)
- Note multi-tenancy architecture (isolation requirements)
- Extract backup and disaster recovery commitments
- Identify network segmentation and access control patterns

**From Security Plan (if available):**

- Identify existing compliance certifications or attestations
- Note security controls already in place
- Extract risk assessment findings
- Identify security policies and standards already adopted

### 2. Identify Applicable Frameworks

Work with the user to evaluate each major framework:

**SOC 2 (Type I / Type II):**
- Applicable if: Providing services to other businesses, handling customer data
- Trust Service Criteria: Security, Availability, Processing Integrity, Confidentiality, Privacy
- Scope trigger: B2B SaaS, cloud services, data processing services
- Assessment: Does this apply? Which trust criteria are relevant?

**HIPAA (Health Insurance Portability and Accountability Act):**
- Applicable if: Processing, storing, or transmitting Protected Health Information (PHI)
- Key rules: Privacy Rule, Security Rule, Breach Notification Rule
- Scope trigger: Healthcare providers, health plans, business associates
- Assessment: Does the system handle PHI? Is there a BAA requirement?

**PCI-DSS (Payment Card Industry Data Security Standard):**
- Applicable if: Processing, storing, or transmitting cardholder data
- SAQ levels: A, A-EP, D (based on processing method)
- Scope trigger: Payment processing, e-commerce, recurring billing
- Assessment: Does the system touch cardholder data? What SAQ level?

**GDPR (General Data Protection Regulation):**
- Applicable if: Processing personal data of EU/EEA residents
- Key principles: Lawfulness, purpose limitation, data minimization, accuracy, storage limitation
- Scope trigger: EU users, EU-based operations, monitoring EU residents
- Assessment: Does the system process EU personal data? Data controller or processor?

**NIST (Cybersecurity Framework / 800-53):**
- Applicable if: Federal contracts, critical infrastructure, voluntary adoption
- Framework tiers: Partial, Risk Informed, Repeatable, Adaptive
- Scope trigger: Government contracts, FedRAMP, critical infrastructure designation
- Assessment: Is NIST required or adopted voluntarily as a baseline?

**Other Frameworks to Consider:**
- ISO 27001/27002 — International information security management
- FedRAMP — Federal cloud service authorization
- CCPA/CPRA — California consumer privacy
- SOX — Financial reporting controls (if publicly traded)
- HITRUST — Healthcare information trust alliance

### 3. Determine Compliance Scope

For each applicable framework, define boundaries:

**System Scope:**
- Which services, databases, and infrastructure components are in scope?
- What are the system boundaries (network segments, cloud accounts)?
- Which third-party services and integrations are in scope?
- Are there components that can be explicitly excluded with justification?

**Data Classification Scope:**
- What data types are processed (PII, PHI, PAN, confidential, public)?
- Where does regulated data enter, flow through, and exit the system?
- What data retention periods apply per regulation?
- What data residency requirements exist?

**User Population Scope:**
- Which user populations trigger which frameworks?
- Are there geographic segmentation requirements?
- How are different user types (internal, external, admin) scoped?
- Are there specific consent management requirements?

### 4. Map Business Context to Compliance Obligations

Create a mapping of business activities to regulatory requirements:

**Regulatory Trigger Matrix:**

**Example only — replace with project-specific data:**

| Business Activity | Data Type | Geography | Framework(s) Triggered | Priority |
|-------------------|-----------|-----------|----------------------|----------|
| User registration | PII | Global | GDPR, SOC 2 | High |
| Payment processing | PAN/PII | Global | PCI-DSS, SOC 2 | Critical |
| Health data storage | PHI | US | HIPAA | Critical |
| Analytics tracking | PII | EU | GDPR | High |

### 5. Prioritize Frameworks

Work with the user to prioritize framework implementation:

**Prioritization Criteria:**
- **Legal risk**: What is the penalty exposure for non-compliance?
- **Business impact**: Which frameworks are required for sales/contracts?
- **Current readiness**: How far are we from compliance for each framework?
- **Timeline pressure**: Are there contractual or regulatory deadlines?
- **Shared controls**: Which frameworks share the most controls (efficiency gains)?

**Priority Matrix:**

**Example only — replace with project-specific data:**

| Framework | Legal Risk | Business Impact | Current Readiness | Timeline | Priority |
|-----------|-----------|----------------|------------------|----------|----------|
| SOC 2 | Medium | High | Low | Q2 | 1 |
| GDPR | High | High | Medium | Ongoing | 2 |
| PCI-DSS | High | Medium | Low | Q3 | 3 |

### 6. Present Framework Selection

Reflect the analysis back to the user:

"Here's my analysis of the regulatory landscape for {{project_name}}.

**Applicable Frameworks:**
{list of applicable frameworks with justification}

**Compliance Scope:**
- Systems in scope: {count and summary}
- Data types: {classification summary}
- User populations: {geographic/demographic summary}

**Regulatory Trigger Matrix:**
{summary table from step 4}

**Recommended Priority Order:**
{prioritized list with rationale}

Does this match your understanding? Any frameworks I missed or should be excluded?"

### 7. Generate Framework Selection Content

Prepare the content to replace the existing placeholder section 2 in the document:

#### Content Structure:

```markdown
## 2. Framework Selection & Scope

### Applicable Frameworks

| Framework | Applicability Justification | Scope | Priority | Target Timeline |
|-----------|---------------------------|-------|----------|----------------|
{{framework_table_entries}}

### Data Classification Scope

| Data Type | Classification | Frameworks Applicable | Storage Location | Retention |
|-----------|---------------|----------------------|-----------------|-----------|
{{data_classification_entries}}

### System Scope

| Component | In Scope | Frameworks | Data Types Handled | Notes |
|-----------|----------|------------|-------------------|-------|
{{system_scope_entries}}

### Regulatory Trigger Matrix

| Business Activity | Data Type | Geography | Framework(s) Triggered | Priority |
|-------------------|-----------|-----------|----------------------|----------|
{{trigger_matrix_entries}}

### Framework Prioritization

{{prioritization_rationale_and_matrix}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Framework Selection & Scoping based on your project documents.

**Here's what I'll add to the compliance map:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this selection and proceed to control inventory mapping
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Replace the existing placeholder section 2 in `{bgr_artifacts}/compliance-map.md` with the final content
- Update frontmatter: `stepsCompleted: [1, 2]`
- Load `./step-03-control-mapping.md`

## UPDATE DOCUMENT:

When user selects 'C', replace the placeholder content under section 2 (between `## 2.` and `## 3.`) with the collaboratively developed content.

## SUCCESS METRICS:

✅ All loaded documents thoroughly analyzed for regulatory triggers
✅ Applicable frameworks identified with clear justification
✅ Compliance scope defined per framework (systems, data, users)
✅ Regulatory trigger matrix maps business activities to frameworks
✅ Frameworks prioritized by risk, business impact, and timeline
✅ User confirmation of framework selection and scoping
✅ C/R menu presented and handled correctly
✅ Content properly replaces placeholder section in document when C selected

## FAILURE MODES:

❌ Skimming documents without thorough regulatory analysis
❌ Missing applicable frameworks based on data types or geography
❌ Not defining clear compliance scope boundaries
❌ Not validating framework selection with user
❌ Generating content without real analysis of loaded documents
❌ Not presenting C/R menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-03-control-mapping.md` to map existing controls to framework requirements.

Remember: Do NOT proceed to step-03 until user explicitly selects 'C' from the C/R menu and content is saved!
