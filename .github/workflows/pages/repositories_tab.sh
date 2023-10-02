#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORIES=($(gh search repos --owner "dennykorsukewitz" --topic "pages" --jq '.[].name' --json name | sort))

# REPOSITORIES="dennykorsukewitz"

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

cat << EOF > "$PAGES"/_tabs/repositories.md
---
layout: page
popup: false
icon: fa fa-cubes
order: 1
---

EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"

  UNIQUE_VIEWS=`gh api -XGET https://api.github.com/repos/$OWNER/$REPOSITORY/traffic/views --jq .uniques`
  TOTAL_VIEWS=`gh api -XGET https://api.github.com/repos/$OWNER/$REPOSITORY/traffic/views --jq .count`
  BRANCHES=`gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/branches" --jq '.[].name'`
  BRANCHES_STRING=$(echo $BRANCHES | sed 's/ /, /g')

  REPOSITORY_JSON=`gh api /repos/$OWNER/$REPOSITORY`
  REPOSITORY_NAME=`echo $REPOSITORY_JSON | jq .name | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_DESCRIPTION=`echo $REPOSITORY_JSON | jq .description | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_URL=`echo $REPOSITORY_JSON | jq .url | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_STARS=`echo $REPOSITORY_JSON | jq .stargazers_count | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_FORKS=`echo $REPOSITORY_JSON | jq .forks_count | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_WATCHERS=`echo $REPOSITORY_JSON | jq .watchers_count | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`
  REPOSITORY_LANGUAGE=`echo $REPOSITORY_JSON | jq .language | sed 's/^\"//g' | sed 's/\"$//g' | sed 's/\\\"/\"/g'`


# echo "$REPOSITORY_STARS"
# echo "$REPOSITORY_FORKS"
# echo "$REPOSITORY_WATCHERS"

  cat << EOF >> "$PAGES"/_tabs/repositories.md
<div id="post-list" class="flex-grow-1 pe-xl-2">
    <article class="card-wrapper">
        <div href="/posts/Znuny-Timeline/" class="card post-preview flex-md-row-reverse">
            <div class="card-body d-flex flex-column">
                <h1 class="card-title my-2 mt-md-0">
                  <a href="/$REPOSITORY">
                    $REPOSITORY
                  </a>
                </h1>
                <div class="card-text content mt-0 mb-2">
                    <p>
                        $REPOSITORY_DESCRIPTION
                    </p>
                </div>
                <div class="post-meta flex-grow-1 d-flex align-items-end">
                    <div class="me-auto">
                      <div class="badges">
                          <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/$OWNER/$REPOSITORY">
                          <img alt="GitHub license" src="https://img.shields.io/github/license/$OWNER/$REPOSITORY">
                          <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/$OWNER/$REPOSITORY?style=flat&label=language">
                          <img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/$OWNER/$REPOSITORY">
                          <br>
                          <img alt="GitHub open issues" src="https://img.shields.io/github/issues/$OWNER/$REPOSITORY">
                          <img alt="GitHub closed issues" src="https://img.shields.io/github/issues-closed/$OWNER/$REPOSITORY?color=#44CC44">
                          <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/$OWNER/$REPOSITORY?label=PR">
                          <img alt="GitHub closed pull requests" src="https://img.shields.io/github/issues-pr-closed/$OWNER/$REPOSITORY?color=g&label=PR">
                          <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/$OWNER/$REPOSITORY">
                        </div>
                        <br>

                        <i class="far fa-folder-open fa-fw me-1"></i>
                        <span class="categories">
                          <a href="/categories/dk4/" title="categories">
                            DK4
                          </a>
                        </span>

                        <i class="fa-solid fa-star fa-fw me-1"></i>
                        <span class="stars">
                            <a href="https://github.com/$OWNER/$REPOSITORY/stargazers" title="stars" target="_blank">
                              $REPOSITORY_STARS
                            </a>
                        </span>



                        <i class="fa-regular fa-eye"></i>
                        <span class="watchers">
                          <a href="https://github.com/$OWNER/$REPOSITORY/watchers" title="watchers" target="_blank">
                            $REPOSITORY_WATCHERS
                          </a>
                        </span>


                        <i class="fa-solid fa-code-fork"></i>
                        <span class="forks">
                          <a href="https://github.com/$OWNER/$REPOSITORY/forks" title="forks" target="_blank">
                            $REPOSITORY_FORKS
                          </a>
                        </span>

                        <i class="fa-solid fa-language"></i>
                        <span class="forks">
                            $REPOSITORY_LANGUAGE
                        </span>

                        <i class="fa-solid fa-eye"></i>
                        <span class="views">
                            <a href="https://github.com/$OWNER/$REPOSITORY" title="unique / total views last 14 days" target="_blank">
                              $UNIQUE_VIEWS / $TOTAL_VIEWS
                            </a>
                        </span>

                        <i class="fa-solid fa-code-branch"></i>
                        <span class="branches">
                          <a href="https://github.com/$OWNER/$REPOSITORY/branches" title="branches" target="_blank">
                            $BRANCHES_STRING
                          </a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </article>
</div>

EOF

done
