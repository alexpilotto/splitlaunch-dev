# Set Up URL Experiments

SplitLaunch experiments test existing control and variation URLs. The user keeps
their own website and SplitLaunch handles assignment, redirects, exposure
tracking, and reporting.

## When To Use This

Use a URL experiment when the user wants to test:

- a homepage against a revised homepage,
- a pricing page against a new pricing page,
- a checkout flow variant,
- a campaign landing page,
- product page template changes,
- a page generated or edited by an AI coding agent.

## Requirements

- SplitLaunch pixel installed on the relevant pages.
- Control and variation hostnames allowlisted.
- Conversion goal created.
- Conversion event fired after the successful action.
- User approval before launch.

## API Command

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

## Targeted Test Example

```json
{
  "command": "experiments.create",
  "input": {
    "projectId": "PROJECT_ID",
    "name": "Paid search mobile landing test",
    "controlUrl": "https://example.com/landing",
    "variationUrl": "https://example.com/landing-v2",
    "trafficAllocation": 50,
    "targeting": {
      "deviceType": "mobile-only",
      "trafficFilters": {
        "utm_source": "google",
        "utm_medium": "cpc"
      },
      "geoFilters": {
        "countries": {
          "type": "include",
          "countryCodes": ["US", "AU"],
          "includeUnknown": false
        }
      }
    }
  }
}
```

## Before Launch Checklist

1. Confirm the project.
2. Confirm the control URL loads.
3. Confirm the variation URL loads.
4. Confirm domains are allowlisted.
5. Confirm the pixel is installed.
6. Confirm the goal exists.
7. Confirm conversion event placement.
8. Confirm traffic allocation.
9. Confirm targeting.
10. Ask the user before setting status to `running`.

## Related Files

- [Experiments guide](../../skills/experiments.md)
- [Domains guide](../../skills/domains.md)
- [Launch URL experiment runbook](../../runbooks/launch-url-experiment.md)
