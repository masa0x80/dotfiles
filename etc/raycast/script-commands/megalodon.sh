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

url=$(osascript -e 'tell application "Vivaldi" to get URL of active tab of front window')
open "https://megalodon.jp/?url=$url"
