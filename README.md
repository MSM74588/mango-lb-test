# Custom Linux, Mango Linux

```bash
sudo apt install git curl zstd

# live-build from apt (or) compile it from git

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

## Build live-build from git

method 1:

```bash
sudo apt-get install git build-essential
git clone https://salsa.debian.org/live-team/live-build.git
cd live-build
sudo apt-get build-dep live-build
dpkg-buildpackage -b -uc -us
sudo dpkg -i ../live-build_*.deb
lb --version
```

# MINOR NOTES:
- https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html
- https://github.com/nodiscc/debian-live-config

# FIXES:

FIRMWARE LINUX FIX: https://www.mail-archive.com/debian-live@lists.debian.org/msg18982.html

Notes:
- firmware-linux no longer shipped as separate package (Aug 2023)


file to edit (on host): /usr/lib/live/build/chroot_firmware
- change `firmware-linux` to `firmware-linux-nonfree` for nonfree firmware in FIRMWARE_PACKAGES
