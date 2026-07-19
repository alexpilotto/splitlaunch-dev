# SplitLaunch Capability Guides

These guides split the SplitLaunch command surface by capability so agents can
retrieve the exact area they need without reading the whole playbook.

Use [../SKILLS.md](../SKILLS.md) as the complete command playbook and
`https://www.splitlaunch.dev/api/skills` as the latest live version.

## Guides

- [Projects and pixel IDs](projects.md)
- [Experiments](experiments.md)
- [Conversion tracking](conversion-tracking.md)
- [Domains](domains.md)
- [Reports](reports.md)
- [Usage and billing](usage-billing.md)

## Shared Command Envelope

```json
{
  "command": "projects.get",
  "input": {}
}
```

Endpoint:

```text
POST https://www.splitlaunch.dev/api/external/v1/commands
Authorization: Bearer sl_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

## Shared Safety Rules

- Keep private API keys out of browser code.
- Use only public pixel IDs in client-side snippets.
- Resolve `projectId` before writes.
- Allowlist domains before redirecting traffic.
- Confirm before launch, pause, end, or attribution changes.
- Read back resources after write commands.
