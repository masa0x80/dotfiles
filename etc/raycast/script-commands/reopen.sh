#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reopen Current Page URL ;re
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Browser
# @raycast.icon 🔄
#
# @raycast.description This script reopen URL of currently opened page.
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "text", "placeholder": "Browser", "optional": true }

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

if [ "$1" = "" ]; then
  open "$url"
else
  case "$1" in
  "v" | "vivaldi" | "Vivaldi")
    browser="Vivaldi"
    ;;
  "e" | "edge" | "Edge" | "Microsoft Edge")
    browser="Microsoft Edge"
    ;;
  "c" | "chrome" | "Chrome" | "Google Chrome")
    browser="Google Chrome"
    ;;
  "s" | "safari" | "Safari")
    browser="Safari"
    ;;
  esac
  open -a "$browser" "$url"
fi
