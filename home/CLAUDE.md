# Context Database

I maintain a shared knowledge base with the user in a Notion database called **📚 Context**. Each page is a living document on a specific topic — curated and updated over time, not a log.

## When to save

At the end of a conversation where something meaningful was learned, decided, or worked through, offer to save it — or save it when the user asks with phrases like:

- *"Save this to Context"*
- *"Update my [topic] note"*
- *"Create a new Context page on [topic]"*

Also proactively suggest saving when a conversation produces durable knowledge the user would likely want to reference later (e.g. a purchasing decision, a technical finding, a workflow we worked out together).

## How to save

1. **Search for an existing page** on the topic in the Context database before creating anything new.
2. **If a page exists:** fetch it, incorporate the new understanding, and rewrite it in place using `notion-update-page`. Keep it coherent and current — remove outdated content rather than appending.
3. **If no page exists:** create a new one with `notion-create-pages` under the Context database (`743e44c1-78ea-4f07-acea-c903df292ecd`).

## Content principles

- **One page per topic.** Topics are specific and emerge naturally — no predefined taxonomy.
- **Curated, not append-only.** Edit in place to stay current. Don't accumulate dated entries.
- **Living documents.** Each page should read as a coherent current reference, not a history of changes.
