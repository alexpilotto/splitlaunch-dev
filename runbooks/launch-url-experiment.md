# Launch A URL A/B Experiment

Use this when the user wants to test an existing control URL against an existing
variation URL.

## Inputs To Collect

- `projectId`
- Experiment name
- Control URL
- Variation URL
- Traffic allocation
- Primary conversion goal
- Device targeting, if any
- Visitor targeting, if any
- Traffic source filters, if any
- Geo filters, if any
- URL pattern rules, if any

## Command Sequence

### 1. Resolve Project

```json
{
  "command": "projects.get",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

### 2. Add Required Domains

Add every hostname used by the control and variation URLs:

```json
{
  "command": "domains.add",
  "input": {
    "projectId": "PROJECT_ID",
    "hostname": "example.com"
  }
}
```

Read back the list:

```json
{
  "command": "domains.list",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

### 3. Confirm Or Create Goal

```json
{
  "command": "goals.list",
  "input": {
    "projectId": "PROJECT_ID",
    "active": true
  }
}
```

If needed:

```json
{
  "command": "goals.create",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "Lead",
    "eventName": "Lead",
    "value": 100
  }
}
```

### 4. Create Draft Experiment

```json
{
  "command": "experiments.create",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "Homepage headline test",
    "controlUrl": "https://example.com/",
    "variationUrl": "https://example.com/homepage-v2",
    "trafficAllocation": 50,
    "preserveRedirectParams": true
  }
}
```

### 5. Read Back Experiment

```json
{
  "command": "experiments.list",
  "input": {
    "projectId": "PROJECT_ID",
    "status": "draft",
    "perPage": 25
  }
}
```

### 6. Launch After Approval

Confirm launch with the operator first.

```json
{
  "command": "experiments.set_status",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "status": "running"
  }
}
```

### 7. Monitor Results

```json
{
  "command": "reports.experiment.details",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "goal": "Lead"
  }
}
```

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "goal": "Lead"
  }
}
```

## Done Criteria

- Domains are allowlisted.
- Goal exists and browser event is wired.
- Experiment exists.
- User approved launch.
- Experiment status is `running`.
- First reporting check is scheduled.
