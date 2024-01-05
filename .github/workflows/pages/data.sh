#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

cat /dev/null > "$PAGES"/_data/repositories.yml

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Add $REPOSITORY to "$PAGES"/_data/repositories.yml"
  echo "- $REPOSITORY" >> "$PAGES"/_data/repositories.yml
done
