# Project Instructions

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# Add rules when Claude gets something wrong. Review monthly.
# ============================================================

## Project Context
# Describe your project in 2-3 lines so Claude understands what it's working on.
# Example:
# This is a SaaS dashboard for warehouse management. Stack: Next.js, Prisma, PostgreSQL.
# The app is deployed on Vercel. CI runs on GitHub Actions.


## Rules
# Every rule here should exist because of a real mistake.
# Format: bold rule name + one-line explanation.

### Verification
- **Verify before claiming done.** Before saying any code works, run it and show proof. If verification isn't possible, say so explicitly.
- **State the verification method first.** Before writing code, say how you'll test it. Then write. Then test.

### Planning
- **Use plan mode for complex changes.** Any task touching 3+ files or involving architectural decisions: plan first, get approval, then execute.
- **No guessing.** Don't fabricate URLs, API endpoints, file paths, or configuration values. If you don't know it, ask or look it up.

### Code Quality
- **No placeholder code.** Every function must do something real. No `// TODO: implement this` unless explicitly told to stub.
- **Prefer editing over creating.** Always check if a file exists before creating a new one. Edit existing files when possible.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait for confirmation, then continue.
- **Lead with the problem.** When asked "what do you think?" -- say what's wrong first, then what's strong.


## Environment
# Configure for your setup. Examples below.
# - **Platform:** macOS / Linux / Windows (Git Bash)
# - **Shell:** Use Unix syntax (forward slashes, /dev/null not NUL)
# - **Package manager:** npm / pnpm / yarn
# - **Python:** python3 (or python on Windows)
# - **Never auto-commit.** Only commit when explicitly asked.


## Skill Triggers
# Define when skills should activate. Claude reads the SKILL.md when triggered.
# Format: skill name -> trigger condition
#
# - `research` -> any task requiring external information, comparisons, or multi-source analysis
# - `debugging` -> anything broken or behaving unexpectedly
# - `proposal-writing` -> drafting client proposals, SOWs, or project pitches


## Key Files
# List files Claude should know about. Keeps it from searching blindly.
#
# | File | Purpose |
# |------|---------|
# | `memory/MEMORY.md` | Persistent state across sessions |
# | `src/config.ts` | App configuration |
# | `docs/architecture.md` | System design decisions |
