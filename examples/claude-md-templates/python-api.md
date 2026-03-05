# Project Instructions — Python API Service
# Stack: FastAPI + SQLAlchemy + PostgreSQL (or SQLite for local dev)
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: FastAPI, SQLAlchemy (async), PostgreSQL, Pydantic v2, Alembic for migrations.
Deployed on [Railway / Fly.io / EC2]. Tests run with pytest.

## Rules

### Verification
- **Verify before claiming done.** Run the relevant test or curl the endpoint. Show the output.
- **State the verification method first.** Before writing a new endpoint, say how you'll test it (pytest / curl / httpx).
- **Type hints are required.** Every function signature must have type hints. Pydantic models for all request/response bodies.

### Planning
- **Use plan mode for changes touching 3+ files.** New resource = model + schema + router + migration = plan first.
- **No guessing.** Don't fabricate SQLAlchemy column names, FastAPI parameters, or Alembic revision IDs.
- **Migration before model.** Show the Alembic migration content before running `alembic upgrade head`.

### Code Quality
- **No `Any` types.** Use proper Pydantic and SQLAlchemy types.
- **No placeholder code.** Every function must do something real. No pass-with-a-comment stubs.
- **Async all the way.** Use `async def` for all route handlers and DB operations. No blocking calls in async context.
- **Dependency injection for DB sessions.** Use FastAPI `Depends(get_db)`. Never create sessions inline in route handlers.

### Database
- **Never run `alembic upgrade head` without reviewing the migration file first.**
- **Use SQLAlchemy transactions.** Wrap multi-table writes in explicit transaction blocks.
- **Test DB is separate.** Tests use a separate test database or SQLite in-memory. Never run tests against production.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Python: 3.11+, use `python` (or `python3` on macOS/Linux)
- Package manager: pip with `requirements.txt` (or Poetry)
- Never auto-commit.
- DB connection string in `DATABASE_URL` env var. Never hardcode it.
- Run dev server: `uvicorn app.main:app --reload`

## Skill Triggers
- `debugging` -> anything broken, unexpected 422s, async errors, SQLAlchemy warnings
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between approaches (e.g., sync vs async, ORM vs raw SQL)
- `research` -> comparing libraries, evaluating FastAPI patterns, auth strategies

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `app/main.py` | FastAPI app entry point, router registration |
| `app/models/` | SQLAlchemy ORM models |
| `app/schemas/` | Pydantic request/response schemas |
| `app/routers/` | Route handlers, organized by resource |
| `app/db.py` | Database engine + session factory |
| `alembic/versions/` | Migration history |
| `.env` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when an architecture decision is made or a pattern is confirmed.
- Delete stale entries.
