#!/bin/bash

# Browse the web with Chromium — the open-source base of Chrome.
# Google Chrome does not provide an official arm64 build for Linux.
# See https://www.chromium.org/
sudo apt update -y
sudo apt install -y chromium
xdg-settings set default-web-browser chromium.desktop
