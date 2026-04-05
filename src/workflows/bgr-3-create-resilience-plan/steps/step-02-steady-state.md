# Step 2: Steady-State Hypothesis Definition

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on defining measurable steady-state conditions per service — not on experiments yet
- 🎯 ANALYZE loaded observability plan and SLOs to ground steady-state in existing metrics
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present [C]ontinue / [R]evise menu after generating steady-state content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## CONTEXT BOUNDARIES:

- Current document and frontmatter from step 1 are available
- Input documents already loaded are in memory (architecture, observability, incident response, etc.)
- Focus on defining what "healthy" looks like — not what can break
- Use SLOs from observability plan as the primary source for steady-state definitions

## YOUR TASK:

Collaboratively define steady-state hypotheses for each critical service, identify critical user journeys and their failure boundaries, and document the baseline metrics that prove the system is healthy before any experiment begins.

## STEADY-STATE HYPOTHESIS SEQUENCE:

### 1. Identify Critical Services and User Journeys

Before defining steady-state, understand what matters most to the business:

Ask the user:
"Let's start by identifying what we're protecting. In chaos engineering, we only inject failures into systems where we've first proven a healthy baseline.

**Key questions:**
- What are the 3-5 most critical user journeys in your system? (e.g., user login, checkout flow, data processing pipeline)
- Which services back those user journeys?
- Are there any services that are absolutely off-limits for failure injection? (e.g., billing, auth, compliance systems)
- What does a 'business day going well' look like in terms of metrics?"

If an observability plan exists, surface its SLO definitions:
"Your observability plan defines SLOs for {services} — let's use these as the foundation for your steady-state hypotheses."

### 2. Define Steady-State Per Service

For each critical service identified, collaboratively define a steady-state hypothesis using this format:

**Steady-State Hypothesis Template:**

```
Service: {service_name}
Hypothesis: "{service_name} is operating normally when..."
  - Availability: {SLO availability target, e.g., ≥ 99.9% over 5 minutes}
  - Latency: {p50/p95/p99 thresholds, e.g., p99 < 500ms}
  - Error Rate: {acceptable error rate, e.g., < 0.1% of requests}
  - Throughput: {normal throughput range, e.g., 1,000–5,000 req/min}
  - Custom Metrics: {any service-specific health signals}
Measurement Window: {how long to observe before declaring steady state, e.g., 5 minutes}
Data Source: {where these metrics are measured, e.g., Prometheus, Datadog, CloudWatch}
```

For each service, propose steady-state values based on loaded SLOs or ask the user to define them:

"For {service_name}:
- What's the target availability you've committed to (or want to commit to)?
- What latency thresholds indicate healthy operation?
- What error rate is acceptable in steady state?
- Are there any custom metrics specific to this service (e.g., queue depth, cache hit rate, order throughput)?"

### 3. Define Critical User Journey Failure Boundaries

For each critical user journey, define the failure boundary — what failure modes would violate steady state:

**Failure Boundary Definition:**

- What partial failures are acceptable? (e.g., recommendation service can be degraded without violating checkout SLO)
- What failures are unacceptable even momentarily? (e.g., payment processing failures = immediate SLO violation)
- Which downstream dependencies, if failed, would cascade into this journey?

Present to user:
"For the {journey_name} user journey:
- Which failures are acceptable graceful degradation vs. hard SLO violations?
- Are there circuit breakers or fallback mechanisms already in place?
- How do your existing alerts cover failure detection on this journey?"

### 4. Define Baseline Metrics and Measurement Protocol

Define how steady state is verified before each experiment:

**Pre-Experiment Baseline Protocol:**
- Observation window before starting any experiment: {e.g., 10 minutes of normal metrics}
- Minimum sample size required to declare steady state established
- Tooling for baseline verification: {dashboard links, query examples}
- Who is responsible for verifying baseline before experiment starts

Discuss with user:
"Before any chaos experiment, we need to confirm the system is in a healthy baseline. Let's define:
- How long should we observe the system before declaring it healthy enough to proceed?
- What's your process for verifying no other changes are happening simultaneously?
- Who has authority to declare 'system is in steady state — safe to proceed'?"

### 5. Generate Steady-State Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 2. Steady-State Hypotheses

### 2.1 Critical Services and User Journeys

| User Journey | Critical Services | SLO Owner | Business Impact |
|-------------|------------------|-----------|----------------|
| {{journey_name}} | {{services}} | {{owner}} | {{impact}} |

### 2.2 Steady-State Definitions

#### {{service_name}}

**Hypothesis:** "{{service_name}} is operating normally when all of the following conditions hold:"

| Signal | Steady-State Condition | Measurement Source | Window |
|--------|----------------------|-------------------|--------|
| Availability | {{availability_target}} | {{source}} | {{window}} |
| Latency (p99) | {{latency_threshold}} | {{source}} | {{window}} |
| Error Rate | {{error_rate}} | {{source}} | {{window}} |
| {{custom_metric}} | {{threshold}} | {{source}} | {{window}} |

**Failure Boundaries:**
- Acceptable degradation: {{what_can_degrade}}
- Hard violations: {{what_cannot_fail}}
- Critical dependencies: {{upstream_downstream}}

[Repeat for each critical service]

### 2.3 Baseline Verification Protocol

**Pre-Experiment Checklist:**
- [ ] Observe system metrics for {{observation_window}} with no anomalies
- [ ] Confirm no deployments or changes in the past {{change_freeze_window}}
- [ ] Verify all steady-state conditions are met for all in-scope services
- [ ] Confirm experiment scope with blast radius control owner
- [ ] Notify on-call team that experiment is starting

**Baseline Verification Tooling:**
- Dashboard: {{dashboard_link_or_description}}
- Query: {{sample_metric_query}}
- Responsible: {{role_or_team}}
```

### 6. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Steady-State Hypotheses based on our discussion.

**Here's what I'll add to the document:**

[Show the complete markdown content from step 5]

**What would you like to do?**
[C] Continue - Save this and proceed to failure scenario design
[R] Revise - Let's adjust the steady-state definitions, metrics, or failure boundaries"

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask what specific areas need adjustment
- Collaborate on revisions
- Present updated content
- Return to [C]/[R] menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/resilience-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2]`
- Load `./step-03-failure-scenarios.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 5.

## SUCCESS METRICS:

✅ Critical services and user journeys identified and prioritized
✅ Steady-state hypothesis defined for each critical service with measurable conditions
✅ Failure boundaries defined per user journey
✅ Baseline verification protocol established
✅ SLOs from observability plan surfaced and used as baseline where available
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Defining steady-state without grounding in actual metrics or SLOs
❌ Missing failure boundaries — vague "it should work" criteria
❌ No measurement source defined — steady state that can't be verified
❌ Not asking about off-limits services that should never be targeted
❌ Not surfacing observability plan SLOs when available
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-03-failure-scenarios.md` to design failure scenarios and experiment catalog.

Remember: Do NOT proceed to step-03 until user explicitly selects 'C' from the menu and content is saved!
