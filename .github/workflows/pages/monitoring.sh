#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name | sort))
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

  UNIQUE_VIEWS=`gh api -XGET https://api.github.com/repos/$OWNER/$REPOSITORY/traffic/views --jq .uniques`
  TOTAL_VIEWS=`gh api -XGET https://api.github.com/repos/$OWNER/$REPOSITORY/traffic/views --jq .count`

  BRANCHES=($(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name' ))

      cat << EOF >> "$PAGES"/monitoring.md
<hr>

## $REPOSITORY

| Repository | GitHub |
| ------ | ------ |
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/$OWNER/$REPOSITORY) | ![GitHub open issues](https://img.shields.io/github/issues/$OWNER/$REPOSITORY) ![GitHub closed issues](https://img.shields.io/github/issues-closed/$OWNER/$REPOSITORY?color=#44CC44) |
| ![GitHub license](https://img.shields.io/github/license/$OWNER/$REPOSITORY) | ![GitHub pull requests](https://img.shields.io/github/issues-pr/$OWNER/$REPOSITORY?label=PR) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/$OWNER/$REPOSITORY?color=g&label=PR) |
| ![GitHub language count](https://img.shields.io/github/languages/count/$OWNER/$REPOSITORY?style=flat&label=language)  | ![GitHub contributors](https://img.shields.io/github/contributors/$OWNER/$REPOSITORY) ![github forks](https://img.shields.io/github/forks/$OWNER/$REPOSITORY) ![github watchers](https://img.shields.io/github/watchers/$OWNER/$REPOSITORY) |
| ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/$OWNER/$REPOSITORY) | ![GitHub Repo stars](https://img.shields.io/github/stars/$OWNER/$REPOSITORY?color=%23eac54f) ![GitHub downloads](https://img.shields.io/github/downloads/$OWNER/$REPOSITORY/total?style=flat) ![unique views last 14 days](https://img.shields.io/badge/unique_views_last_14_days-$UNIQUE_VIEWS-blue) ![total views last 14 days](https://img.shields.io/badge/total_views_last_14_days-$TOTAL_VIEWS-blue) |

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
