#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)
REPOSITORIES+=("DK4")
REPOSITORIES+=("dennykorsukewitz")

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Delete: $REPOSITORY"
  rm -Rf "$REPOSITORY"
done

echo "Delete: _posts/*"
rm -f _posts/*