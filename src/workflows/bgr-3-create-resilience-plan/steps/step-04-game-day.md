# Step 4: Game Day Planning

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on making game days practical and executable — not just planned
- 🎯 BUILD on the experiments designed in step 3 to create structured exercises
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present [C]ontinue / [R]evise menu after generating game day content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## CONTEXT BOUNDARIES:

- Steady-state definitions from step 2 and experiment catalog from step 3 are in the document
- Incident response plan (if loaded) informs roles, communication plans, and escalation paths
- Focus on making experiments executable as organized team exercises
- Adapt to team size — a 3-person startup runs game days differently than a 50-person engineering org

## YOUR TASK:

Collaboratively design game day exercises (both tabletop and live), define roles and communication plans for each exercise, establish a scheduling cadence, and document runback procedures for every experiment.

## GAME DAY PLANNING SEQUENCE:

### 1. Understand Game Day Context

Before designing exercises, discuss with the user:

- What is the team size? (this shapes how complex game days can be)
- Has the team run any game days or tabletop exercises before?
- Is there buy-in from leadership to take production-facing risks?
- What is the current on-call tooling? (PagerDuty, OpsGenie, Slack, etc.)
- Are there quiet periods (maintenance windows, low-traffic hours) that should be used for early experiments?
- Should early game days be staging-only, or is the team ready for production testing?

### 2. Design Tabletop Exercises

Tabletop exercises are low-risk, high-learning discussions that build muscle memory without production risk.

**Tabletop Format:**

A tabletop exercise presents a failure scenario and walks the team through:
1. How would you detect this failure? (observability)
2. How would you classify the severity? (incident response)
3. Who would you page and when? (escalation)
4. What would you do in the first 5 minutes? (runbook)
5. What could make this worse? (blast radius awareness)
6. How do you confirm resolution? (steady-state verification)

**Recommended Tabletop Scenarios:**
- Pick 2-3 high-priority experiments from step 3 as tabletop scenarios
- Also consider: "A key engineer is unavailable during an incident" (process resilience)
- And: "Monitoring goes dark during an incident" (observability resilience)

Discuss with user:
"Let's select which experiments from your catalog should be run as tabletop exercises first:
- Which scenarios does the team feel least prepared for?
- Are there any failure modes where the runbooks are unclear?
- How often should you run tabletop exercises? (monthly, quarterly)"

### 3. Design Live Experiments

Live experiments inject real failures and validate that steady state is maintained.

**Live Experiment Progression (Safest to Boldest):**

1. **Staging Only** — Full blast radius, no production risk. Use to validate tooling and procedures.
2. **Production Canary** — Small percentage of production traffic. Use after staging is validated.
3. **Production with Traffic Shaping** — Broader production test with feature flags or gradual rollout.
4. **Full Production** — Run on all production traffic after confidence is established.

**Live Experiment Structure:**

For each live experiment from step 3, define the game day execution plan:

```
Game Day: [Experiment Name]
Date/Window: [scheduled time or "TBD"]
Duration: [expected total time including recovery]
Environment: [staging / production canary / production]

Roles:
- Experiment Lead: [who runs the injection]
- Safety Monitor: [who watches metrics and calls abort]
- Communications Lead: [who updates stakeholders]
- Scribe: [who logs timeline and observations]

Pre-Experiment Checklist:
- [ ] Steady-state confirmed (all baseline metrics healthy)
- [ ] Rollback procedure reviewed and ready
- [ ] On-call team notified of experiment window
- [ ] Stakeholders notified (if production)
- [ ] Monitoring dashboards open and verified
- [ ] Abort criteria reviewed with all participants

Experiment Steps:
1. [Step-by-step execution instructions]
2. ...

Abort Criteria: [from step 3 failure boundaries]
Rollback Steps: [from step 3 blast radius controls]

Post-Experiment:
- [ ] Confirm steady state restored
- [ ] Record observations and anomalies
- [ ] Update experiment design based on learnings
- [ ] Schedule follow-up if hypothesis was disproven
```

Discuss each live experiment with the user and define the execution plan.

### 4. Define Roles and Communication Plan

**Core Game Day Roles:**

| Role | Responsibility | Required For |
|------|---------------|-------------|
| **Experiment Lead** | Executes failure injection; knows the tooling | All live experiments |
| **Safety Monitor** | Watches steady-state metrics; authority to call abort | All live experiments |
| **Scribe** | Records timeline, observations, anomalies in real time | All live experiments |
| **Communications Lead** | Updates stakeholders, posts status if production-visible | Production experiments |
| **Observer/Learner** | Team members learning from the exercise | Optional, encouraged |

For smaller teams:
- One person can fill multiple roles (e.g., Experiment Lead + Scribe)
- But Safety Monitor must be a separate person from Experiment Lead

**Communication Plan:**

- **Pre-experiment**: Notify on-call team, relevant stakeholders, and support team (if customer-visible)
- **During experiment**: Regular check-ins at defined intervals (e.g., every 5 minutes)
- **Post-experiment**: Brief summary to all notified parties
- **If abort triggered**: Immediate notification to team lead and stakeholders

Align communication channels with incident response plan if available.

### 5. Establish Scheduling Cadence

Help the user define a sustainable game day schedule:

**Recommended Cadence by Maturity:**

| Maturity Level | Tabletop Frequency | Live Experiment Frequency |
|---------------|-------------------|--------------------------|
| None / Basic | Monthly | Quarterly (staging only first) |
| Intermediate | Monthly | Monthly (staging + canary) |
| Advanced | Bi-weekly | Continuous (automated + periodic live) |

**Scheduling Considerations:**
- Avoid major release windows (coordinate with pipeline plan if available)
- Schedule during business hours for early experiments (easier to get help)
- Rotate who runs experiments (builds team-wide knowledge)
- Document results after every exercise to build institutional knowledge

Ask user:
"What scheduling cadence is realistic for your team right now?
- How many people can participate in game days?
- Are there weeks or periods to avoid?
- Should you start with one experiment per quarter and build from there?"

### 6. Document Runback Procedures

For every experiment in the catalog, document the exact runback (rollback) procedure:

A runback procedure must:
1. Stop the failure injection
2. Verify the injection has stopped
3. Wait for the system to recover
4. Confirm steady state is restored
5. Document actual recovery time vs. expected

If the system does NOT recover to steady state within the expected recovery window from step 2:
- Escalate to on-call lead
- Treat as a real incident using incident response procedures
- Document the gap between expected and actual recovery

### 7. Generate Game Day Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 4. Game Day Program

### 4.1 Tabletop Exercises

{{for each tabletop scenario: scenario description, facilitation guide, key questions}}

#### Tabletop Schedule

| Exercise | Scenario | Frequency | Next Date |
|----------|----------|-----------|-----------|
{{tabletop_schedule_rows}}

### 4.2 Live Experiments

{{for each live experiment: full game day plan using the template above}}

#### Live Experiment Schedule

| Experiment | Environment | Scheduled Window | Status |
|-----------|-------------|-----------------|--------|
{{live_experiment_schedule_rows}}

### 4.3 Roles & Communication Plan

{{roles_table and communication_plan}}

### 4.4 Scheduling Cadence

**Recommended Cadence:** {{cadence_based_on_maturity}}

{{scheduling_considerations_and_constraints}}

### 4.5 Runback Procedures

{{for each experiment: step-by-step rollback, recovery verification, escalation if recovery fails}}

### 4.6 Metrics & Learning Framework

After each game day exercise, capture:
- Hypothesis result: Confirmed / Disproved / Inconclusive
- Actual steady-state behavior vs. expected
- Actual recovery time vs. RTO
- New failure modes discovered
- Process improvements identified
- Action items with owners and due dates
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Game Day Program based on our discussion.

**Here's what I'll add to the document:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this and proceed to validation & finalization
[R] Revise - Let's adjust the game day exercises, roles, or scheduling"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Ask what specific areas need adjustment
- Collaborate on revisions
- Present updated content
- Return to [C]/[R] menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/resilience-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4]`
- Load `./step-05-validation.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 7.

## SUCCESS METRICS:

✅ Tabletop exercises designed with clear facilitation guides
✅ Live experiments have complete game day plans with roles defined
✅ Safety Monitor role is separate from Experiment Lead
✅ Communication plan defined for pre/during/post experiment
✅ Scheduling cadence is realistic for the team's maturity
✅ Runback procedures documented for every experiment
✅ Recovery time expectations tied to step 2 RTOs
✅ Escalation path defined if recovery fails
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Designing game days without defining who watches metrics (no Safety Monitor)
❌ No runback procedures — experiments that can't be stopped are dangerous
❌ Scheduling cadence that's too aggressive for the team's maturity
❌ Live production experiments before staging has been validated
❌ No communication plan — stakeholders surprised by degradation
❌ Not defining escalation path when recovery fails to steady state
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-05-validation.md` to validate and finalize the resilience testing plan.

Remember: Do NOT proceed to step-05 until user explicitly selects 'C' from the menu and content is saved!
