#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Gyotaku [megalodon]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName 魚拓
# @raycast.icon 📜
#
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
open "https://megalodon.jp/?url=$url"
