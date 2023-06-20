#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Bookmark ;b
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon 🔖
#
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

: "${TARGET_BROWSER:=Safari}"
url=$(osascript -e "tell application \"$browser\" to get URL of active tab of front window")
osascript -e "activate application \"$TARGET_BROWSER\""
osascript -e "delay 0.1"
osascript -e "tell application \"$TARGET_BROWSER\" to open location \"$url\""
osascript -e "delay 1"
osascript -e "activate application \"$TARGET_BROWSER\""
# Chromiumでは Cmd + d でブックマークできる
osascript -e "tell application \"System Events\" to keystroke \"d\" using command down"
