# Project Instructions — SaaS Web App
# Stack: Next.js 14 (App Router) + Prisma + PostgreSQL + TypeScript
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: Next.js 14 (App Router), TypeScript, Prisma ORM, PostgreSQL, Tailwind CSS.
Deployed on Vercel. CI runs on GitHub Actions. DB hosted on [Supabase / Railway / RDS].

## Rules

### Verification
- **Verify before claiming done.** Run `npm run build` and show the output. No silent "it works."
- **State the verification method first.** Before writing a new API route, say how you'll test it.
- **Type errors are real errors.** `tsc --noEmit` must pass. Never use `// @ts-ignore` without explaining why.

### Planning
- **Use plan mode for changes touching 3+ files.** Schema migration + route + component = plan first.
- **No guessing.** Don't fabricate Prisma field names, Next.js config options, or env variable names. Look them up.
- **Migration before model.** When changing the Prisma schema, generate and review the migration SQL before running it.

### Code Quality
- **No `any`.** Use proper TypeScript types. If you don't know the type, say so.
- **No placeholder code.** Every function must do something real.
- **Server components by default.** Only add `"use client"` when you need browser APIs or interactivity.
- **Prefer editing over creating.** Check if a component or utility already exists before creating a new one.

### Database
- **Never run destructive migrations without showing the SQL first.**
- **Use transactions for multi-table writes.** Prisma `$transaction([...])` for anything touching 2+ tables.
- **Seed data belongs in `prisma/seed.ts`.** Not in application code, not hardcoded in tests.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Node: 20+, npm
- Python: not used
- Never auto-commit.
- DB connection string in `DATABASE_URL` env var. Never hardcode it.

## Skill Triggers
- `debugging` -> anything broken, type errors, failing tests, unexpected behavior
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between approaches (e.g., server action vs API route)
- `research` -> comparing libraries, evaluating Prisma alternatives, Next.js patterns

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `prisma/schema.prisma` | Database schema — source of truth |
| `src/lib/db.ts` | Prisma client singleton |
| `src/app/api/` | API routes |
| `.env.local` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when a schema decision is made or a pattern is confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
