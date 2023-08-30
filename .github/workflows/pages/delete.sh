#!/bin/bash

REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES+=("DK4")
REPOSITORIES+=("dennykorsukewitz")
REPOSITORIES+=("_posts")

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Delete: $REPOSITORY"
  rm -Rf "$REPOSITORY"
done


echo "Delete: _posts/*"
rm -f _posts/*