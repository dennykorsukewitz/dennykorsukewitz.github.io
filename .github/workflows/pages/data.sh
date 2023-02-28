#!/bin/bash

OWNER="dennykorsukewitz"
TOPIC="pages"

REPOSITORIES=($(gh search repos --owner "$OWNER" --topic "$TOPIC" --jq '.[].name' --json name))
for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Add $REPOSITORY to _data/repositories.yml"
  echo "- $REPOSITORY" >> _data/repositories.yml
done
