#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Bookmark
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon 🔖
#
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

: "${TARGET_BROWSER:=Safari}"
wezterm cli spawn --new-window -- zsh -c "~/.bin/open-bookmark $TARGET_BROWSER" > /dev/null
