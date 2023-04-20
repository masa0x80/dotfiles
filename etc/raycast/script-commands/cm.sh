#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (Markdown) [cm]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Vivaldi
# @raycast.icon 🔗
#
# @raycast.description This script copies URL of currently opened page in Vivaldi into clipboard.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

url=$(osascript -e 'tell application "Vivaldi" to return URL of active tab of front window')
title=$(osascript -e 'tell application "Vivaldi" to return title of active tab of front window')
echo "[$title]($url)" | pbcopy
echo "Copy Current Page URL (Markdown)"
