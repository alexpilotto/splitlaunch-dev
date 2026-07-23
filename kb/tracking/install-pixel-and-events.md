# Install The Pixel And Track Events

SplitLaunch uses a public pixel ID in browser code and a private API key for
server, terminal, CI, and agent-side commands.

## Install With The CLI

```bash
npm install @splitlaunch/ab
npx splitlaunch init
```

The CLI asks for a private API key, validates it, retrieves the public pixel ID,
writes local setup config, and prints the browser snippet.

## Manual Pixel Snippet

```html
<!-- Start of SplitLaunch Pixel -->
<script>
  window.splitlaunch = window.splitlaunch || function(){(window.splitlaunch.q=window.splitlaunch.q||[]).push(arguments)};
</script>
<script async src="https://www.splitlaunch.dev/pixel/px_your_pixel_id.js"></script>
<!-- End of SplitLaunch Pixel -->
```

## Create A Goal

Revenue values require Free, Plus, or Pro. On Go, omit `value` and track the
conversion count only.

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

## Track A Conversion

```js
window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request"
});
```

Fire events after success:

- after a form submits successfully,
- after a user signs up,
- after payment completes,
- after a booking is confirmed,
- after a subscription starts.

Do not fire conversion events on initial click unless the click itself is the
conversion.

## Useful Metadata

For revenue on plans that include revenue tracking:

```js
window.splitlaunch("track", "Purchase", {
  value: 249,
  currency: "USD",
  orderId: "ORDER_ID"
});
```

For leads:

```js
window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request",
  plan: "Pro"
});
```

## Related Files

- [Conversion tracking guide](../../skills/conversion-tracking.md)
- [Quickstart](../../QUICKSTART.md)
- [Setup tracking example](../../examples/curl/setup-tracking.sh)
