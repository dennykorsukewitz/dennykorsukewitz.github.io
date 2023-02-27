#!/bin/bash

OWNER="dennykorsukewitz"
REPOSITORY="DK4Znuny-VisualStudioCode"
RELEASES=$(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/releases" | jq -r '.[] | @base64'  )

jsonData='[{"name": "name#1","value": "value#1"},{"name": "name#2","value": "value#2"}]'
RELEASES=($(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/releases" ))

jsonData='[{"name": "name#1","value": "value#1"},{"name": "name#2","value": "value#2"}]'
for row in $(echo "${RELEASES}" | jq -r '.[] | @base64'); do
    _jq() {
     echo "${row}" | base64 --decode | jq -r "${1}"
    }

    # OPTIONAL
    # Set each property of the row to a variable
    name=$(_jq '.name')
    value=$(_jq '.value')

    # Utilize your variables
    echo "$name = $value"
done

# json=$(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY/releases")


# arr=( $( echo "$json" | jq '.[]' ) )
# printf '%s\n' "${arr[@]}"

# # iterate through the Bash array
for item in "${RELEASES[@]}"; do
  echo -e "\n-----------1-----------\n"
  echo "$item | {full_name: .full_name, url: .url}'"
  echo -e "\n-----------2-----------\n"
done



# items=$(echo "$RELEASES" | jq -c -r '.[]')
# for item in ${items[@]}; do
#     echo $item
#     # whatever you are trying to do ...
# done

# # iterate through the Bash array
# for item in "${RELEASES[@]}"; do
#   echo '1 -----------'
#   echo "$item"
#   echo '2 -----------'
# done

