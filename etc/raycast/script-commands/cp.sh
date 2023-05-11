#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (PlantUML) ;cp
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page in Vivaldi into clipboard.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

browser="Vivaldi"
url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
title=$(osascript -e "tell application \"$browser\" to get title of active tab of front window" | sed -n 's/ [-|·] [^-|·]*$//p')
echo "[[$url $title]]" | pbcopy
echo "Copy Current Page URL (PlantUML)"
