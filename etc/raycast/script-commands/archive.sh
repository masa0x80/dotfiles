#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Web Archive
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName 魚拓
# @raycast.icon 📜
#
# @raycast.author KIMURA Masayuki

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

open "https://archive.is/$url"
