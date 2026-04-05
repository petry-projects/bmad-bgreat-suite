---
status: draft
stepsCompleted: []
inputDocuments: []
maturityLevel: ""
createdDate: ""
lastUpdated: ""
crossWorkflowContext: []
---

# Resilience Testing Plan

## 1. Overview

- **Project**:
- **Author**:
- **Last Review Date**:
- **Resilience Maturity Level**: (none / basic / intermediate / advanced)

## 2. Steady-State Hypotheses

### 2.1 Critical Services and User Journeys

| User Journey | Critical Services | SLO Owner | Business Impact |
|-------------|------------------|-----------|----------------|

### 2.2 Steady-State Definitions

#### {Service Name}

**Hypothesis:** "{Service Name} is operating normally when all of the following conditions hold:"

| Signal | Steady-State Condition | Measurement Source | Window |
|--------|----------------------|-------------------|--------|
| Availability | | | |
| Latency (p99) | | | |
| Error Rate | | | |

**Failure Boundaries:**
- Acceptable degradation:
- Hard violations:
- Critical dependencies:

### 2.3 Baseline Verification Protocol

**Pre-Experiment Checklist:**
- [ ] Observe system metrics for {observation_window} with no anomalies
- [ ] Confirm no deployments or changes in the past {change_freeze_window}
- [ ] Verify all steady-state conditions are met for all in-scope services
- [ ] Confirm experiment scope with blast radius control owner
- [ ] Notify on-call team that experiment is starting

**Baseline Verification Tooling:**
- Dashboard:
- Query:
- Responsible:

## 3. Failure Catalog

### 3.1 Failure Mode Inventory

#### Compute Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

#### Network Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

#### Storage Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

#### Dependencies Layer

| Failure Mode | Affected Services | Probability | Severity | Notes |
|-------------|------------------|-------------|----------|-------|

### 3.2 STRIDE Mapping

| STRIDE Category | Relevant Failure Modes | Experiment Coverage |
|----------------|----------------------|-------------------|
| Spoofing | | |
| Tampering | | |
| Repudiation | | |
| Information Disclosure | | |
| Denial of Service | | |
| Elevation of Privilege | | |

### 3.3 Experiment Designs

#### EXP-001: {Experiment Name}

- **Failure Mode**:
- **Target**:
- **Hypothesis**: "If {failure is injected}, the system will {expected behavior}..."
- **Blast Radius Controls**:
  - Scope:
  - Duration:
  - Abort Criteria:
  - Rollback:
- **Injection Method**:
- **Environment**:
- **Observability**:
- **Success Criteria**:
- **Learning Goal**:
- **Risk Level**: (low / medium / high)

### 3.4 Prioritized Experiment Catalog

| Priority | Experiment | Risk | Learning Value | Environment | Prerequisites |
|----------|-----------|------|----------------|-------------|---------------|

## 4. Game Day Plan

### 4.1 Game Day Formats

### 4.2 Tabletop Exercises

#### TT-001: {Scenario Name}

- **Scenario**:
- **Scenario Narrative**:
- **Facilitator**:
- **Participants**:
- **Duration**:
- **Discussion Questions**:
  1.
  2.
  3.
- **Learning Objectives**:

### 4.3 Live Experiment Game Days

**Pre-Game Day Checklist (T-48 hours):**
- [ ] Confirm steady-state is stable
- [ ] Review experiment designs and abort criteria
- [ ] Brief all participants on their roles
- [ ] Verify rollback procedures are tested and ready
- [ ] Confirm observability dashboards and alerts are working
- [ ] Notify stakeholders of scheduled experiment
- [ ] Establish game day communication channel

**Execution Timeline:**

| Time | Activity |
|------|----------|
| T-30 min | Baseline verification |
| T-15 min | Role assignments confirmed |
| T-0 | Failure injection authorized |
| T+{duration} | Observe and document |
| T+{recovery} | Remove injection, observe recovery |
| End | Debrief |

**Post-Game Day Checklist:**
- [ ] Document actual vs. expected system behavior
- [ ] Capture all actions in timeline
- [ ] Identify new runbooks or improvements needed
- [ ] Schedule follow-up for surprises
- [ ] Share findings with team and stakeholders

### 4.4 Roles and Communication

| Role | Responsibilities | Filled By |
|------|-----------------|-----------|
| Experiment Lead | Owns the game day, authorizes failure injection, calls abort | |
| Safety Observer | Monitors steady-state metrics, authority to abort at any time | |
| Chaos Operator | Executes failure injection and rollback procedures | |
| Observability Lead | Watches dashboards and alerts, reports deviations | |
| Scribe | Documents timeline, decisions, and system behavior | |
| Communications Lead | Handles stakeholder updates during experiment | |
| On-Call Standby | Maintains normal on-call responsibilities | |

### 4.5 Abort Criteria and Runback Procedures

#### EXP-001: {Experiment Name}

**Abort Conditions (any one triggers immediate abort):**
- Steady-state violation:
- Duration exceeded:
- Unintended blast radius:
- On-call alarm during experiment
- Safety observer call

**Runback Procedure:**
1.
2.
3.

**Verification:**
**Responsible:**

### 4.6 Experiment Scheduling Cadence

| Cadence | Activity |
|---------|---------|
| Weekly | Review experiment backlog |
| Monthly | Execute one tabletop or live game day |
| Quarterly | Review results, update failure catalog |
| Annually | Full resilience program review |

**Experiment Calendar Owner:**
**Experiment Backlog Location:**

## 5. Implementation Roadmap

### 5.1 Phased Implementation

#### Phase 1 — Foundation

#### Phase 2 — First Live Experiments

#### Phase 3 — Production Experiments

#### Phase 4 — Continuous Resilience

## 6. Metrics & Learning

### 6.1 Experiment Outcomes

| Experiment | Date | Hypothesis Result | Findings | Action Items |
|-----------|------|-------------------|----------|-------------|

### 6.2 Resilience Improvement Tracking

| Quarter | Experiments Run | Hypotheses Confirmed | Weaknesses Found | Improvements Made |
|---------|----------------|---------------------|-----------------|------------------|

### 6.3 Maturity Progress

- **Starting Maturity Level**:
- **Current Maturity Level**:
- **Target Maturity Level**:
- **Target Date**:
