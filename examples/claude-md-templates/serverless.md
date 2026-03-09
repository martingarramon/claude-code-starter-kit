# Project Instructions — Serverless Application
# Stack: AWS Lambda + SAM + DynamoDB + Python/Node.js
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: AWS Lambda, SAM (Serverless Application Model), DynamoDB, API Gateway.
Runtime: [Python 3.12 / Node.js 20]. Deployed via `sam deploy`. CI on [GitHub Actions / CodePipeline].

## Rules

### Verification
- **Verify before claiming done.** Run `sam build` and `sam validate` — both must pass. Show the output.
- **State the verification method first.** Before writing a function, say how you'll test it (unit test / `sam local invoke` / curl).
- **`sam local invoke` for integration tests.** Test with realistic event payloads from `events/` directory.
- **Unit tests are mandatory.** Every Lambda handler must have corresponding unit tests. Run `pytest` or `npm test`.

### Planning
- **Use plan mode for changes touching 3+ files.** New endpoint = function + template.yaml + IAM policy + DynamoDB table = plan first.
- **No guessing.** Don't fabricate SAM resource properties, IAM actions, or DynamoDB attribute names. Check the AWS docs.
- **Review template.yaml changes before deploying.** IAM policy changes and resource additions need explicit review.

### Code Quality
- **Handler functions must be pure.** No side effects at module scope. All initialization (DB clients, config) inside the handler or via lazy init.
- **Cold start optimization.** Minimize top-level imports. Use Lambda layers for heavy dependencies. Avoid importing unused modules.
- **No placeholder code.** Every function must do something real. No stubs.
- **Prefer editing over creating.** Check if a function or utility already exists before creating a new one.
- **Structured JSON logs.** Use Lambda Powertools (Python: `aws-lambda-powertools`, Node: `@aws-lambda-powertools/logger`). No `print()` or `console.log()` for production logging.
- **Environment variables for ALL configuration.** No hardcoded ARNs, table names, bucket names, or URLs. Define in template.yaml `Environment.Variables`.

### IAM & Security
- **Least privilege always.** Every function gets only the permissions it needs. Never use `"Resource": "*"` in production.
- **Scope IAM to specific resources.** Use `!GetAtt` or `!Sub` to reference specific ARNs, not wildcards.
- **No secrets in template.yaml.** Use AWS Secrets Manager or SSM Parameter Store. Reference via `{{resolve:ssm:...}}`.
- **Validate all inputs.** Lambda receives untrusted data. Validate event structure before processing.

### DynamoDB
- **Single-table design where possible.** Use composite keys (PK/SK) with access pattern-driven design.
- **Document access patterns first.** Before creating a table, list all read/write patterns. Design keys to support them.
- **Use `ConditionExpression` for writes.** Prevent accidental overwrites with condition checks.
- **Batch operations for bulk work.** Use `batch_write_item` / `batch_get_item` for multiple items. Handle unprocessed items.

### Project Structure
- SAM template at root: `template.yaml` — single source of truth for infrastructure.
- Each function in its own directory: `functions/[function-name]/`.
- Shared code in `layers/` (Lambda layers) or `shared/` (copied at build time).
- Test event payloads in `events/`. Unit tests alongside function code or in `tests/`.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Runtime: [Python 3.12 / Node.js 20]
- SAM CLI installed. Docker required for `sam local invoke`.
- Never auto-commit.
- AWS profile in `AWS_PROFILE` env var or `~/.aws/credentials`. Never hardcode AWS keys.
- Deploy: `sam build && sam deploy --guided` (first time) or `sam deploy` (subsequent).
- Local testing: `sam local invoke FunctionName -e events/test-event.json`

## Skill Triggers
- `debugging` -> Lambda timeouts, permission errors, cold start issues, DynamoDB throttling
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between patterns (e.g., Step Functions vs direct invocation, SQS vs EventBridge)
- `research` -> comparing AWS services, evaluating serverless patterns, cost optimization

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `template.yaml` | SAM template — all infrastructure defined here |
| `functions/` | Lambda function directories (one per function) |
| `layers/` | Shared Lambda layers (dependencies, utilities) |
| `events/` | Test event payloads for `sam local invoke` |
| `tests/` | Unit and integration tests |
| `samconfig.toml` | SAM deployment configuration |
| `.env` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when an infrastructure decision is made or an access pattern is confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
