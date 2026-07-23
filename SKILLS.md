# SplitLaunch Agent Command Playbook

This playbook describes the public SplitLaunch command surface for AI agents,
automation tools, and developers. It can be used as a Claude skill, Codex
context file, Cursor reference, Custom GPT instruction source, or general
agent command manual.

Latest live version:

```text
https://www.splitlaunch.dev/api/skills
```

This repository file is a readable snapshot. Agents should use the live URL
when they need the current command contract.

Use this document when an external agent needs to install SplitLaunch, create
projects, retrieve public pixel IDs, allowlist domains, launch URL A/B tests,
track conversions, read reports, or check usage.

## Connection Options

SplitLaunch v1 supports API-key command calls.

API command endpoint:

```text
POST https://www.splitlaunch.dev/api/external/v1/commands
```

API headers:

```text
Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

Use the canonical `www` endpoint. Do not call `https://splitlaunch.dev` from
scripts, because HTTP redirects can drop the `Authorization` header.

## Request Envelope

Every command uses this JSON shape:

```json
{
  "command": "projects.get",
  "input": {}
}
```

Successful responses include the command and returned data:

```json
{
  "command": "projects.get",
  "data": {
    "project": {
      "id": "PROJECT_ID",
      "pixelId": "px_abc123"
    }
  }
}
```

## Scope And Safety

SplitLaunch API keys can be account-level or project-scoped.

Account-level keys can manage multiple projects and create new projects when
the account plan allows it. Project-scoped keys can access only their assigned
project and cannot create new projects.

Allowed actions:

- Read project setup, pixel IDs, whitelisted domains, goals, experiments, reports,
  usage, and billing portal links.
- Create projects when the API key and plan allow it.
- Add domains to the whitelist.
- Create and update URL experiments.
- Move experiments through `draft`, `running`, `paused`, and `ended`.
- Create conversion goals.

High-impact actions that require explicit operator confirmation:

- Setting an experiment to `running`.
- Pausing or ending an active experiment.
- Changing control or variation URLs.
- Changing traffic allocation on a running experiment.
- Changing domain allowlists.
- Changing attribution window or attribution model.
- Opening billing portal actions for subscription management.

Blocked actions:

- Exposing private API keys to browser code.
- Calling internal or undocumented endpoints.
- Creating tests on domains the user does not control.
- Guessing IDs from names when an ID lookup command is available.

## Operational Defaults

- Use `projectId` when the account has more than one project.
- Pagination defaults should be treated as `page = 1` and `perPage = 25`.
- `perPage` max is `100`.
- `trafficAllocation` accepts either a percentage such as `50` or a fraction
  such as `0.5`.
- Dates for report filters can be ISO date strings or ISO date-time strings.
- `attributionWindowDays` defaults to `3` and can be between `1` and `365`.
- `attributionModel` is `last_touch` or `first_touch`; the default is
  `last_touch`.
- API keys are rate limited. Back off and retry later if the API returns a rate
  limit response.

## ID Discovery Protocol

Resolve IDs before write commands. Do not guess IDs from display names.

1. Run `projects.list` to find the right `projectId` and `pixelId`.
2. Run `projects.get` to inspect whitelisted domains and attribution settings.
3. Run `domains.list` to verify domain allowlisting.
4. Run `goals.list` to find existing conversion goals.
5. Run `experiments.list` to find current experiment IDs.
6. Use reports commands only after resolving `experimentId`.

## Agent Execution Protocol

For every action:

1. Understand the user's intended project, URLs, goal, and launch state.
2. Validate command inputs locally.
3. Resolve the right IDs.
4. Send the smallest payload that performs the intended action.
5. Parse the response and verify expected keys.
6. For write commands, read the resource back or list related resources.
7. Explain the result in plain language.

## Plan Gates

- Free includes the first project, all platform features, and 10,000 one-off
  tracked sessions. No credit card is required.
- Go is for additional projects with URL A/B testing, conversion tracking,
  domain whitelisting, MCP access, and API access. Do not use geo targeting,
  traffic-source filters, URL pattern rules, or revenue values on Go.
- Plus adds geo targeting, traffic-source filters, and revenue tracking. Do not
  use URL pattern rules on Plus.
- Pro adds URL pattern rules and custom feature support.
- When revenue tracking is not included, omit monetary `value`, `revenue`,
  `amount`, `price`, and `currency` fields. SplitLaunch records the conversion
  count but ignores revenue metadata.

## Installation Flow

User-facing setup:

1. User creates a SplitLaunch account and opens the dashboard.
2. Free projects can run immediately within the included limits. Go, Plus, and
   Pro projects use Stripe checkout before running as paid additional projects.
3. User copies the account API key.
4. In the user's website or app repository, the user or agent runs:

```bash
npm install @splitlaunch/ab
npx splitlaunch init
```

5. The terminal asks for the API key.
6. The CLI validates the key and retrieves the public pixel ID.
7. The CLI writes `splitlaunch.config.json`.
8. The CLI prints the browser pixel snippet.
9. The agent wires the pixel snippet and conversion events into the app.
10. The agent uses this playbook to create and manage experiments.

Non-interactive setup:

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init
```

Specific project:

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

## Browser Pixel

The browser pixel loads with a public pixel ID:

```html
<!-- Start of SplitLaunch Pixel -->
<script>
  window.splitlaunch = window.splitlaunch || function(){(window.splitlaunch.q=window.splitlaunch.q||[]).push(arguments)};
</script>
<script async src="https://www.splitlaunch.dev/pixel/px_your_pixel_id.js"></script>
<!-- End of SplitLaunch Pixel -->
```

The pixel collects:

- page URL and path,
- referrer URL and referrer host,
- visitor ID and session ID,
- visitor type,
- device type,
- browser language,
- timezone,
- viewport bucket,
- UTMs,
- ad click IDs such as `gclid`, `fbclid`, `msclkid`, `ttclid`, `li_fat_id`,
  `twclid`, `gbraid`, and `wbraid`,
- query snapshot,
- country and region when available,
- in-app browser detection,
- experiment ID,
- assigned variant,
- custom event data after sanitisation.

## Command Catalogue

### Projects

#### `projects.create`

Create a project and allocate a unique public pixel ID.

Mode: write

Input:

```json
{
  "name": "Acme Client",
  "allowedDomains": ["acme.com", "www.acme.com"],
  "reportingTimezone": "America/New_York",
  "attributionWindowDays": 30,
  "attributionModel": "last_touch"
}
```

Notes:

- Requires an account-level API key.
- Project-scoped API keys cannot create projects.
- `allowedDomains` are normalized as hostnames.
- Each project receives its own public `pixelId`.

#### `projects.list`

List projects available to the API key.

Mode: read-only

Input:

```json
{
  "page": 1,
  "perPage": 25
}
```

Use this first when the user mentions a client, site, or project by name.

#### `projects.get`

Return the current or requested project, public pixel ID, whitelisted domains,
attribution settings, and plan context.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID"
}
```

If `projectId` is omitted, an account-level key returns the first project. A
project-scoped key returns its assigned project.

#### `projects.update`

Update project name, domain whitelist, attribution window, or attribution model.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "name": "Acme Store",
  "allowedDomains": ["acme.com", "www.acme.com"],
  "attributionWindowDays": 60,
  "attributionModel": "first_touch"
}
```

Confirm before changing attribution settings because future report
interpretation depends on them.

#### `projects.archive`

Archive a project so its pixel stops serving experiments and accepting new
events while historical usage and reports remain available.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID"
}
```

### Domains

#### `domains.list`

List allowed customer-owned domains for a project.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID"
}
```

#### `domains.add`

Add a customer-owned domain that may load the pixel or participate in redirects.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "hostname": "example.com"
}
```

Rules:

- Use hostnames, not full URLs.
- Add both apex and subdomain if both are used.
- Add every hostname used by control and variation URLs.
- Do not add domains the user does not control.

#### `domains.remove`

Remove a customer-owned domain from a project's whitelist.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "hostname": "example.com"
}
```

Removing a domain stops future pixel loads and redirects from that hostname.

### Experiments

#### `experiments.create`

Create a URL A/B test with control URL, variation URL, traffic allocation, and
optional targeting.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "name": "Homepage headline test",
  "controlUrl": "https://example.com/",
  "variationUrl": "https://example.com/homepage-v2",
  "trafficAllocation": 50,
  "preserveRedirectParams": true,
  "targeting": {
    "deviceType": "all-devices",
    "visitorType": "all-visitors"
  },
  "urlPatternRules": []
}
```

Recommended checklist:

1. Confirm project.
2. Confirm control URL.
3. Confirm variation URL.
4. Add or verify whitelisted domains.
5. Decide traffic allocation.
6. Decide targeting filters.
7. Decide conversion goal event names.
8. Create the experiment.
9. Keep it in draft until launch approval.
10. Set status to `running`.

#### `experiments.get`

Return one experiment by ID, including status, URLs, allocation, targeting, URL
pattern rules, and timestamps.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID"
}
```

#### `experiments.update`

Change an experiment's URLs, allocation, filters, URL pattern rules, or redirect
parameter behavior.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID",
  "name": "Homepage headline test v2",
  "trafficAllocation": 25,
  "preserveRedirectParams": true,
  "targeting": {
    "visitorType": "new-visitors"
  }
}
```

Confirm before updating a running experiment.

#### `experiments.set_status`

Move an experiment through `draft`, `running`, `paused`, and `ended`.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID",
  "status": "running"
}
```

Agents should explicitly confirm before setting status to `running`, `paused`,
or `ended`.

#### `experiments.archive`

Archive an experiment by ending it while keeping exposures, conversion events,
and reports available.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID"
}
```

#### `experiments.list`

List experiments for a project with optional status filter.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "status": "running",
  "page": 1,
  "perPage": 25
}
```

### Targeting

Device targeting:

```json
{
  "targeting": {
    "deviceType": "desktop-only"
  }
}
```

Visitor targeting:

```json
{
  "targeting": {
    "visitorType": "new-visitors"
  }
}
```

Traffic source targeting:

Requires Plus or Pro.

```json
{
  "targeting": {
    "trafficFilters": {
      "utm_source": "google",
      "utm_medium": "cpc"
    }
  }
}
```

Geo targeting:

Requires Plus or Pro.

```json
{
  "targeting": {
    "geoFilters": {
      "countries": {
        "type": "include",
        "countryCodes": ["US", "AU"],
        "includeUnknown": false
      }
    }
  }
}
```

URL pattern rules:

Requires Pro.

```json
{
  "urlPatternRules": [
    {
      "conditions": [
        {
          "operator": "starts_with",
          "value": "/products/"
        }
      ]
    }
  ]
}
```

Supported URL pattern operators:

- `is`
- `contains`
- `starts_with`
- `ends_with`

### Conversion Goals

#### `goals.create`

Create a conversion goal that can be fired by the browser pixel.

Revenue values require Free, Plus, or Pro. On Go, omit `value` and track the
conversion count only.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "name": "Lead",
  "eventName": "Lead",
  "value": 100
}
```

If the goal already exists for the event name, the API updates and reactivates
it.

#### `goals.list`

List conversion goals available for experiments and reporting.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "active": true
}
```

#### `goals.deactivate`

Deactivate a conversion goal by goal ID or event name while keeping historical
reporting data.

Mode: write

Input:

```json
{
  "projectId": "PROJECT_ID",
  "eventName": "Lead"
}
```

### Custom Events

Fire conversion events in browser code after the successful action:

```js
window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request",
  plan: "Pro"
});
```

Common event names:

- `Lead`
- `Signup`
- `TrialStarted`
- `Purchase`
- `DemoBooked`
- `Subscribe`
- `ContactFormSubmitted`

Agent guidance:

- Track form conversions after successful submission.
- Track purchases after confirmed checkout or payment success.
- Include `value` and `currency` when revenue matters and the plan includes
  revenue tracking.
- Use stable event names that match goals.

### Reports

#### `reports.experiment.details`

Return experiment totals, variants, visitors, exposures, conversions, revenue,
and conversion rates.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID",
  "goal": "Lead",
  "from": "2026-07-01",
  "to": "2026-07-14"
}
```

Agents should explain:

- exposure count,
- visitor count,
- conversion count,
- conversion rate by variant,
- revenue by variant when present,
- absolute conversion-rate difference,
- relative lift,
- sample-size caveats.

#### `reports.experiment.chart`

Return time-series experiment performance.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID",
  "interval": "day",
  "goal": "Lead"
}
```

Supported intervals are `day` and `hour`.

#### `reports.experiment.channels`

Return acquisition channel and metadata performance using the pixel's collected
UTMs, click IDs, referrers, and browser context.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "experimentId": "EXPERIMENT_ID",
  "goal": "Lead",
  "from": "2026-07-01",
  "to": "2026-07-14"
}
```

Rows can include channel, source/medium, campaign, content, variant, exposures,
visitors, conversions, revenue, and conversion rate.

Agents should check whether a result is caused by a real variant difference or
by channel mix, device mix, geography, or small sample size.

### Usage And Billing

#### `usage.summary`

Return billing usage such as events, sessions, exposures, active experiments,
and plan context.

Mode: read-only

Input:

```json
{
  "projectId": "PROJECT_ID",
  "from": "2026-07-01",
  "to": "2026-07-31"
}
```

#### `billing.portal`

Create or return a billing portal link for subscription management.

Mode: write

Input:

```json
{
  "returnUrl": "https://www.splitlaunch.dev/dashboard"
}
```

Use this only when the user asks to manage billing.

## High-Value Runbooks

### Install And Verify

1. Run `npm install @splitlaunch/ab`.
2. Run `npx splitlaunch init`.
3. Verify `splitlaunch.config.json`.
4. Confirm the pixel ID starts with `px_`.
5. Add the printed pixel snippet if the CLI cannot safely edit framework files.
6. Add conversion events after successful actions.

### Onboard A New Project

1. Create or select the project.
2. Add domains to the whitelist.
3. Install the package in the customer repository.
4. Wire the pixel snippet.
5. Create the first conversion goal.
6. Fire and test the conversion event.
7. Create the first draft experiment.

### Launch A URL Experiment

1. Resolve the project.
2. Confirm control and variation URLs.
3. Allowlist both hostnames.
4. Create or confirm the conversion goal.
5. Create `experiments.create` in draft.
6. Read back `experiments.list`.
7. Ask for launch confirmation.
8. Set status to `running`.
9. Pull report data after traffic accrues.

### Weekly Optimization Cycle

1. List running experiments.
2. Pull details, chart, and channel reports for each one.
3. Check usage summary.
4. Summarize winners, inconclusive tests, risky tests, and next actions.
5. Recommend whether to keep running, pause, end, or create a follow-up test.

## Related Files

- [Quickstart](QUICKSTART.md)
- [Projects and pixel IDs](skills/projects.md)
- [Experiments](skills/experiments.md)
- [Conversion tracking](skills/conversion-tracking.md)
- [Reports](skills/reports.md)
- [Runbooks](runbooks/README.md)
