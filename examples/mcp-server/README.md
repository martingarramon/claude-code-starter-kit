# MCP Server Example — Project Notes

A minimal working MCP server. Gives Claude persistent read/write access to a local notes
store. Notes survive across sessions without a database.

Use this as a template for building your own MCP servers.

---

## Setup (5 minutes)

**1. Install dependencies**

```bash
cd examples/mcp-server
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

**2. Configure**

```bash
cp .env.example .env
# Edit .env if you want notes stored at a custom path
```

**3. Register with Claude Code**

Add to `.claude/settings.json` in your project:

```json
{
  "mcpServers": {
    "project-notes": {
      "command": "python",
      "args": ["/absolute/path/to/examples/mcp-server/server.py"],
      "env": {
        "NOTES_FILE": "/absolute/path/to/notes.json"
      }
    }
  }
}
```

**4. Add a skill trigger to CLAUDE.md**

```
- `project-notes` MCP -> use for storing decisions, status updates, and patterns learned
```

**5. Test it**

Start a Claude Code session and ask: "List my project notes." If the server is connected,
Claude will call `list_notes` and return "No notes stored yet."

---

## How It Works

The server exposes four tools:

| Tool | What It Does |
|------|-------------|
| `add_note` | Write or overwrite a note by key |
| `get_note` | Retrieve a note by key |
| `list_notes` | List all stored keys |
| `delete_note` | Remove a note by key |

Notes are stored in a plain JSON file. No database, no dependencies beyond the MCP SDK.

---

## Extending This

The pattern for adding a new tool:

1. Add a `types.Tool(...)` entry to `list_tools()`
2. Add a matching `elif name == "your_tool":` branch to `call_tool()`
3. Always return `list[types.TextContent]`
4. Always validate inputs and return clear error messages

To connect a real API instead of a local file: replace `load_notes()`/`save_notes()` with
your API client calls. The rest of the structure stays identical.

---

## Anti-Patterns This Example Avoids

- **No hardcoded paths.** Config comes from environment variables.
- **No silent failures.** Every error case returns a clear message.
- **No monolithic tool.** Four focused tools instead of one "do everything" tool.
- **No missing docs.** Setup works from a clean machine in under 5 minutes.
