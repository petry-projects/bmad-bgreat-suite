# Step 3: Failure Scenario Design

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on failure modes and experiment designs that match the user's infrastructure and risk tolerance
- 🎯 BUILD on steady-state definitions from step 2 to design targeted, bounded experiments
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present [C]ontinue / [R]evise menu after generating failure scenario content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## CONTEXT BOUNDARIES:

- Steady-state hypotheses and critical services from step 2 are in the document
- Input documents and infrastructure context are available from earlier steps
- Focus on what to break, expected impact, and how to control blast radius
- Adapt to infrastructure layer — cloud vs. on-prem, containers vs. VMs differ significantly

## YOUR TASK:

Collaboratively identify failure modes across each infrastructure layer, map them to risk and learning value, design concrete experiments with blast radius controls, and build a prioritized failure catalog.

## FAILURE SCENARIO DESIGN SEQUENCE:

### 1. Identify Failure Modes by Infrastructure Layer

Walk through each infrastructure layer and identify realistic failure modes. Adapt based on the infrastructure plan if available.

**Compute Layer:**
- Process crash / OOM kill
- CPU starvation / throttling
- Container / pod eviction (Kubernetes)
- VM or instance termination
- Node failure (partial cluster failure)
- Resource exhaustion (disk full, file descriptors)

**Network Layer:**
- Latency injection (added delay between services)
- Packet loss / corruption
- Network partition (split-brain)
- DNS resolution failure
- Load balancer health check failure
- Firewall rule change blocking traffic

**Storage Layer:**
- Disk I/O latency injection
- Volume unavailability
- Database connection pool exhaustion
- Slow query injection
- Read replica lag / promotion failure
- Object storage throttling

**Dependencies Layer:**
- Third-party API unavailability (payment gateway, auth provider, email service)
- Internal service unavailability (auth, notification, reporting)
- Message queue consumer failure
- Cache eviction / Redis unavailability
- CDN failure or misconfiguration
- Secret store unavailability

Ask the user:
"Let's map out the failure modes that are most realistic for your infrastructure.

**Key questions:**
- What infrastructure are you running? (Kubernetes, VMs, serverless, managed services?)
- Which third-party dependencies are most critical to your user journeys?
- Have you experienced production incidents that revealed unexpected failure modes? What broke that surprised you?
- Are there known weak points in your architecture that you've been meaning to test?"

### 2. Map Failure Modes to STRIDE Threat Categories (If Security Plan Exists)

If a security plan was loaded in step 1, cross-reference failure modes with STRIDE threat categories:

| STRIDE Category | Relevant Failure Modes |
|----------------|----------------------|
| **Spoofing** | Auth service failure, identity provider outage |
| **Tampering** | Data corruption injection, storage integrity failure |
| **Repudiation** | Audit log unavailability, event stream failure |
| **Information Disclosure** | Secret store failure, encryption key unavailability |
| **Denial of Service** | Resource exhaustion, traffic flood, dependency saturation |
| **Elevation of Privilege** | RBAC service failure, authorization cache corruption |

Surface the mapping to the user:
"Your security plan identified {STRIDE_threats} as key risk areas. These map to the following failure modes we should consider testing: {mapped_failure_modes}."

If no security plan exists, skip this section and note it as an optional future enhancement.

### 3. Design Experiments

For each prioritized failure mode, design a concrete experiment. Use this structure:

**Experiment Design Template:**

```
Experiment ID: EXP-{number}
Name: {descriptive experiment name}
Failure Mode: {what we are injecting}
Target: {specific service, component, or layer}
Hypothesis: "If {failure is injected}, the system will {expected behavior} and steady state for {impacted services} will {be maintained / degrade within acceptable bounds / recover within X minutes}"
Blast Radius Controls:
  - Scope: {percentage of traffic, number of instances, specific environment}
  - Duration: {maximum experiment duration, e.g., 10 minutes}
  - Abort Criteria: {conditions that trigger immediate abort}
  - Rollback: {how to restore normal operation if needed}
Injection Method: {tool or technique, e.g., kill -9, tc netem, Chaos Monkey, Gremlin, Litmus}
Environment: {staging / canary / production}
Observability: {which dashboards, alerts, or queries to monitor}
Success Criteria: {how we know the experiment confirmed or falsified the hypothesis}
Learning Goal: {what we want to learn from this experiment}
Risk Level: {low / medium / high}
```

Walk through the design with the user for each experiment:
"For the {failure_mode} experiment targeting {service}:
- What is the hypothesis — what do you expect the system to do?
- What blast radius controls should we apply? (percentage of traffic, environment scope)
- What are the abort criteria — at what point do we stop immediately?
- What observability do we have to monitor during this experiment?
- Should this start in staging or go directly to production?"

### 4. Prioritize Failure Scenarios

Collaboratively prioritize experiments by two dimensions:

**Risk** — What is the probability and severity of this failure in production?
- High: Failure has happened before OR is highly likely given architecture
- Medium: Plausible failure mode that hasn't been observed
- Low: Edge case failure that would be novel

**Learning Value** — What would we learn from running this experiment?
- High: Tests an untested assumption or has never been validated
- Medium: Validates a known resilience pattern
- Low: Confirms existing behavior that is well understood

Propose a prioritized experiment catalog:

| Priority | Experiment ID | Name | Risk | Learning Value | Environment | Prerequisites |
|----------|--------------|------|------|----------------|-------------|---------------|
| 1 | EXP-001 | {{name}} | High | High | Staging | Steady state verified |
| 2 | EXP-002 | {{name}} | High | Medium | Production (canary) | EXP-001 passed |
| ... | | | | | | |

Ask the user:
"Here's my proposed prioritization. A few questions:
- Are there any experiments that should never run in production regardless of staging results?
- Are there experiments that are urgent to run because of known risks?
- Are there resource or tooling constraints that affect which experiments are feasible right now?"

### 5. Generate Failure Scenario Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 3. Failure Catalog

### 3.1 Failure Mode Inventory

#### Compute Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|
| {{failure_mode}} | {{services}} | {{probability}} | {{severity}} | {{notes}} |

#### Network Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

#### Storage Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

#### Dependencies Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

### 3.2 STRIDE Mapping (if security plan available)

{{stride_mapping_table_or_not_applicable}}

### 3.3 Experiment Designs

#### EXP-001: {{experiment_name}}

{{experiment_design_block_per_template_above}}

[Repeat for each experiment]

### 3.4 Prioritized Experiment Catalog

| Priority | Experiment | Risk | Learning Value | Environment | Prerequisites |
|----------|-----------|------|----------------|-------------|---------------|
| {{rows}} | | | | | |
```

### 6. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Failure Scenario Catalog based on our discussion.

**Here's what I'll add to the document:**

[Show the complete markdown content from step 5]

**What would you like to do?**
[C] Continue - Save this and proceed to game day planning
[R] Revise - Let's adjust failure modes, experiment designs, or prioritization"

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask what specific areas need adjustment
- Collaborate on revisions
- Present updated content
- Return to [C]/[R] menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/resilience-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3]`
- Load `./step-04-game-day.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 5.

## SUCCESS METRICS:

✅ Failure modes identified across all relevant infrastructure layers
✅ STRIDE mapping surfaced when security plan is available
✅ Each experiment has a clear hypothesis, blast radius controls, and abort criteria
✅ Experiments prioritized by risk and learning value
✅ Environment strategy defined (staging vs. production) per experiment
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Designing experiments without blast radius controls
❌ Missing abort criteria — experiments that can't be stopped
❌ Failure modes not grounded in the actual infrastructure
❌ Not asking about off-limits services identified in step 2
❌ Prioritizing by arbitrary order rather than risk × learning value
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-04-game-day.md` to plan game day exercises and establish the experiment cadence.

Remember: Do NOT proceed to step-04 until user explicitly selects 'C' from the menu and content is saved!
