#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reopen Current Page URL ;re
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon 🔄
#
# @raycast.description This script reopen URL of currently opened page.
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "Brave", "value": "Brave Browser"}, {"title": "Chrome", "value": "Google Chrome"}, {"title": "Edge", "value": "Microsoft Edge"}, {"title": "Safari", "value": "Safari"}, {"title": "Vivaldi", "value": "Vivaldi"}], "placeholder": "Safari", "optional": true }

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"
open -a "${1:-Safari}" "$url"
