#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (Textile) ;ct
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page into clipboard.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80
# @raycast.argument1 { "type": "text", "placeholder": "[c] Chrome [v] Vivaldi", "optional": true }

case "$1" in
"c")
  browser="Google Chrome"
  ;;
"v")
  browser="Vivaldi"
  ;;
*)
  browser="Microsoft Edge"
  ;;
esac

url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
title=$(osascript -e "tell application \"$browser\" to get title of active tab of front window")
trimmedTitle=$(echo "$title" | sed -n 's/ [-|·] [^-|·]*$//p')
test "$trimmedTitle" = '' && trimmedTitle="$title"
echo "\"$trimmedTitle\":$url" | pbcopy
echo "Copy Current Page URL (Textile)"
