# Step 3: Purchase Commitment Strategy

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between FinOps peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on reserved instances, savings plans, spot/preemptible strategy, and commitment term decisions
- 🎯 ANALYZE right-sizing output from step 2 to inform commitment baseline
- ⚠️ Do not estimate software delivery timelines or task durations — but do define cost governance timing (commitment renewal dates, utilization review cadence) as these are core FinOps outputs
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Share a concise rationale (assumptions, key trade-offs, and decisions) before taking any action
- ⚠️ Present C/R menu after generating purchase strategy
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the strategy, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with right-sizing analysis from step 2 is available
- Input documents already loaded are in memory
- Focus on defining commitment purchases — what to reserve, at what term, and what to leave on-demand or use spot
- Build on the right-sized baselines from step 2 (commit to right-sized, not over-provisioned, resources)

## YOUR TASK:

Define the cloud purchase commitment strategy — what workloads to cover with reserved instances or savings plans, what to run on spot/preemptible instances, commitment term recommendations, and the governance process for managing commitments over time.

## PURCHASE STRATEGY SEQUENCE:

### 1. Understand Current Purchase Mix

Establish the baseline before defining the target state:

Discuss with the user:

"Let's understand your current purchase mix before defining the target state:

**Current commitments:**
- Do you have any existing reserved instances or savings plans? If so, what are the expiry dates?
- What is your current on-demand vs reserved vs spot split (approximate)?
- Have you had any commitment utilization issues (unused reservations)?
- Does your organization have a minimum commitment approval process (finance, FinOps team)?

**Business constraints:**
- Is there a minimum contract term your finance team requires or limits?
- Are there cash flow constraints that affect upfront payment options?
- Do you have a FinOps or cloud governance team we need to involve?"

### 2. Workload Classification for Purchase Type

Classify workloads by stability to determine the right purchase vehicle:

**Classification Framework:**

| Workload Characteristic | Purchase Vehicle | Rationale |
|------------------------|-----------------|-----------|
| Steady-state, predictable, always-on | Reserved Instances (1-yr or 3-yr) | Highest savings for stable baseline |
| Flexible instance type/region/OS needs | Compute Savings Plans | Cross-family flexibility at 66% savings |
| Specific instance family, stable | EC2 Instance Savings Plans / GCP CUDs | Family-level commitment |
| Fault-tolerant batch, stateless workers | Spot / Preemptible Instances | Up to 90% savings with interruption tolerance |
| Spiky, unpredictable, bursty | On-Demand | Pay-as-you-go flexibility |
| Serverless (Lambda, Cloud Run) | Compute Savings Plans (AWS) / No commitment needed | Usage-based with potential savings plan coverage |

**Per-Service Classification (based on right-sizing from step 2):**

For each service in the right-sizing analysis, determine:

| Service | Stability | Current Purchase Type | Recommended Purchase Type | Recommended Term | Estimated Savings vs On-Demand |
|---------|----------|----------------------|--------------------------|-----------------|-------------------------------|

Discuss with the user:
"For each service classified as a candidate for commitment, let's validate:
- Is the resource type stable enough to commit? (Will this instance family change in the next 1-3 years?)
- Is the workload critical enough to guarantee utilization? (Empty reservations are wasted spend)
- Do you have a growth projection that might require upsizing before the commitment ends?"

### 3. Reserved Instance Strategy

For workloads identified as reservation candidates:

**Term and Payment Options:**

| Option | Discount vs On-Demand | Flexibility | Cash Impact | Best For |
|--------|----------------------|------------|------------|---------|
| 1-year, no upfront | ~30-40% | Can modify/sell | None | Conservative start |
| 1-year, partial upfront | ~35-45% | Can modify/sell | Moderate | Balanced |
| 1-year, all upfront | ~40-50% | Can modify/sell | High | Maximum savings, stable workload |
| 3-year, no upfront | ~50-60% | Can modify/sell | None | Long-term stable workloads |
| 3-year, all upfront | ~60-70% | Can modify/sell | High | Maximum savings, very stable |

**Scope Decisions:**

- **Regional** (AWS) vs **Zonal** reservations: Regional gives more flexibility, zonal gives capacity guarantees
- **Instance size flexibility** (AWS): t3 family reservations can apply across sizes within a family
- **Platform/tenancy**: Shared vs dedicated tenancy affects reservation applicability

**Reservation Recommendations:**

| Service | Recommended Reservation | Term | Payment Option | Annual Commitment | Savings vs Current |
|---------|------------------------|------|---------------|------------------|-------------------|

**Utilization Guardrails:**

- Target RI/SP utilization ≥ 80% to justify the commitment
- Review utilization monthly — alert at < 70% utilization
- Build a process to convert expiring reservations or sell unused ones on the marketplace

### 4. Savings Plans Strategy (AWS) / Committed Use Discounts (GCP)

For workloads where flexibility is more important than maximum savings:

**AWS Savings Plans:**

- **Compute Savings Plans**: Most flexible — applies to EC2 (any family, region, OS), Fargate, and Lambda
- **EC2 Instance Savings Plans**: More specific but slightly higher discount than Compute SP
- **SageMaker Savings Plans**: For ML workloads on SageMaker

**GCP Committed Use Discounts (CUDs):**

- **Resource-based CUDs**: Commit to vCPU and memory in a region (1 or 3 year)
- **Spend-based CUDs**: Commit to a minimum hourly spend for a service (e.g., Cloud SQL, VMware Engine)

**Savings Plan / CUD Recommendations:**

| Commitment Type | Hourly Commitment Amount | Term | Region/Scope | Estimated Annual Savings |
|----------------|-------------------------|------|-------------|------------------------|

Discuss with the user:
"Savings Plans provide flexibility in exchange for slightly lower discounts than specific RIs. Key question: Is your instance family likely to change in the next 1-3 years (e.g., migrating from x86 to ARM/Graviton)? If yes, Compute Savings Plans give you that flexibility."

### 5. Spot / Preemptible Instance Strategy

For fault-tolerant workloads, spot instances can provide 60-90% savings:

**Spot Workload Candidates:**

| Characteristic | Suitable for Spot | Explanation |
|---------------|------------------|-------------|
| Can checkpoint and restart | Yes | Handle 2-minute interruption notice |
| Stateless web/API tier with redundancy | Yes | Load balancer routes around interruptions |
| Batch data processing | Yes | Retry on failure is inherent |
| CI/CD build agents | Yes | Builds can be re-queued |
| ML training jobs | Yes | Checkpointing handles interruptions |
| Production databases | No | Interruptions cause data loss risk |
| Single-instance stateful services | No | No redundancy to absorb interruptions |

**Spot Fleet / Managed Instance Groups Strategy:**

- **Diversification**: Spread across multiple instance families and sizes to reduce interruption probability
- **Instance type selection**: Choose 5-10 instance types that meet your requirements — more variety = lower interruption rate
- **Availability zone diversification**: Spread across AZs to reduce correlated interruptions
- **Fallback to on-demand**: Configure fallback so critical work completes if spot capacity is unavailable

**Spot/Preemptible Recommendations:**

| Workload | Spot Candidate | Instance Families | Diversification Strategy | Expected Interruption Rate | Fallback |
|---------|---------------|------------------|------------------------|--------------------------|---------|

### 6. Commitment Governance Process

Define how to manage commitments over time:

**Commitment Lifecycle:**

| Phase | Activity | Cadence | Owner |
|-------|---------|---------|-------|
| Purchase | Analyze utilization data before committing | Before each purchase | FinOps / DevOps |
| Monitor | Track utilization of existing commitments | Monthly | FinOps / DevOps |
| Optimize | Modify, exchange, or sell underutilized reservations | Quarterly | FinOps / DevOps |
| Renew | Evaluate renewal 90 days before expiry | 90 days before expiry | FinOps / Finance |

**Commitment Approval Process:**

| Commitment Value | Approval Required | Turnaround |
|-----------------|-----------------|-----------|
| < $1,000/yr | DevOps team | Same day |
| $1,000-$10,000/yr | Engineering manager + FinOps | 2-3 days |
| > $10,000/yr | Director + Finance | 1 week |

(Adjust thresholds to match your organization's financial governance)

**Commitment Utilization Targets:**

| Metric | Target | Alert Threshold | Action |
|--------|--------|----------------|--------|
| RI utilization | ≥ 85% | < 70% | Investigate unused RIs, consider selling/modifying |
| Savings Plan utilization | ≥ 80% | < 65% | Review compute usage changes, adjust SP amount |
| Spot interruption rate | < 5% | > 10% | Diversify instance type selection |

### 7. Cost-Aware SLO Trade-offs (Morgan Collaboration)

Identify where reliability investment decisions intersect with cost optimization:

**Trade-off Analysis Framework:**

When reviewing each service, ask:
- "Is this replica for reliability or for capacity? Could we reduce replicas and accept lower error budget utilization?"
- "Is this reserved capacity for a worst-case scenario that rarely happens? Is the cost of that reservation worth the risk mitigation?"
- "Can we accept slightly longer cold-start times for this service in exchange for using spot instances?"

**Cost-Aware SLO Trade-offs:**

| Service | Current Reliability Config | SLO Target | Cost-Aware Alternative | Cost Delta | Error Budget Impact | Recommendation |
|---------|--------------------------|-----------|----------------------|-----------|-------------------|---------------|

Discuss with the user:
"Some reliability configurations exist because of past incidents or conservative estimates — not always because the SLO requires them. Let's review each multi-replica or redundant setup: Is the cost of this redundancy justified by the reliability improvement we get?"

### 8. Total Purchase Strategy Summary

Summarize the complete commitment strategy:

**Commitment Portfolio:**

| Purchase Type | Scope | Term | Annual Commitment | Annual Savings vs On-Demand |
|--------------|-------|------|------------------|---------------------------|
| Reserved Instances | {services} | {term} | ${amount} | ${savings} |
| Savings Plans | {scope} | {term} | ${amount} | ${savings} |
| Spot Instances | {workloads} | N/A | Variable | ${savings} |
| **Total** | | | | |

**FinOps Maturity Progression for Purchase Strategy:**

- **Crawl**: Start with 1-year no-upfront RIs for top 3 stable services only
- **Walk**: Expand to savings plans, add spot for batch workloads, monthly utilization reviews
- **Run**: Full commitment portfolio optimization, automated RI recommendations, spot fleet management

### 9. Generate Purchase Strategy Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 3. Purchase Commitment Strategy

### 3.1 Workload Classification

| Service | Stability | Recommended Purchase Type | Rationale |
|---------|----------|--------------------------|-----------|
{{workload_classification_entries}}

### 3.2 Reserved Instance Recommendations

| Service | Current Type | Reserved Type | Term | Payment Option | Annual Savings |
|---------|-------------|--------------|------|---------------|---------------|
{{ri_recommendation_entries}}

### 3.3 Savings Plans / Committed Use Discounts

| Commitment Type | Hourly Amount | Term | Scope | Annual Savings |
|----------------|--------------|------|-------|---------------|
{{savings_plan_entries}}

### 3.4 Spot / Preemptible Instance Strategy

| Workload | Instance Families | Diversification | Fallback | Expected Savings |
|---------|------------------|----------------|---------|-----------------|
{{spot_strategy_entries}}

### 3.5 Cost-Aware SLO Trade-offs

| Service | Current Config | SLO Target | Alternative | Cost Delta | Recommendation |
|---------|--------------|-----------|------------|-----------|---------------|
{{slo_tradeoff_entries}}

### 3.6 Commitment Portfolio Summary

| Purchase Type | Annual Commitment | Annual Savings | Utilization Target |
|--------------|-----------------|---------------|-------------------|
{{commitment_portfolio_entries}}

**Total Annual Commitment Savings:** {{total_commitment_savings}}

### 3.7 Commitment Governance

**Approval Thresholds:**
{{approval_threshold_entries}}

**Review Cadence:**
{{commitment_review_cadence}}

**Utilization Targets:**

| Metric | Target | Alert Threshold | Action |
|--------|--------|----------------|--------|
{{commitment_utilization_targets}}
```

### 10. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Purchase Commitment Strategy.

**Here's what I'll add to the cost optimization plan:**

[Show the complete markdown content from step 9]

**What would you like to do?**
[C] Continue - Save this strategy and proceed to tagging, anomaly detection, and budget alerts
[R] Revise - Let's adjust specific sections before continuing"

### 11. Handle Menu Selection

#### If 'R' (Revise):

- Ask: "Which section would you like to revise? (Workload Classification / Reserved Instances / Savings Plans / Spot Strategy / SLO Trade-offs / Commitment Portfolio / Governance)"
- Discuss the specific section with the user
- Update the content based on feedback
- Return to C/R menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/cost-optimization-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3]`
- Load `./step-04-tagging-anomaly-budget.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 9.

## SUCCESS METRICS:

✅ Current purchase mix baseline established
✅ All workloads classified by stability and purchase vehicle
✅ Reserved instance and savings plan recommendations defined
✅ Spot/preemptible strategy defined for eligible workloads
✅ Cost-aware SLO trade-offs analyzed with Morgan collaboration items
✅ Commitment governance process established with approval thresholds
✅ Commitment utilization targets defined
✅ User confirmed all commitment decisions through discussion
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Recommending commitments without validating workload stability
❌ Committing to over-provisioned resources (should commit to right-sized baseline)
❌ Not defining commitment governance or utilization monitoring
❌ Missing spot/preemptible analysis for batch or fault-tolerant workloads
❌ Not capturing SLO trade-off opportunities
❌ Generating content without real discussion with user
❌ Not presenting C/R menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-04-tagging-anomaly-budget.md` to define cost allocation tagging standards, anomaly detection rules, and budget alert thresholds.

Remember: Do NOT proceed to step-04 until user explicitly selects 'C' from the C/R menu and content is saved!
