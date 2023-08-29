#!/bin/bash

REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES+=("DK4")

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Delete: $REPOSITORY"
  rm -Rf "$REPOSITORY"
done

rm -f _posts/*
rm -f _data/repositories.yml
rm -Rf dennykorsukewitz