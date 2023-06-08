#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Transfer norikae
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Jorudan
# @raycast.icon 🚂
#
# @raycast.description Open transfer guide
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80
#
# @raycast.argument1 { "type": "text", "placeholder": "駅1", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "駅2", "optional": true }

open "https://www.jorudan.co.jp/norikae/cgi/nori.cgi?eki1=$1&eki2=$2"
