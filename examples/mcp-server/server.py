"""
Minimal MCP server — Project Notes Store

Gives Claude persistent read/write access to a local notes file.
Notes survive across sessions. No database required.

Tools exposed:
  add_note    — write or overwrite a note by key
  get_note    — retrieve a note by key
  list_notes  — list all note keys
  delete_note — remove a note by key

Usage:
  pip install -r requirements.txt
  python server.py
"""

import asyncio
import json
import os
from pathlib import Path

import mcp.server.stdio
import mcp.types as types
from mcp.server import Server

# ── Config ────────────────────────────────────────────────────────────────────

NOTES_FILE = Path(os.getenv("NOTES_FILE", "notes.json"))

# ── Helpers ───────────────────────────────────────────────────────────────────

def load_notes() -> dict:
    if NOTES_FILE.exists():
        return json.loads(NOTES_FILE.read_text())
    return {}

def save_notes(notes: dict) -> None:
    NOTES_FILE.write_text(json.dumps(notes, indent=2))

# ── Server ────────────────────────────────────────────────────────────────────

server = Server("project-notes")

@server.list_tools()
async def list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="add_note",
            description="Write or overwrite a note. Use for decisions, status, patterns, anything worth remembering.",
            inputSchema={
                "type": "object",
                "properties": {
                    "key":   {"type": "string", "description": "Short identifier, e.g. 'db-schema-decision'"},
                    "value": {"type": "string", "description": "The note content"},
                },
                "required": ["key", "value"],
            },
        ),
        types.Tool(
            name="get_note",
            description="Retrieve a note by key.",
            inputSchema={
                "type": "object",
                "properties": {
                    "key": {"type": "string"},
                },
                "required": ["key"],
            },
        ),
        types.Tool(
            name="list_notes",
            description="List all note keys. Call this first when you don't know what's stored.",
            inputSchema={
                "type": "object",
                "properties": {},
            },
        ),
        types.Tool(
            name="delete_note",
            description="Delete a note by key.",
            inputSchema={
                "type": "object",
                "properties": {
                    "key": {"type": "string"},
                },
                "required": ["key"],
            },
        ),
    ]


@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[types.TextContent]:
    notes = load_notes()

    if name == "add_note":
        key   = arguments.get("key", "").strip()
        value = arguments.get("value", "").strip()
        if not key:
            return [types.TextContent(type="text", text="Error: key is required")]
        notes[key] = value
        save_notes(notes)
        return [types.TextContent(type="text", text=f"Saved: {key}")]

    elif name == "get_note":
        key = arguments.get("key", "").strip()
        if key not in notes:
            return [types.TextContent(type="text", text=f"Not found: {key}")]
        return [types.TextContent(type="text", text=notes[key])]

    elif name == "list_notes":
        if not notes:
            return [types.TextContent(type="text", text="No notes stored yet.")]
        keys = "\n".join(f"- {k}" for k in sorted(notes))
        return [types.TextContent(type="text", text=keys)]

    elif name == "delete_note":
        key = arguments.get("key", "").strip()
        if key not in notes:
            return [types.TextContent(type="text", text=f"Not found: {key}")]
        del notes[key]
        save_notes(notes)
        return [types.TextContent(type="text", text=f"Deleted: {key}")]

    return [types.TextContent(type="text", text=f"Unknown tool: {name}")]


# ── Entry point ───────────────────────────────────────────────────────────────

async def main():
    async with mcp.server.stdio.stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            server.create_initialization_options(),
        )

if __name__ == "__main__":
    asyncio.run(main())
