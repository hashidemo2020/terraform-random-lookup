#!/bin/bash

if [ -z "$TRAVIS_TAG" ]
then
  # Update Deadline
  export KEY='deadline'
  export VALUE=$(date --utc +%FT%TZ)
  curl -sk \
    --request PATCH \
    --data "{\"data\":{\"id\":\"$VAR_ID\",\"attributes\":{\"key\":\"$KEY\",\"value\":\"$VALUE\",\"category\":\"policy-set\",\"description\":null,\"hcl\":false,\"sensitive\":false,\"read-only\":false,\"relationships\":{\"configurable\":{\"data\":{\"type\":\"policy-sets\",\"id\":\"$POLICY_ID\"}}},\"type\":\"vars\"}}" \
    -H "Content-type: application/vnd.api+json" \
    -H "Authorization: Bearer $TFE_TOKEN" \
    https://app.terraform.io/api/v2/policy-sets/$POLICY_ID/parameters/$VAR_ID

  # Update version
  # Remove leading 'v' from version number
  export KEY='version'
  export VALUE=$(echo $TRAVIS_TAG | sed -E 's/v?([0-9\.]+)/\1/')
  curl -sk \
    --request PATCH \
    --data "{\"data\":{\"id\":\"$VAR_ID\",\"attributes\":{\"key\":\"$KEY\",\"value\":\"$VALUE\",\"category\":\"policy-set\",\"description\":null,\"hcl\":false,\"sensitive\":false,\"read-only\":false,\"relationships\":{\"configurable\":{\"data\":{\"type\":\"policy-sets\",\"id\":\"$POLICY_ID\"}}},\"type\":\"vars\"}}" \
    -H "Content-type: application/vnd.api+json" \
    -H "Authorization: Bearer $TFE_TOKEN" \
    https://app.terraform.io/api/v2/policy-sets/$POLICY_ID/parameters/$VAR_ID
else
  exit 0
fi
