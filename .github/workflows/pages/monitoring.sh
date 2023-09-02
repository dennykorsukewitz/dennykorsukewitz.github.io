#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name))
REPOSITORIES+=("DK4")

REPOSITORIES="DK4Znuny-QuickDelete"

# OWNER="dennykorsukewitz"
# REPOSITORIES="dennykorsukewitz"

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

cat << EOF > "$PAGES"/_tabs/monitoring.md
---
layout: page
popup: false
icon: fa fa-cubes
---

EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"

  BRANCHES=($(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name' ))

      cat << EOF >> "$PAGES"/_tabs/monitoring.md
<hr>
## $REPOSITORY

EOF


  for BRANCHE in "${BRANCHES[@]}"; do

    echo -e "\n-----------$REPOSITORY - $BRANCHE-----------\n"

    # gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/dennykorsukewitz/dennykorsukewitz/actions/workflows | jq '.workflows[].name'

      cat << EOF >> "$PAGES"/_tabs/monitoring.md
<div class="post-tag btn btn-outline-primary">$BRANCHE</div>
EOF


    WORKFLOWS=($(gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/$OWNER/$REPOSITORY/actions/workflows --jq '.workflows[]' ))

    for WORKFLOW in "${WORKFLOWS[@]}"; do
      echo '------WORKFLOW------'
      echo $WORKFLOW | jq
      WORKFLOW_NAME=$(echo $WORKFLOW | jq '.name' | sed 's/\"//g')
      WORKFLOW_BADGE_URL=$(echo $WORKFLOW | jq '.badge_url' | sed 's/\"//g')

      if [ -z "$WORKFLOW_NAME" ];then
        break
      fi

      cat << EOF >> "$PAGES"/_tabs/monitoring.md
![$WORKFLOW_NAME]($WORKFLOW_BADGE_URL){: .normal}
EOF

    done
  done
done

