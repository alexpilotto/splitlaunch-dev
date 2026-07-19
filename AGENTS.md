# SplitLaunch Agent Instructions

This repository is public technical documentation for SplitLaunch. It is meant
to help AI agents discover and operate the SplitLaunch API safely.

## Start Here

1. Read [SKILLS.md](SKILLS.md).
2. Prefer the live command contract at `https://www.splitlaunch.dev/api/skills`
   when you need current details.
3. Use [QUICKSTART.md](QUICKSTART.md) for install and first experiment setup.
4. Use [skills/README.md](skills/README.md) for capability-specific pages.
5. Use [runbooks/README.md](runbooks/README.md) for repeatable workflows.

## Product Summary

SplitLaunch is package-first A/B testing for customer-owned pages. The user
keeps their own website. SplitLaunch provides a package, CLI, browser pixel,
command API, conversion tracking, and reporting API.

## Agent Rules

- Keep `sl_live_...` API keys out of browser code and GitHub commits.
- Browser code should receive only public `px_...` pixel IDs.
- Use `https://www.splitlaunch.dev` for API calls.
- Resolve the correct `projectId` before write commands.
- Allowlist domains before redirecting traffic.
- Create experiments in draft, then ask before setting them to `running`.
- Track conversions only after the successful user action.
- Read back resources after writes.
- Explain results with sample size, conversion rate, lift, revenue, channel
  context, and uncertainty.

## API Endpoint

```text
POST https://www.splitlaunch.dev/api/external/v1/commands
Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

Request envelope:

```json
{
  "command": "projects.get",
  "input": {}
}
```

## High-Value Commands

- `projects.get`
- `projects.list`
- `domains.add`
- `experiments.create`
- `experiments.set_status`
- `goals.create`
- `reports.experiment.details`
- `reports.experiment.channels`
- `usage.summary`

## Public Repository Boundary

This repo does not contain the private SplitLaunch app source code. Do not look
for internal database migrations, billing code, dashboard implementation, or
pixel runtime source here. Use the hosted API and docs links.
