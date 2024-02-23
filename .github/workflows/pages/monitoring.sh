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

cat << EOF > "$PAGES"/monitoring.md
---
layout: page
popup: false
---

EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

    echo -e "\n-----------$REPOSITORY-----------\n"

    UNIQUE_VIEWS=$(gh api -XGET https://api.github.com/repos/"$OWNER"/"$REPOSITORY"/traffic/views --jq .uniques)
    TOTAL_VIEWS=$(gh api -XGET https://api.github.com/repos/"$OWNER"/"$REPOSITORY"/traffic/views --jq .count)
    LATEST_VERSION=$(gh api -XGET https://api.github.com/repos/"$OWNER"/"$REPOSITORY"/releases/latest --jq .tag_name)

    mapfile -t BRANCHES < <(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name')

    cat << EOF >> "$PAGES"/monitoring.md
<hr>

## $REPOSITORY

| Repository | GitHub |
| ------ | ------ |
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/$OWNER/$REPOSITORY) | ![GitHub open issues](https://img.shields.io/github/issues/$OWNER/$REPOSITORY) ![GitHub closed issues](https://img.shields.io/github/issues-closed/$OWNER/$REPOSITORY?color=#44CC44) |
| ![GitHub license](https://img.shields.io/github/license/$OWNER/$REPOSITORY) | ![GitHub pull requests](https://img.shields.io/github/issues-pr/$OWNER/$REPOSITORY?label=PR) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/$OWNER/$REPOSITORY?color=g&label=PR) |
| ![GitHub language count](https://img.shields.io/github/languages/count/$OWNER/$REPOSITORY?style=flat&label=language)  | ![GitHub contributors](https://img.shields.io/github/contributors/$OWNER/$REPOSITORY) ![github forks](https://img.shields.io/github/forks/$OWNER/$REPOSITORY?style=flat) ![github watchers](https://img.shields.io/github/watchers/$OWNER/$REPOSITORY?style=flat) |
| ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/$OWNER/$REPOSITORY) | ![GitHub Repo stars](https://img.shields.io/github/stars/$OWNER/$REPOSITORY?style=flat&color=%23eac54f) ![GitHub downloads](https://img.shields.io/github/downloads/$OWNER/$REPOSITORY/total?style=flat) ![unique views last 14 days](https://img.shields.io/badge/unique_views_last_14_days-$UNIQUE_VIEWS-blue) ![total views last 14 days](https://img.shields.io/badge/total_views_last_14_days-$TOTAL_VIEWS-blue) |

EOF

  for BRANCHE in "${BRANCHES[@]}"; do

    echo -e "\n-----------$REPOSITORY - $BRANCHE-----------\n"

    COMPARE="<a href='https://github.com/$OWNER/$REPOSITORY/compare/$LATEST_VERSION...dev'><img src='https://img.shields.io/github/commits-since/$OWNER/$REPOSITORY/$LATEST_VERSION/dev'></a>"

    if [ "$BRANCHE" == "dev" ];then
        cat << EOF >> "$PAGES"/monitoring.md
<div><div class="post-tag btn btn-outline-primary"><a href="https://github.com/$OWNER/$REPOSITORY/actions?query=branch%3A$BRANCHE" target="_blank">$BRANCHE</a></div><div style=" display: inline-block; position: relative; top: 6px;">$COMPARE</div></div>
EOF
    else
        cat << EOF >> "$PAGES"/monitoring.md
<div class="post-tag btn btn-outline-primary"><a href="https://github.com/$OWNER/$REPOSITORY/actions?query=branch%3A$BRANCHE" target="_blank">$BRANCHE</a></div>
EOF
    fi

    mapfile -t WORKFLOWS < <(gh api -XGET /repos/"$OWNER"/"$REPOSITORY"/actions/workflows --jq '.workflows[]' | sed 's/[[:space:]]//g')

    for WORKFLOW in "${WORKFLOWS[@]}"; do
        BRANCHE_URL="branch=$BRANCHE"
        WORKFLOW_NAME=$(echo "$WORKFLOW" | jq '.name' | sed 's/\"//g')
        WORKFLOW_URL=$(echo "$WORKFLOW" | jq '.badge_url' | sed 's/\"//g' | sed 's/workflows.*//  g' )
        WORKFLOW_PATH=$(echo "$WORKFLOW" | jq '.path' | sed 's/\"//g' | sed 's/.github\///g' )

        WORKFLOW_BADGE_URL="${WORKFLOW_URL}actions/${WORKFLOW_PATH}/badge.svg"

        if [ -z "$WORKFLOW_NAME" ];then
            break
        fi

        if [ "$WORKFLOW_NAME" == "Release" ];then
          BRANCHE_URL=""
        fi

        cat << EOF >> "$PAGES"/monitoring.md
![$WORKFLOW_NAME]($WORKFLOW_BADGE_URL?$BRANCHE_URL){: .normal}
EOF

    done
  done
done
