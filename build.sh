#!/usr/bin/env bash

ZIPNAME=Nexus-Tweak-x0.${buildNo}.zip

function push() {
curl -F document=@$1 "https://api.telegram.org/bot${token}/sendDocument" \
     -F chat_id="${chat_id}"  \
     -F "disable_web_page_preview=true" \
     -F "parse_mode=html" \
     -F caption="`cat changelog.md`"
}

mkdir -p system/bin
mkdir -p nex
mv -f nexus/nAi nex
mv -f nexus/product system 
mv -f nexus/* system/bin
rm -rf nexus

zip -r9 "${ZIPNAME}" * -x build.sh -x *.github*

push "${ZIPNAME}"
