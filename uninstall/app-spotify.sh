#!/bin/bash

sudo apt remove -y spotify-client
sudo rm -f /etc/apt/sources.list.d/spotify.list
sudo rm -f /etc/apt/trusted.gpg.d/spotify.gpg
