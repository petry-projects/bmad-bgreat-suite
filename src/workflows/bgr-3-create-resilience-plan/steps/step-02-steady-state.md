# Step 2: Steady-State Hypothesis Definition

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on defining what "healthy" looks like before designing how to break things
- 🎯 ANALYZE loaded observability and SLO documents — don't invent steady-state from scratch
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
- Input documents already loaded are in memory (observability plan, incident response, architecture, etc.)
- Focus on defining measurable, observable definitions of health — not failure modes yet
- Steady-state must be measurable from existing or planned observability instrumentation

## YOUR TASK:

Collaboratively define what "healthy" looks like for each critical service, identify the user journeys that resilience testing must protect, and document the baseline metrics that define steady state.

## STEADY-STATE DEFINITION SEQUENCE:

### 1. Understand Critical Services and User Journeys

Before proposing steady-state definitions, discuss with the user:

- What are the critical user journeys in your system? (e.g., user login, checkout flow, data pipeline processing)
- Which services are in the critical path for each journey?
- Are there SLOs already defined in the observability plan? If so, surface them here as the starting point.
- What does "degraded but acceptable" look like versus "clearly broken"?

If observability plan is loaded, extract existing SLOs and present them:
"From your observability plan, I found these SLO targets. Let's use them as the foundation for steady-state:
- [List SLOs found: service, metric, target]
Are these still accurate? Any services or journeys we should add?"

If no observability plan:
"Since we don't have an observability plan yet, we'll define steady-state based on what you know about your system's healthy behavior. For each critical service, we'll define what metrics indicate it's working correctly."

### 2. Define Steady-State Per Critical Service

For each critical service or user journey, collaboratively define:

**Steady-State Template:**

```
Service: [name]
User Journey: [what user action this serves]
Steady-State Hypothesis: "Normal behavior is characterized by..."

Metrics (all must hold for steady state to be true):
- Availability: ≥ X% (e.g., ≥ 99.9% measured over trailing 5 minutes)
- Latency: p99 ≤ X ms (e.g., p99 ≤ 500ms for login endpoint)
- Error Rate: ≤ X% (e.g., ≤ 0.1% 5xx responses)
- Throughput: ≥ X req/s (minimum to confirm service is handling load)

Observable Via: [which dashboard or alert tells you this is true]
Failure Boundary: "We consider steady state broken when..."
```

Present proposed steady-state definitions to user and refine collaboratively.

### 3. Define Baseline Metrics

For each steady-state definition, ensure the baseline metrics are:

**Observable:** Each metric must be visible in your monitoring stack right now (or must be added before testing).

**Measurable Before and After:** You need a way to confirm the system returned to steady state after an experiment.

**Specific:** Vague goals like "low latency" are not steady-state hypotheses. "p99 latency ≤ 200ms for /api/checkout" is.

Ask user:
"For each steady-state metric, let's confirm:
- Where exactly can this metric be read? (dashboard name, alert name, query)
- What's the measurement window? (e.g., trailing 5 minutes, 1-minute average)
- How quickly should the system recover to steady state after we stop an experiment?
  - This is the Recovery Time Objective (RTO) for each experiment."

### 4. Identify Failure Boundaries

For each steady-state definition, define when it's clearly violated:

**Failure Boundary Examples:**

| Metric | Steady State | Failure Boundary |
|--------|-------------|-----------------|
| Availability | ≥ 99.9% | < 99.0% (10x error budget consumed) |
| p99 Latency | ≤ 200ms | > 2000ms (10x degradation) |
| Error Rate | ≤ 0.1% | > 5% (50x normal rate) |
| Queue Depth | ≤ 1000 messages | > 10000 messages |

Failure boundaries are used in two ways:
1. **Abort criteria** — if an experiment breaches a failure boundary, immediately stop the test
2. **Success definition** — an experiment "passes" if steady state is maintained throughout

### 5. Generate Steady-State Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 2. Steady-State Hypothesis

### 2.1 Maturity Assessment

**Current Resilience Maturity:** {{maturity_level_from_step_1}}

{{brief_description_of_current_state_and_what_this_plan_aims_to_achieve}}

### 2.2 Critical User Journeys

{{list_of_critical_user_journeys_and_the_services_in_their_critical_path}}

### 2.3 Steady-State Definitions

{{for each service/journey: steady_state_hypothesis, metrics, observability pointer, failure boundary}}

### 2.4 Baseline Metrics Summary

| Service | Metric | Steady-State Target | Failure Boundary | Observable Via |
|---------|--------|--------------------|--------------------|----------------|
{{table_rows_for_each_defined_metric}}

### 2.5 Recovery Time Objectives

| Service | Max Recovery Time | Measurement Method |
|---------|------------------|--------------------|
{{rto_table_for_each_service}}
```

### 6. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Steady-State Hypothesis definitions based on our discussion.

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

✅ All critical user journeys identified and documented
✅ Steady-state defined with specific, measurable metrics for each service
✅ Failure boundaries defined to serve as experiment abort criteria
✅ All metrics observable through existing or planned monitoring
✅ Recovery time objectives established per service
✅ SLOs from observability plan incorporated where available
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Defining vague or unmeasurable steady-state ("the system is fast")
❌ Not referencing observability plan SLOs when available
❌ Steady-state metrics not observable in current monitoring
❌ No failure boundaries defined — experiments have no abort criteria
❌ Missing recovery time objectives — can't tell when experiment is "done"
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-03-failure-scenarios.md` to identify failure modes and design experiments.

Remember: Do NOT proceed to step-03 until user explicitly selects 'C' from the menu and content is saved!
