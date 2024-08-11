#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add bookmark ;ab
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Obsidian Bookmarks
# @raycast.icon 🔖
#
# @raycast.description Save the web page as a bookmark in Obsidian
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

: ${BOOKMARKS_DIR:=$SCRAPBOOK_DIR/Bookmarks}
FILENAME=$(rg -l "^# \[.*\]\(${url:q}\)" $BOOKMARKS_DIR)
if [ "$?" -eq 0 ]; then
  echo "ブックマーク済みです"
else
  DATE=$(date +%Y-%m-%d)
  TIME=$(date +%H%M%S)
  FILENAME="${BOOKMARKS_DIR}/${DATE//-}${TIME}.md"

  echo "# [$title]($url) #bookmark" > $FILENAME
fi

open "obsidian://open?vault=${SCRAPBOOK_DIR:t}&file=${FILENAME:t:r}"
