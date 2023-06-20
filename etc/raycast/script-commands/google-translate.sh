#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate entire page
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Google Translate
# @raycast.icon images/translate-logo.png
#
# @raycast.description Translates entire page
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80
#
# @raycast.argument1 { "type": "text", "placeholder": "Source (auto)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Target (ja)", "optional": true }

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
open "https://translate.google.com/translate?js=n&sl=${1:-auto}&tl=${2:-ja}&u=$url"
