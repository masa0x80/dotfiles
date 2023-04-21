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

url=$(osascript -e 'tell application "Vivaldi" to get URL of active tab of front window')
open "https://translate.google.com/translate?js=n&sl=${1:-auto}&tl=${2:-ja}&u=$url"
