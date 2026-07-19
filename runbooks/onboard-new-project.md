# Onboard A New SplitLaunch Project

Use this when the user wants a new website, client, brand, or product tracked
separately in SplitLaunch.

## Inputs To Collect

- Project name
- Website hostnames
- Reporting timezone
- Attribution window
- Attribution model
- Primary conversion event name
- Estimated conversion value, if useful

## Command Sequence

### 1. Create The Project

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

Save the returned `projectId` and public `pixelId`.

### 2. Verify The Project

```json
{
  "command": "projects.get",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

### 3. Install The Package In The Website Repo

```bash
SPLITLAUNCH_API_KEY=sl_live_REPLACE_WITH_REAL_KEY npx splitlaunch init --project PROJECT_ID
```

If the CLI cannot safely edit framework files, add the printed browser snippet
in the app's global layout, document head, tag manager, or equivalent browser
entrypoint.

### 4. Create The First Goal

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

### 5. Wire The Conversion Event

```js
window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request"
});
```

Fire this only after the form, signup, purchase, or booking succeeds.

### 6. Confirm Setup

```json
{
  "command": "domains.list",
  "input": {
    "projectId": "PROJECT_ID"
  }
}
```

```json
{
  "command": "goals.list",
  "input": {
    "projectId": "PROJECT_ID",
    "active": true
  }
}
```

## Done Criteria

- Project exists.
- Public pixel ID is known.
- Required hostnames are allowlisted.
- Pixel is installed in the customer website or app.
- First conversion goal exists.
- Browser event is wired after a successful action.
- The user knows the next step is creating a draft experiment.
