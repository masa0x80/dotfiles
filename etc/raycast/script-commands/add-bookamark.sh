#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Bookmark ;b
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon 🔖
#
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

: "${TARGET_BROWSER:=Safari}"
url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
osascript -e "activate application \"$TARGET_BROWSER\""
osascript -e "delay 0.1"
osascript -e "tell application \"$TARGET_BROWSER\" to open location \"$url\""
osascript -e "delay 1"
osascript -e "activate application \"$TARGET_BROWSER\""
# Chromiumでは Cmd + d でブックマークできる
osascript -e "tell application \"System Events\" to keystroke \"d\" using command down"
