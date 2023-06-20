#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title B! entry page
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Hatena Bookmark
# @raycast.icon images/bookmark-logo.png
#
# @raycast.description Jump to B! entry page about current page.
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
open "https://b.hatena.ne.jp/entry/s/${url//*:\/\//}"
