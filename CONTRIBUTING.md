# Contributing to Claude Code Starter Kit

Thanks for your interest in contributing! This project follows the "rules from mistakes" philosophy — every addition should come from real experience, not theory.

## What We're Looking For

### High Priority
- **New skills** — Structured workflows for common development tasks
- **Stack templates** — CLAUDE.md configurations for popular tech stacks
- **Hook examples** — Scripts for Claude Code's hooks API (PreToolUse, PostToolUse, Notification, Stop, SubagentStop)

### Also Welcome
- Bug fixes and improvements to existing content
- Documentation clarity improvements
- MCP server examples

## How to Contribute

### Adding a New Skill

1. Create `skills/your-skill-name/SKILL.md`
2. Follow this structure:
   - **Name** — Clear, descriptive
   - **When to Use** — Specific triggers
   - **Core Principle** — One sentence philosophy
   - **Process** — Numbered steps (5-7 max)
   - **Output Format** — What Claude should produce
   - **Rules** — Hard constraints
   - **Anti-Patterns** — What NOT to do

3. Every rule must come from real experience. Include the mistake that inspired it.

### Adding a Stack Template

1. Create `examples/claude-md-templates/your-stack.md`
2. Include: project structure, key files, verification commands, stack-specific rules
3. Test it with a real project first

### Adding a Hook Example

1. Create `examples/hooks/your-hook.sh`
2. Specify the hook type in the filename or header comment
3. Include error handling and logging
4. Test on both macOS and Linux if possible

## Quality Standards

- **No theoretical rules** — Every rule must come from a real mistake or problem
- **No bloat** — If it doesn't add clear value, don't add it
- **Test first** — Try your contribution with a real Claude Code project before submitting
- **Keep it simple** — Prefer clarity over cleverness

## Process

1. Fork the repo
2. Create a feature branch (`git checkout -b add-rust-template`)
3. Make your changes
4. Test with a real Claude Code project
5. Submit a PR with a clear description of what problem this solves

## Code of Conduct

Be respectful, be helpful, be specific. We're all here to make Claude Code better.
