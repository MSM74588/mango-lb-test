# DOCKER BUILD COMMAND

testing

test-1:

```bash
docker run --privileged -i -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:bookworm \
    /bin/bash < live-build.sh

```

test-2:

```bash
docker run -i -v /proc:/proc -v ${PWD}:/working_dir -w /working_dir debian:sid /bin/bash < live-build.sh
```

```bash
docker run --privileged -i -v /proc:/proc -v ${PWD}:/working_dir -w /working_dir debian:sid /bin/bash < live-build.sh

```

```bash
docker run --privileged -i -v /proc:/proc -v ${PWD}:/working_dir:rw -w /working_dir debian:sid /bin/bash < live-build.sh
```
give permission to folder: `chmod 700`


# VANILLA OS SCRIPT:

```bash
#!/bin/bash

set -e

# check for root permissions
if [[ "$(id -u)" != 0 ]]; then
  echo "E: Requires root permissions" > /dev/stderr
  exit 1
fi

# get config
if [ -n "$1" ]; then
  CONFIG_FILE="$1"
else
  CONFIG_FILE="etc/terraform.conf"
fi
BASE_DIR="$PWD"
source "$BASE_DIR"/"$CONFIG_FILE"

# install dep
apt-get update
apt-get install -y live-build gnupg2 binutils zstd ca-certificates


build () {
  BUILD_ARCH="$1"
  mkdir -p "$BASE_DIR/tmp/$BUILD_ARCH"
  cd "$BASE_DIR/tmp/$BUILD_ARCH" || exit

  # remove old configs and copy over new
  rm -rf config auto
  cp -r "$BASE_DIR"/etc/* .
  # Make sure conffile specified as arg has correct name
  cp -f "$BASE_DIR"/"$CONFIG_FILE" terraform.conf

  # Symlink chosen package lists to where live-build will find them
  ln -s "package-lists.$PACKAGE_LISTS_SUFFIX" "config/package-lists"

  lb clean

  lb config

  lb build

    # move output to build dir
  YYYYMMDD="$(date +%Y%m%d)"
  OUTPUT_DIR="$BASE_DIR/builds/$BUILD_ARCH"
  mkdir -p "$OUTPUT_DIR"
  FNAME="VanillaOS-$VERSION-$CHANNEL.$YYYYMMDD$OUTPUT_SUFFIX"
  mv $BASE_DIR/tmp/amd64/live-image-amd64.iso "$OUTPUT_DIR/${FNAME}.iso"

  # cd into output to so {FNAME}.sha256.txt only
  # includes the filename and not the path to
  # our file.
  cd $OUTPUT_DIR
  md5sum "${FNAME}.iso" > "${FNAME}.md5.txt"
  sha256sum "${FNAME}.iso" > "${FNAME}.sha256.txt"
  cd $BASE_DIR
}

if [[ "$ARCH" == "all" ]]; then
    build amd64
else
    build "$ARCH"
fi
```
