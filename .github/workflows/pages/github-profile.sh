#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORY='dennykorsukewitz'

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

git clone "https://github.com/$OWNER/$REPOSITORY" $REPOSITORY

TEMPLATE="---
layout: page
# Index page
category: $REPOSITORY
toc: true
---

"

echo "$TEMPLATE" | cat - "$REPOSITORY"/README.md > temp && mv temp "$PAGES"/index.md