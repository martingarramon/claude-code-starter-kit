# Project Instructions — Node.js TypeScript API
# Stack: Express/NestJS + TypeScript + PostgreSQL + TypeORM/Prisma
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: Node.js, Express (or NestJS), TypeScript (strict mode), PostgreSQL, TypeORM/Prisma.
Deployed on [Railway / Fly.io / EC2]. Tests run with Jest + Supertest.

## Rules

### Verification
- **Verify before claiming done.** Run `npm test` for the affected module. Show the output.
- **State the verification method first.** Before writing a new route, say how you'll test it (Jest / Supertest / curl).
- **`npx tsc --noEmit` must pass.** Run it after any code change. Type errors are ship-blockers.
- **No `@ts-ignore`.** If a type problem is hard, fix it properly. Explain the real type.

### Planning
- **Use plan mode for changes touching 3+ files.** New resource = model + service + controller + migration = plan first.
- **No guessing.** Don't fabricate TypeORM column options, Express middleware signatures, or NestJS decorators. Look them up.
- **Migration before model.** Show the migration SQL or TypeORM migration content before running it.

### Code Quality
- **TypeScript strict mode always.** `"strict": true` in tsconfig. No `any` types. Use `unknown` + type guards if unsure.
- **Async/await only.** Never use callbacks. No nested `.then()` chains. Handle errors with try/catch.
- **No placeholder code.** Every function must do something real. No `// TODO` stubs.
- **Prefer editing over creating.** Check if a service, middleware, or utility already exists before creating a new one.
- **Validation on all inputs.** Use Zod schemas or class-validator decorators on every request body and query parameter.
- **Custom error classes.** Throw typed errors (NotFoundError, ValidationError). Handle them in centralized error middleware.
- **No `console.log` in committed code.** Use a structured logger (winston, pino). Console is for debugging only.

### Database
- **Never run migrations without reviewing the SQL first.**
- **Use transactions for multi-table writes.** TypeORM `queryRunner` or Prisma `$transaction` for anything touching 2+ tables.
- **Prepared statements only.** Never interpolate user input into SQL strings. Use parameterized queries.
- **Seed data belongs in a seed script.** Not in application code.

### Project Structure
- Routes in `src/routes/`, services in `src/services/`, models in `src/models/`.
- Middleware in `src/middleware/`. Shared types in `src/types/`.
- Keep route handlers thin — business logic lives in services.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Node: 20+, npm
- TypeScript: 5.x with `"strict": true`
- Never auto-commit.
- All config via `.env` — never hardcode secrets, connection strings, or API keys.
- Run dev server: `npm run dev` (ts-node-dev or nodemon + ts-node)

## Skill Triggers
- `debugging` -> runtime errors, type mismatches, async race conditions, middleware ordering issues
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between patterns (e.g., service layer vs repository, REST vs GraphQL)
- `research` -> comparing ORMs, auth strategies, validation libraries

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `src/app.ts` | Express/NestJS app setup, middleware registration |
| `src/routes/` | Route handlers, organized by resource |
| `src/services/` | Business logic layer |
| `src/models/` | TypeORM entities or Prisma schema reference |
| `src/middleware/` | Auth, error handling, validation, logging |
| `src/types/` | Shared TypeScript interfaces and types |
| `tsconfig.json` | TypeScript configuration — strict mode enforced |
| `.env` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when an architecture decision is made or a pattern is confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
