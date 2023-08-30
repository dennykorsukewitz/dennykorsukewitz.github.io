#!/bin/bash

REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))

ls -alih _data
touch _data/repositories.yml
for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Add $REPOSITORY to _data/repositories.yml"
  echo "- $REPOSITORY" >> _data/repositories.yml
done
