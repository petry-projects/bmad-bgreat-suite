# Step 3: Failure Scenario Design

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on realistic failure modes — not exotic edge cases, but the failures that actually happen
- 🎯 ANALYZE infrastructure and architecture documents for failure injection points
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present [C]ontinue / [R]evise menu after generating failure scenario content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## CONTEXT BOUNDARIES:

- Steady-state definitions and failure boundaries from step 2 are in the document
- Input documents are loaded (architecture, infrastructure, observability, security if available)
- Focus on identifying real-world failure modes and designing safe, controlled experiments
- Every experiment must have a blast radius control before being added to the catalog

## YOUR TASK:

Collaboratively identify failure modes across all infrastructure layers, map them to risk categories, design specific experiments with blast radius controls, and prioritize the experiment catalog by learning value.

## FAILURE SCENARIO DESIGN SEQUENCE:

### 1. Identify Failure Modes by Infrastructure Layer

Walk through each infrastructure layer with the user. Use architecture/infrastructure documents to make this concrete:

**Compute Layer:**
- Instance/pod failure (node crash, OOM kill, process termination)
- CPU throttling (noisy neighbor, CPU limits, thermal throttle)
- Memory pressure (memory limits, OOM conditions, swap exhaustion)
- Disk I/O saturation (IOPS limits, disk full, slow writes)

**Network Layer:**
- Network partition (split-brain, inter-AZ loss, VPC route failure)
- Latency injection (packet delay, high jitter, slow network path)
- Packet loss (intermittent connectivity, UDP loss, TCP retransmit storms)
- DNS failure (NXDOMAIN, slow resolution, stale cache)
- Load balancer failure (LB unhealthy, session affinity broken)

**Storage Layer:**
- Database connection pool exhaustion
- Replication lag / replication failure
- Storage backend slow (high IOPS, slow queries, lock contention)
- Backup/restore failure
- Data corruption (soft failure, checksum mismatch)

**External Dependencies:**
- Third-party API degradation (timeout, 503, rate limiting)
- Auth service unavailable (IdP outage, token expiry cascade)
- CDN failure (origin fallback, cache poisoning)
- Queue/messaging backlog (consumer lag, dead letter queue growth)
- Certificate expiration

Ask user:
"Based on your architecture, which of these failure modes are most relevant to your system?
- Which layer has the highest blast radius if it fails?
- Have any of these failures actually occurred in production? Those are the highest priority to test.
- Are there any failure modes specific to your stack that I haven't listed?"

### 2. Map Failure Modes to Security Threat Categories (If Security Plan Available)

If a security plan was loaded, map applicable failure modes to STRIDE categories:

| STRIDE Category | Applicable Failure Modes |
|----------------|--------------------------|
| **Spoofing** | Auth service unavailable, certificate expiration, token expiry cascade |
| **Tampering** | Data corruption, storage backend manipulation, message queue poisoning |
| **Repudiation** | Logging system failure, audit trail gaps during chaos |
| **Information Disclosure** | Error response leakage during degraded state, log flooding |
| **Denial of Service** | Resource exhaustion (CPU/memory/disk), network partition, DDoS simulation |
| **Elevation of Privilege** | Auth bypass under failure conditions, RBAC failures during degradation |

Surface the mapping:
"Your security plan identified these STRIDE threats. These failure modes overlap:
[Show relevant mappings]

Testing these failure modes serves double duty: resilience AND security validation."

If no security plan is available, skip this sub-step.

### 3. Design Experiments

For each high-priority failure mode, collaboratively design the experiment:

**Experiment Design Template:**

```
Experiment ID: EXP-{N}
Name: [Descriptive name]
Failure Mode: [What we're injecting]
Target: [Specific service/component/zone]
Hypothesis: "When [failure] occurs, steady state will be maintained because [reason]"

Steady-State Check:
- Before: [confirm baseline is healthy]
- During: [metrics to monitor throughout]
- After: [confirm recovery to steady state]

Blast Radius Controls:
- Scope: [what is affected, what is NOT affected]
- Traffic: [% of traffic routed through experiment, e.g., "5% via feature flag"]
- Rollback: [exact steps to immediately stop and reverse the experiment]
- Abort Criteria: [which steady-state failure boundaries trigger immediate abort]

Execution Method: [tooling to use — e.g., kill -9, tc netem, iptables, AWS FIS, Chaos Monkey]
Environment: [where to run — staging / canary / production subset]
Prerequisites: [what must be in place before running]

Expected Outcome: [steady state maintained / degraded but recovered / known failure mode documented]
Learning Value: [what we expect to learn or validate]
```

Guide the user through designing 3-5 high-priority experiments before filling out the full catalog later.

### 4. Establish Blast Radius Controls

Before any experiment is approved for the catalog, it must have blast radius controls:

**Required Controls:**

1. **Scope Definition** — Exactly what is in scope vs. what is protected. Be specific: "Pod failure in staging cluster, production is NOT affected."

2. **Traffic Shaping** — Start small. Use feature flags, canary weights, or shadow traffic. Never inject failure into 100% of production traffic on first run.

3. **Rollback Procedure** — Step-by-step commands to immediately stop and reverse the failure injection. Must be executable in under 60 seconds.

4. **Abort Criteria** — If any steady-state failure boundary is breached, abort immediately. Document who has authority to call abort.

5. **Monitoring Coverage** — The dashboards and alerts that will be actively monitored during the experiment. Someone must be watching.

6. **Communication Plan** — Who needs to know this experiment is running: on-call engineer, team lead, stakeholders.

Discuss with user:
"For each experiment, let's define the blast radius controls:
- Do you have feature flags or traffic shaping available?
- Who has authority to call experiment abort?
- What's the rollback procedure for each failure injection method?
- Should any experiments be staging-only until the team is more comfortable?"

### 5. Prioritize the Experiment Catalog

Help the user prioritize experiments by two dimensions:

**Risk Score (1-5):** How bad is it if this actually fails in production?
- 5 = Revenue/data impact, customer-visible, no mitigation
- 3 = Degraded experience, workaround available
- 1 = Internal service, low blast radius

**Learning Value (1-5):** How much do we learn from running this experiment?
- 5 = We've never tested this, we don't know what happens
- 3 = We've seen this fail before, want to validate our fixes
- 1 = We're confident in this path, test is confirmatory

**Priority = Risk × Learning Value** — run high-risk, high-learning experiments first.

Present the prioritized catalog to the user for review and adjustment.

### 6. Generate Failure Scenario Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 3. Failure Catalog

### 3.1 Failure Mode Inventory

| Layer | Failure Mode | Relevant Services | Risk Score | In Scope |
|-------|-------------|-------------------|------------|----------|
{{failure_mode_inventory_rows}}

### 3.2 Security Threat Mapping

{{stride_mapping_table_if_security_plan_available_or_note_that_section_is_deferred}}

### 3.3 Experiment Designs

{{for each experiment: full experiment design using the template above}}

### 3.4 Experiment Priority Matrix

| Experiment | Risk Score | Learning Value | Priority Score | Recommended Order |
|-----------|-----------|---------------|---------------|-------------------|
{{priority_matrix_rows}}

### 3.5 Blast Radius Controls Summary

| Experiment | Scope | Traffic Limit | Abort Authority | Rollback Time |
|-----------|-------|--------------|----------------|--------------|
{{blast_radius_summary_rows}}
```

### 7. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Failure Catalog and Experiment Designs based on our discussion.

**Here's what I'll add to the document:**

[Show the complete markdown content from step 6]

**What would you like to do?**
[C] Continue - Save this and proceed to game day planning
[R] Revise - Let's adjust the failure modes, experiment designs, or prioritization"

### 8. Handle Menu Selection

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

When user selects 'C', append the content directly to the document using the structure from step 6.

## SUCCESS METRICS:

✅ Failure modes identified across all relevant infrastructure layers
✅ Architecture/infrastructure documents used to make failure modes concrete
✅ Security threat mapping completed if security plan available
✅ Each experiment has a complete design with blast radius controls
✅ Rollback procedures defined and executable within 60 seconds
✅ Experiment catalog prioritized by risk × learning value
✅ Abort criteria tied to steady-state failure boundaries from step 2
✅ [C]/[R] menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Listing theoretical failure modes not relevant to the actual architecture
❌ Designing experiments without blast radius controls
❌ No rollback procedures — experiments that can't be stopped are dangerous
❌ Abort criteria not connected to steady-state definitions from step 2
❌ Prioritizing low-risk experiments over high-risk, high-learning ones
❌ Not using architecture documents to identify real failure injection points
❌ Not presenting [C]/[R] menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-04-game-day.md` to design game day exercises and establish experiment scheduling.

Remember: Do NOT proceed to step-04 until user explicitly selects 'C' from the menu and content is saved!
