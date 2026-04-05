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

Initialize the Resilience Testing Plan workflow by detecting continuation state, discovering input documents, assessing maturity, and setting up the document for collaborative resilience planning.

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Workflow

First, check if the output document already exists:

- Look for existing `{bgr_artifacts}/resilience-plan.md` (canonical path first)
- If not found, fall back to `{bgr_artifacts}/*resilience*.md` glob
- If multiple files match, STOP and ask the user which file to resume from (or whether to start fresh)
- If a match is found, read the selected file completely including frontmatter
- If no match is found, this is a fresh workflow

<critical>
**FILE OVERWRITE PROTECTION:** If an existing resilience plan is found, you MUST NOT overwrite it without explicit user confirmation. Always present the existing file and ask whether to resume, start fresh (with confirmation), or abort.
</critical>

### 2. Handle Continuation (If Document Exists)

If the document found above exists and has frontmatter with `stepsCompleted`:

- **STOP here** and load `./step-01b-continue.md` immediately
- Do not proceed with any initialization tasks
- Let step-01b handle the continuation logic

### 3. Check Production Readiness Checklist

Look for `{bgr_artifacts}/production-readiness-checklist.md`:

- If it exists, read it to understand which other workflows have been completed
- Note any completed workflow plans — their key decisions and cross-references will be loaded in the discovery phase
- If it does not exist, create it from the shared template at `../../../templates/bgr-production-readiness-checklist-template.md` and save to `{bgr_artifacts}/production-readiness-checklist.md`

### 4. Load Context from Completed Workflow Artifacts

Check `{bgr_artifacts}/` for previously completed BGreat workflow outputs:

- `*observability*.md` — If completed, load SLO targets, golden signal metrics, and alert definitions to use as baseline steady-state measurements for resilience experiments
- `*incident-response*.md` — If completed, load severity classification and escalation paths to align experiment abort criteria and blast radius controls with incident response procedures
- `*infrastructure*.md` — If completed, load environment topology, cloud provider choices, and service architecture to identify failure injection points across infrastructure layers
- `*security-plan*.md` — If completed, load STRIDE threat categories to map failure modes to security threat categories during failure scenario design

For each completed plan found:
- Load the document and extract key decisions relevant to resilience planning
- Surface these as context during the workflow (e.g., "The Observability Plan defines SLOs for the checkout service — these become steady-state hypotheses we can validate through chaos experiments")
- Track loaded plans in frontmatter `crossWorkflowContext` array. Each entry should include a `workflow` field identifying the source. Before adding an entry, check if `crossWorkflowContext` already contains an entry with the same `workflow` field value — if found, update it; if not found, append a new entry (upsert by `workflow` field).

### 5. Fresh Workflow Setup (If No Document)

If no document exists or no `stepsCompleted` in frontmatter:

#### A. Input Document Discovery

Discover and load context documents using smart discovery. Documents can be in the following locations:
- {bgr_artifacts}/**
- {project_knowledge}/**
- {project-root}/docs/**

Also — when searching — documents can be a single markdown file, or a folder with an index and multiple files. For example, if searching for `*foo*.md` and not found, also search for a folder called *foo*/index.md (which indicates sharded content).

Try to discover the following:
- Architecture Document (`*architecture*.md`)
- Observability Plan (`*observability*.md`) — **strongly recommended**: provides SLOs for steady-state definition
- Incident Response Plan (`*incident-response*.md`) — **strongly recommended**: provides severity classification for abort criteria
- Infrastructure Plan (`*infrastructure*.md`) — provides environment topology for failure injection points
- Security Plan (`*security-plan*.md`) — optional: provides STRIDE threat categories for failure mapping
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

- If no observability plan found: "An observability plan is strongly recommended for resilience testing — it provides the SLOs and metrics that define your steady-state hypothesis. Without it, we'll need to define baseline metrics from scratch. You can create one with the `bgr-3-create-observability` workflow."
- Allow proceeding without it, but note the gap

**Incident Response Plan Validation:**

- If no incident response plan found: "An incident response plan is strongly recommended — it provides severity classification and escalation paths that define experiment abort criteria and blast radius controls. You can create one with the `bgr-3-create-incident-response` workflow."
- Allow proceeding without it, but note the gap

**Architecture Document Validation:**

- If no architecture document found: "An architecture document is recommended. It helps identify services, dependencies, and failure boundaries for experiment design. Please consider creating one first or providing the file path."
- Allow proceeding without it, but note the gap

#### C. Assess Resilience Testing Maturity

Before creating the document, assess the team's current resilience testing maturity. Ask the user:

"Before we begin, let me understand where your team is today with resilience testing:

**Which best describes your current state?**
- **[N] None** — No formal resilience testing. Failures are discovered in production by users.
- **[B] Basic** — Some ad-hoc manual failure tests. No structured approach or documentation.
- **[I] Intermediate** — Periodic chaos experiments in staging. Some steady-state definitions. Limited production testing.
- **[A] Advanced** — Regular chaos experiments in production with defined steady-state hypotheses, automated experiments, and a game day cadence.

This helps me tailor the plan to build on what you have rather than starting from zero."

Record the maturity level in frontmatter as `maturityLevel: none | basic | intermediate | advanced`.

#### D. Create Initial Document

<critical>
**FILE OVERWRITE PROTECTION:** Before creating the document, perform a final check that `{bgr_artifacts}/resilience-plan.md` does not already exist. If it does, STOP and ask the user for confirmation before overwriting.
</critical>

Copy the template from `../templates/resilience-plan-template.md` to `{bgr_artifacts}/resilience-plan.md`

#### E. Complete Initialization and Report

Complete setup and report to user:

**Document Setup:**

- Created: `{bgr_artifacts}/resilience-plan.md` from template
- Initialized frontmatter with workflow state

**Input Documents Discovered:**
Report what was found:
"Welcome {{user_name}}! I've set up your Resilience Testing workspace.

**Documents Found:**

- Architecture: {architecture files loaded or "None found - recommended"}
- Observability Plan: {observability files loaded or "None found - strongly recommended"}
- Incident Response Plan: {incident response files loaded or "None found - strongly recommended"}
- Infrastructure: {infrastructure files loaded or "None found"}
- Security Plan: {security plan files loaded or "None found"}
- PRD: {PRD files loaded or "None found"}
- Project context: {project_context_rules count of rules for AI agents found}

**Resilience Maturity Level:** {assessed maturity level}

**Files loaded:** {list of specific file names or "No additional documents found"}

Ready to begin resilience planning. Do you have any other documents you'd like me to include?

[C] Continue to steady-state hypothesis definition

## SUCCESS METRICS:

✅ Existing workflow detected and handed off to step-01b correctly
✅ Fresh workflow initialized with template and frontmatter
✅ Input documents discovered and loaded using sharded-first logic
✅ All discovered files tracked in frontmatter `inputDocuments`
✅ Observability and incident response document recommendations communicated
✅ Resilience maturity assessed and recorded in frontmatter
✅ User confirmed document setup and can proceed
✅ Production readiness checklist found or created
✅ Previously completed workflow artifacts discovered and context loaded
✅ File overwrite protection enforced — no silent overwrites

## FAILURE MODES:

❌ Proceeding with fresh initialization when existing workflow exists
❌ Not updating frontmatter with discovered input documents
❌ Creating document without proper template
❌ Not checking sharded folders first before whole files
❌ Not reporting what documents were found to user
❌ Not assessing resilience maturity before proceeding
❌ Overwriting an existing resilience plan without user confirmation

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects [C] to continue, only after ensuring all the template output has been created, then load `./step-02-steady-state.md` to define steady-state hypotheses and baseline metrics.

Remember: Do NOT proceed to step-02 until user explicitly selects [C] from the menu and setup is confirmed!
