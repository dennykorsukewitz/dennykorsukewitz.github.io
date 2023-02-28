#!/bin/bash


OWNER="dennykorsukewitz"
# REPOSITORIES='DK4Znuny-VisualStudioCode DK4Znuny-QuickDelete DK4OTRS-UBInventory MRBS-OTRS'
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES=($(echo "$REPOSITORIES"))

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

# copy static posts
cp "$PAGES"/_posts_static/* "$PAGES"/_posts/

for REPOSITORY in "${REPOSITORIES[@]}"; do
  read RELEASE_NAME RELEASE_TAG RELEASE_DATE RELEASE_URL RELEASE_TAR_URL RELEASE_ZIP_URL RELEASE_BODY < <(echo $(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/releases/latest" | jq -r '.name, .tag_name, .published_at, .html_url, .tarball_url, .zipball_url, .body'))

  RELEASE_DATE=$(echo "$RELEASE_DATE" | sed -Ee "s|(T.*)||")

  echo "RELEASE_NAME: $RELEASE_NAME"
  echo "RELEASE_TAG: $RELEASE_TAG"
  echo "RELEASE_DATE: $RELEASE_DATE"
  echo "RELEASE_URL: $RELEASE_URL"
  echo "RELEASE_TAR_URL: $RELEASE_TAR_URL"
  echo "RELEASE_ZIP_URL: $RELEASE_ZIP_URL"

  read TOPICS  < <(echo $(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY" | jq -r '.topics'))
  echo "$TOPICS"

  echo ""
  printf "${RELEASE_BODY}"
  echo ""

  cat << EOF > "$PAGES"/_posts/"$RELEASE_DATE"-"$REPOSITORY"-Release-"$RELEASE_NAME".md
---
title: $REPOSITORY - Release $RELEASE_TAG
date: $RELEASE_DATE
author: $OWNER
categories: [DK4]
tags: $TOPICS
pin: true
---

# $RELEASE_NAME

$RELEASE_BODY

- [View this release on GitHub]($RELEASE_URL)

- [Download as .zip]($RELEASE_ZIP_URL)

- [Download as .tar.gz]($RELEASE_TAR_URL)

EOF
done

echo -e "\n-----------List all posts-----------\n"
ls -l "$PAGES"/_posts/