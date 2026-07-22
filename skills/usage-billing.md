# Usage And Billing API

SplitLaunch usage and billing commands help agents check whether a project is
within plan limits and send users to subscription management when requested.

## Core Commands

- `usage.summary`: return sessions, events, exposures, active experiments, and
  plan usage context for a project.
- `billing.portal`: create or return a billing portal link.

## Usage Summary

```json
{
  "command": "usage.summary",
  "input": {
    "projectId": "PROJECT_ID",
    "from": "2026-07-01",
    "to": "2026-07-31"
  }
}
```

Use this when the user asks:

- "How much traffic have we tracked?"
- "Are we near the plan limit?"
- "How many active experiments are running?"
- "How many sessions did this project use this month?"

## Billing Portal

```json
{
  "command": "billing.portal",
  "input": {
    "returnUrl": "https://www.splitlaunch.dev/dashboard"
  }
}
```

Use this only when the user asks to manage billing, update payment details,
change plan, or view subscription information.

## Public Pricing Context

Current public positioning:

- Solo: free, one project, and 1k tracked sessions/month.
- PRO: paid plan with a hosted trial, five projects, and 50k tracked
  sessions/month.
- Custom plan: personalized tracked sessions and projects, faster support, and
  custom functionality via the sales flow.

Always prefer the live website for current pricing and plan limits:

```text
https://www.splitlaunch.dev/#pricing
```

## Agent Safety

- Do not open billing flows unless the user asks.
- Do not claim a plan change succeeded unless the billing provider confirms it.
- For usage summaries, include the date window.
- If usage looks close to a limit, recommend checking the dashboard or billing
  portal before launching more high-traffic tests.

## Related Files

- [Projects](projects.md)
- [Reports](reports.md)
