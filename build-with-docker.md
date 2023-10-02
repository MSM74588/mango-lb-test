# DOCKER BUILD COMMAND

testing

```
docker run --privileged -i -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:sid \
    /bin/bash < live-build.sh

```