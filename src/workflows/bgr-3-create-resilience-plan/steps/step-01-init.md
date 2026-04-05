# Step 1: Resilience Testing Workflow Initialization

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between reliability peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on initialization and setup only - don't look ahead to future steps
- 🚪 DETECT existing workflow state and handle continuation properly
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- 💾 Initialize document and update frontmatter
- 📖 Set up frontmatter `stepsCompleted: [1]` before loading next step
- 🚫 FORBIDDEN to load next step until setup is complete

## CONTEXT BOUNDARIES:

- Variables from workflow.md are available in memory
- Previous context = what's in output document + frontmatter
- Don't assume knowledge from other steps
- Input document discovery happens in this step

## YOUR TASK:

Initialize the Resilience Testing workflow by detecting continuation state, discovering input documents, assessing resilience maturity, and setting up the document for collaborative resilience planning.

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Workflow

First, check if the output document already exists:

- Look for existing `{bgr_artifacts}/*resilience*.md`
- If exists, read the complete file(s) including frontmatter
- If not exists, this is a fresh workflow

### 2. Check Production Readiness Checklist

Look for `{bgr_artifacts}/production-readiness-checklist.md`:

- If it exists, read it to understand which other workflows have been completed
- Note any completed workflow plans — their key decisions and cross-references will be loaded in the discovery phase
- If it does not exist, create it from the shared template at `../../../templates/bgr-production-readiness-checklist-template.md` and save to `{bgr_artifacts}/production-readiness-checklist.md`

### 3. Load Context from Completed Workflow Artifacts

Check `{bgr_artifacts}/` for previously completed BGreat workflow outputs:

- `*observability*.md` — If completed, load SLOs, error budgets, alert thresholds, and golden signals to define steady-state hypotheses; resilience experiments must validate these exact metrics
- `*incident-response*.md` — If completed, load severity classification and escalation procedures to align experiment abort criteria and game day escalation paths
- `*infrastructure*.md` — If completed, load environment topology, service architecture, and infrastructure layers to identify failure injection points
- `*security*.md` — If completed, load STRIDE threat categories to map failure modes to security threat surfaces

For each completed plan found:
- Load the document and extract key decisions relevant to resilience testing planning
- Surface these as context during the workflow (e.g., "The Observability Plan defines a 99.9% availability SLO — this is the steady-state hypothesis we must validate")
- Track loaded plans in frontmatter `crossWorkflowContext` array. Each entry should include a `workflow` field identifying the source (e.g., 'observability', 'incident-response', 'infrastructure'). Before adding an entry, check if `crossWorkflowContext` already contains an entry with the same `workflow` field value -- if found, update it with the latest decisions; if not found, append a new entry (upsert by `workflow` field).

### 4. Handle Continuation (If Document Exists)

If the document from step 1 exists and has frontmatter with `stepsCompleted`:

- **STOP here** and load `./step-01b-continue.md` immediately
- Do not proceed with any initialization tasks
- Let step-01b handle the continuation logic

### 5. Fresh Workflow Setup (If No Document)

If no document exists or no `stepsCompleted` in frontmatter:

#### A. Input Document Discovery

Discover and load context documents using smart discovery. Documents can be in the following locations:
- `{bgr_artifacts}/**`
- `{project_knowledge}/**`
- `{project-root}/docs/**`

Also - when searching - documents can be a single markdown file, or a folder with an index and multiple files. For example, if searching for `*foo*.md` and not found, also search for a folder called `*foo*/index.md` (which indicates sharded content)

Try to discover the following:
- Observability Plan (`*observability*.md`) — **Required**: SLOs define steady-state
- Incident Response Plan (`*incident-response*.md`) — **Required**: Severity tiers anchor abort criteria
- Architecture Document (`*architecture*.md`)
- Infrastructure Document (`*infrastructure*.md`)
- Security Plan (`*security*.md`)
- Product Requirements Document (`*prd*.md`)
- Project Context (`**/project-context.md`)

<critical>Confirm what you have found with the user, along with asking if the user wants to provide anything else. Only after this confirmation will you proceed to follow the loading rules</critical>

**Loading Rules:**

- Load ALL discovered files completely that the user confirmed or provided (no offset/limit)
- If there is a project context, whatever is relevant should try to be biased in the remainder of this whole workflow process
- For sharded folders, load ALL files to get complete picture, using the index first to potentially know the potential of each document
- index.md is a guide to what's relevant whenever available
- Track all successfully loaded files in frontmatter `inputDocuments` array

#### B. Validate Required Inputs

Before proceeding, verify we have the essential inputs:

**Observability Plan Validation:**

- If no observability plan found: "A completed observability plan is strongly recommended — it defines the SLOs and golden signals that become the steady-state hypotheses for your experiments. You can create one with the `bgr-3-create-observability` workflow. Do you want to proceed without it or pause to create it first?"
- Allow proceeding without it, but document the gap clearly

**Incident Response Plan Validation:**

- If no incident response plan found: "An incident response plan is strongly recommended — experiment abort criteria and game day escalation paths should align with your severity classification. You can create one with the `bgr-3-create-incident-response` workflow. Do you want to proceed without it or pause to create it first?"
- Allow proceeding without it, but document the gap clearly

#### C. Assess Resilience Testing Maturity

Before creating the document, understand the team's current maturity level:

**Maturity Levels:**

| Level | Description |
|-------|-------------|
| **None** | No resilience testing in place; starting from scratch |
| **Basic** | Manual experiments occasionally run; no systematic approach |
| **Intermediate** | Defined steady-state, documented experiments, some game days scheduled |
| **Advanced** | Continuous automated experiments, mature game day program, production testing |

Ask user:
"Before we design your resilience testing plan, help me understand where you are today:
- Have you run any chaos experiments or resilience tests before?
- Do you have a defined steady-state hypothesis for any services?
- Have you conducted any game day exercises or tabletop drills?
- Do you have any automated resilience checks in your pipeline?"

Document the maturity assessment — it shapes how ambitious the plan should be and which areas to prioritize.

#### D. Create Initial Document

Copy the template from `../templates/resilience-plan-template.md` to `{bgr_artifacts}/resilience-plan.md`

#### E. Complete Initialization and Report

Complete setup and report to user:

"Welcome {{user_name}}! I've set up your Resilience Testing workspace.

**Documents Found:**

- Observability Plan: {observability files loaded or "None found - strongly recommended"}
- Incident Response Plan: {incident-response files loaded or "None found - strongly recommended"}
- Architecture: {architecture files loaded or "None found"}
- Infrastructure: {infrastructure files loaded or "None found"}
- Security Plan: {security files loaded or "None found"}
- PRD: {PRD files loaded or "None found"}
- Project context: {project_context_rules count of rules for AI agents found}

**Maturity Assessment:** {maturity level determined from discussion}

**Files loaded:** {list of specific file names or "No additional documents found"}

Ready to begin resilience testing planning. Do you have any other documents you'd like me to include?

[C] Continue to steady-state hypothesis definition

## SUCCESS METRICS:

✅ Existing workflow detected and handed off to step-01b correctly
✅ Fresh workflow initialized with template and frontmatter
✅ Input documents discovered and loaded using sharded-first logic
✅ All discovered files tracked in frontmatter `inputDocuments`
✅ Observability and incident response recommendations communicated
✅ Resilience maturity assessment completed and documented
✅ User confirmed document setup and can proceed
✅ Production readiness checklist found or created
✅ Previously completed workflow artifacts discovered and context loaded

## FAILURE MODES:

❌ Proceeding with fresh initialization when existing workflow exists
❌ Not updating frontmatter with discovered input documents
❌ Creating document without proper template
❌ Not checking sharded folders first before whole files
❌ Not reporting what documents were found to user
❌ Skipping the maturity assessment — it shapes the entire plan
❌ Not recommending observability and incident response plans when missing

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects [C] to continue, only after ensuring all the template output has been created, then load `./step-02-steady-state.md` to define steady-state hypotheses and critical user journeys.

Remember: Do NOT proceed to step-02 until user explicitly selects [C] from the menu and setup is confirmed!
