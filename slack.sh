#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Slack webhook URL not provided"
  exit 1
fi

webhook_url=$1
log=$(cat git.log)

payload=$(cat <<EOF
{
  "text": ":rocket: Nasazeno :ok_hand: \n*Změny:* \n$log"
}
EOF
)

curl -X POST -H 'Content-type: application/json' --data "$payload" "$webhook_url"
