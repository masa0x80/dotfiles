#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (JIRA) ;cj
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page into clipboard.
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "trimmedTitle", "value": "trim"}, {"title": "rawTitle", "value": "raw"}], "placeholder": "trimmedTitle", "optional": true }

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

if [ "$1" = "raw" ]; then
  echo "[$title|$url]" | pbcopy
else
  echo "[$trimmedTitle|$url]" | pbcopy
fi
echo "Copy Current Page URL (JIRA)"
