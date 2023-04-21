#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GHE
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName GHE
# @raycast.icon 🚀
#
# @raycast.description Open GHE Org/Repository page
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80
#
# @raycast.argument1 { "type": "text", "placeholder": "Org", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Repository", "optional": true }

if [ -z "$GHE_BASE_URL" ]; then
  echo "Error: GHE_BASE_URL not set."
  exit 1
fi

open "$GHE_BASE_URL/${1}/${2}"
