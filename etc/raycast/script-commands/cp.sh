#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (PlantUML) ;cp
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page into clipboard.
# @raycast.author KIMURA Masayuki

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

echo "[[$url $trimmedTitle]]" | pbcopy
echo "Copy Current Page URL (PlantUML)"
