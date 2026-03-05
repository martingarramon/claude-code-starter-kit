# Claude Code Starter Kit

**A production-ready operating system for Claude Code -- skills, memory, and project structure that actually works.**

Most Claude Code setups are a single CLAUDE.md with a few lines of instructions. This kit gives you the architecture that emerges after months of daily production use: structured skills that trigger automatically, persistent memory that survives across sessions, and project rules that prevent Claude from making the same mistakes twice.

Drop it into your project. Customize it. Stop re-explaining things to Claude every session.

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/martingarramon/claude-code-starter-kit.git

# Run setup (creates structure in your target project)
cd claude-code-starter-kit
chmod +x setup.sh
./setup.sh /path/to/your/project
```

Or just copy the files manually -- there is no magic here, only structure.

---

## Architecture

Claude Code reads instructions from three layers. This kit gives you a working version of each.

```
your-project/
  CLAUDE.md              # Project rules -- what Claude must always do (and never do)
  memory/
    MEMORY.md            # Persistent state -- decisions, status, learned patterns
  skills/
    research/SKILL.md    # Activated when Claude needs to research something
    debugging/SKILL.md   # Activated when something breaks
    proposal-writing/    # Activated when drafting client proposals
      SKILL.md
  .claude/
    settings.json        # Claude Code configuration
```

**CLAUDE.md** is the constitution. It runs every turn. Keep it tight -- rules, not essays.

**Skills** are specialists. They activate only when relevant, so they can be detailed without bloating every interaction. Claude reads the SKILL.md when the skill triggers.

**Memory** is the persistent brain. Claude writes here during sessions and reads it at the start of the next one. Without memory, every session starts from zero.

These three layers work together: CLAUDE.md tells Claude *how to behave*, skills tell it *how to do specific jobs*, and memory tells it *what happened before*.

---

## What's Included

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Project instructions template with battle-tested rules |
| `skills/research/SKILL.md` | Parallel research with structured synthesis |
| `skills/debugging/SKILL.md` | Systematic root-cause debugging (no random patches) |
| `skills/proposal-writing/SKILL.md` | Client proposals: problem-first, specific, no fluff |
| `memory/MEMORY.md` | Memory template with sections for status, decisions, and patterns |
| `.claude/settings.json` | Minimal Claude Code configuration example |
| `setup.sh` | Copies the structure into your project |

---

## How to Customize

**CLAUDE.md**: Start with the template. Delete rules that don't apply. Add rules when Claude gets something wrong -- every rule should exist because of a real mistake. Review monthly and prune.

**Skills**: Each SKILL.md follows a pattern: context, triggers, steps, output format. Write new skills for any repeated workflow where you find yourself re-explaining the process.

**Memory**: The template gives you sections. The content comes from your project. Let Claude update MEMORY.md during sessions -- it will learn what to track over time.

---

## Design Principles

- **Rules come from mistakes.** Don't pre-optimize. Add rules when Claude gets something wrong.
- **Skills are specialists, not essays.** Each skill does one job. Keep them focused.
- **Memory is for state, not documentation.** Store decisions, status, and patterns. Not prose.
- **Less is more.** Claude reads your CLAUDE.md every turn. Every unnecessary line costs attention.

---

## Want More?

This starter kit covers the fundamentals. The full system behind it includes custom MCP server orchestration, connection registries with health checks and failover, multi-project memory architectures, automated verification protocols, and adversarial review modes.

For custom Claude Code environments, advanced MCP server setups, and AI workflow automation:

[LinkedIn](https://linkedin.com/in/martin-garramon) | martin@yulicreative.ai
