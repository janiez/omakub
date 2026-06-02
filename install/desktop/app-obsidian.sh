#!/bin/bash

# Obsidian is a multi-platform note taking application. See https://obsidian.md
cd /tmp
OBSIDIAN_VERSION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
wget -O obsidian.tar.gz "https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-arm64.tar.gz"
tar -xf obsidian.tar.gz
sudo install -Dm755 obsidian-${OBSIDIAN_VERSION}-arm64/obsidian /usr/local/bin/obsidian
rm -rf obsidian.tar.gz obsidian-${OBSIDIAN_VERSION}-arm64
cd -
