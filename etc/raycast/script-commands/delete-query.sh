#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete query string [=?]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon ✂️
#
# @raycast.description Delete query string
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

url=$(osascript -e "tell application \"$BROWSER\" to get URL of active tab of front window")
osascript -e "tell application \"$BROWSER\" to set URL of active tab of front window to \"${url//\?*/}\""
osascript -e "tell application \"$BROWSER\" to activate"
