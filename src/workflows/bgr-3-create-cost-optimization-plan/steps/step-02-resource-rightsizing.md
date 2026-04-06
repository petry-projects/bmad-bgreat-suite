# Step 2: Resource Right-Sizing Analysis

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between FinOps peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on resource utilization analysis, waste identification, and right-sizing recommendations
- 🎯 ANALYZE loaded documents, don't assume or generate requirements
- ⚠️ Do not estimate software delivery timelines or task durations — but do define cost governance timing (anomaly detection windows, budget review cadence, commitment renewal dates) as these are core FinOps outputs
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Share a concise rationale (assumptions, key trade-offs, and decisions) before taking any action
- ⚠️ Present C/R menu after generating right-sizing recommendations
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the analysis, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document and frontmatter from step 1 are available
- Input documents already loaded are in memory (capacity plan, infrastructure, observability, etc.)
- Focus on understanding current resource usage and identifying over-provisioned or idle resources
- No purchase commitments yet — pure analysis and recommendation phase

## YOUR TASK:

Analyze current resource utilization across compute, storage, and data services to identify waste and produce actionable right-sizing recommendations that balance cost reduction with reliability targets.

## RIGHT-SIZING SEQUENCE:

### 1. Establish Resource Inventory

**From Capacity Plan (if available):**

- Extract current resource baselines per service (CPU, memory, storage, replicas)
- Note current utilization percentages at average and peak
- Identify any bottleneck resources already flagged
- Note growth projections that constrain downsizing decisions

**From Infrastructure Plan (if available):**

- Extract instance types and sizes per service and environment
- Identify compute tiers (production, staging, development)
- Note container resource requests/limits if Kubernetes
- Extract storage volume types and sizes

**From Architecture Document (if available):**

- Extract service inventory and deployment topology
- Identify stateful vs stateless services
- Note multi-region or multi-AZ deployments

Ask the user to fill gaps:

"Let's build a resource inventory. Based on what I've loaded:

**Current resources I can see:**
{summary from documents}

**What I need from you:**
- Current instance types/sizes for key services (if not in loaded docs)
- Average CPU and memory utilization over the last 30 days
- Any known idle or underutilized environments (dev, staging, QA)?
- Are there any resources you already know are oversized?"

### 2. Utilization Analysis by Resource Class

Work through each resource class systematically:

#### Compute Right-Sizing

For each service, analyze utilization and determine the appropriate action:

**Utilization Thresholds (industry standard):**

| Utilization Range | Classification | Action |
|------------------|---------------|--------|
| < 10% | Idle / candidate for termination | Terminate or consolidate |
| 10-40% | Significantly underutilized | Downsize 1-2 instance classes |
| 40-60% | Lightly utilized | Consider downsizing 1 class |
| 60-80% | Well utilized | Right-sized — monitor for growth |
| > 80% | Potentially undersized | Review — may need scale-out |

**Per-Service Right-Sizing Assessment:**

| Service | Current Size | Avg CPU% | Avg Mem% | Peak CPU% | Peak Mem% | Recommendation | Estimated Savings |
|---------|-------------|---------|---------|---------|---------|---------------|-----------------|

Discuss with the user:

"For each service, I want to understand the headroom you're comfortable with. Some considerations:
- What's the latency sensitivity? (low-latency services need more headroom)
- Does this service have burst patterns? (bursty services need different sizing than steady-state)
- Any memory pressure events or OOM kills in the last 90 days?
- Are SLO targets giving us flexibility to right-size aggressively?"

#### Storage Right-Sizing

- Identify over-provisioned volumes (provisioned IOPS vs actual IOPS, provisioned throughput vs actual)
- Identify snapshots older than retention policy
- Identify unused EBS/persistent disk volumes (detached or attached but unread)
- Identify storage class mismatches (hot storage for cold data)

**Storage Inventory:**

| Volume/Store | Type | Provisioned | Actual Usage | IOPS Provisioned | IOPS Actual | Recommendation | Savings |
|-------------|------|------------|-------------|-----------------|------------|---------------|---------|

#### Database Right-Sizing

- Analyze RDS/Cloud SQL/Cosmos DB instance sizes vs query load
- Review read replica utilization — are replicas actually serving read traffic?
- Identify development/test databases that could use smaller instances or serverless options
- Review ElastiCache/Memorystore cluster sizing vs cache hit rates

**Database Assessment:**

| Database | Engine | Current Class | Avg CPU% | Connections Used% | Cache Hit Rate | Recommendation | Savings |
|---------|--------|--------------|---------|-----------------|--------------|---------------|---------|

### 3. Idle and Orphaned Resource Identification

Identify resources that can be terminated outright:

**Common Idle Resource Patterns:**

- Stopped EC2/VM instances still paying for attached EBS volumes
- Unattached elastic IPs / static IPs (billed even when idle)
- Old AMIs/machine images and associated snapshots
- Unused load balancers with no registered targets
- Orphaned network interfaces and NAT gateways
- Unused Elastic IPs, reserved IPs, and static public IPs
- Old log groups / data streams without retention policies
- Development environments left running over weekends or off-hours

Discuss with the user:

"Are there any environments (dev, staging, QA) that only need to run during business hours? Auto-scheduling these could cut 60-70% of those costs without any right-sizing needed."

**Idle Resources Found:**

| Resource | Type | Region | Monthly Cost | Status | Action | Owner |
|---------|------|--------|-------------|--------|--------|-------|

### 4. Environment-Tier Cost Optimization

Non-production environments are often the highest-ROI optimization target:

**Environment Tiering Strategy:**

| Environment | Strategy | Schedule | Estimated Reduction |
|------------|---------|---------|-------------------|
| Production | Right-size only, preserve headroom | Always on | 10-20% |
| Staging | Right-size + schedule off-hours | Business hours only | 40-60% |
| QA/Test | Right-size + schedule + spot/preemptible | On-demand with scheduler | 60-80% |
| Development | Right-size aggressively + spot | On-demand | 70-85% |

### 5. FinOps Maturity Context for Right-Sizing

Align recommendations to current maturity level assessed in step 1:

**If Crawl maturity:** Focus on the highest-impact, lowest-risk wins first:
1. Terminate confirmed idle/orphaned resources (zero reliability risk)
2. Right-size dev/staging environments (no production risk)
3. Apply auto-scheduling to non-production

**If Walk maturity:** Add production right-sizing with proper validation:
1. Right-size production services one at a time with monitoring
2. Use capacity plan projections to right-size with growth headroom
3. Implement environment scheduling automation

**If Run maturity:** Continuous right-sizing with automation:
1. Automated right-sizing recommendations via cloud provider tools (AWS Compute Optimizer, GCP Recommender)
2. Scheduled review cycles for right-sizing drift
3. Integration with deployment pipelines to prevent over-provisioning

### 6. Savings Impact Summary

Summarize the optimization opportunity:

**Total Right-Sizing Opportunity:**

| Category | Current Monthly Cost | Projected Monthly After | Monthly Savings | Annual Savings | Confidence |
|---------|--------------------|-----------------------|----------------|---------------|-----------|
| Idle/Orphaned | | | | | High |
| Compute right-sizing | | | | | Medium |
| Storage right-sizing | | | | | High |
| Database right-sizing | | | | | Medium |
| Environment scheduling | | | | | High |
| **Total** | | | | | |

### 7. Generate Right-Sizing Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 2. Resource Right-Sizing Analysis

### 2.1 Resource Inventory

| Service | Resource Type | Current Size | Avg CPU% | Avg Mem% | Peak CPU% | Peak Mem% |
|---------|-------------|-------------|---------|---------|---------|---------|
{{resource_inventory_entries}}

### 2.2 Compute Right-Sizing Recommendations

| Service | Current Size | Recommended Size | Avg Utilization | Rationale | Monthly Savings | Priority | Owner |
|---------|-------------|-----------------|----------------|-----------|----------------|----------|-------|
{{compute_rightsizing_entries}}

### 2.3 Storage Right-Sizing Recommendations

| Volume/Store | Current Config | Recommended Config | Actual Usage | Monthly Savings | Priority |
|-------------|--------------|-------------------|-------------|----------------|----------|
{{storage_rightsizing_entries}}

### 2.4 Database Right-Sizing Recommendations

| Database | Current Class | Recommended Class | Rationale | Monthly Savings | Priority |
|---------|--------------|------------------|-----------|----------------|----------|
{{database_rightsizing_entries}}

### 2.5 Idle and Orphaned Resources

| Resource | Type | Region | Monthly Cost | Action | Owner |
|---------|------|--------|-------------|--------|-------|
{{idle_resource_entries}}

### 2.6 Environment Scheduling

| Environment | Current State | Recommended Schedule | Estimated Monthly Savings |
|------------|-------------|---------------------|--------------------------|
{{environment_scheduling_entries}}

### 2.7 Right-Sizing Savings Summary

| Category | Monthly Savings | Annual Savings | Confidence | Implementation Risk |
|---------|----------------|---------------|-----------|-------------------|
{{savings_summary_entries}}

**Total Identified Opportunity:** {{total_monthly_savings}}/month ({{total_annual_savings}}/year)
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Resource Right-Sizing Analysis.

**Here's what I'll add to the cost optimization plan:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this analysis and proceed to purchase strategy
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/cost-optimization-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2]`
- Load `./step-03-purchase-strategy.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 7.

## SUCCESS METRICS:

✅ Resource inventory built from loaded documents and user input
✅ Compute, storage, and database utilization analyzed per service
✅ Idle and orphaned resources identified
✅ Environment scheduling opportunities identified
✅ Right-sizing recommendations tied to maturity level
✅ Savings impact summarized with confidence levels
✅ User confirmation of all right-sizing assumptions
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Recommending right-sizing without understanding SLO constraints
❌ Not distinguishing between production and non-production risk profiles
❌ Missing idle/orphaned resource analysis
❌ Not quantifying savings with confidence levels
❌ Generating recommendations without discussing with user
❌ Not presenting C/R menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-03-purchase-strategy.md` to define reserved instance, spot instance, and savings plan purchase strategy.

Remember: Do NOT proceed to step-03 until user explicitly selects 'C' from the C/R menu and content is saved!
