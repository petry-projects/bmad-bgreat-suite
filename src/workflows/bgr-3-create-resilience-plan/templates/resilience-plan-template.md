---
status: draft
stepsCompleted: []
inputDocuments: []
createdDate: ""
lastUpdated: ""
crossWorkflowContext: []
---

# Resilience Testing Plan

## 1. Overview

- **Project**:
- **Author**:
- **Last Review Date**:
- **Resilience Maturity Level**:

## 2. Steady-State Hypothesis

### 2.1 Maturity Assessment

**Current Resilience Maturity:**

### 2.2 Critical User Journeys

| Journey | Critical Services | Owner |
|---------|-----------------|-------|

### 2.3 Steady-State Definitions

### 2.4 Baseline Metrics Summary

| Service | Metric | Steady-State Target | Failure Boundary | Observable Via |
|---------|--------|--------------------|--------------------|----------------|

### 2.5 Recovery Time Objectives

| Service | Max Recovery Time | Measurement Method |
|---------|------------------|--------------------|

## 3. Failure Catalog

### 3.1 Failure Mode Inventory

| Layer | Failure Mode | Relevant Services | Risk Score | In Scope |
|-------|-------------|-------------------|------------|----------|

### 3.2 Security Threat Mapping

| STRIDE Category | Applicable Failure Modes | Experiment |
|----------------|--------------------------|-----------|

### 3.3 Experiment Designs

### 3.4 Experiment Priority Matrix

| Experiment | Risk Score | Learning Value | Priority Score | Recommended Order |
|-----------|-----------|---------------|---------------|-------------------|

### 3.5 Blast Radius Controls Summary

| Experiment | Scope | Traffic Limit | Abort Authority | Rollback Time |
|-----------|-------|--------------|----------------|--------------|

## 4. Game Day Program

### 4.1 Tabletop Exercises

#### Tabletop Schedule

| Exercise | Scenario | Frequency | Next Date |
|----------|----------|-----------|-----------|

### 4.2 Live Experiments

#### Live Experiment Schedule

| Experiment | Environment | Scheduled Window | Status |
|-----------|-------------|-----------------|--------|

### 4.3 Roles & Communication Plan

| Role | Responsibility | Assigned To |
|------|---------------|------------|
| Experiment Lead | Executes failure injection | |
| Safety Monitor | Watches metrics; authority to call abort | |
| Scribe | Records timeline and observations | |
| Communications Lead | Updates stakeholders | |

### 4.4 Scheduling Cadence

- **Tabletop exercises**:
- **Staging experiments**:
- **Production experiments**:

### 4.5 Runback Procedures

### 4.6 Metrics & Learning Framework

After each game day exercise, capture:
- Hypothesis result: Confirmed / Disproved / Inconclusive
- Actual steady-state behavior vs. expected
- Actual recovery time vs. RTO
- New failure modes discovered
- Process improvements identified
- Action items with owners and due dates

## 5. Implementation Roadmap

### 5.1 Phased Approach

**Phase 1 — Foundation:**

**Phase 2 — Building Confidence:**

**Phase 3 — Operational:**

### 5.2 Tooling Requirements

| Tool | Purpose | Phase Needed | Status |
|------|---------|-------------|--------|
