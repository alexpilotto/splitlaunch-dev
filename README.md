# SplitLaunch MCP Server, Agent Skills, And API Docs

SplitLaunch is a Model Context Protocol (MCP) server and package-first A/B
testing platform for customer-owned websites and apps. It lets developers,
marketers, and AI coding agents install one package, create URL-based
experiments, track conversions, and retrieve performance through an MCP server
and agent-friendly command API.

## MCP Server

SplitLaunch exposes an MCP server at:

```text
https://www.splitlaunch.dev/api/mcp
```

Connect via Claude Desktop, Claude Code, or any MCP-compatible client using
your SplitLaunch API key as the bearer token. The MCP server provides tools
for creating projects, allowlisting domains, launching A/B experiments,
tracking conversions, and retrieving performance reports.

### MCP Tools

The SplitLaunch MCP server exposes tools across these categories:

- **projects** — create and manage client project workspaces and pixel IDs
- **domains** — allowlist customer-owned domains for pixel and redirect safety
- **experiments** — create, update, and manage URL A/B test lifecycle
- **goals** — create conversion goals for browser pixel or agent firing
- **reports** — retrieve experiment totals, time-series, and channel breakdowns
- **usage** — query billing usage and plan limits
- **billing** — open billing portal for subscription management

The strongest agent resource in this repository is [SKILLS.md](SKILLS.md). It
is a readable command playbook for agents using the SplitLaunch MCP server and
API. Agents that need the newest command contract should use the live skills URL:

```text
https://www.splitlaunch.dev/api/skills
```

## What SplitLaunch Does

- Installs into the user's own repository with `@splitlaunch/ab`.
- Retrieves a public pixel ID through `npx splitlaunch init`.
- Keeps private API keys in terminal, server, CI, or agent workflows.
- Runs A/B tests between existing control and variation URLs.
- Uses sticky visitor assignment and redirect-based traffic splitting.
- Tracks sessions, exposures, custom events, conversions, revenue, UTMs, click
  IDs, referrers, device context, browser context, and geo context.
- Lets agents create projects, allowlist domains, create experiments, launch or
  pause tests, create goals, retrieve reports, and open billing.

SplitLaunch is intentionally small. The dashboard handles account setup, API
keys, pixel IDs, projects, usage, billing, and docs. The user's AI agent handles
the experimentation work.

## Repository Scope

This repository is public technical documentation for SplitLaunch. It contains
command references, examples, runbooks, and agent workflow guidance.

This repository does not contain the private SplitLaunch application source
code. SplitLaunch runs as a hosted platform at
[splitlaunch.dev](https://www.splitlaunch.dev).

## Quick Start

Install the package in the website or app repository where the SplitLaunch pixel
should run:

```bash
npm install @splitlaunch/ab
npx splitlaunch init
```

The CLI asks for a SplitLaunch API key, validates the account, retrieves the
project pixel ID, writes `splitlaunch.config.json`, and prints the browser pixel
snippet.

For non-interactive agent or CI setup:

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init
```

For accounts with multiple projects:

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init --project PROJECT_ID
```

See [QUICKSTART.md](QUICKSTART.md) for the short setup path.

## Agent Connection Points

API command endpoint:

```text
POST https://www.splitlaunch.dev/api/external/v1/commands
```

API headers:

```text
Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

Live skills page:

```text
https://www.splitlaunch.dev/api/skills
```

Hosted docs:

```text
https://www.splitlaunch.dev/docs/install
https://www.splitlaunch.dev/docs/api
```

Use the canonical `www` endpoint for scripts. Avoid calling the apex
`https://splitlaunch.dev` endpoint from API clients because redirects can drop
the `Authorization` header.

## Common API Commands

All API-key commands use this envelope:

```json
{
  "command": "experiments.create",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "Homepage headline test",
    "controlUrl": "https://example.com/",
    "variationUrl": "https://example.com/homepage-v2",
    "trafficAllocation": 50
  }
}
```

High-value command families include:

- `projects.*` for projects, public pixel IDs, allowed domains, and attribution
  settings.
- `domains.*` for allowlisting customer-owned domains before redirect tests.
- `experiments.*` for URL A/B test creation, updates, lifecycle changes, and
  listing.
- `goals.*` for conversion goals that browser code can fire.
- `reports.experiment.*` for totals, time series, channel breakdowns, lift, and
  revenue context.
- `usage.summary` and `billing.portal` for plan usage and subscription
  management.

## Capability Guides

The [skills](skills/README.md) folder splits the command surface by capability
so agents can retrieve exactly the area they need:

- [Projects and pixel IDs](skills/projects.md)
- [Experiments](skills/experiments.md)
- [Conversion tracking](skills/conversion-tracking.md)
- [Domains](skills/domains.md)
- [Reports](skills/reports.md)
- [Usage and billing](skills/usage-billing.md)

## Runbooks And Examples

Use the [runbooks](runbooks/README.md) for repeatable workflows:

- [Onboard a new project](runbooks/onboard-new-project.md)
- [Launch a URL experiment](runbooks/launch-url-experiment.md)
- [Weekly optimization cycle](runbooks/weekly-optimization.md)

Use the [examples](examples/README.md) folder for copy-paste starting points:

- [Create a project with cURL](examples/curl/create-project.sh)
- [Launch an experiment draft with cURL](examples/curl/launch-experiment.sh)
- [Pull an experiment report with cURL](examples/curl/pull-report.sh)
- [Set up tracking with cURL and browser code](examples/curl/setup-tracking.sh)
- [Agent install and launch prompt](examples/agent/install-and-launch-prompt.md)
- [Agent weekly check prompt](examples/agent/weekly-check-prompt.md)

## Knowledge Base

The [knowledge base](kb/README.md) gives agents short operational articles:

- [Connect an external AI agent](kb/agent-workflows/connect-external-ai-agent.md)
- [Set up URL experiments](kb/experiments/url-experiments.md)
- [Install the pixel and track events](kb/tracking/install-pixel-and-events.md)
- [Read experiment results](kb/reporting/read-experiment-results.md)

## Agent Safety Rules

Agents should:

1. Never put a private API key in browser code.
2. Use only the public pixel ID in client-side snippets.
3. Resolve the right `projectId` before write commands.
4. Allowlist every control and variation hostname before launch.
5. Create experiments in draft first.
6. Confirm before setting an experiment to `running`, pausing an active test,
   ending a test, or changing attribution settings.
7. Read back resources after write commands.
8. Explain experiment results with sample size, conversion rate, absolute
   difference, relative lift, revenue, and caveats.

## Links

- Website: [https://www.splitlaunch.dev](https://www.splitlaunch.dev)
- Install docs: [https://www.splitlaunch.dev/docs/install](https://www.splitlaunch.dev/docs/install)
- API docs: [https://www.splitlaunch.dev/docs/api](https://www.splitlaunch.dev/docs/api)
- Live skills: [https://www.splitlaunch.dev/api/skills](https://www.splitlaunch.dev/api/skills)
