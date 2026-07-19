#!/usr/bin/env bash
set -euo pipefail

: "${SPLITLAUNCH_API_KEY:?Set SPLITLAUNCH_API_KEY to a SplitLaunch API key}"
: "${SPLITLAUNCH_PROJECT_ID:?Set SPLITLAUNCH_PROJECT_ID to the target project ID}"
: "${SPLITLAUNCH_CONTROL_URL:?Set SPLITLAUNCH_CONTROL_URL to the control URL}"
: "${SPLITLAUNCH_VARIATION_URL:?Set SPLITLAUNCH_VARIATION_URL to the variation URL}"
: "${SPLITLAUNCH_EXPERIMENT_NAME:=Homepage headline test}"
: "${SPLITLAUNCH_TRAFFIC_ALLOCATION:=50}"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"experiments.create\",
    \"input\": {
      \"projectId\": \"${SPLITLAUNCH_PROJECT_ID}\",
      \"name\": \"${SPLITLAUNCH_EXPERIMENT_NAME}\",
      \"controlUrl\": \"${SPLITLAUNCH_CONTROL_URL}\",
      \"variationUrl\": \"${SPLITLAUNCH_VARIATION_URL}\",
      \"trafficAllocation\": ${SPLITLAUNCH_TRAFFIC_ALLOCATION},
      \"preserveRedirectParams\": true
    }
  }"

printf "\nCreated the experiment draft. Review it, then launch with experiments.set_status when approved.\n"
