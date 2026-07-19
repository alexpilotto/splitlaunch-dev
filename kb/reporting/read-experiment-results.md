# Read Experiment Results

SplitLaunch reports give agents the data needed to explain whether an
experiment is winning, losing, inconclusive, or affected by traffic mix.

## Recommended Report Flow

1. Run `experiments.list` to find running or recently ended experiments.
2. Run `reports.experiment.details` for totals by variant.
3. Run `reports.experiment.channels` for source and channel context.
4. Run `reports.experiment.chart` when traffic or conversion timing needs
   inspection.
5. Run `usage.summary` if the user asks about plan limits or tracked sessions.

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

## Channel Report

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "goal": "Lead",
    "from": "2026-07-01",
    "to": "2026-07-14"
  }
}
```

## Agent Output Pattern

```text
Experiment: Homepage headline test
Goal: Lead
Window: 2026-07-01 to 2026-07-14

Control: 1,204 visitors, 72 conversions, 5.98% conversion rate
Variation: 1,188 visitors, 84 conversions, 7.07% conversion rate
Difference: +1.09 percentage points, +18.2% relative lift

Read: Directionally positive. Keep running if the team wants more confidence.
Channel mix looks balanced, with no obvious skew.
```

## Interpretation Rules

- Do not overclaim from small samples.
- Mention absolute difference and relative lift.
- Mention revenue when it exists.
- Mention channel, device, or geo skew if visible.
- Treat a report as directional unless the sample is large enough for the user's
  risk tolerance.
- Recommend a next action in practical terms.

## Related Files

- [Reports guide](../../skills/reports.md)
- [Weekly optimization runbook](../../runbooks/weekly-optimization.md)
- [Pull report example](../../examples/curl/pull-report.sh)
