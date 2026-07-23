# A/B Testing And Experiments API

SplitLaunch experiments run between existing URLs. The pixel and command API
handle sticky visitor assignment, traffic allocation, redirects, targeting,
exposure tracking, and report retrieval.

## Core Commands

- `experiments.create`: create a draft URL A/B test.
- `experiments.get`: inspect one experiment by ID.
- `experiments.update`: update mutable experiment settings.
- `experiments.set_status`: move an experiment through `draft`, `running`,
  `paused`, and `ended`.
- `experiments.archive`: end an experiment while keeping historical reports.
- `experiments.list`: list experiments for a project.
- `reports.experiment.details`: read experiment totals.
- `reports.experiment.chart`: read time-series performance.
- `reports.experiment.channels`: read channel-segmented performance.

## Create A Draft Experiment

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

`trafficAllocation` means the percentage of eligible visitors assigned to the
variation URL. Agents may send `50` or `0.5`; both represent 50%.

## Get An Experiment

```json
{
  "command": "experiments.get",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID"
  }
}
```

Use this before updating or archiving a specific experiment.

## Targeting Fields

Plan gates:

- Go supports standard URL A/B testing and conversions, but not geo targeting,
  traffic-source filters, or URL pattern rules.
- Plus supports geo targeting and traffic-source filters, but not URL pattern
  rules.
- Pro supports all targeting, including URL pattern rules.

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

Traffic source filters:

Requires Plus or Pro.

```json
{
  "targeting": {
    "trafficFilters": {
      "utm_source": "google",
      "utm_medium": "cpc",
      "utm_campaign": "winter-sale"
    }
  }
}
```

Geo filters:

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

## URL Pattern Rules

Requires Pro. Use URL pattern rules when one experiment should match multiple
paths.

```json
{
  "command": "experiments.create",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "All product pages CTA",
    "controlUrl": "https://example.com/products/widget",
    "variationUrl": "https://example.com/products/widget-v2",
    "trafficAllocation": 50,
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
}
```

Supported operators:

- `is`
- `contains`
- `starts_with`
- `ends_with`

## Archive An Experiment

```json
{
  "command": "experiments.archive",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID"
  }
}
```

Archiving ends the experiment and keeps exposures, conversion events, and
reports available.

## Update An Experiment

```json
{
  "command": "experiments.update",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "trafficAllocation": 25,
    "targeting": {
      "visitorType": "new-visitors"
    }
  }
}
```

Confirm before updating a running experiment.

## Launch, Pause, And End

Launch:

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

Pause:

```json
{
  "command": "experiments.set_status",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "status": "paused"
  }
}
```

End:

```json
{
  "command": "experiments.set_status",
  "input": {
    "projectId": "PROJECT_ID",
    "experimentId": "EXPERIMENT_ID",
    "status": "ended"
  }
}
```

## Agent Checklist

1. Resolve the project.
2. Confirm control URL.
3. Confirm variation URL.
4. Allowlist every hostname involved.
5. Create or confirm the conversion goal.
6. Decide allocation and targeting.
7. Create the experiment.
8. Read back the experiment list.
9. Ask before launch.
10. Set status to `running`.

## Guardrails

- Create experiments in draft first.
- Do not run tests on domains the user does not control.
- Do not change a running experiment without confirmation.
- Track conversion events only after successful user actions.
- Pull reports after enough traffic has accrued.

## Related Files

- [Domains](domains.md)
- [Conversion tracking](conversion-tracking.md)
- [Reports](reports.md)
- [Launch experiment example](../examples/curl/launch-experiment.sh)
- [Launch URL experiment runbook](../runbooks/launch-url-experiment.md)
