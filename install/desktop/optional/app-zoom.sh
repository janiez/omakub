#!/bin/bash

# Make video calls using https://zoom.us/
cd /tmp
wget https://zoom.us/client/latest/zoom_arm64.deb
sudo apt install -y ./zoom_arm64.deb
rm zoom_arm64.deb
cd -
