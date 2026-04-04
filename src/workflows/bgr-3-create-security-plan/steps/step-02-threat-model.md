# Step 2: Threat Modeling

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between security peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on identifying threats through structured STRIDE analysis
- 🎯 ANALYZE loaded documents, don't assume or generate requirements
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating threat model content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the threat model, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document and frontmatter from step 1 are available
- Input documents already loaded are in memory (architecture, infrastructure, PRD, etc.)
- Focus on identifying assets, trust boundaries, data flows, and threats
- No control design yet - pure threat identification phase

## YOUR TASK:

Build a comprehensive threat model by analyzing the system architecture to identify assets, trust boundaries, data flows, and apply STRIDE analysis to uncover threats across all components.

## THREAT MODELING SEQUENCE:

### 1. Identify Assets and Trust Boundaries

Work with the user to map what needs protection:

**Critical Assets:**

For each component identified in the architecture, classify:
- **Data assets**: User data, credentials, business data, configuration secrets, encryption keys
- **Service assets**: APIs, microservices, databases, message queues, caches
- **Infrastructure assets**: Compute instances, networks, DNS, load balancers, CDN
- **Identity assets**: User accounts, service accounts, API keys, certificates

**Trust Boundaries:**

Identify where trust levels change:
- External internet to public-facing services (DMZ boundary)
- Public-facing services to internal services (application boundary)
- Application tier to data tier (data boundary)
- Service-to-service communication (microservice boundaries)
- Cloud account boundaries and VPC boundaries
- Third-party integrations and external API boundaries
- CI/CD pipeline trust boundaries (build vs deploy vs runtime)

### 2. Map Data Flows

For each critical data path through the system:

**Data Flow Inventory:**
- Source: Where does the data originate?
- Transport: How does it move? (HTTPS, gRPC, message queue, internal network)
- Processing: What services touch it and what transformations occur?
- Storage: Where does it persist? (database, cache, object storage, logs)
- Destination: Where does it ultimately go? (user, external API, analytics)

**Sensitive Data Flows:**
- Authentication flows (credential submission, token issuance, session management)
- Payment or financial data flows
- PII data flows (collection, processing, storage, deletion)
- Administrative or privileged operation flows
- Secret distribution flows (how do services get their credentials?)

Present data flow analysis to the user:

"Here's my analysis of the data flows for {{project_name}} based on the architecture.

**Data Flow Summary:**
{N} critical data flows identified across {N} trust boundaries

**Sensitive Flows Requiring Extra Protection:**
{list of sensitive data flows with trust boundary crossings}

Does this capture the key flows? Any I've missed?"

### 3. STRIDE Analysis per Component

For each major component and trust boundary crossing, apply STRIDE:

**STRIDE Categories:**

| Threat | Description | Question to Ask |
|--------|-------------|-----------------|
| **S**poofing | Impersonating something or someone | Can an attacker pretend to be this component or user? |
| **T**ampering | Modifying data or code | Can an attacker modify data in transit or at rest? |
| **R**epudiation | Claiming to have not performed an action | Can a user deny performing a critical action? |
| **I**nformation Disclosure | Exposing information to unauthorized parties | Can an attacker access data they shouldn't see? |
| **D**enial of Service | Denying or degrading service to users | Can an attacker make this component unavailable? |
| **E**levation of Privilege | Gaining capabilities without authorization | Can an attacker gain higher permissions than intended? |

**Analysis Approach:**

For each component or trust boundary:
1. Walk through each STRIDE category
2. Identify specific threat scenarios
3. Note the attack vector and preconditions
4. Assess the potential impact

### 4. Build Attack Trees for Critical Paths

For the top 3-5 most critical assets or flows, build attack trees:

**Attack Tree Structure:**
- **Root goal**: What the attacker wants to achieve
- **Sub-goals**: Steps needed to reach the root goal (AND/OR decomposition)
- **Leaf nodes**: Specific attack techniques
- **Annotations**: Difficulty, cost, detectability for each leaf

**Example Critical Paths to Analyze:**
- Unauthorized access to user data
- Privilege escalation to admin
- Service disruption of critical user journeys
- Supply chain compromise through dependencies
- Data exfiltration through side channels

### 5. Risk Scoring

For each identified threat, calculate risk:

**Risk Score = Likelihood x Impact**

**Likelihood Factors (1-5):**
- Attack complexity (how hard is it to exploit?)
- Attacker skill required (script kiddie vs nation-state?)
- Access required (network, local, physical?)
- Existing controls (what's already in place?)

**Impact Factors (1-5):**
- Confidentiality impact (data exposure scope)
- Integrity impact (data corruption scope)
- Availability impact (service disruption scope)
- Business impact (financial, reputational, regulatory)

**Risk Matrix:**

| | Impact: 1 (Minimal) | Impact: 2 (Low) | Impact: 3 (Moderate) | Impact: 4 (High) | Impact: 5 (Critical) |
|---|---|---|---|---|---|
| **Likelihood: 5 (Almost Certain)** | Medium | Medium | High | Critical | Critical |
| **Likelihood: 4 (Likely)** | Low | Medium | Medium | High | Critical |
| **Likelihood: 3 (Possible)** | Low | Low | Medium | High | High |
| **Likelihood: 2 (Unlikely)** | Low | Low | Low | Medium | Medium |
| **Likelihood: 1 (Rare)** | Low | Low | Low | Low | Medium |

### 6. Present Threat Model

Reflect the threat model back to the user:

"Here's the Threat Model I've drafted for {{project_name}}.

**Assets Identified:**
- Data assets: {count}
- Service assets: {count}
- Infrastructure assets: {count}
- Identity assets: {count}

**Trust Boundaries:**
- {N} trust boundaries mapped across the architecture

**STRIDE Analysis Results:**
- Total threats identified: {count}
- Critical risk: {count}
- High risk: {count}
- Medium risk: {count}
- Low risk: {count}

**Top Threats:**
{top 5 threats by risk score with brief description}

Does this threat model capture your concerns? Anything I missed or got wrong?"

### 7. Generate Threat Model Content

Prepare the content to replace the existing placeholder section 2 in the document:

#### Content Structure:

```markdown
## 2. Threat Model

### 2.1 Asset Inventory

| Asset Type | Asset | Classification | Owner | Notes |
|------------|-------|---------------|-------|-------|
{{asset_inventory_entries}}

### 2.2 Trust Boundaries

{{trust_boundary_descriptions_with_components_on_each_side}}

### 2.3 Data Flow Analysis

| Flow | Source | Transport | Processing | Storage | Sensitivity | Notes |
|------|--------|-----------|------------|---------|-------------|-------|
{{data_flow_entries}}

### 2.4 STRIDE Analysis

| Component / Boundary | Threat Type | Threat Description | Attack Vector | Risk Score | Priority |
|---------------------|-------------|-------------------|---------------|------------|----------|
{{stride_analysis_entries}}

### 2.5 Risk Matrix

| Threat ID | Threat | Likelihood (1-5) | Impact (1-5) | Risk Score | Risk Level | Mitigation Priority |
|-----------|--------|-------------------|--------------|------------|------------|-------------------|
{{risk_scoring_entries}}

### 2.6 Attack Trees (Critical Paths)

{{attack_tree_descriptions_for_top_critical_paths}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Threat Model covering assets, trust boundaries, data flows, STRIDE analysis, and risk scoring.

**Here's what I'll add to the security plan:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this threat model and proceed to security controls design
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Replace the existing placeholder section 2 in `{bgr_artifacts}/security-plan.md` with the final content
- Update frontmatter: `stepsCompleted: [1, 2]`
- Load `./step-03-security-controls.md`

## UPDATE DOCUMENT:

When user selects 'C', replace the existing placeholder section 2 in the document with the content from step 7.

## SUCCESS METRICS:

✅ All critical assets identified and classified across data, service, infrastructure, and identity
✅ Trust boundaries mapped with clear component delineation
✅ Data flows documented with sensitivity classification
✅ STRIDE analysis applied to every major component and trust boundary crossing
✅ Attack trees built for top critical paths
✅ Risk scores calculated with likelihood and impact factors
✅ User confirmation of threat model completeness
✅ C/R menu presented and handled correctly
✅ Content properly replaces placeholder section in document when C selected

## FAILURE MODES:

❌ Generating threat model without analyzing architecture documents
❌ Missing trust boundaries between internal components
❌ Skipping STRIDE categories or applying them superficially
❌ Not building attack trees for critical paths
❌ Risk scoring without discussing likelihood and impact with user
❌ Not validating threat model completeness with user
❌ Not presenting C/R menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-03-security-controls.md` to design security controls and zero-trust architecture.

Remember: Do NOT proceed to step-03 until user explicitly selects 'C' from the C/R menu and content is saved!
