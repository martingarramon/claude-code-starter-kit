# Project Instructions — Go Microservice
# Stack: Go + Gin + PostgreSQL + Redis
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: Go 1.22+, Gin framework, PostgreSQL (sqlx or pgx), Redis for caching/sessions.
Deployed on [Kubernetes / ECS / Fly.io]. Tests run with `go test`.

## Rules

### Verification
- **Verify before claiming done.** Run `go test ./...` and show the output. All tests must pass.
- **State the verification method first.** Before writing a handler, say how you'll test it (unit test / integration / curl).
- **`go build ./...` must pass.** Compilation errors are ship-blockers.
- **`go vet ./...` must pass.** Vet catches real bugs — suspicious constructs, unreachable code, bad printf args.

### Planning
- **Use plan mode for changes touching 3+ files.** New endpoint = handler + service + repository + migration = plan first.
- **No guessing.** Don't fabricate Gin methods, sqlx tags, or Redis commands. Check the docs.
- **Migration before model.** Show the SQL migration before running it.

### Code Quality
- **Follow Go conventions.** Run `gofmt` on all files. Follow Effective Go and Go Code Review Comments.
- **Always check errors.** Never assign error to `_`. Handle every error explicitly. Wrap errors with `fmt.Errorf("context: %w", err)`.
- **No placeholder code.** Every function must do something real. No `// TODO` stubs.
- **Prefer editing over creating.** Check if a handler, service, or utility already exists before creating a new one.
- **Keep functions short.** If a function exceeds 50 lines, consider splitting it.
- **Interface-driven design.** Define interfaces in the package that uses them, not the package that implements them.

### Concurrency
- **Goroutines + channels for concurrency.** Prefer channels over shared memory.
- **Protect shared state with `sync.Mutex`.** If you must share memory, synchronize access explicitly.
- **Always handle goroutine lifecycle.** Use `context.Context` for cancellation. No fire-and-forget goroutines without cleanup.
- **Use `errgroup` for parallel operations.** It handles error propagation and context cancellation.

### Database
- **Never run migrations without reviewing the SQL first.**
- **Prepared statements only.** Never concatenate user input into SQL strings. Use `$1`, `$2` placeholders.
- **Use transactions for multi-table writes.** `sqlx.Beginx()` or `pgx.Begin()` with explicit commit/rollback.
- **Connection pooling configured.** Set `MaxOpenConns`, `MaxIdleConns`, and `ConnMaxLifetime` on the pool.

### Project Structure
- Follow standard Go project layout:
  - `cmd/` — main application entry points
  - `internal/` — private application code (handlers, services, repositories)
  - `pkg/` — public library code (reusable across projects)
  - `api/` — API definitions (OpenAPI specs, proto files)
  - `migrations/` — SQL migration files

### HTTP
- **Gin middleware for cross-cutting concerns.** Auth, logging, CORS, rate limiting — all as middleware.
- **Graceful shutdown.** Handle `SIGTERM` / `SIGINT` with `signal.Notify`. Drain in-flight requests.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Go: 1.22+
- Use `go mod` for dependency management.
- Never auto-commit.
- Config via environment variables or `.env` file loaded at startup. Never hardcode secrets.
- Run dev server: `go run cmd/server/main.go`
- Docker: Multistage build — `golang:1.22-alpine` for build, `alpine:latest` for runtime.

## Skill Triggers
- `debugging` -> runtime panics, race conditions, deadlocks, goroutine leaks
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between patterns (e.g., repository vs direct DB, gRPC vs REST)
- `research` -> comparing libraries, evaluating Go patterns, caching strategies

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `cmd/server/main.go` | Application entry point, server startup |
| `internal/handler/` | HTTP handlers (Gin route handlers) |
| `internal/service/` | Business logic layer |
| `internal/repository/` | Database access layer |
| `internal/middleware/` | Gin middleware (auth, logging, CORS) |
| `internal/model/` | Domain types and structs |
| `migrations/` | SQL migration files |
| `go.mod` | Module definition and dependencies |
| `.env` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when an architecture decision is made or a pattern is confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
