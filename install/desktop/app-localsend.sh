#!/bin/bash

cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O localsend.tar.gz "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-arm-64.tar.gz"
tar -xf localsend.tar.gz
sudo install -Dm755 LocalSend-${LOCALSEND_VERSION}-linux-arm-64 /usr/local/bin/localsend
rm -f localsend.tar.gz LocalSend-${LOCALSEND_VERSION}-linux-arm-64
cd -
