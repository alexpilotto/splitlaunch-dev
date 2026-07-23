# Experiment Reports API

SplitLaunch reports are designed for agent analysis rather than a large
dashboard. Agents should retrieve experiment totals, time series, channel
breakdowns, and usage data, then explain what changed and what remains uncertain.

## Core Commands

- `experiments.list`: find running, paused, draft, or ended experiments.
- `reports.experiment.details`: return variant totals.
- `reports.experiment.chart`: return time-series conversions.
- `reports.experiment.channels`: return acquisition channel performance.
- `usage.summary`: return project usage for billing context.

## List Experiments

```json
{
  "command": "experiments.list",
  "input": {
    "projectId": "PROJECT_ID",
    "status": "running",
    "page": 1,
    "perPage": 25
  }
}
```

## Experiment Details

```json
{
  "command": "reports.experiment.details",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "goal": "Lead",
    "from": "2026-07-01",
    "to": "2026-07-14"
  }
}
```

Explain:

- exposures,
- visitors,
- conversions,
- revenue when available,
- conversion rate,
- absolute difference,
- relative lift,
- whether more data is needed.

## Chart Data

```json
{
  "command": "reports.experiment.chart",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "interval": "day",
    "goal": "Lead"
  }
}
```

Use chart data to spot traffic drops, conversion spikes, or changes after a
deployment.

## Channel Breakdown

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "goal": "Purchase",
    "from": "2026-07-01",
    "to": "2026-07-31"
  }
}
```

Rows can include:

- channel,
- source/medium,
- campaign,
- content,
- variant,
- exposures,
- visitors,
- conversions,
- revenue when available,
- conversion rate.

## Agent Reporting Pattern

Use this format when summarizing results:

```text
Experiment: Homepage headline test
Window: 2026-07-01 to 2026-07-14
Goal: Lead

Control: 1,204 visitors, 72 conversions, 5.98% CVR
Variation: 1,188 visitors, 84 conversions, 7.07% CVR
Difference: +1.09 percentage points, +18.2% relative lift

Read: Directionally positive, but keep running if the decision needs higher
confidence. Paid Search traffic is overrepresented in the variation, so channel
mix should be watched.
```

## Decision Guidance

- Do not declare a winner from tiny samples.
- Mention if traffic or channel mix is skewed.
- Mention if revenue and conversion rate disagree.
- Recommend a next action: keep running, pause, end, ship the variation, or
  create a follow-up test.
- Keep the explanation practical and readable for non-technical users.

## Related Files

- [Experiments](experiments.md)
- [Usage and billing](usage-billing.md)
- [Weekly optimization runbook](../runbooks/weekly-optimization.md)
