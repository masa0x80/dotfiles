#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add bookmark ;ab
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Obsidian Bookmarks
# @raycast.icon 🔖
#
# @raycast.description Save the web page as a bookmark in Obsidian
# @raycast.author KIMURA Masayuki
# @raycast.authorURL https://github.com/masa0x80

CURRENT_DIR=$(
  cd "$(dirname "$0")" || exit
  pwd
)
source "$CURRENT_DIR/utils/_fetch_url_and_page_title"

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
FILENAME="${SCRAPBOOK_DIR}/Bookmarks/${DATE}T${TIME}.md"

echo "---" > $FILENAME
echo "title: $(echo $title | sed -e 's/:/;/g')" >> $FILENAME
echo "saved: $DATE" >> $FILENAME
echo "source: $url" >> $FILENAME
echo "publisher: $(echo $url | cut -d/ -f3)" >> $FILENAME
echo "read: false" >> $FILENAME
echo "tags: []" >> $FILENAME
echo "---" >> $FILENAME
echo >> $FILENAME
echo "# [$title]($url) #bookmark" >> $FILENAME

open "obsidian://open?vault=${SCRAPBOOK_DIR:t}&file=${FILENAME:t:r}"
