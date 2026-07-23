# Projects And Pixel IDs API

Projects separate websites, client accounts, pixel IDs, domains, experiments,
goals, attribution settings, and usage. Agents should resolve the correct
project before installing the pixel or creating an experiment.

## Core Commands

- `projects.create`: create a project and allocate a public pixel ID.
- `projects.list`: list projects available to the API key.
- `projects.get`: inspect one project, its pixel ID, whitelisted domains, and
  attribution settings.
- `projects.update`: rename a project, replace the domain whitelist, or update
  attribution settings.
- `projects.archive`: archive a project so its pixel stops serving experiments
  while historical usage and reports remain available.

## List Projects

```json
{
  "command": "projects.list",
  "input": {
    "page": 1,
    "perPage": 25
  }
}
```

Use this when the user says "for Client A", "for the ecommerce project", or
"for this site" and the `projectId` is not known.

## Get A Project

```json
{
  "command": "projects.get",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

The response includes the public `pixelId`. Browser code can use the pixel ID.
The private API key must stay server-side, terminal-side, CI-side, or agent-side.

## Create A Project

```json
{
  "command": "projects.create",
  "input": {
    "name": "Acme Client",
    "allowedDomains": ["acme.com", "www.acme.com"],
    "reportingTimezone": "America/New_York",
    "attributionWindowDays": 30,
    "attributionModel": "last_touch"
  }
}
```

Rules:

- Requires an account-level API key.
- Project-scoped API keys cannot create projects.
- `allowedDomains` should be hostnames, not full URLs.
- Each project gets a unique public pixel ID.

## Update A Project

```json
{
  "command": "projects.update",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "Acme Store",
    "attributionWindowDays": 60,
    "attributionModel": "first_touch"
  }
}
```

Attribution guidance:

- Use `last_touch` when the latest experiment exposure before conversion should
  get credit.
- Use `first_touch` when the first experiment exposure in the window should get
  credit.
- SplitLaunch defaults to a 3-day attribution window and `last_touch`.
- The maximum attribution window is 365 days.
- Short-cycle ecommerce tests usually use 3 to 7 days and `last_touch`.
- Lead-gen, local service, SaaS, or B2B projects may need 30 to 90 days.

## Archive A Project

```json
{
  "command": "projects.archive",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

Archiving a project stops its pixel from serving experiments or accepting new
events. Historical usage and reports remain available.

## Install For A Project

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init --project PROJECT_ID
```

The CLI retrieves that project's public pixel ID and writes local setup config.

## Agent Protocol

1. Run `projects.list` when the project is ambiguous.
2. Run `projects.get` before installing or creating tests.
3. Verify whitelisted domains before experiments.
4. Use `projectId` on all write commands for multi-project accounts.
5. Confirm with the user before attribution changes.

## Related Files

- [Domains](domains.md)
- [Experiments](experiments.md)
- [Onboard new project runbook](../runbooks/onboard-new-project.md)
