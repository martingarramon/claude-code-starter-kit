<div align="center">

# Claude Code Starter Kit

**Production-extracted architecture for Claude Code — stop losing context, stop repeating yourself, start shipping.**

[![MIT License](https://img.shields.io/github/license/martingarramon/claude-code-starter-kit?style=flat-square)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/martingarramon/claude-code-starter-kit?style=social)](https://github.com/martingarramon/claude-code-starter-kit/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/martingarramon/claude-code-starter-kit?style=social)](https://github.com/martingarramon/claude-code-starter-kit/network/members)
[![Last Commit](https://img.shields.io/github/last-commit/martingarramon/claude-code-starter-kit?style=flat-square)](https://github.com/martingarramon/claude-code-starter-kit/commits/main)

[Quick Start](#quick-start) · [Architecture](#architecture) · [Skills](#skills) · [Examples](#examples) · [Contributing](#contributing)

</div>

---

## The Problem

Claude Code is powerful, but without structure it:
- Forgets your project rules every session
- Skips verification and ships broken code
- Wastes context window on things it already knows
- Gives inconsistent results across sessions

This starter kit fixes all of that.

## What This Is

A **3-layer configuration architecture** extracted from months of daily production use with Claude Code. Every rule exists because Claude got it wrong — not because it seemed like a good idea.

```
┌─────────────────────────────────────┐
│           CLAUDE.md                 │  ← Constitution: runs every turn
│   Rules, verification, planning     │
├─────────────────────────────────────┤
│           Skills/                   │  ← Specialists: activated on demand
│   Debugging, code review, ADRs...  │
├─────────────────────────────────────┤
│           Memory/                   │  ← Persistence: survives sessions
│   Decisions, patterns, commands     │
└─────────────────────────────────────┘
```

## Who Is This For

- **Solo developers** using Claude Code who want consistent, reliable results
- **Teams** standardizing how Claude Code behaves across projects
- **Power users** who've hit the limits of ad-hoc prompting and want structure
- **Anyone migrating from Cursor/Copilot** who wants to replicate their rules in Claude Code

Not for: building Claude API applications (use the SDK for that). This is for configuring the Claude Code CLI itself.

## Quick Start

```bash
git clone https://github.com/martingarramon/claude-code-starter-kit.git
cd claude-code-starter-kit
chmod +x setup.sh && ./setup.sh
```

That's it. The setup script creates the directory structure and copies templates. Non-destructive — won't overwrite existing files.

## Architecture

### Layer 1: CLAUDE.md — The Constitution

The `CLAUDE.md` file runs on every Claude Code interaction. It contains:

- **Verification rules** — "Run before claiming done. State the method first."
- **Planning rules** — "3+ files = plan mode. No guessing."
- **Code quality rules** — "No placeholders. Prefer editing existing files."
- **Communication rules** — "One step at a time. Lead with problems."
- **Environment config** — Shell, OS, paths, tools
- **Context hygiene** — When to compact, what to load

### Layer 2: Skills — Specialist Workflows

Twelve battle-tested workflows that activate on demand:

| Skill | What it does | When to use |
|-------|-------------|-------------|
| `debugging` | Systematic root-cause analysis | Anything breaks or behaves unexpectedly |
| `code-review` | 5-step structured review | Before merging or after major changes |
| `architecture-decision` | ADR process with max 3 options | Technical choices with tradeoffs |
| `research` | Multi-source decomposition | Complex questions needing investigation |
| `context-management` | Context window hygiene | Long sessions approaching limits |
| `tool-integration` | MCP server workflow | Building or connecting external tools |
| `proposal-writing` | Client-first structure | Scoping work for clients |
| `testing` | AI-driven TDD strategy | Starting features, ensuring reliability |
| `deployment` | CI/CD pipeline design | Setting up automated workflows |
| `migration` | AI tool transition guide | Switching from Cursor/Copilot |
| `performance` | Profiling and optimization | Slow code, bottlenecks |
| `security-audit` | Proactive vulnerability scanning | Before deployments, periodic reviews |

### Layer 3: Memory — Persistent State

The `memory/MEMORY.md` file persists across sessions:
- Key decisions with rationale
- Patterns learned from mistakes
- Frequently used commands
- Project status

### Supporting Infrastructure

- **Hooks** — Shell scripts that run at session start, after tool use, on errors
- **Examples** — Stack-specific CLAUDE.md templates, MCP server reference
- **Permissions** — `.claude/settings.json` with safe defaults (deny `rm -rf`, deny `force push`)

## Examples

### Stack Templates

Ready-to-use CLAUDE.md configurations for specific tech stacks:

| Template | Stack |
|----------|-------|
| `python-api.md` | FastAPI + SQLAlchemy + PostgreSQL |
| `saas-webapp.md` | Next.js 14 + Prisma + PostgreSQL |
| `nodejs-typescript-api.md` | Express/NestJS + TypeScript + PostgreSQL |
| `react-frontend.md` | React + Vite + TypeScript |
| `go-microservice.md` | Go + Gin + Redis |
| `data-science.md` | Python + Jupyter + Pandas + scikit-learn |
| `serverless.md` | AWS Lambda + SAM + Python/Node.js |

### Hook Examples

| Hook | Type | Purpose |
|------|------|---------|
| `session-start.sh` | Session Start | Git status, last commit, memory reminder |
| `post-tool-use.sh` | PostToolUse | Error logging, last 50 entries |
| `pre-tool-use-security.sh` | PreToolUse | Block dangerous commands before execution |
| `notification-slack.sh` | Notification | Alert team on deployments or errors |
| `session-stop-cleanup.sh` | Stop | Cleanup temp files, generate session summary |
| `post-tool-use-autocorrect.sh` | PostToolUse | Auto-lint/format after file creation |
| `subagent-performance.sh` | SubagentStop | Log sub-agent duration and outcomes |

### MCP Server

A working reference implementation (140 lines, Python) for building your own MCP tools. Includes a 5-minute setup guide.

## Design Principles

1. **Rules from mistakes, not pre-optimization** — Every rule exists because Claude got it wrong
2. **Progressive context loading** — Load what you need, when you need it
3. **Skills over prompts** — Structured workflows beat ad-hoc instructions
4. **Verification before completion** — Always run it, never assume it works
5. **Memory is cheap, context is expensive** — Persist decisions, load on demand

## Comparison

| Feature | This Kit | Bare Claude Code | .cursorrules | Ad-hoc Prompts |
|---------|----------|-----------------|--------------|----------------|
| Persistent rules | CLAUDE.md constitution | None | Rules file | Copy-paste each time |
| Specialist workflows | 12 battle-tested skills | Manual each time | Community rules | Reinvent every session |
| Cross-session memory | MEMORY.md system | None | None | None |
| Verification protocol | Built-in rules | Hope for the best | Varies | None |
| Hook automation | 7 hook examples (all API types) | Manual setup | N/A | N/A |
| Stack templates | 7 ready-to-use | Start from scratch | Some available | N/A |
| MCP server reference | Working example | Docs only | N/A | N/A |

## Roadmap

- [x] ~~More stack templates~~ — 7 templates covering Node.js, React, Go, Python, serverless
- [x] ~~More hook examples~~ — 7 hooks covering all Claude Code API types
- [x] ~~Additional skills~~ — 12 skills including testing, deployment, migration, performance, security
- [ ] Community skill directory (share and discover skills)
- [ ] Self-learning patterns (auto-improve CLAUDE.md from outcomes)
- [ ] MCP ecosystem browser (discover community MCP servers)
- [ ] Team collaboration guide

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. We welcome:
- New skills and stack templates
- Hook examples for different workflows
- Bug reports and improvements
- Documentation fixes

## License

MIT — see [LICENSE](LICENSE).

## Built By

[Martin Garramon](https://github.com/martingarramon) at [Yuli Creative](https://yulicreative.ai) — AI automation consulting for dev teams and SaaS founders.

Need a custom Claude Code setup for your team? [Get in touch](https://yulicreative.ai).
