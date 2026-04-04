# Step 1: Initialize Security Plan

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between security peers
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

Initialize the Security Plan workflow by detecting continuation state, discovering input documents, and setting up the document for collaborative security architecture planning.

## INITIALIZATION SEQUENCE:

### 1. Check for Existing Workflow

First, check if the output document already exists:

- Look for existing {bgr_artifacts}/`*security*.md`
- If exists, read the complete file(s) including frontmatter
- If not exists, this is a fresh workflow

### 2. Handle Continuation (If Document Exists)

If the document exists and has frontmatter with `stepsCompleted`:

- **STOP here** and load `./step-01b-continue.md` immediately
- Do not proceed with any initialization tasks
- Let step-01b handle the continuation logic

### 3. Fresh Workflow Setup (If No Document)

If no document exists or no `stepsCompleted` in frontmatter:

#### A. Input Document Discovery

Discover and load context documents using smart discovery. Documents can be in the following locations:
- {bgr_artifacts}/**
- {project_knowledge}/**
- {project-root}/docs/**

Also - when searching - documents can be a single markdown file, or a folder with an index and multiple files. For example, if searching for `*foo*.md` and not found, also search for a folder called *foo*/index.md (which indicates sharded content)

Try to discover the following:
- Architecture Document (`*architecture*.md`)
- Product Requirements Document (`*prd*.md`)
- Infrastructure Document (`*infrastructure*.md`)
- Observability Document (`*observability*.md`)
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

**Architecture Validation:**

- If no Architecture document found: "Security planning requires architecture decisions. Please run the architecture workflow first."
- Do NOT proceed without an Architecture document

**Other Input that might exist:**

- Infrastructure Document: "Provides infrastructure context for network security and deployment hardening"
- Observability Document: "Provides monitoring context for security event detection and SIEM integration"
- PRD: "Provides business context for data classification and compliance requirements"

#### C. Create Initial Document

Copy the template from `../templates/security-plan-template.md` to `{bgr_artifacts}/security-plan.md`

#### D. Complete Initialization and Report

Complete setup and report to user:

**Document Setup:**

- Created: `{bgr_artifacts}/security-plan.md` from template
- Initialized frontmatter with workflow state

**Input Documents Discovered:**
Report what was found:
"Welcome {{user_name}}! I've set up your Security Plan workspace for {{project_name}}.

**Documents Found:**

- Architecture: {number of architecture files loaded or "None found - REQUIRED"}
- Infrastructure: {number of infrastructure files loaded or "None found"}
- Observability: {number of observability files loaded or "None found"}
- PRD: {number of PRD files loaded or "None found"}
- Project context: {project_context_rules count of rules for AI agents found}

**Files loaded:** {list of specific file names or "No additional documents found"}

Ready to begin security planning. Here's what we'll build together:

**The 5-Step Security Planning Process:**
1. **Threat Modeling** — Identify assets, trust boundaries, data flows, and apply STRIDE analysis to uncover threats
2. **Security Controls** — Design zero-trust architecture, network segmentation, application security, and API protection
3. **Identity & Data Protection** — Define IAM strategy, secret management, data classification, and encryption standards
4. **Supply Chain Security** — Establish dependency management, SBOM generation, container security, and CI/CD pipeline hardening
5. **Validation** — Run quality gates, generate implementation backlog, and finalize the security plan

Do you have any other documents you'd like me to include?

[C] Continue to threat modeling

## SUCCESS METRICS:

✅ Existing workflow detected and handed off to step-01b correctly
✅ Fresh workflow initialized with template and frontmatter
✅ Input documents discovered and loaded using sharded-first logic
✅ All discovered files tracked in frontmatter `inputDocuments`
✅ Architecture requirement validated and communicated
✅ User confirmed document setup and can proceed
✅ 5-step security planning process clearly presented

## FAILURE MODES:

❌ Proceeding with fresh initialization when existing workflow exists
❌ Not updating frontmatter with discovered input documents
❌ Creating document without proper template
❌ Not checking sharded folders first before whole files
❌ Not reporting what documents were found to user
❌ Proceeding without validating Architecture requirement

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects [C] to continue, only after ensuring all the template output has been created, then load `./step-02-threat-model.md` to begin threat modeling and STRIDE analysis.

Remember: Do NOT proceed to step-02 until user explicitly selects [C] from the menu and setup is confirmed!
