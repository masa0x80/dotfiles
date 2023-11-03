#!/usr/bin/env zsh

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

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

open "https://b.hatena.ne.jp/entry/s/${url//*:\/\//}"
