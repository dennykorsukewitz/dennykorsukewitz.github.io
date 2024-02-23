#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)
REPOSITORIES+=("DK4")
REPOSITORIES+=("dennykorsukewitz.github.io")

# REPOSITORIES="dennykorsukewitz"

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

cat << EOF > "$PAGES"/workflows.md
---
layout: page
popup: false
---

EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"

  mapfile -t BRANCHES < <(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name')

      cat << EOF >> "$PAGES"/workflows.md
<hr>

## $REPOSITORY

EOF

  for BRANCHE in "${BRANCHES[@]}"; do

    echo -e "\n-----------$REPOSITORY - $BRANCHE-----------\n"
      cat << EOF >> "$PAGES"/workflows.md

<div class="post-tag btn btn-outline-primary"><a href="https://github.com/$OWNER/$REPOSITORY/actions?query=branch%3A$BRANCHE" target="_blank">$BRANCHE</a></div>
EOF


    mapfile -t WORKFLOWS < <(gh api -XGET /repos/"$OWNER"/"$REPOSITORY"/actions/workflows --jq '.workflows[]' | sed 's/[[:space:]]//g')

    for WORKFLOW in "${WORKFLOWS[@]}"; do
      BRANCHE_URL="branch=$BRANCHE"
      WORKFLOW_NAME=$(echo "$WORKFLOW" | jq '.name' | sed 's/\"//g')
      WORKFLOW_URL=$(echo "$WORKFLOW" | jq '.badge_url' | sed 's/\"//g' | sed 's/workflows.*//g' )
      WORKFLOW_PATH=$(echo "$WORKFLOW" | jq '.path' | sed 's/\"//g' | sed 's/.github\///g' )

      WORKFLOW_BADGE_URL="${WORKFLOW_URL}actions/${WORKFLOW_PATH}/badge.svg"

      if [ -z "$WORKFLOW_NAME" ];then
        break
      fi

      if [ "$WORKFLOW_NAME" == "Release" ];then
        BRANCHE_URL=""
      fi

      cat << EOF >> "$PAGES"/workflows.md
![$WORKFLOW_NAME]($WORKFLOW_BADGE_URL?$BRANCHE_URL){: .normal}
EOF

    done
  done
done
