#!/bin/bash
####
#### Author: wuseman <wuseman@nr1.nu>
#### License: GPL 3.0
####
#### This script does not work anymore due to rss has been dead for a long time

RSSURL=feeds.feedburner.com/hacked-emails

curl --silent "$RSSURL" |sed -e 's/<\/[^>]*>/\n/g' -e 's/<[^>]*>//g' | grep -o "https://[ -~][^\"]*" | cut -d/ -f1,2,3,4,5,6 > url; cat url | tr --delete \] | tr --delete \> 
curl "$RSSURL" |sed -e 's/<\/[^>]*>/\n/g' -e 's/<[^>]*>//g' | grep -Eo '(http|https)://[^/"]+.*' | sed '/]/d'
sed -i s'/pastebin.com/pastebin.com\/raw/'g pastebin | xargs


