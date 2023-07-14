#!/bin/bash


set -e

# check for root permissions
if [[ "$(id -u)" != 0 ]]; then
  echo "E: Requires root permissions" > /dev/stderr
  exit 1
fi

# install dependencies
apt-get update
apt-get install -y live-build gnupg2 binutils zstd ca-certificates

apt-get install squashfs-tools live-boot live-config live-boot-initramfs-tools live-config-sysvinit libburn4 libisofs6 libisoburn1 xorriso isolinux 

apt update

ARCH="amd64"
# BASECODENAME="sid" #very unstable and not supported by all ftp
BASECODENAME="bookworm"

BASEVERSION="12" # debian bookworm
CODENAME="orchid-test-1" # release codename, custom

NAME="Mango-linux"
# mirror to fetch packages from
MIRROR_URL="http://ftp.debian.org/debian/"
# indian mirror: http://mirror.cse.iitk.ac.in
# german mirror: http://ftp.de.debian.org
# MIRROR_BINARY_URL="https://repo.vanillaos.org"
MIRROR_BINARY_URL="http://ftp.debian.org/debian/"

# MIRROR_SECURITY_URL="http://deb.debian.org/debian-security"
MIRROR_SECURITY_URL="http://security.debian.org/debian-security"

# use HWE kernel and packages?
# HWE_KERNEL="yes"

# suffix for generated .iso files
OUTPUT_SUFFIX="test-1" # CHANGE THIS

# folder suffix for the package lists to use
PACKAGE_LISTS_SUFFIX="vanilla-installer"

BOOTLOADER="grub-pc"
# default is syslinux
# --bootloaders grub-legacy|grub-pc|syslinux|grub-efi|"BOOTLOADERS"
KERNEL_FLAVORS="amd64"



# if [ "$HWE_KERNEL" = "yes" ]; then
#     KERNEL_FLAVORS="amd64-hwe-${BASEVERSION}"
#     # KERNEL_FLAVORS="amd64-hwe"

# else
#     KERNEL_FLAVORS="amd64"
# fi


# linux packages => linux kernel packages

# stages of live-build
# - Bootstrap : retrieving package lists, installing the core packages, and configuring the initial system environment.
# - Chroot : separate directory tree that emulates the root file system of the live system. It allows the build process to make changes and modifications within this isolated environment.
# - Binary Stage : creating the binary image of the live system, such as an ISO image or a compressed file system. It includes tasks like installing additional packages, configuring the system, and creating the final image.
# - Cleanup :  Once the binary image is generated, the cleanup stage removes temporary files and cleans up the chroot environment to ensure a clean and minimal final image.

# parent-mirror-... is used for fallback

# --binary-images iso (original)
# --firmware-binary false \ > change to true for max hardware compatibility

# --firmware-chroot false \ > disable the installation of firmware packages during the chroot phase of the live system build process.
# enable if targetting max support

# change --updates false to true later

lb config noauto \
  --architectures "$ARCH"\
  --mode debian \
  --distribution "$BASECODENAME" \
  --parent-distribution "$BASECODENAME" \
  --archive-areas "main non-free contrib" \
  --parent-archive-areas "main non-free contrib" \
  --linux-packages "linux-image linux-headers" \
  --linux-flavours "$KERNEL_FLAVORS" \
  --bootappend-live "boot=live config username=msm-testing user-fullname=Msm-test hostname=msm-testing timezone=Asia/Kolkata quiet splash" \
  --mirror-bootstrap "$MIRROR_URL" \
  --parent-mirror-bootstrap "$MIRROR_URL" \
  --mirror-chroot-security "$MIRROR_SECURITY_URL" \
  --parent-mirror-chroot-security "$MIRROR_SECURITY_URL" \
  --mirror-binary-security "$MIRROR_SECURITY_URL" \
  --parent-mirror-binary-security "$MIRROR_SECURITY_URL" \
  --mirror-binary "$MIRROR_BINARY_URL" \
  --parent-mirror-binary "$MIRROR_BINARY_URL" \
  --keyring-packages debian-keyring \
  --apt-options "--yes --option Acquire::Retries=5 --option Acquire::http::Timeout=100" \
  --apt-recommends false \
  --cache-packages false \
  --uefi-secure-boot enable \
  --binary-images iso-hybrid \
  --iso-application "$NAME" \
  --iso-volume "$NAME" \
  --iso-preparer "MSM" \
  --iso-publisher "MSM Mango Linux" \
  --firmware-binary false \
  --firmware-chroot false \
  --security true \
  --updates false \
  --debootstrap-options "--exclude=pinephone-tweaks,mobile-tweaks-common,librem5-tweaks,pinetab-tweaks --include=apt-transport-https,ca-certificates,openssl" \
  --checksums md5 \
  --clean \
  --debian-installer live \
  --debian-installer-gui true \
  --memtest memtest86+ \
  --initsystem systemd \
  --bootloaders "$BOOTLOADER"

  # --clean \
  # --debootstrap-options "--keyring=/usr/share/keyrings/vanilla_keyring.gpg"
  
  