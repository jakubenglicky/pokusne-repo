#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Slack webhook URL not provided"
  exit 1
fi

webhook_url=$1

LATEST_TAG=$(git describe --abbrev=0 --tags)
PREVIOUS_TAG=$(git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1))
echo $LATEST_TAG
echo $PREVIOUS_TAG

echo "$(git log --pretty=format:'%an: %s' --reverse $PREVIOUS_TAG...$LATEST_TAG)" >> git.log
log=$(cat git.log)

payload=$(cat <<EOF
{
  "text": ":rocket: Nasazeno :ok_hand: \n*Změny:* \n$log"
}
EOF
)

curl -X POST -H 'Content-type: application/json' --data "$payload" "$webhook_url"

rm git.log
