#!/usr/bin/env bash
set -euo pipefail

: "${SPLITLAUNCH_API_KEY:?Set SPLITLAUNCH_API_KEY to a SplitLaunch API key}"
: "${SPLITLAUNCH_PROJECT_ID:?Set SPLITLAUNCH_PROJECT_ID to the target project ID}"
: "${SPLITLAUNCH_HOSTNAME:=example.com}"
: "${SPLITLAUNCH_GOAL_NAME:=Lead}"
: "${SPLITLAUNCH_EVENT_NAME:=Lead}"
: "${SPLITLAUNCH_GOAL_VALUE:=100}"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"domains.add\",
    \"input\": {
      \"projectId\": \"${SPLITLAUNCH_PROJECT_ID}\",
      \"hostname\": \"${SPLITLAUNCH_HOSTNAME}\"
    }
  }"

printf "\n\nCreating conversion goal:\n"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"goals.create\",
    \"input\": {
      \"projectId\": \"${SPLITLAUNCH_PROJECT_ID}\",
      \"name\": \"${SPLITLAUNCH_GOAL_NAME}\",
      \"eventName\": \"${SPLITLAUNCH_EVENT_NAME}\",
      \"value\": ${SPLITLAUNCH_GOAL_VALUE}
    }
  }"

cat <<'SNIPPET'

Browser conversion event example:

window.splitlaunch("track", "Lead", {
  value: 100,
  form: "Demo request"
});
SNIPPET
