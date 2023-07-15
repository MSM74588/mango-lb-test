#!/bin/bash


set -e

# check for root permissions
if [[ "$(id -u)" != 0 ]]; then
  echo "E: Requires root permissions" > /dev/stderr
  exit 1
fi

apt-get update

apt-get install -y \
    live-build \
    gnupg2 \
    binutils \
    zstd \
    ca-certificates \
    squashfs-tools  \
    live-boot  \
    live-config  \
    live-boot-initramfs-tools \
    live-config-sysvinit \
    libburn4  \
    libisofs6  \
    libisoburn1  \
    xorriso \
    curl


sudo lb build