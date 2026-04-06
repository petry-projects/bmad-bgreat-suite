# Step 1: Cost Optimization Plan Workflow Initialization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between FinOps peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on initialization and setup only - don't look ahead to future steps
- 🚪 DETECT existing workflow state and handle continuation properly
- ⚠️ Do not estimate software delivery timelines or task durations — but do define cost governance timing (anomaly detection windows, budget review cadence, commitment renewal dates) as these are core FinOps outputs
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Share a concise rationale (assumptions, key trade-offs, and decisions) before taking any action
- 💾 Initialize document and update frontmatter
- 📖 Set up frontmatter `stepsCompleted: [1]` before loading next step
- 🚫 FORBIDDEN to load next step until setup is complete

## CONTEXT BOUNDARIES:

- Variables from workflow.md are available in memory
- Previous context = what's in output document + frontmatter
- Don't assume knowledge from other steps
- Input document discovery happens in this step

## YOUR TASK:

Initialize the Cost Optimization Plan workflow by detecting continuation state, discovering input documents, and setting up the document for collaborative FinOps planning.

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Workflow

First, check if the output document already exists:

- Look for existing `{bgr_artifacts}/cost-optimization-plan.md` (canonical path first)
- If not found, fall back to `{bgr_artifacts}/*cost-optim*.md` glob
- If multiple files match, STOP and ask the user which file to resume from (or whether to start fresh)
- If a match is found, read the selected file completely including frontmatter
- If no match is found, this is a fresh workflow

<critical>
**FILE OVERWRITE PROTECTION:** If an existing cost optimization plan is found, you MUST NOT overwrite it without explicit user confirmation. Always present the existing file and ask whether to resume, start fresh (with confirmation), or abort.
</critical>

### 2. Handle Continuation (If Document Exists)

If the document found above exists and has frontmatter with `stepsCompleted`:

- **STOP here** and load `./step-01b-continue.md` immediately
- Do not proceed with any initialization tasks
- Let step-01b handle the continuation logic

### 3. Check Production Readiness Checklist

Look for `{bgr_artifacts}/production-readiness-checklist.md`:

- If it exists, read it as-is to understand which other workflows have been completed
- Note any completed workflow plans — their key decisions and cross-references will be loaded in the discovery phase
- If it does not exist, note that we are starting without an existing checklist (do not create it here — the finalization step will handle that)

### 4. Load Context from Completed Workflow Artifacts

Check `{bgr_artifacts}/` for previously completed BGreat workflow outputs:

- `*capacity*.md` — **PRIMARY INPUT**: If completed, load growth projections, resource baselines, scaling approaches, reserved capacity strategy, and cost guardrails to anchor right-sizing and purchase strategy decisions
- `*infrastructure*.md` — If completed, load cloud provider choices, compute resource types, environment topology, and IaC tooling to inform tagging standards and commitment scope
- `*observability*.md` — If completed, load SLO targets and alerting strategy to inform cost-aware trade-off analysis and anomaly detection integration
- `*incident-response*.md` — If completed, load severity classification to inform cost anomaly escalation paths
- `*pipeline*.md` — If completed, load deployment strategy to understand ephemeral resource patterns and environment lifecycle

For each completed plan found:
- Load the document and extract key decisions relevant to cost optimization
- Surface these as context during the workflow (e.g., "The Capacity Plan specifies 3-year reserved instances for the API tier — this directly informs our purchase strategy step")
- Track loaded plans in frontmatter `crossWorkflowContext` array. If this workflow already has an entry in `crossWorkflowContext`, update it rather than adding a duplicate (upsert semantics).

### 5. Fresh Workflow Setup (If No Document)

If no document exists or no `stepsCompleted` in frontmatter:

#### A. Input Document Discovery

Discover and load context documents using smart discovery. Documents can be in the following locations:
- {bgr_artifacts}/**
- {project_knowledge}/**
- {project-root}/docs/**

Discovery order for each document type: try the exact path in `{bgr_artifacts}/` first (e.g., `{bgr_artifacts}/capacity-plan.md`), then fall back to a glob pattern (e.g., `*capacity*.md`) across the search locations, then check for a sharded folder (e.g., `*capacity*/index.md` which indicates sharded content across multiple files).

Try to discover the following:
- Capacity Plan (`*capacity*.md`) — **STRONGLY RECOMMENDED**
- Infrastructure Document (`*infrastructure*.md`)
- Observability Plan (`*observability*.md`)
- Architecture Document (`*architecture*.md`)
- Project Context (`**/project-context.md`)

<critical>Confirm what you have found with the user, along with asking if the user wants to provide anything else. Only after this confirmation will you proceed to follow the loading rules.</critical>

**Loading Rules:**

- Load ALL discovered files completely that the user confirmed or provided (no offset/limit)
- If there is a project context, whatever is relevant should try to be biased in the remainder of this whole workflow process
- For sharded folders, load ALL files to get complete picture, using the index first to potentially know the potential of each document
- index.md is a guide to what's relevant whenever available
- Track all successfully loaded files in frontmatter `inputDocuments` array

#### B. Validate Recommended Inputs

Before proceeding, verify we have the essential inputs:

**Capacity Plan Validation:**

- If no Capacity Plan found: "Cost optimization is most effective when grounded in actual resource usage and growth projections from a capacity plan. You can create one with the `bgr-3-create-capacity-plan` workflow. Proceeding without it means we'll rely on estimates — let me know if you have current billing reports or resource utilization data to share instead."
- Allow proceeding without it, but note the gap and ask for alternative data sources (cloud billing exports, resource utilization reports)

**Infrastructure Plan Validation:**

- If no Infrastructure document found: "The infrastructure plan defines resource types and environments that determine commitment scope and tagging taxonomy. Consider running `bgr-3-create-infrastructure` first, or provide current cloud architecture details now."
- Allow proceeding without it, but note the gap

**Other inputs that might exist:**

- Observability Plan: "Provides SLO targets needed for cost-aware trade-off analysis"
- Architecture Document: "Provides system topology and service inventory for right-sizing analysis"

#### C. Assess Current FinOps Maturity

Before diving into optimization tactics, establish the starting point:

**FinOps Maturity Levels (Crawl → Walk → Run):**

| Level | Characteristics |
|-------|----------------|
| Crawl | No cost visibility, reactive billing surprises, no tagging, no budgets |
| Walk | Basic cost reporting, partial tagging, some budgets, ad-hoc optimization |
| Run | Full cost visibility, automated anomaly detection, FinOps culture, continuous optimization |

Ask the user:

"Before we build the plan, let's establish where you are today on the FinOps maturity curve:

**Current cost visibility:**
- Do you have a cost dashboard or billing export set up?
- Can you break costs down by service, environment, or team today?

**Current governance:**
- Are there any budget alerts in place?
- Is there a tagging policy (even informal)?
- Who currently owns cloud cost decisions?

**Recent cost events:**
- Any unexpected billing spikes in the last 6 months?
- Do you know your current monthly cloud spend (ballpark)?

This context shapes where we focus — are we starting from scratch or refining an existing practice?"

#### D. Create Initial Document

<critical>
**FILE OVERWRITE PROTECTION:** Before creating the document, perform a final check that `{bgr_artifacts}/cost-optimization-plan.md` does not already exist. If it does, STOP and ask the user for confirmation before overwriting.
</critical>

Copy the template from `../templates/cost-optimization-plan-template.md` to `{bgr_artifacts}/cost-optimization-plan.md`

Immediately update frontmatter in `{bgr_artifacts}/cost-optimization-plan.md`:
- Set `stepsCompleted: [1]`
- Set `lastUpdated: {{current_date}}`

#### E. Complete Initialization and Report

Complete setup and report to user:

**Document Setup:**

- Created: `{bgr_artifacts}/cost-optimization-plan.md` from template
- Initialized frontmatter with workflow state

**Input Documents Discovered:**
Report what was found:
"Welcome {{user_name}}! I've set up your Cost Optimization Plan workspace.

**Documents Found:**

- Capacity Plan: {capacity plan files loaded or "None found - strongly recommended"}
- Infrastructure: {infrastructure files loaded or "None found - recommended"}
- Observability: {observability files loaded or "None found"}
- Architecture: {architecture files loaded or "None found"}
- Project context: {project_context_rules_count or "None found"}

**Files loaded:** {list of specific file names or "No additional documents found"}

Ready to begin cost optimization planning. Do you have any other documents (billing reports, cost exports, utilization data) you'd like me to include?

[C] Continue to resource right-sizing

## SUCCESS METRICS:

✅ Existing workflow detected and handed off to step-01b correctly
✅ Fresh workflow initialized with template and frontmatter
✅ Input documents discovered using exact-path-first, then glob fallback, then sharded folder check
✅ All discovered files tracked in frontmatter `inputDocuments`
✅ Capacity plan recommendation communicated
✅ FinOps maturity baseline assessed
✅ User confirmed document setup and can proceed
✅ Previously completed workflow artifacts discovered and context loaded
✅ File overwrite protection enforced — no silent overwrites

## FAILURE MODES:

❌ Proceeding with fresh initialization when existing workflow exists
❌ Not updating frontmatter with discovered input documents
❌ Creating document without proper template
❌ Not following the discovery order: exact path first, then glob fallback, then sharded folder check
❌ Not reporting what documents were found to user
❌ Overwriting an existing cost optimization plan without user confirmation
❌ Skipping the FinOps maturity baseline assessment

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects [C] to continue, only after ensuring all the template output has been created, then load `./step-02-resource-rightsizing.md` to analyze current resource utilization and define right-sizing recommendations.

Remember: Do NOT proceed to step-02 until user explicitly selects [C] from the menu and setup is confirmed!
