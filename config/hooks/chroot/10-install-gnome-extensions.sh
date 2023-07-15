#!/bin/bash
# Description: install gnome extensions
# https://raw.githubusercontent.com/msm-linux/msm-linux-iso-generator/main/assets/install-gnome-shell-extension.py

# install extension
# - https://extensions.gnome.org/extension/3088/extension-list/
# test

# 307 - Dash to dock - https://extensions.gnome.org/extension/307/dash-to-dock/ > dash-to-dock@micxgx.gmail.com
# 4337 -Desktop-Icons-NEO - https://extensions.gnome.org/extension/4337/desktop-icons-neo/ > desktopicons-neo@darkdemon
# 3210 - Compiz Window Effect - https://extensions.gnome.org/extension/3210/compiz-windows-effect/ > compiz-windows-effect@hermes83.github.com
# 3193 - Blur My Shell - https://extensions.gnome.org/extension/3193/blur-my-shell/ > blur-my-shell@aunetx
# https://extensions.gnome.org/extension/517/caffeine/

set -e

chroot "$CHROOTDIR" /hooks/gnome-extensions-installer 307 4337 3210 3193 517