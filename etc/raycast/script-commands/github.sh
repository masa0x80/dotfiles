#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon 🚀
#
# @raycast.description Open GitHub Org/Repository page
# @raycast.author KIMURA Masayuki
#
# @raycast.argument1 { "type": "text", "placeholder": "Org", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Repository", "optional": true }

open "https://github.com/${1}/${2}"
