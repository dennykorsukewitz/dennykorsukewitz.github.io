#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES+=("DK4")

# REPOSITORIES="dennykorsukewitz"

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

cat << EOF > "$PAGES"/monitoring.md
---
layout: page
popup: false
---

EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"

  BRANCHES=($(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name' ))

      cat << EOF >> "$PAGES"/monitoring.md
<hr>

## $REPOSITORY

EOF

  for BRANCHE in "${BRANCHES[@]}"; do

    echo -e "\n-----------$REPOSITORY - $BRANCHE-----------\n"
      cat << EOF >> "$PAGES"/monitoring.md

<div class="post-tag btn btn-outline-primary"><a href="https://github.com/$OWNER/$REPOSITORY/actions?query=branch%3A$BRANCHE" target="_blank">$BRANCHE</a></div>
EOF

    WORKFLOWS=($(gh api -XGET /repos/$OWNER/$REPOSITORY/actions/workflows --jq '.workflows[]' | sed 's/[[:space:]]//g'))

    # gh api -XGET https://api.github.com/repos/$OWNER/$REPOSITORY/commits/dev/check-runs --jq '.check_runs[].name' --field 'filter=latest'
    # echo $WORKFLOWS

    for WORKFLOW in "${WORKFLOWS[@]}"; do
      WORKFLOW_NAME=$(echo $WORKFLOW | jq '.name' | sed 's/\"//g')
      WORKFLOW_BADGE_URL=$(echo $WORKFLOW | jq '.badge_url' | sed 's/\"//g')

      if [ -z "$WORKFLOW_NAME" ];then
        break
      fi

      cat << EOF >> "$PAGES"/monitoring.md
![$WORKFLOW_NAME]($WORKFLOW_BADGE_URL?branch=$BRANCHE){: .normal}
EOF

    done
  done
done
