# Conversion Tracking API

SplitLaunch tracks custom conversion events through the browser pixel. Agents
should create goals for important event names, then wire browser events after
successful user actions.

## Core Commands

- `goals.create`: create or reactivate a conversion goal.
- `goals.list`: list goals for a project.
- `reports.experiment.details`: inspect conversion totals.
- `reports.experiment.channels`: inspect conversions by acquisition channel.

## Create A Goal

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

If the same `eventName` already exists for the project, SplitLaunch updates it
and marks it active.

## List Goals

```json
{
  "command": "goals.list",
  "input": {
    "projectId": "PROJECT_ID",
    "active": true
  }
}
```

## Fire A Browser Event

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

## Revenue Events

For purchases or subscriptions, include value and currency when available:

```js
window.splitlaunch("track", "Purchase", {
  value: 249,
  currency: "USD",
  orderId: "ORDER_ID"
});
```

Use the customer's real event data when possible. Do not fire purchase events
before payment is confirmed.

## Form Events

For forms, fire the event after a successful submission:

```js
async function submitLeadForm(payload) {
  const response = await fetch("/api/lead", {
    method: "POST",
    body: JSON.stringify(payload)
  });

  if (response.ok) {
    window.splitlaunch?.("track", "Lead", {
      form: "Demo request"
    });
  }
}
```

Do not track conversions on initial button click unless the click itself is the
conversion.

## Attribution Behavior

If the visitor was previously exposed to a running experiment, SplitLaunch keeps
active experiment and variant context and attaches it to later conversion
events. The ingestion API can also use the visitor's latest eligible exposure
when a conversion event arrives without explicit experiment fields.

## Agent Checklist

1. Ask what action counts as a conversion.
2. Create or confirm the matching goal.
3. Add the browser event after the successful action.
4. Include `value` and `currency` for revenue events.
5. Avoid duplicate firing on retries or validation errors.
6. Pull experiment reports after traffic accrues.

## Related Files

- [Experiments](experiments.md)
- [Reports](reports.md)
- [Tracking knowledge-base article](../kb/tracking/install-pixel-and-events.md)
