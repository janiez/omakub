#!/bin/bash

# Install the latest mainline kernel on Debian 13 arm64.
# Uses official Debian kernel packages from the default repositories.

sudo apt update

# Install the latest available kernel from Debian's official repos for arm64
LATEST_KERNEL=$(apt-cache search linux-image | grep -oP 'linux-image-[0-9]+\.[0-9]+\.[0-9]+-[0-9]+-arm64' | sort -V | tail -1)

if [ -z "$LATEST_KERNEL" ]; then
  echo "No newer mainline kernel found in Debian repos. Falling back to linux-image-arm64..."
  sudo apt install -y linux-image-arm64 linux-headers-arm64
else
  echo "Installing kernel: $LATEST_KERNEL"
  HEADERS=${LATEST_KERNEL/image/headers}
  sudo apt install -y "$LATEST_KERNEL" "$HEADERS" || sudo apt install -y linux-image-arm64 linux-headers-arm64
fi

echo "Kernel installation complete. Please reboot to use the new kernel."
