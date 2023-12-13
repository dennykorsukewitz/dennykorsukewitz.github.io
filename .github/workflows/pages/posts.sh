#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

# copy static posts
cp "$PAGES"/_static/_posts/* "$PAGES"/_posts/

for REPOSITORY in "${REPOSITORIES[@]}"; do

  RELEASES=($(gh release list --repo "$OWNER"/"$REPOSITORY" | awk '{print $1}'))

  read TOPICS  < <(echo $(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY" | jq -r '.topics'))

  TOPICS=$(echo "$TOPICS" | sed 's/\"pages\", //g')
  # echo "TOPICS"
  # echo "$TOPICS"

  for RELEASE in "${RELEASES[@]}"; do
    echo -e "\n-----------$REPOSITORY - $RELEASE-----------\n"

    read RELEASE_NAME RELEASE_TAG RELEASE_DATE RELEASE_URL RELEASE_TAR_URL RELEASE_ZIP_URL < <(echo $(gh release view $RELEASE --repo "$OWNER"/"$REPOSITORY" --json name --json tagName --json publishedAt --json url --json tarballUrl --json zipballUrl --json body | jq -r '.name, .tagName, .publishedAt, .url, .tarballUrl, .zipballUrl'))

    # gh release view "1.2.0" -R dennykorsukewitz/VSCode-Znuny --json body --jq .body
    RELEASE_BODY=`gh release view $RELEASE --repo "$OWNER"/"$REPOSITORY" --json body --jq .body`

    RELEASE_DATE=$(echo "$RELEASE_DATE" | sed -Ee "s|(T.*)||")

    PIN='false'
    LAST_MODIFIED_AT=''
    if [ "${RELEASES[0]}" == "$RELEASE" ]; then
      PIN='true'

      # optional
      LAST_MODIFIED_AT="last_modified_at: $RELEASE_DATE"
    fi

    # echo "RELEASE_NAME: $RELEASE_NAME"
    # echo "RELEASE_TAG: $RELEASE_TAG"
    # echo "RELEASE_DATE: $RELEASE_DATE"
    # echo "RELEASE_URL: $RELEASE_URL"
    # echo "RELEASE_TAR_URL: $RELEASE_TAR_URL"
    # echo "RELEASE_ZIP_URL: $RELEASE_ZIP_URL"
    # echo "PIN: $PIN"

    # echo ""
    # printf "$RELEASE_BODY"
    # echo ""

    cat << EOF > "$PAGES"/_posts/"$RELEASE_DATE"-"$REPOSITORY"-Release-"$RELEASE_NAME".md
---
title: $REPOSITORY - Release $RELEASE_TAG
date: $RELEASE_DATE
author: $OWNER
categories: [DK4, $REPOSITORY]
tags: $TOPICS
toc: true
pin: $PIN
---

# $RELEASE_NAME

$RELEASE_BODY

<hr>

- [View this release on GitHub]($RELEASE_URL)
- [Download as .zip]($RELEASE_ZIP_URL)
- [Download as .tar.gz]($RELEASE_TAR_URL)

EOF
    done
  done

echo -e "\n-----------List all posts-----------\n"
ls -lA "$PAGES"/_posts/ | awk -F':[0-9]* ' '/:/{print $2}'