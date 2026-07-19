#!/usr/bin/env bash
set -euo pipefail

: "${SPLITLAUNCH_API_KEY:?Set SPLITLAUNCH_API_KEY to a SplitLaunch API key}"
: "${SPLITLAUNCH_PROJECT_NAME:=Acme Client}"
: "${SPLITLAUNCH_ALLOWED_DOMAIN:=example.com}"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"projects.create\",
    \"input\": {
      \"name\": \"${SPLITLAUNCH_PROJECT_NAME}\",
      \"allowedDomains\": [\"${SPLITLAUNCH_ALLOWED_DOMAIN}\"],
      \"reportingTimezone\": \"UTC\",
      \"attributionWindowDays\": 30,
      \"attributionModel\": \"last_touch\"
    }
  }"
