#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORY="MRBS-OTRS"
RELEASES=($(gh release list --repo "$OWNER"/"$REPOSITORY" | awk '{print $1}'))
for RELEASE in "${RELEASES[@]}"; do

  echo -e "\n-----------$REPOSITORY - $RELEASE-----------\n"

  read RELEASE_NAME RELEASE_TAG RELEASE_DATE RELEASE_URL RELEASE_TAR_URL RELEASE_ZIP_URL RELEASE_BODY < <(echo $(gh release view $RELEASE --repo $OWNER/$REPOSITORY --json name --json tagName --json publishedAt --json url --json tarballUrl --json zipballUrl --json body | jq -r '.name, .tagName, .publishedAt, .url, .tarballUrl, .zipballUrl, .body'))
  RELEASE_DATE=$(echo "$RELEASE_DATE" | sed -Ee "s|(T.*)||")

  echo "RELEASE_NAME: $RELEASE_NAME"
  echo "RELEASE_TAG: $RELEASE_TAG"
  echo "RELEASE_DATE: $RELEASE_DATE"
  echo "RELEASE_URL: $RELEASE_URL"
  echo "RELEASE_TAR_URL: $RELEASE_TAR_URL"
  echo "RELEASE_ZIP_URL: $RELEASE_ZIP_URL"

  echo ""
  printf "${RELEASE_BODY}"
  echo ""

done



