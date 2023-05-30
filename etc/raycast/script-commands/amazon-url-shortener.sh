#!/bin/bash

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
# @raycast.authorURL https://github.com/masa0x80

browser="Vivaldi"
url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
url="$(echo "$url" | sed -n 's|.*/\(dp/[^/?#]*\).*|https://www.amazon.co.jp/\1|p')"
osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"$url\""
osascript -e "tell application \"$browser\" to activate"