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
# - `code-review` -> reviewing code for quality, security, and maintainability
# - `context-management` -> when context is getting large or sessions are long
# - `architecture-decision` -> any choice between technical approaches
# - `tool-integration` -> connecting external tools via MCP or APIs


## MCP Usage Protocol
# Rules for how Claude interacts with MCP servers and external tools.
#
# - **Prefer dedicated tools over shell commands.** Use Read instead of cat, Glob instead of find,
#   Grep instead of grep. Shell is for execution, not exploration.
# - **Check tool availability before assuming.** Not all MCP servers are always connected.
#   If a tool call fails, report the failure clearly -- don't retry silently.
# - **One action per tool call.** Don't chain unrelated operations in a single Bash command
#   when dedicated tools exist for each step.
# - **Respect rate limits and quotas.** External APIs have costs. Never loop API calls
#   without explicit approval.
# - **Log external interactions.** When calling external services, state what you're calling
#   and why before making the call.


## Memory Management
# Rules for how Claude uses and updates persistent memory.
#
# - **Read memory at session start.** Always check memory/MEMORY.md before your first response.
# - **Update memory at natural breakpoints.** When a decision is made, a pattern is learned,
#   or project status changes significantly.
# - **Keep memory factual.** Store decisions and outcomes, not opinions or speculation.
# - **Delete stale entries.** If something is no longer true, remove it. Outdated memory
#   is worse than no memory.
# - **Stay under 80 lines.** If memory grows beyond that, create topic files in memory/
#   and link to them from MEMORY.md.


## Context Window Hygiene
# - **Watch for context bloat.** If a session runs long, summarize progress and consider
#   compacting. Don't let accumulated context degrade response quality.
# - **Don't re-read files you've already read this session** unless they've changed.
# - **Offload large outputs.** Write long results to files instead of dumping them into
#   the conversation.
# - **Use subagents for parallel research.** If you need to search 3 things independently,
#   use parallel tool calls or agents -- don't sequentially search and bloat the main context.


## Self-Review Protocol
# Before claiming any task is complete:
# 1. Re-read the original request. Did you actually do what was asked?
# 2. Run verification (tests, linting, manual check). Show the output.
# 3. Check for regressions -- did your change break anything adjacent?
# 4. Ask: "Would a senior engineer approve this, or am I shipping something hacky?"
# If you can't verify, say: "I can't test this because [reason]."


## Key Files
# List files Claude should know about. Keeps it from searching blindly.
#
# | File | Purpose |
# |------|---------|
# | `memory/MEMORY.md` | Persistent state across sessions |
# | `src/config.ts` | App configuration |
# | `docs/architecture.md` | System design decisions |
