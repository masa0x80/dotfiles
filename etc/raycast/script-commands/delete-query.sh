#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete query string [=?]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Brower
# @raycast.icon ✂️
#
# @raycast.description Delete query string
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
osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"${url//\?*/}\""
osascript -e "tell application \"$browser\" to activate"
