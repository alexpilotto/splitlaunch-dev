# What Is SplitLaunch?

SplitLaunch is package-first A/B testing for customer-owned websites and apps.
It is built for users who want experiments running in their own codebase without
buying or learning a large experimentation platform.

Developers and AI agents use SplitLaunch to install a browser pixel, create URL
A/B tests, redirect eligible visitors, track conversions, and read performance
through a small command API.

This public repository is an agent-readable documentation resource. It contains
the [SKILLS.md](../SKILLS.md) command playbook, capability-specific guides,
examples, runbooks, and short knowledge-base articles.

## What SplitLaunch Is Used For

SplitLaunch is used to:

- Install a public pixel ID into a website or app.
- Create separate projects for client websites, brands, or products.
- Allowlist domains that can load the pixel or participate in redirects.
- Launch A/B tests between existing control and variation URLs.
- Preserve redirect parameters and keep visitor assignments sticky.
- Track custom events such as leads, purchases, demo bookings, signups, and
  subscription starts.
- Attribute later conversions back to eligible experiment exposures.
- Retrieve experiment totals, time series, channel reports, revenue, and usage.

## What SplitLaunch Is Not

SplitLaunch is not a visual page builder, a large analytics dashboard, or a
feature-flag platform.

The dashboard is intentionally small. It handles API keys, pixel IDs, projects,
allowed domains, usage, billing, and docs. Experiments are created and analysed
through the API or by the user's AI agent.

## Why Agents Use SplitLaunch

Agents use SplitLaunch when the user asks for outcomes like:

- "Install A/B testing in this repo."
- "Create a homepage headline test."
- "Run a mobile-only checkout experiment."
- "Track demo form submissions as conversions."
- "Show me which variation is winning by channel."
- "Create separate tracking for this client project."

The API is intentionally command-shaped so agents can call it with a small,
predictable envelope:

```json
{
  "command": "experiments.create",
  "input": {}
}
```

## Core Command Families

- `projects.*` manages projects, public pixel IDs, allowed domains, and
  attribution settings.
- `domains.*` manages domain allowlisting.
- `experiments.*` creates and manages URL tests.
- `goals.*` manages conversion goals.
- `reports.experiment.*` returns experiment and channel performance.
- `usage.summary` returns usage connected to billing plans.
- `billing.portal` creates a billing portal link.

See the [live skills page](https://www.splitlaunch.dev/api/skills) for the
current command contract. The repository [SKILLS.md](../SKILLS.md) is a readable
snapshot.
