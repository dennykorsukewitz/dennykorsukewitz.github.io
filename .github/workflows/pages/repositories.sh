#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name | sort))
REPOSITORIES+=("DK4")

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"
  git clone "https://github.com/$OWNER/$REPOSITORY" "$PAGES"/"$REPOSITORY"

  read TOPICS  < <(echo $(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY" | jq -r '.topics'))

  MARKDOWN_FILES=($(find "$PAGES"/"$REPOSITORY" -name "*.md" -print0 | xargs -0 -I file))
  
  # find "$PAGES"/"$REPOSITORY" -type d -not -name doc -not -name logs -exec rm -R {} \;
  for MARKDOWN_FILE in "${MARKDOWN_FILES[@]}"; do

    echo -e "\n-----------MARKDOWN_FILE-----------\n"
    echo "$MARKDOWN_FILE"

    FILE_PATH="$MARKDOWN_FILE"
    FILE_NAME="$(basename $FILE_PATH)"
    md='.md'
    TITLE="${FILE_NAME%$md}"

    TEMPLATE="---
layout: page
title: $REPOSITORY
repository: $REPOSITORY
tags: $TOPICS
toc: true
---

    "
    echo "$TEMPLATE" | cat - "$FILE_PATH" > temp && mv temp "$FILE_PATH"

    if [ -z "$GITHUB_WORKSPACE" ];then
      sed -i '' 's/.md)/)/g' "$FILE_PATH"
    else
      sed -i 's/.md)/)/g' "$FILE_PATH"
    fi

    echo -e "\n-----------FILE-----------\n"
    cat "$FILE_PATH"


  done

  mv "$PAGES"/"$REPOSITORY"/README.md "$PAGES"/"$REPOSITORY"/index.md
 # find "$PAGES"/"$REPOSITORY" -not -name "*.md" -exec rm -R {} \;

done
