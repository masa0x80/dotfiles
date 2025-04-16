#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (Rich Text) ;cr
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Clipboard
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page into clipboard.
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "trimmedTitle", "value": "trim"}, {"title": "rawTitle", "value": "raw"}], "placeholder": "trimmedTitle", "optional": true }

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

if [ "$1" = "raw" ]; then
  url="javascript:(()=>{const clipNode=document.createElement('a');const range=document.createRange();const sel=window.getSelection();clipNode.setAttribute('href',location.href);clipNode.innerText='$title';document.body.appendChild(clipNode);range.selectNode(clipNode);sel.removeAllRanges();sel.addRange(range);document.execCommand('copy',false,null);document.body.removeChild(clipNode);})();"
else
  url="javascript:(()=>{const clipNode=document.createElement('a');const range=document.createRange();const sel=window.getSelection();clipNode.setAttribute('href',location.href);clipNode.innerText='$trimmedTitle';document.body.appendChild(clipNode);range.selectNode(clipNode);sel.removeAllRanges();sel.addRange(range);document.execCommand('copy',false,null);document.body.removeChild(clipNode);})();"
fi
osascript -e "tell application \"$TARGET_BROWSER\" to set URL of active tab of front window to \"$url\""
echo "Copy Current Page URL (Rich Text)"
