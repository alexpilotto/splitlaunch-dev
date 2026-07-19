# SplitLaunch Quickstart For AI Agents

SplitLaunch gives AI coding agents and developers a controlled way to install a
browser pixel, launch URL A/B tests, track conversions, and retrieve experiment
performance.

Use this quickstart when you are working inside the user's website or app
repository. For the current command catalogue, use the live skills page:

```text
https://www.splitlaunch.dev/api/skills
```

## 1. Get An API Key

Create a SplitLaunch account, activate the trial or subscription, and copy an
API key from the dashboard.

API keys use the `sl_live_` prefix. Keep them secret.

Never commit a real API key to GitHub. Never put it in browser code.

## 2. Install The Package

Run this in the customer website or app repository:

```bash
npm install @splitlaunch/ab
npx splitlaunch init
```

The CLI asks:

```text
Paste your SplitLaunch API key:
```

After validation, it retrieves the public pixel ID, writes
`splitlaunch.config.json`, and prints the browser pixel snippet.

## 3. Non-Interactive Setup

For CI, local automation, or an AI agent that already has the key:

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init
```

For a specific project:

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init --project PROJECT_ID
```

Useful CLI commands:

```bash
npx splitlaunch projects list
npx splitlaunch pixel status
npx splitlaunch docs
npx splitlaunch skills
```

## 4. Verify The Project And Pixel

Use the command endpoint:

```bash
curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "command": "projects.get",
    "input": {}
  }'
```

The response includes the project, public pixel ID, allowed domains, attribution
settings, and plan context.

## 5. Allowlist Domains

Before launching a redirecting test, allowlist every hostname used by the
control and variation URLs:

```json
{
  "command": "domains.add",
  "input": {
    "projectId": "PROJECT_ID",
    "hostname": "example.com"
  }
}
```

Use hostnames such as `example.com` or `www.example.com`, not full URLs.

## 6. Create A Draft Experiment

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

`trafficAllocation` is the share of eligible visitors assigned to the variation.
Agents may send `50` or `0.5`; both represent 50%.

## 7. Create A Goal And Fire Events

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

Fire the event only after the successful user action:

```js
window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request"
});
```

## 8. Launch After Confirmation

Confirm the URLs, allowed domains, goal, and allocation with the operator, then
set the experiment to `running`:

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

## 9. Pull Results

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

For acquisition and channel context:

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

Agents should explain sample size, exposure count, visitors, conversions,
conversion rate by variant, absolute difference, relative lift, revenue, channel
skew, and whether more data is needed.

## Next Files

- [SKILLS.md](SKILLS.md) for the command playbook.
- [Projects guide](skills/projects.md) for project and pixel ID setup.
- [Experiments guide](skills/experiments.md) for URL tests and targeting.
- [Conversion tracking guide](skills/conversion-tracking.md) for events.
- [Reports guide](skills/reports.md) for analysis.
