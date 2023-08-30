#!/bin/bash

REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES+=("DK4")
REPOSITORIES+=("dennykorsukewitz")
REPOSITORIES+=("_posts")

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Delete: $REPOSITORY"
  rm -Rf "$REPOSITORY"
done

echo "Delete: _data/repositories.yml"
rm -f _data/repositories.yml


touch _posts/.placeholder