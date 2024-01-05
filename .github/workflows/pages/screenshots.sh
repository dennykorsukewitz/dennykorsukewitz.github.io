#!/bin/bash

OWNER="dennykorsukewitz"
mapfile -t REPOSITORIES < <(gh search repos --owner "$OWNER" --topic "pages" --jq '.[].name' --json name | sort)

REPOSITORIES+=("repositories")
REPOSITORIES+=("posts")
REPOSITORIES+=("categories")
REPOSITORIES+=("tags")
REPOSITORIES+=("archives")
REPOSITORIES+=("metrics")

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

echo "Delete: screenshots"
rm -Rf $PAGES/assets/img/screenshots/

cat << EOF > "$PAGES"/README.md

# Screenshots
EOF

for REPOSITORY in "${REPOSITORIES[@]}"; do

  REPOSITORYLABEL="$(tr '[:lower:]' '[:upper:]' <<< ${REPOSITORY:0:1})${REPOSITORY:1}"
  echo -e "\n-----------Screenshot $REPOSITORYLABEL-----------\n"

  capture-website https://dennykorsukewitz.github.io/$REPOSITORY --overwrite --launch-options='{"headless":"false","args":["--start-maximized", "--no-sandbox", "--disable-setuid-sandbox"]}' --width="1920" --height="1080" --output=$PAGES/assets/img/screenshots/Screenshot-$REPOSITORYLABEL.png

  capture-website https://dennykorsukewitz.github.io/$REPOSITORY --overwrite --launch-options='{"headless":"false","args":["--start-maximized", "--no-sandbox", "--disable-setuid-sandbox"]}' --width="1920" --height="1080" --dark-mode --output=$PAGES/assets/img/screenshots/Screenshot-$REPOSITORYLABEL-Dark.png

  cat << EOF >> "$PAGES"/README.md
## $REPOSITORYLABEL

![$REPOSITORYLABEL](assets/img/screenshots/Screenshot-$REPOSITORYLABEL.png)
![$REPOSITORYLABEL](assets/img/screenshots/Screenshot-$REPOSITORYLABEL-Dark.png)

EOF
done