#!/bin/bash

cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O localsend.tar.gz "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-arm-64.tar.gz"
tar -xf localsend.tar.gz --one-top-level="localsend"
sudo install -Dm755 localsend/localsend_app /usr/local/bin/localsend
rm -rf localsend.tar.gz localsend
cd -
