# Connect An External AI Agent To SplitLaunch

SplitLaunch supports external AI agents through API-key command calls and a
live agent skills page. This is useful for Codex, Claude Code, Cursor, Custom
GPT Actions, internal automations, scheduled jobs, and CI workflows.

## Connection Path

| Path | Best For | Auth Model |
| --- | --- | --- |
| API key + live skills page | Coding agents, custom agents, CI, scheduled jobs, internal tools | User-managed `sl_live_...` API key |

Live skills page:

```text
https://www.splitlaunch.dev/api/skills
```

Command endpoint:

```text
POST https://www.splitlaunch.dev/api/external/v1/commands
```

Headers:

```text
Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

## Setup Flow

1. Create a SplitLaunch account.
2. Activate the trial or subscription.
3. Copy an API key from the dashboard.
4. Store it in a safe environment variable such as `SPLITLAUNCH_API_KEY`.
5. Give the agent the live skills URL.
6. Ask the agent to run `npx splitlaunch init` inside the website repository.

## What Agents Can Do

Agents can:

- list projects,
- create projects,
- retrieve public pixel IDs,
- add allowed domains,
- create draft experiments,
- launch, pause, or end experiments after confirmation,
- create conversion goals,
- retrieve experiment reports,
- retrieve usage summaries,
- open a billing portal link when requested.

## Security Rules

- Never put the private API key in browser code.
- Never commit the key to GitHub.
- Browser code should use only the public `px_...` pixel ID.
- Prefer `SPLITLAUNCH_API_KEY` environment variables for local agent use.
- Confirm before high-impact write commands.

## First Success Check

```bash
curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "command": "projects.get",
    "input": {}
  }'
```

## Related Files

- [Quickstart](../../QUICKSTART.md)
- [Agent command playbook](../../SKILLS.md)
- [Install and launch prompt](../../examples/agent/install-and-launch-prompt.md)
