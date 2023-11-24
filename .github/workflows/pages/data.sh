#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)

cat /dev/null > _data/repositories.yml

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Add $REPOSITORY to _data/repositories.yml"
  echo "- $REPOSITORY" >> _data/repositories.yml
done
