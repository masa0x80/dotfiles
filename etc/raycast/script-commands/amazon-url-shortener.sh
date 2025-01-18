#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Amazon URL shortener [==]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Amazon
# @raycast.icon ✂️
#
# @raycast.description Amazon URL shortener
# @raycast.author KIMURA Masayuki

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

url="$(echo "$url" | sed 's|.*/\(dp/[^/?#]*\).*|https://www.amazon.co.jp/\1|')"
osascript -e "tell application \"$BROWSER\" to set URL of active tab of front window to \"$url\""
osascript -e "tell application \"$BROWSER\" to activate"
