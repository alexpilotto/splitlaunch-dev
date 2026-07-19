# SplitLaunch Runbooks

Runbooks are repeatable agent workflows for installing SplitLaunch, creating
projects, launching URL A/B tests, and reviewing performance.

## Runbook Index

- [Onboard a new project](onboard-new-project.md)
- [Launch a URL experiment](launch-url-experiment.md)
- [Weekly optimization cycle](weekly-optimization.md)

## Shared Safety Rules

- Resolve the correct project before writes.
- Keep API keys out of browser code.
- Use only public pixel IDs in browser snippets.
- Allowlist domains before launch.
- Create experiments in draft first.
- Confirm before setting a test to `running`, `paused`, or `ended`.
- Read back resources after write commands.
