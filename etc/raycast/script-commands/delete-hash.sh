#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete url hash [=#]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon ✂️
#
# Documentation:
# @raycast.description Delete url hash
# @raycast.author KIMURA Masayuki

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

url=$(osascript -e "tell application \"$TARGET_BROWSER\" to get URL of active tab of front window")
osascript -e "tell application \"$TARGET_BROWSER\" to set URL of active tab of front window to \"${url//\#*/}\""
osascript -e "tell application \"$TARGET_BROWSER\" to activate"
