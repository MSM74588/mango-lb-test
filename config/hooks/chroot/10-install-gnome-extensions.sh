#!/bin/bash
# Description: install gnome extensions
# https://raw.githubusercontent.com/msm-linux/msm-linux-iso-generator/main/assets/install-gnome-shell-extension.py

# install extension
# - https://extensions.gnome.org/extension/3088/extension-list/
# test

set -e

chroot "$CHROOTDIR" /hooks/gnome-extensions-installer 3088