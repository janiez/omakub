#!/bin/bash

if [ ! -f /etc/os-release ]; then
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  exit 1
fi

. /etc/os-release

# Check if running on Debian 13 or higher
if [ "$ID" != "debian" ] || [ $(echo "$VERSION_ID >= 13" | bc) != 1 ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Debian 13 or higher"
  echo "Installation stopped."
  exit 1
fi

# Check if running on arm64
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ] && [ "$ARCH" != "armv7l" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture detected"
  echo "Current architecture: $ARCH"
  echo "This installation is only supported on arm64 architectures (aarch64 or armv7l)."
  echo "Installation stopped."
  exit 1
fi
