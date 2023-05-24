#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL (Rich Text) ;cr
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Vivaldi
# @raycast.icon 📋
#
# @raycast.description This script copies URL of currently opened page in Vivaldi into clipboard.
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

browser="Vivaldi"
title=$(osascript -e "tell application \"$browser\" to get title of active tab of front window" | sed -n 's/ [-|·] [^-|·]*$//p')
url="javascript:(()=>{const clipNode=document.createElement('a');const range=document.createRange();const sel=window.getSelection();clipNode.setAttribute('href',location.href);clipNode.innerText='$title';document.body.appendChild(clipNode);range.selectNode(clipNode);sel.removeAllRanges();sel.addRange(range);document.execCommand('copy',false,null);document.body.removeChild(clipNode);})();"

osascript -e "tell application \"$browser\" to set URL of active tab of front window to \"$url\""

echo "Copy Current Page URL (Rich Text)"
