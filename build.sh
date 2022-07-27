#!/usr/bin/env bash

ZIPNAME=Nexus-Tweak-x0.${buildNo}.zip
APP_DIR=nexus/product/app/NexusTweak

function push() {
curl -F document=@$1 "https://api.telegram.org/bot${token}/sendDocument" \
     -F chat_id="${chat_id}"  \
     -F "disable_web_page_preview=true" \
     -F "parse_mode=html" \
     -F caption="`cat changelog.md`"
}

# download nexus tweak app
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update && apt install gh
echo $gh_token > mytoken.txt
gh auth login --with-token < mytoken.txt
rm -rf mytoken.txt
mkdir -p $APP_DIR
gh release download -p '*.apk' --repo https://github.com/ImSpiDy/NexusTweak-App --dir $APP_DIR

mkdir -p nex
curl -s https://$gh_token@raw.githubusercontent.com/ImSpiDy/Nexus_Tweak_files/master/nAi -o nex/nAi
curl -s https://$gh_token@raw.githubusercontent.com/ImSpiDy/Nexus_Tweak_files/master/breaker -o nexus/breaker
mkdir -p system/bin
mv -f nexus/product system 
mv -f nexus/* system/bin
rm -rf nexus

zip -r9 "${ZIPNAME}" * -x build.sh -x *.github*

push "${ZIPNAME}"
