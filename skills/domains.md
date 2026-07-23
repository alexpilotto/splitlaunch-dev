# Domains API

SplitLaunch should only load pixels and redirect traffic on domains the customer
controls. Agents should verify domain allowlisting before launching experiments.

## Core Commands

- `domains.list`: list whitelisted domains for a project.
- `domains.add`: add a customer-owned hostname.
- `projects.get`: read the project's current domain whitelist.
- `projects.update`: replace the project's domain whitelist when needed.

## List Domains

```json
{
  "command": "domains.list",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

Use this before `experiments.set_status` when the experiment redirects traffic.

## Add A Domain

```json
{
  "command": "domains.add",
  "input": {
    "projectId": "PROJECT_ID",
    "hostname": "example.com"
  }
}
```

Hostname rules:

- Use hostnames, not full page URLs.
- Use `example.com`, not `https://example.com/pricing`.
- Add both apex and subdomain when both are used.
- Add every hostname used by the control URL and variation URL.
- Add each participating subdomain for cross-subdomain tests.

## Example Sequence

```json
{
  "command": "domains.add",
  "input": {
    "projectId": "PROJECT_ID",
    "hostname": "example.com"
  }
}
```

```json
{
  "command": "domains.add",
  "input": {
    "projectId": "PROJECT_ID",
    "hostname": "www.example.com"
  }
}
```

```json
{
  "command": "domains.list",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

## Agent Safety

- Do not add domains the user does not own or control.
- Confirm unusual cross-domain tests with the user.
- If the variation URL uses a different hostname, allowlist it too.
- Read back domains before launch.

## Related Files

- [Projects](projects.md)
- [Experiments](experiments.md)
- [URL experiment runbook](../runbooks/launch-url-experiment.md)
