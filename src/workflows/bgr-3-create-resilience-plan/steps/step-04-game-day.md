# Step 4: Game Day Planning

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on practical game day logistics that work for the user's team and maturity level
- 🎯 BUILD on the prioritized experiment catalog from step 3 to design actionable game day exercises
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present [C]ontinue / [R]evise menu after generating game day content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## CONTEXT BOUNDARIES:

- Failure catalog and prioritized experiments from step 3 are in the document
- Steady-state hypotheses from step 2 are available
- Incident response plan escalation paths may be available from step 1
- Focus on operational game day design — roles, communication, cadence, and runback procedures

## YOUR TASK:

Collaboratively design game day exercises (both tabletop and live), define roles and communication plans, establish an experiment scheduling cadence, and document runback procedures for each experiment.

## GAME DAY PLANNING SEQUENCE:

### 1. Choose Game Day Format

Explain the two formats and help the user choose the right starting point based on their maturity level:

**Tabletop Exercise:**
- A facilitated discussion where participants walk through a failure scenario hypothetically
- No actual failure is injected — the team talks through "what would happen if..."
- Best for: teams new to resilience testing, validating runbooks before live experiments, preparing for a live game day
- Duration: 1-2 hours
- Risk: Zero — no production impact

**Live Experiment Game Day:**
- Actual failure injection with the team in a coordinated observation session
- Hypothesis is tested in real-time against a live or staging environment
- Best for: teams that have completed tabletop exercises, validated steady-state definitions, and have confidence in their abort criteria
- Duration: 2-4 hours depending on experiment count
- Risk: Managed — controlled blast radius with abort criteria

Ask the user:
"Based on your maturity level ({maturityLevel from frontmatter}), here's my recommendation:

- **None / Basic**: Start with tabletop exercises for your top 3 scenarios before any live experiments
- **Intermediate**: Begin with live experiments in staging, then graduate to production canary
- **Advanced**: Live experiments in production with automated chaos pipelines

Does this approach work for your team, or would you like to adjust?"

### 2. Design Tabletop Exercises

For the top 3-5 failure scenarios from the prioritized experiment catalog, design tabletop exercises:

**Tabletop Exercise Design Template:**

```
Tabletop ID: TT-{number}
Scenario: {failure scenario from experiment catalog}
Scenario Narrative: "At {time}, on-call receives an alert that {what happened}. Investigation reveals {root cause scenario}..."
Facilitator: {who runs the tabletop}
Participants: {on-call engineers, service owners, SRE, management observers}
Duration: {60-120 minutes}
Discussion Questions:
  1. How would this failure be detected? (alert, user report, or not at all?)
  2. What is the initial severity classification?
  3. Who gets paged? What is the escalation path?
  4. What runbooks apply? Are they complete and accurate?
  5. What is the mitigation strategy?
  6. What is the blast radius and what stops it from spreading?
  7. What signals confirm resolution?
  8. What postmortem actions would this generate?
Learning Objectives: {what the team should learn from this tabletop}
```

Discuss with user:
"For each tabletop scenario, we need a narrative that feels realistic. Let's build one for your highest-priority scenario:
- What does the alert look like when this failure happens?
- Who would be the first to know, and how?
- Are there runbooks that would apply to this scenario?
- What are the most likely wrong turns the team might take?"

### 3. Design Live Game Day Exercises

For the prioritized live experiments, design the game day structure:

**Live Game Day Structure:**

**Pre-Game Day (T-48 hours):**
- [ ] Confirm steady-state is stable
- [ ] Review experiment designs and abort criteria
- [ ] Brief all participants on their roles
- [ ] Verify rollback procedures are tested and ready
- [ ] Confirm observability dashboards and alerts are working
- [ ] Notify stakeholders (support, product, management) of scheduled experiment
- [ ] Establish game day communication channel (dedicated Slack channel or bridge)

**Game Day Execution:**

| Time | Activity |
|------|----------|
| T-30 min | Baseline verification — confirm steady state for all in-scope services |
| T-15 min | Role assignments confirmed, dashboards open, abort criteria reviewed |
| T-0 | Experiment #1 begins — failure injection authorized by Experiment Lead |
| T+{duration} | Observe and document system behavior against steady-state hypothesis |
| T+{abort_window} | Abort criteria check — proceed or stop? |
| T+{recovery} | Remove failure injection, observe recovery |
| T+{cool_down} | Cool-down period, system returns to steady state before next experiment |
| End | Debrief and learning capture |

**Post-Game Day:**
- [ ] Document actual system behavior vs. hypothesis
- [ ] Capture all actions taken during experiment in timeline
- [ ] Identify new runbooks or improvements needed
- [ ] Schedule follow-up for any abort conditions or surprises
- [ ] Share findings with team and stakeholders

### 4. Define Roles and Communication Plan

**Game Day Roles:**

| Role | Responsibilities | Filled By |
|------|-----------------|-----------|
| Experiment Lead | Owns the game day, authorizes failure injection, calls abort | |
| Safety Observer | Monitors steady-state metrics, has authority to trigger abort at any time | |
| Chaos Operator | Executes failure injection and rollback procedures | |
| Observability Lead | Watches dashboards and alerts, reports deviations from steady state | |
| Scribe | Documents timeline, decisions, and actual system behavior | |
| Communications Lead | Handles stakeholder updates during the experiment | |
| On-Call Standby | Maintains normal on-call responsibilities during the game day | |

Ask the user:
"For your game days:
- Who should serve as Experiment Lead? (ideally someone who can call abort without hesitation)
- Does your team have enough people to separate the Safety Observer from the Chaos Operator?
- For smaller teams, we can combine roles — which combinations make sense for you?
- How will you communicate with stakeholders during live experiments?"

**Abort Criteria and Runback Procedures:**

For each experiment, define:

```
Experiment: EXP-{number}
Abort Conditions (any one triggers immediate abort):
  - Steady-state violation: {specific metric breaching threshold}
  - Duration exceeded: experiment running longer than {max_duration}
  - Unintended blast radius: failure spreading beyond {defined_scope}
  - On-call alarm: unrelated production incident during experiment
  - Safety observer call: Safety Observer judgment that something is wrong
Runback Procedure:
  Step 1: {first rollback action, e.g., remove failure injection}
  Step 2: {second action, e.g., verify traffic normalizing}
  Step 3: {third action, e.g., confirm steady state restored}
  Verification: {how we know we're back to normal}
  Responsible: {who executes the runback}
```

### 5. Establish Experiment Scheduling Cadence

Define a sustainable cadence for resilience testing:

**Proposed Cadence (adapt to maturity level):**

- **None / Basic**: 1 tabletop exercise per month for 3 months, then re-assess
- **Intermediate**: Monthly game days in staging, quarterly production experiments
- **Advanced**: Weekly automated chaos in staging, monthly game days, quarterly production campaigns

Ask the user:
"What's a realistic cadence for your team?
- How often can you dedicate 2-4 hours for a game day?
- Are there change freezes or release cycles that should block experiment scheduling?
- Is there appetite for automated continuous chaos, or do you prefer scheduled, human-supervised experiments?
- Who owns the experiment calendar and backlog?"

**Experiment Backlog Cadence:**

| Cadence | Activity |
|---------|---------|
| Weekly | Review experiment backlog, prioritize next game day |
| Monthly | Execute one tabletop or live game day |
| Quarterly | Review all experiment results, update failure catalog, re-assess maturity |
| Annually | Full resilience program review — update steady-state hypotheses, retire old experiments, add new |

### 6. Generate Game Day Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 4. Game Day Plan

### 4.1 Game Day Formats

{{tabletop_vs_live_selection_and_rationale}}

### 4.2 Tabletop Exercises

#### TT-001: {{scenario_name}}

{{tabletop_design_block}}

[Repeat for each tabletop]

### 4.3 Live Experiment Game Days

#### Game Day Structure

{{pre_game_day_checklist}}
{{execution_timeline}}
{{post_game_day_checklist}}

### 4.4 Roles and Communication

| Role | Responsibilities | Filled By |
|------|-----------------|-----------|
{{role_table_rows}}

### 4.5 Abort Criteria and Runback Procedures

#### EXP-001: {{experiment_name}}

{{abort_criteria_and_runback}}

[Repeat for each experiment]

### 4.6 Experiment Scheduling Cadence

{{cadence_table}}

**Experiment Calendar Owner:** {{owner_role}}
**Experiment Backlog Location:** {{backlog_location}}
```

### 7. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Game Day Plan based on our discussion.

**Here's what I'll add to the document:**

[Show the complete markdown content from step 6]

**What would you like to do?**
[C] Continue - Save this and proceed to validation & finalization
[R] Revise - Let's adjust the game day format, roles, cadence, or runback procedures"

### 8. Handle Menu Selection

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

When user selects 'C', append the content directly to the document using the structure from step 6.

## SUCCESS METRICS:

✅ Game day format chosen appropriate to team maturity
✅ Tabletop exercises designed for top scenarios
✅ Live game day structure with pre/during/post checklists defined
✅ Roles and communication plan adapted to team size
✅ Abort criteria and runback procedures defined for every experiment
✅ Sustainable experiment scheduling cadence established
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Designing live game days for teams that need tabletops first
❌ Missing abort criteria — experiments with no emergency stop
❌ Missing runback procedures — no way to restore normal state
❌ Roles not adapted to team size (enterprise roles for a 3-person team)
❌ Cadence that is unsustainable for the team's capacity
❌ No safety observer role — no independent monitoring during experiments
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-05-validation.md` to validate the complete resilience plan and finalize.

Remember: Do NOT proceed to step-05 until user explicitly selects 'C' from the menu and content is saved!
