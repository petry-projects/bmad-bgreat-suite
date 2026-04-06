---
status: draft
stepsCompleted: []
inputDocuments: []
crossWorkflowContext: []
createdDate: ""
lastUpdated: ""
finopsMaturity: ""
---

# Cost Optimization Plan

## 1. Overview

- **Project**:
- **Author**:
- **Cloud Provider**:
- **Current FinOps Maturity**:
- **Target FinOps Maturity**:
- **Plan Date**:

## 2. Resource Right-Sizing Analysis

### 2.1 Resource Inventory

| Service | Resource Type | Current Size | Avg CPU% | Avg Mem% | Peak CPU% | Peak Mem% |
|---------|-------------|-------------|---------|---------|---------|---------|

### 2.2 Compute Right-Sizing Recommendations

| Service | Current Size | Recommended Size | Avg Utilization | Rationale | Monthly Savings | Priority | Owner |
|---------|-------------|-----------------|----------------|-----------|----------------|----------|-------|

### 2.3 Storage Right-Sizing Recommendations

| Volume/Store | Current Config | Recommended Config | Actual Usage | Monthly Savings | Priority |
|-------------|--------------|-------------------|-------------|----------------|----------|

### 2.4 Database Right-Sizing Recommendations

| Database | Current Class | Recommended Class | Rationale | Monthly Savings | Priority |
|---------|--------------|------------------|-----------|----------------|----------|

### 2.5 Idle and Orphaned Resources

| Resource | Type | Region | Monthly Cost | Action | Owner |
|---------|------|--------|-------------|--------|-------|

### 2.6 Environment Scheduling

| Environment | Current State | Recommended Schedule | Estimated Monthly Savings |
|------------|-------------|---------------------|--------------------------|

### 2.7 Right-Sizing Savings Summary

| Category | Monthly Savings | Annual Savings | Confidence | Implementation Risk |
|---------|----------------|---------------|-----------|-------------------|

## 3. Purchase Commitment Strategy

### 3.1 Workload Classification

| Service | Stability | Recommended Purchase Type | Rationale |
|---------|----------|--------------------------|-----------|

### 3.2 Reserved Instance Recommendations

| Service | Current Type | Reserved Type | Term | Payment Option | Annual Savings |
|---------|-------------|--------------|------|---------------|---------------|

### 3.3 Savings Plans / Committed Use Discounts

| Commitment Type | Hourly Amount | Term | Scope | Annual Savings |
|----------------|--------------|------|-------|---------------|

### 3.4 Spot / Preemptible Instance Strategy

| Workload | Instance Families | Diversification | Fallback | Expected Savings |
|---------|------------------|----------------|---------|-----------------|

### 3.5 Cost-Aware SLO Trade-offs

| Service | Current Config | SLO Target | Alternative | Cost Delta | Recommendation |
|---------|--------------|-----------|------------|-----------|---------------|

### 3.6 Commitment Portfolio Summary

| Purchase Type | Annual Commitment | Annual Savings | Utilization Target |
|--------------|-----------------|---------------|-------------------|

### 3.7 Commitment Governance

**Approval Thresholds:**

| Commitment Value | Approval Required | Turnaround |
|-----------------|-----------------|-----------|

**Review Cadence:**

| Activity | Frequency | Owner |
|---------|---------|-------|

**Utilization Targets:**

| Metric | Target | Alert Threshold | Action |
|--------|--------|----------------|--------|

## 4. Cost Allocation Tagging

### 4.1 Mandatory Tags

| Tag Key | Description | Example Values | Enforced By |
|---------|------------|---------------|------------|

### 4.2 Recommended Tags

| Tag Key | Description | Example Values | When to Apply |
|---------|------------|---------------|--------------|

### 4.3 Tagging Enforcement

| Control Type | Tool | Enforcement Level | Resources in Scope |
|-------------|------|------------------|-------------------|

### 4.4 Untagged Spend Baseline

| Category | Monthly Spend | % Untagged | Untagged Monthly | Priority |
|---------|--------------|-----------|-----------------|---------|

## 5. Anomaly Detection

### 5.1 Anomaly Detection Rules

| Monitor Name | Scope | Threshold | Sensitivity | Alert Channel |
|-------------|-------|---------|------------|--------------|

### 5.2 Anomaly Thresholds

| Anomaly Type | Detection Window | Threshold | Severity |
|-------------|----------------|---------|---------|

### 5.3 Anomaly Response Playbook

| Severity | Responder | SLA | Escalation |
|---------|----------|-----|----------|

## 6. Budget Alerts

### 6.1 Budget Definitions

| Budget Name | Scope | Monthly Amount | Alert at 80% | Alert at 100% | Forecast Alert |
|------------|-------|---------------|-------------|--------------|---------------|

### 6.2 Forecast-Based Alerts

| Budget | Forecast Alert Threshold | Action |
|--------|------------------------|--------|

### 6.3 Budget Response Procedures

| Alert Level | Response | Owner | Timeline |
|------------|---------|-------|---------|

## 7. FinOps Maturity Roadmap

### Current Maturity:

| Phase | Timeframe | Governance Milestones | Cost Visibility Target |
|-------|-----------|----------------------|----------------------|
| Crawl | | | |
| Walk | | | |
| Run | | | |

## 8. Validation Results

### Quality Gates

| Gate | Status | Notes |
|------|--------|-------|
| Right-Sizing | | |
| Purchase Strategy | | |
| Tagging Governance | | |
| Anomaly Detection | | |
| Budget Governance | | |

## 9. Total Savings Opportunity

| Area | Monthly Savings | Annual Savings | Confidence |
|------|----------------|---------------|-----------|

## 10. Implementation Roadmap

| Priority | Milestone | Expected Savings Impact | Owner | Target Timeframe |
|---------|-----------|------------------------|-------|----------------|

## 11. Cost Optimization Maintenance

### Review Cadence

- **Weekly**: Anomaly detection review, new untagged resource alert
- **Monthly**: Budget utilization review, right-sizing drift check, RI/SP utilization review
- **Quarterly**: Growth-adjusted purchase strategy review, tagging compliance audit, FinOps maturity assessment
- **Annually**: Full cost optimization plan refresh, commitment renewal decisions, unit economics review

### FinOps Health Indicators

| Indicator | Green | Yellow | Red |
|-----------|-------|--------|-----|
| Tagging coverage | > 90% | 75-90% | < 75% |
| RI/SP utilization | > 80% | 65-80% | < 65% |
| Budget alert response | < 24 hours | 24-48 hours | > 48 hours |
| Anomaly detection to resolution | < 4 hours | 4-24 hours | > 24 hours |
| Month-over-month spend growth | ≤ traffic growth | Up to 15% above | > 15% above traffic growth |
