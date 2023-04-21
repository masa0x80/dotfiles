#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete url hash [=#]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Vivaldi
# @raycast.icon ✂️
#
# @raycast.description Delete url hash
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

url=$(osascript -e 'tell application "Vivaldi" to return URL of active tab of front window')
open "${url//#*/}"
