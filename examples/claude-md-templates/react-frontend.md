# Project Instructions — React Frontend
# Stack: React + Vite + TypeScript + Tailwind CSS
# Customize this template. Delete sections that don't apply.

# ============================================================
# This file runs every turn. Keep it lean. Rules, not essays.
# ============================================================

## Project Context
This is [PROJECT NAME] — [one-sentence description of what it does].
Stack: React 18+, Vite, TypeScript (strict mode), Tailwind CSS (or CSS Modules).
Deployed on [Vercel / Netlify / Cloudflare Pages]. Tests run with Vitest + React Testing Library.

## Rules

### Verification
- **Verify before claiming done.** Run `npm run build` and show the output. Zero warnings, zero errors.
- **State the verification method first.** Before writing a component, say how you'll verify it (Vitest / browser check / build).
- **Check the browser console.** After any UI change, verify there are no console errors or warnings.
- **`npx tsc --noEmit` must pass.** Type errors are real errors. Never use `// @ts-ignore`.

### Planning
- **Use plan mode for changes touching 3+ files.** New feature = component + hook + route + types = plan first.
- **No guessing.** Don't fabricate React API methods, Vite config options, or Tailwind class names. Look them up.
- **Wireframe before building.** For new pages or complex layouts, describe the component hierarchy first.

### Code Quality
- **Functional components only.** No class components. Use hooks for all state and effects.
- **TypeScript props interfaces required.** Every component must have an explicit `Props` interface. No `any`.
- **No inline styles in JSX.** Use Tailwind classes or CSS Modules. Exception: truly dynamic values (e.g., `style={{ width: calculatedWidth }}`).
- **No `console.log` in committed code.** Remove all debug logging before presenting work.
- **No placeholder code.** Every component must render something real. No `// TODO` stubs.
- **Prefer editing over creating.** Check if a component or utility already exists before creating a new one.

### State Management
- **Server state: React Query (TanStack Query).** All API calls go through `useQuery` / `useMutation`. No `useEffect` for fetching.
- **Client state: Zustand or React Context.** Choose one and stay consistent. Context for simple global state, Zustand for complex.
- **No prop drilling past 2 levels.** If passing props through 3+ components, lift state or use context.

### Accessibility
- **Semantic HTML first.** Use `<button>`, `<nav>`, `<main>`, `<section>` — not `<div onClick>`.
- **ARIA labels on interactive elements.** Buttons, links, and form inputs must be screen-reader friendly.
- **Keyboard navigation.** All interactive elements must be reachable and operable via keyboard.
- **Color contrast.** Text must meet WCAG AA contrast ratio (4.5:1 for normal text).

### Project Structure
- Components in `src/components/`, pages in `src/pages/`, hooks in `src/hooks/`.
- API layer in `src/api/`. Shared types in `src/types/`.
- Keep components small — if a component exceeds 150 lines, split it.

### Communication
- **One step at a time.** Don't dump checklists. Give the next action, wait, then continue.
- **Lead with the problem.** When asked "what do you think?" — say what's wrong first.

## Environment
- Platform: [macOS / Linux / Windows Git Bash]
- Node: 20+, npm
- TypeScript: 5.x with `"strict": true`
- Never auto-commit.
- API base URL in `VITE_API_URL` env var. Never hardcode backend URLs.
- Run dev server: `npm run dev`

## Skill Triggers
- `debugging` -> rendering bugs, state sync issues, hydration errors, layout breakage
- `code-review` -> before merging any feature branch
- `architecture-decision` -> choosing between patterns (e.g., state library, routing approach, data fetching)
- `research` -> comparing component libraries, animation tools, form solutions

## Key Files
| File | Purpose |
|------|---------|
| `memory/MEMORY.md` | Persistent state — decisions, status, patterns |
| `src/App.tsx` | Root component, router setup |
| `src/components/` | Reusable UI components |
| `src/pages/` | Page-level components (route targets) |
| `src/hooks/` | Custom React hooks |
| `src/api/` | API client functions and React Query hooks |
| `src/types/` | Shared TypeScript interfaces |
| `vite.config.ts` | Vite build configuration |
| `tailwind.config.ts` | Tailwind CSS configuration |
| `.env` | Local environment variables (never commit) |

## MCP Usage Protocol
- Prefer Read/Write/Glob/Grep tools over shell commands for file operations.
- Check tool availability before assuming an MCP server is connected.
- Never loop API calls without explicit approval.

## Memory Management
- Read `memory/MEMORY.md` at session start.
- Update memory when a design system decision is made or a pattern is confirmed.
- Delete stale entries. Outdated memory is worse than no memory.
