# Custom Linux, Mango Linux

```bash
cd ~/Desktop
git clone https://github.com/MSM74588/mango-lb-test.git
cd mango-lb-test
sudo ./live-build.sh

sudo lb build

sudo lb clean

sudo lb clean && sudo ./live-build.sh && sudo lb build


cd ~/Desktop
git clone https://github.com/MSM74588/mango-lb-test.git
cd mango-lb-test
sudo lb config
sudo lb build
```

# MINOR NOTES:
- https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html

# FIXES:

FIRMWARE LINUX FIX: https://www.mail-archive.com/debian-live@lists.debian.org/msg18982.html

Notes:
- firmware-linux no longer shipped as separate package (Aug 2023)


file to edit (on host): /usr/lib/live/build/chroot_firmware
- change `firmware-linux` to `firmware-linux-nonfree` for nonfree firmware in FIRMWARE_PACKAGES

