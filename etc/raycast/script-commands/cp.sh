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
# @raycast.description This script copies URL of currently opened page into clipboard.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

identifier="$(defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'"' '/http;/{print window[(NR)-1]}{window[NR]=$2}')"
case "$identifier" in
"com.vivaldi.vivaldi")
  browser="Vivaldi"
  ;;
"com.microsoft.edgemac")
  browser="Microsoft Edge"
  ;;
"com.google.chrome")
  browser="Google Chrome"
  ;;
*)
  browser="Safari"
  ;;
esac

url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
title=$(osascript -e "tell application \"$browser\" to get title of active tab of front window")
trimmedTitle=$(echo "$title" | sed -n 's/ [-|·] [^-|·]*$//p')
test "$trimmedTitle" = '' && trimmedTitle="$title"
echo "[[$url $trimmedTitle]]" | pbcopy
echo "Copy Current Page URL (PlantUML)"
