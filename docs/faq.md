# SplitLaunch FAQ

## Can An AI Agent Install SplitLaunch?

Yes. The agent can run:

```bash
npm install @splitlaunch/ab
npx splitlaunch init
```

The user or agent provides a private `sl_live_...` API key in the terminal or
environment. The CLI retrieves the public pixel ID and prints the browser pixel
snippet.

## Where Does The API Key Go?

The API key belongs only in terminal, server, CI, or agent-side calls. It should
never be embedded in browser code or committed to GitHub.

Browser code receives only the public `px_...` pixel ID.

## What Can SplitLaunch Test?

SplitLaunch v1 tests existing URLs. A typical experiment has:

- a control URL,
- a variation URL,
- traffic allocation,
- optional device, visitor, traffic-source, geo, and URL pattern targeting when
  the selected plan includes those features,
- a lifecycle status such as `draft`, `running`, `paused`, or `ended`.

## Does SplitLaunch Include A Visual Editor?

No. SplitLaunch is designed for users and agents that already edit the website
or app repository directly. The product focuses on package installation,
redirect tests, conversion tracking, and reporting.

## What Events Can I Track?

Common event names include `Lead`, `Signup`, `TrialStarted`, `Purchase`,
`DemoBooked`, `Subscribe`, and `ContactFormSubmitted`.

Agents should fire conversion events after the successful action, not on an
initial click.

## How Does Domain Safety Work?

Before a redirecting test runs, the customer-owned hostnames should be added
with `domains.add`. Use hostnames like `example.com` and `www.example.com`, not
full URLs.

## What Reports Should Agents Pull?

Use:

- `reports.experiment.details` for variant totals, visitors, exposures,
  conversions, revenue when available, and conversion rate.
- `reports.experiment.chart` for time-series performance.
- `reports.experiment.channels` for acquisition and channel breakdowns.

Agents should explain the result in practical terms and call out uncertainty
when sample size is small.

## How Does Attribution Work?

Each project has an attribution window and model. SplitLaunch defaults to a
3-day window and `last_touch`. The API also supports `first_touch` and windows
up to 365 days.

## Is There An MCP Endpoint?

Yes. SplitLaunch exposes a hosted MCP endpoint at
`https://www.splitlaunch.dev/api/mcp`.

Use `https://www.splitlaunch.dev/api/skills` as the live agent command
playbook.
