#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete query string [=?]
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon ✂️
#
# @raycast.description Delete query string
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
osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"${url//\?*/}\""
osascript -e "tell application \"$browser\" to activate"
