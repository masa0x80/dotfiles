#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (Human-readable) ;ch
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page clipboard.
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "trimmedTitle", "value": "trim"}, {"title": "rawTitle", "value": "raw"}], "placeholder": "trimmedTitle", "optional": true }
# @raycast.argument2 { "type": "dropdown", "data": [{"title": "Brave", "value": "Brave Browser"}, {"title": "Chrome", "value": "Google Chrome"}, {"title": "Edge", "value": "Microsoft Edge"}, {"title": "Safari", "value": "Safari"}, {"title": "Vivaldi", "value": "Vivaldi"}], "placeholder": "Safari", "optional": true }

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
TARGET_BROWSER="${2:-$TARGET_BROWSER}"
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

if [ "$1" = "raw" ]; then
  echo "$title $url" | pbcopy
else
  echo "$trimmedTitle $url" | pbcopy
fi
echo "Copy Current Page URL (Human-readable)"
