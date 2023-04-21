#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title B! entry page
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Vivaldi
# @raycast.icon images/bookmark-logo.png
#
# @raycast.description Jump to B! entry page about current page.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

url=$(osascript -e 'tell application "Vivaldi" to return URL of active tab of front window')
open "https://b.hatena.ne.jp/entry/s/${url//*:\/\//}"
