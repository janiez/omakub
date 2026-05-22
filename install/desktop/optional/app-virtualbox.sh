#!/bin/bash

# Virtualbox allows you to run VMs for other flavors of Linux or even Windows on Debian 13 arm64
# See https://www.virtualbox.org/wiki/Linux_Downloads for installation on Debian 13 arm64.
# for a guide on how to run Debian inside it.

sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers ${USER}
