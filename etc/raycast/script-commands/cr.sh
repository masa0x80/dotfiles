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
# @raycast.authorURL https://github.com/masa0x80

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

url="javascript:(()=>{const clipNode=document.createElement('a');const range=document.createRange();const sel=window.getSelection();clipNode.setAttribute('href',location.href);clipNode.innerText='$trimmedTitle';document.body.appendChild(clipNode);range.selectNode(clipNode);sel.removeAllRanges();sel.addRange(range);document.execCommand('copy',false,null);document.body.removeChild(clipNode);})();"
osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"$url\""
echo "Copy Current Page URL (Rich Text)"
