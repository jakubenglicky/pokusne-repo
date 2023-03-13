#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Slack webhook URL not provided"
  exit 1
fi

webhook_url=$1
latest_tag=$(git describe --abbrev=0 --tags)
previous_tag=$(git describe --abbrev=0 --tags "$latest_tag^")
log=$(git log "$previous_tag..$latest_tag" --pretty=format:'%an: %s')

payload=$(cat <<EOF
{
  "text": ":rocket: Nasazeno :ok_hand: \n*Změny:* \n$log"
}
EOF
)

curl -X POST -H 'Content-type: application/json' --data "$payload" "$webhook_url"
