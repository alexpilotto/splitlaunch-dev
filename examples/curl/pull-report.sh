#!/usr/bin/env bash
set -euo pipefail

: "${SPLITLAUNCH_API_KEY:?Set SPLITLAUNCH_API_KEY to a SplitLaunch API key}"
: "${SPLITLAUNCH_PROJECT_ID:?Set SPLITLAUNCH_PROJECT_ID to the target project ID}"
: "${SPLITLAUNCH_EXPERIMENT_ID:?Set SPLITLAUNCH_EXPERIMENT_ID to the experiment ID}"
: "${SPLITLAUNCH_GOAL:=Lead}"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"reports.experiment.details\",
    \"input\": {
      \"projectId\": \"${SPLITLAUNCH_PROJECT_ID}\",
      \"experimentId\": \"${SPLITLAUNCH_EXPERIMENT_ID}\",
      \"goal\": \"${SPLITLAUNCH_GOAL}\"
    }
  }"

printf "\n\nChannel report:\n"

curl -X POST "https://www.splitlaunch.dev/api/external/v1/commands" \
  -H "Authorization: Bearer ${SPLITLAUNCH_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"reports.experiment.channels\",
    \"input\": {
      \"projectId\": \"${SPLITLAUNCH_PROJECT_ID}\",
      \"experimentId\": \"${SPLITLAUNCH_EXPERIMENT_ID}\",
      \"goal\": \"${SPLITLAUNCH_GOAL}\"
    }
  }"
