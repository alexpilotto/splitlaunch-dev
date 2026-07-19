# Weekly Optimization Cycle

Use this when the user wants a practical review of SplitLaunch experiment
performance.

## Goal

Identify which tests are ready to decide, which need more data, which have
tracking problems, and what follow-up action the agent should recommend.

## Command Sequence

### 1. List Projects

```json
{
  "command": "projects.list",
  "input": {
    "perPage": 100
  }
}
```

If more than one project exists, choose the project the user requested or ask
which one to inspect.

### 2. List Running Experiments

```json
{
  "command": "experiments.list",
  "input": {
    "projectId": "PROJECT_ID",
    "status": "running",
    "perPage": 100
  }
}
```

### 3. Pull Experiment Details

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

### 4. Pull Channel Reports

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

### 5. Pull Chart Data If Needed

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

Use chart data when traffic looks uneven, a deployment happened mid-test, or the
result changes sharply during the week.

### 6. Check Usage

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

## Analysis Pattern

For each experiment, report:

- experiment name and status,
- date window,
- goal,
- control visitors, conversions, revenue, and conversion rate,
- variation visitors, conversions, revenue, and conversion rate,
- absolute difference,
- relative lift,
- channel or device skew,
- sample-size caveat,
- recommended next action.

## Output Format

```text
Ready to decide
- Homepage headline test: variation is up +18.2% relative lift on Lead with
  2,392 total visitors. Channel mix looks balanced. Recommend ending the test
  and shipping the variation after stakeholder approval.

Needs more data
- Checkout button test: variation is up +6.1%, but only 19 total conversions.
  Keep running for another week.

Needs investigation
- Pricing page test: traffic dropped sharply after July 8. Check recent deploys
  and pixel loading before making a decision.
```

## Done Criteria

- Running experiments are summarized.
- Usage is checked.
- Each experiment has a recommended next action.
- No lifecycle changes are made without explicit approval.
