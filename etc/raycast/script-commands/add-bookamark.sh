#!/usr/bin/env zsh

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

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

: "${TARGET_BROWSER:=Safari}"
open -a "$TARGET_BROWSER" "$url" && echo "
tell application \"$TARGET_BROWSER\"
  delay 3
  activate
  tell application \"System Events\"
    keystroke \"d\" using command down
  end tell
end tell
" | osascript -
