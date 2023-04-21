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

url=$(osascript -e 'tell application "Vivaldi" to return URL of active tab of front window')
open "$(echo "$url" | sed -n 's|.*/\(dp/.*\)/.*|https://www.amazon.co.jp/\1|p')"
