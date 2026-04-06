# Step 4: Tagging Standards, Anomaly Detection & Budget Alerts

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between FinOps peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on cost allocation tagging taxonomy, anomaly detection rules, and budget alert thresholds
- 🎯 ANALYZE infrastructure plan tagging conventions and align with FinOps cost allocation needs
- ⚠️ Do not estimate software delivery timelines or task durations — but do define cost governance timing (anomaly detection windows, budget review cadence) as these are core FinOps outputs
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Share a concise rationale (assumptions, key trade-offs, and decisions) before taking any action
- ⚠️ Present C/R menu after generating tagging, anomaly, and budget content
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3, 4]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to final validation
- **R (Revise)**: Discuss changes, refine the governance framework, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with right-sizing (step 2) and purchase strategy (step 3) is available
- Input documents already loaded are in memory
- Focus on defining how to track, allocate, and govern costs going forward
- Build on infrastructure plan tagging conventions if available — don't duplicate, extend

## YOUR TASK:

Define cost allocation tagging standards aligned with the infrastructure plan, anomaly detection rules for catching unexpected spend, and budget alert thresholds that give teams actionable cost governance.

## TAGGING, ANOMALY & BUDGET SEQUENCE:

### 1. Cost Allocation Tagging Standards

Cost tags are the foundation of FinOps — without them, you cannot attribute spend to teams, projects, or environments.

#### A. Assess Current Tagging State

Discuss with the user:

"Let's assess your current tagging posture:

**Current state:**
- Do you have any existing tagging standards or a tagging policy document?
- What percentage of your resources are currently tagged? (Approximate)
- Are there resources that cannot be tagged by your cloud provider? (Some managed services)
- Does the infrastructure plan define any tagging conventions we should align with?

**Cost visibility goals:**
- What cost breakdowns do you need? (By team, project, environment, feature, customer, cost center?)
- Who needs to see costs? (Engineering leads, finance, product managers?)
- Do you need chargeback or showback to business units?"

#### B. Define the Tagging Taxonomy

Define a minimum required tag set and extended tag set:

**Mandatory Tags (required on all resources):**

| Tag Key | Description | Example Values | Enforced By |
|---------|------------|---------------|------------|
| `Environment` | Deployment tier | production, staging, qa, development | Tag policy / IaC |
| `Team` | Owning team | platform, backend, frontend, data | Tag policy / IaC |
| `Project` | Product or project | api-gateway, data-pipeline, auth-service | Tag policy / IaC |
| `CostCenter` | Finance cost center code | CC-1234, CC-5678 | Tag policy / IaC |
| `ManagedBy` | IaC tool or manual | terraform, pulumi, manual | IaC convention |

**Recommended Tags (extend for better visibility):**

| Tag Key | Description | Example Values | When to Apply |
|---------|------------|---------------|--------------|
| `Service` | Microservice or component | user-service, payment-api | Always if applicable |
| `Owner` | On-call owner email/alias | platform-oncall@company.com | Production resources |
| `Criticality` | Business criticality | critical, high, medium, low | Production resources |
| `DataClassification` | Data sensitivity | public, internal, confidential | Storage resources |
| `ExpiryDate` | Auto-termination date | 2026-06-30 | Dev/test resources |

**Tagging Alignment with Infrastructure Plan:**

If an infrastructure plan exists and defines tagging conventions:
- Surface any existing tags already defined in the infrastructure plan
- Extend them with FinOps-specific tags rather than replacing
- Note any conflicts and resolve with the user

Discuss:
"I want to make sure our tagging taxonomy aligns with what's already defined in your infrastructure plan. Let's review what exists and extend it for cost allocation rather than create a competing standard."

#### C. Tagging Enforcement Strategy

Define how tags will be enforced:

**Prevention Controls (block untagged resources):**

- AWS: Service Control Policies (SCPs), Tag Policies, AWS Config rules
- GCP: Organization Policy constraints (e.g., `gcp-resourcemanager-tags-required`)
- Azure: Azure Policy with `deny` effect for untagged resources

**Detection Controls (identify and remediate untagged resources):**

- Cloud provider cost allocation reports showing untagged spend percentage
- Weekly untagged resource report shared with team leads
- IaC linting rules to enforce tags at code review time

**Tagging Enforcement Plan:**

| Control Type | Tool | Enforcement Level | Resources in Scope | Timeline |
|-------------|------|------------------|-------------------|---------|
| Prevention | {tool} | Hard block | New resources | Immediate |
| Detection | {tool} | Report + alert | All resources | Within 30 days |
| Remediation | Manual / IaC | Retroactive tagging | Existing untagged | Within 90 days |

#### D. Untagged Spend Baseline

Quantify the current tagging gap:

**Untagged Spend Analysis:**

| Category | Estimated Monthly Spend | % Untagged | Untagged Monthly Spend | Priority to Fix |
|---------|------------------------|-----------|----------------------|----------------|
| Compute | | | | |
| Storage | | | | |
| Database | | | | |
| Networking | | | | |
| Managed Services | | | | |
| **Total** | | | | |

### 2. Anomaly Detection Rules

Define rules to catch unexpected cost spikes before they become billing surprises.

#### A. Anomaly Detection Strategy

Discuss with the user:

"Cloud cost anomalies fall into a few categories — let's define rules for each:

**Spike anomalies:** A single day's spend is significantly higher than the rolling average
**Trend anomalies:** Costs are gradually drifting upward over days/weeks without a corresponding business reason
**Service anomalies:** A specific service's costs jump unexpectedly (data transfer spike, misconfigured autoscaling, runaway job)
**New service anomalies:** Spend appears for a service that wasn't in use before

What cloud cost anomaly detection capabilities does your cloud provider offer?
- AWS: AWS Cost Anomaly Detection (built-in, recommended)
- GCP: Cloud Billing budget alerts with forecast-based thresholds
- Azure: Azure Cost Management anomaly alerts

Are there any past billing surprises we should design rules around?"

#### B. Define Anomaly Detection Rules

**Monitor Scope:**

| Monitor Name | Scope | Dimension | Threshold Type | Alert Sensitivity | Notification Channel |
|-------------|-------|-----------|---------------|-----------------|-------------------|
| Total Account Spend | All services | Account | Absolute + % | High | {channel} |
| Per-Service Spike | Each service | Service | % above rolling avg | Medium | {channel} |
| Data Transfer Anomaly | Data transfer | Usage type | Absolute | High | {channel} |
| Spot/On-Demand Ratio Drift | Compute | Purchase type | % | Medium | {channel} |
| New Service Alert | Unused services | Service | Any spend | High | {channel} |
| Environment Spend Drift | Per environment | Tag: Environment | % | Medium | {channel} |

**Anomaly Thresholds:**

| Anomaly Type | Detection Window | Threshold | Severity | Auto-Response |
|-------------|----------------|---------|---------|--------------|
| Daily spend spike | 7-day rolling avg | > 30% above average | High | Alert + auto-investigation ticket |
| Weekly trend drift | 4-week rolling | > 15% week-over-week | Medium | Alert + team notification |
| Single service spike | 24-hour window | > 50% above 7-day avg | High | Alert + service team notification |
| New service first spend | Real-time | Any spend > $10 | Medium | Alert + owner validation |
| Data egress spike | 24-hour window | > 100% above 7-day avg | High | Alert + network team notification |

**Anomaly Response Playbook:**

For each anomaly severity, define the response:

| Severity | First Responder | Response SLA | Escalation Path | Auto-Remediation |
|---------|----------------|------------|----------------|----------------|
| High | On-call DevOps | 1 hour | DevOps lead → Director | Consider auto-shutdown for dev/test |
| Medium | Team lead | 4 hours | DevOps team | None |
| Low | Weekly review | 1 week | None | None |

Discuss:
"Some anomalies warrant automated responses (e.g., automatically stopping a runaway dev environment). Are there any scenarios where you'd want auto-remediation — with safeguards to prevent false positives?"

### 3. Budget Alert Thresholds

Define budgets and alert thresholds at multiple levels of granularity.

#### A. Budget Hierarchy

Work with the user to define budgets at each level:

"Budget alerts work best with a hierarchical approach — from top-down total budget down to individual service budgets. Let's define:

1. **Total cloud budget** — what's the overall monthly cloud spend target?
2. **Per-environment budgets** — how much should production vs non-production cost?
3. **Per-team budgets** — if you have chargeback/showback, what are team allocations?
4. **Per-service budgets** — for high-cost or fast-growing services

Do you have approved budget figures for this fiscal year I can work with, or should we estimate based on current spend?"

#### B. Define Budget Alert Configuration

**Budget Definitions:**

| Budget Name | Scope | Monthly Amount | Alert at 50% | Alert at 80% | Alert at 100% | Forecast Alert | Owner |
|------------|-------|---------------|-------------|-------------|--------------|---------------|-------|
| Total Cloud | All | ${amount} | Yes | Yes | Yes | Yes | CTO / Finance |
| Production | Environment=production | ${amount} | No | Yes | Yes | Yes | DevOps Lead |
| Non-Production | Environment≠production | ${amount} | Yes | Yes | Yes | No | DevOps Lead |
| Per Team | Team={team} | ${amount} | Yes | Yes | Yes | No | Team Lead |
| High-Risk Service | Service={name} | ${amount} | No | Yes | Yes | Yes | Service Owner |

**Forecast-Based Alerts:**

Forecast alerts fire when projected end-of-month spend will exceed budget, even if current spend hasn't hit the threshold yet.

| Budget | Forecast Alert Threshold | Action |
|--------|------------------------|--------|
| Total Cloud | Forecast > 90% of monthly budget | Notify Finance + DevOps lead |
| Production | Forecast > 95% of monthly budget | Notify DevOps lead |
| Non-Production | Forecast > 100% of monthly budget | Notify team + review optimization |

#### C. Budget Response Procedures

Define what happens when budgets are breached:

| Alert Level | Response | Owner | Timeline |
|------------|---------|-------|---------|
| 50% (first half of month) | Informational — verify on track | Team lead | Review within 3 days |
| 80% | Investigate and forecast end-of-month | DevOps + Finance | Review within 24 hours |
| 100% (forecast) | Cost review meeting, optimization sprint | Engineering lead + Finance | Immediate |
| 100% (actual) | Mandatory spend freeze on non-critical resources | Director | Same day |

### 4. FinOps Maturity Progression for Governance

Define how cost governance will mature over time:

**Crawl (Month 1-3):**
- Implement mandatory tag set on new resources
- Set up total account budget with 80% alert
- Enable cloud provider anomaly detection at account level
- Weekly cost review meeting

**Walk (Month 3-6):**
- Retroactive tagging campaign (target: 80% tagged spend)
- Per-team and per-environment budgets
- Service-level anomaly detection rules
- Monthly FinOps reporting to leadership

**Run (Month 6+):**
- Tag compliance > 95% with automated enforcement
- Real-time cost visibility dashboard per team
- Automated anomaly investigation tickets
- Quarterly FinOps review with business unit chargeback

### 5. Generate Tagging, Anomaly & Budget Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 4. Cost Allocation Tagging

### 4.1 Mandatory Tags

| Tag Key | Description | Example Values | Enforced By |
|---------|------------|---------------|------------|
{{mandatory_tag_entries}}

### 4.2 Recommended Tags

| Tag Key | Description | Example Values | When to Apply |
|---------|------------|---------------|--------------|
{{recommended_tag_entries}}

### 4.3 Tagging Enforcement

| Control Type | Tool | Enforcement Level | Resources in Scope |
|-------------|------|------------------|-------------------|
{{tagging_enforcement_entries}}

### 4.4 Untagged Spend Baseline

| Category | Monthly Spend | % Untagged | Untagged Monthly | Priority |
|---------|--------------|-----------|-----------------|---------|
{{untagged_spend_entries}}

**Tagging Coverage Target:** {{tagging_coverage_target}}% within {{tagging_timeline}}

## 5. Anomaly Detection

### 5.1 Anomaly Detection Rules

| Monitor Name | Scope | Threshold | Sensitivity | Alert Channel |
|-------------|-------|---------|------------|--------------|
{{anomaly_rule_entries}}

### 5.2 Anomaly Thresholds

| Anomaly Type | Detection Window | Threshold | Severity |
|-------------|----------------|---------|---------|
{{anomaly_threshold_entries}}

### 5.3 Anomaly Response Playbook

| Severity | Responder | SLA | Escalation |
|---------|----------|-----|----------|
{{anomaly_response_entries}}

## 6. Budget Alerts

### 6.1 Budget Definitions

| Budget Name | Scope | Monthly Amount | Alert at 80% | Alert at 100% | Forecast Alert |
|------------|-------|---------------|-------------|--------------|---------------|
{{budget_definition_entries}}

### 6.2 Forecast-Based Alerts

| Budget | Forecast Alert Threshold | Action |
|--------|------------------------|--------|
{{forecast_alert_entries}}

### 6.3 Budget Response Procedures

| Alert Level | Response | Owner | Timeline |
|------------|---------|-------|---------|
{{budget_response_entries}}

## 7. FinOps Maturity Roadmap

### Current Maturity: {{current_maturity_level}}

| Phase | Timeframe | Governance Milestones | Cost Visibility Target |
|-------|-----------|----------------------|----------------------|
| Crawl | {{crawl_timeframe}} | {{crawl_milestones}} | {{crawl_visibility}} |
| Walk | {{walk_timeframe}} | {{walk_milestones}} | {{walk_visibility}} |
| Run | {{run_timeframe}} | {{run_milestones}} | {{run_visibility}} |
```

### 6. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Tagging Standards, Anomaly Detection Rules, and Budget Alerts.

**Here's what I'll add to the cost optimization plan:**

[Show the complete markdown content from step 5]

**What would you like to do?**
[C] Continue - Save this governance framework and proceed to final validation
[R] Revise - Let's adjust specific sections before continuing"

### 7. Handle Menu Selection

#### If 'R' (Revise):

- Ask: "Which section would you like to revise? (Mandatory Tags / Recommended Tags / Tagging Enforcement / Anomaly Rules / Anomaly Thresholds / Budget Definitions / Budget Response / FinOps Maturity)"
- Discuss the specific section with the user
- Update the content based on feedback
- Return to C/R menu

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/cost-optimization-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3, 4]`
- Load `./step-05-validation.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 5.

## SUCCESS METRICS:

✅ Current tagging posture assessed and baseline established
✅ Mandatory tag set defined and aligned with infrastructure plan conventions
✅ Tagging enforcement strategy defined with prevention and detection controls
✅ Untagged spend quantified with remediation priority
✅ Anomaly detection rules defined for key spend categories
✅ Anomaly response playbook defined with severity levels and SLAs
✅ Budget hierarchy defined at account, environment, team, and service levels
✅ Forecast-based alerts configured to catch issues before end-of-month
✅ FinOps maturity roadmap defined (Crawl → Walk → Run)
✅ User confirmed all governance decisions through discussion
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Defining tags without checking for existing conventions in the infrastructure plan
❌ Setting anomaly thresholds without understanding normal spend variance
❌ Defining budgets without knowing approved budget figures
❌ Missing forecast-based alerts (react too late)
❌ No anomaly response playbook — alerts with no defined response are noise
❌ Not quantifying the untagged spend baseline
❌ Generating content without real discussion with user
❌ Not presenting C/R menu after content generation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-05-validation.md` to validate the complete cost optimization plan and generate the implementation roadmap.

Remember: Do NOT proceed to step-05 until user explicitly selects 'C' from the C/R menu and content is saved!
