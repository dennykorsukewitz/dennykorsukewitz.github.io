#!/bin/bash

OWNER="dennykorsukewitz"
TOPIC="pages"

PAGES='pages'
if [ -z "$GITHUB_WORKSPACE" ];then
  PAGES='.'
fi

# Front matter keys owned by this script. Keys of the same name in a source
# file are dropped, so a repository can never override the page setup.
FRONT_MATTER_KEYS="layout title repository tags toc render_with_liquid"

# READMEs are written for GitHub, not for Jekyll, so normalize whatever they
# contain before turning them into pages:
#
#   * strip a UTF-8 BOM and CR line endings
#   * remove the 4 space indent that Markdown renders as a code block, but only
#     for blocks that are fully indented and hold a list or bold marker, so real
#     indented code keeps its indent
#   * rewrite links pointing at other Markdown files
#
# Fenced blocks are passed through untouched and are matched by fence character
# and length, so nested fences do not confuse the parser.
normalize_markdown() {
  local FILE_PATH="$1"
  local TMP_FILE

  TMP_FILE="$(mktemp)" || return 1

  awk '
    function flush() {
      if (Count == 0) return

      Dedent = (AllIndented && HasMarker)
      for (Index = 1; Index <= Count; Index++) {
        if (Dedent) sub(/^    /, "", Block[Index])
        print Block[Index]
      }

      Count = 0
      AllIndented = 1
      HasMarker = 0
    }

    # Detects a fence and exposes character, length and trailing info string.
    function fence(Text) {
      Bare = Text
      sub(/^[ \t]+/, "", Bare)

      FenceMarker = substr(Bare, 1, 1)
      if (FenceMarker != "`" && FenceMarker != "~") return 0

      FenceSize = 0
      while (substr(Bare, FenceSize + 1, 1) == FenceMarker) FenceSize++
      if (FenceSize < 3) return 0

      FenceInfo = substr(Bare, FenceSize + 1)
      return 1
    }

    BEGIN {
      Count = 0
      AllIndented = 1
      HasMarker = 0
      OpenMarker = ""
      OpenSize = 0
    }

    {
      Line = $0
      sub(/\r$/, "", Line)
      if (NR == 1) sub("^\357\273\277", "", Line)

      if (fence(Line)) {
        if (OpenSize == 0) {
          flush()
          OpenMarker = FenceMarker
          OpenSize = FenceSize
          print Line
          next
        }
        if (FenceMarker == OpenMarker && FenceSize >= OpenSize && FenceInfo ~ /^[ \t]*$/) {
          OpenMarker = ""
          OpenSize = 0
          print Line
          next
        }
      }

      if (OpenSize > 0) {
        print Line
        next
      }

      gsub(/\.md#/, "#", Line)
      gsub(/\.md\)/, ")", Line)

      if (Line ~ /^[ \t]*$/) {
        flush()
        print Line
        next
      }

      Block[++Count] = Line
      if (Line !~ /^    /) AllIndented = 0
      if (Line ~ /^    [ ]*([*+-] |[0-9]+[.)] |\*\*)/) HasMarker = 1
    }

    END { flush() }
  ' "$FILE_PATH" > "$TMP_FILE" && mv "$TMP_FILE" "$FILE_PATH"
}

# Adds the page front matter. Files that already carry front matter, such as
# issue and pull request templates, keep their remaining keys instead of ending
# up with two front matter blocks.
add_front_matter() {
  local FILE_PATH="$1"
  local REPOSITORY="$2"
  local TOPICS="$3"
  local TMP_FILE

  TMP_FILE="$(mktemp)" || return 1

  awk -v Repository="$REPOSITORY" -v Topics="$TOPICS" -v Keys="$FRONT_MATTER_KEYS" '
    function key_of(Text) {
      if (Text !~ /^[A-Za-z_][A-Za-z0-9_.-]*[ \t]*:/) return ""
      Name = Text
      sub(/[ \t]*:.*$/, "", Name)
      return Name
    }

    BEGIN {
      KeyCount = split(Keys, KeyList, " ")
      for (Index = 1; Index <= KeyCount; Index++) Owned[KeyList[Index]] = 1
    }

    { Lines[NR] = $0 }

    END {
      # Locate the end of an existing front matter block.
      End = 0
      if (NR > 0 && Lines[1] == "---") {
        for (Index = 2; Index <= NR; Index++) {
          if (Lines[Index] == "---" || Lines[Index] == "...") {
            End = Index
            break
          }
        }
      }

      print "---"
      print "layout: page"
      print "title: \"" Repository "\""
      print "repository: \"" Repository "\""
      print "tags: " Topics
      print "toc: true"
      # READMEs may contain braces that Liquid would try to evaluate.
      print "render_with_liquid: false"

      if (End > 0) {
        Skip = 0
        for (Index = 2; Index < End; Index++) {
          Name = key_of(Lines[Index])
          if (Name != "") Skip = (Name in Owned)
          if (!Skip) print Lines[Index]
        }
      }

      print "---"
      print ""

      for (Index = (End > 0 ? End + 1 : 1); Index <= NR; Index++) print Lines[Index]
    }
  ' "$FILE_PATH" > "$TMP_FILE" && mv "$TMP_FILE" "$FILE_PATH"
}

# Read into an array without mapfile, which the bash 3.2 shipped by macOS lacks.
read_lines() {
  LINES=()
  while IFS= read -r LINE; do
    LINES+=("$LINE")
  done
}

read_lines < <(gh search repos --owner "$OWNER" --topic "$TOPIC" --jq '.[].name' --json name | sort)
REPOSITORIES=("${LINES[@]}")

if [ "${#REPOSITORIES[@]}" -eq 0 ]; then
  echo "No repositories found for owner $OWNER and topic $TOPIC." >&2
  exit 1
fi

for REPOSITORY in "${REPOSITORIES[@]}"; do

  echo -e "\n-----------$REPOSITORY-----------\n"

  TARGET="$PAGES/$REPOSITORY"
  rm -rf "$TARGET"

  # Private repositories carry the topic too, but cloning them fails.
  if ! git clone "https://github.com/$OWNER/$REPOSITORY" "$TARGET"; then
    echo "Skipping $REPOSITORY, clone failed." >&2
    rm -rf "$TARGET"
    continue
  fi

  TOPICS="$(gh api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPOSITORY" | jq -c '.topics // []')"
  if [ -z "$TOPICS" ]; then
    TOPICS='[]'
  fi

  read_lines < <(find "$TARGET" -name "*.md")
  MARKDOWN_FILES=("${LINES[@]}")

  for MARKDOWN_FILE in "${MARKDOWN_FILES[@]}"; do
    normalize_markdown "$MARKDOWN_FILE"
    add_front_matter "$MARKDOWN_FILE" "$REPOSITORY" "$TOPICS"
  done

  # The README becomes the landing page of the repository.
  README_FILE="$(find "$TARGET" -maxdepth 1 -iname "readme.md" -print -quit)"
  if [ -n "$README_FILE" ]; then
    mv "$README_FILE" "$TARGET/index.md"
  elif [ ! -f "$TARGET/index.md" ]; then
    echo "Skipping $REPOSITORY, no README.md and no index.md." >&2
    rm -rf "$TARGET"
    continue
  fi

  # remove all file but ("*.md"|"*.png"|"*.gif"|"*.jpg"|"*.jpeg"|"*.svg"|"*.webp")
  find "$TARGET" -type f \
    -not -name "*.md" \
    -not -name "*.png" \
    -not -name "*.gif" \
    -not -name "*.jpg" \
    -not -name "*.jpeg" \
    -not -name "*.svg" \
    -not -name "*.webp" \
    -exec rm -Rf {} \;

  # remove all empty folder
  find "$TARGET" -type d -empty -delete

done
