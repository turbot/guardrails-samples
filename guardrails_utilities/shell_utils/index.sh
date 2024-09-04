#!/usr/bin/env bash -x

curl \
  --request POST \
  "${TURBOT_GRAPHQL_ENDPOINT}" \
  --user "${TURBOT_ACCESS_KEY_ID}:${TURBOT_SECRET_ACCESS_KEY}" \
  --header "Content-Type: application/json" \
  --verbose \
  --data @query.json
