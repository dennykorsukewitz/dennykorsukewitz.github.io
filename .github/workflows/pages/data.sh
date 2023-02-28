#!/bin/bash

OWNER="dennykorsukewitz"
TOPIC="pages"

readarray type< <(./jq r _data/repositories.yml 'type[*]')

cat _data/repositories.yml | jq

REPOSITORIES=($(gh search repos --owner "$OWNER" --topic "$TOPIC" --jq '.[].name' --json name))
for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Add $REPOSITORY to _data/repositories.yml"
  echo "- $REPOSITORY" >> _data/repositories.yml
done
