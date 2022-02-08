#!/usr/bin/env bash

ZIPNAME=Nexus-Tweak-X1.zip

function push() {
curl -F document=@$1 "https://api.telegram.org/bot${token}/sendDocument" \
     -F chat_id="${chat_id}"  \
     -F "disable_web_page_preview=true" \
     -F "parse_mode=html" \
     -F caption="`cat changelog.txt`"
}

mkdir -p system/bin
mv -f profiles/* system/bin
rm -rf profiles

zip -r9 "${ZIPNAME}" *

push "${ZIPNAME}"
