#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete query string [=?]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Vivaldi
# @raycast.icon ✂️
#
# @raycast.description Delete query string
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

browser="Vivaldi"
url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"${url//\?*/}\""
osascript -e "tell application \"$browser\" to activate"
