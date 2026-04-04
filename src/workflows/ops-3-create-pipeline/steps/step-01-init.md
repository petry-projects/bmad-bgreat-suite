# Step 1: Initialization

## MANDATORY EXECUTION RULES

📖 READ this entire file before taking any action.
🛑 FOLLOW the sequence below exactly — do not skip or reorder.
⏳ WAIT for user input when instructed before proceeding.

---

## 1.1 Check for Existing Pipeline Document

Scan `{ops_artifacts}` for any file matching `*pipeline*.md`.

- **If found:** Load `./step-01b-continue.md` instead and follow its instructions. STOP here.
- **If not found:** Continue to 1.2.

## 1.2 Discover Input Documents

Scan `{ops_artifacts}` and `{project_knowledge}` for these input documents:

| Document | Location Pattern | Required |
|----------|-----------------|----------|
| Architecture | `*architecture*.md` | ✅ Yes |
| Infrastructure | `*infrastructure*.md` | ⚠️ Recommended |
| PRD | `*prd*.md` | Optional |
| Project Context | `*project-context*.md` | Optional |

### Discovery Rules

- **Architecture document is REQUIRED.** If not found, inform the user and ask them to either provide one or run the architecture workflow first. Do NOT proceed without it.
- **Infrastructure plan is RECOMMENDED.** If not found, warn the user that pipeline decisions may need revisiting once infrastructure is defined.
- For each document found, read it and extract relevant context for pipeline planning.

## 1.3 Greet and Summarize

Greet the user by `{user_name}` and present:

- 📄 List of discovered input documents (found / not found)
- 📋 Brief summary of key architectural decisions that affect pipeline design
- 🔧 Any infrastructure constraints relevant to CI/CD

## 1.4 Create Document from Template

Create the pipeline plan document from `./templates/pipeline-template.md`:

- Set `createdDate` and `lastUpdated` to today's date
- Set `status: draft`
- Populate `inputDocuments` with discovered documents
- Save to `{ops_artifacts}/pipeline.md`

## 1.5 Confirm and Proceed

Ask the user if they are ready to begin designing the pipeline architecture.

---

**Menu:**

- **[C]ontinue** — Proceed to pipeline architecture design
- **[R]evise** — Adjust initialization or provide missing documents

🔄 **Before transitioning:** Update `stepsCompleted` in frontmatter to include `"step-01-init"`.

➡️ **NEXT:** `./step-02-pipeline-architecture.md`
