# DOCKER BUILD COMMAND

testing

test-1:

```bash
docker run --privileged -i -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:sid \
    /bin/bash < live-build.sh

```

test-2:

```bash
docker run -i -v /proc:/proc -v ${PWD}:/working_dir -w /working_dir debian:sid /bin/bash < live-build.sh
```

```bash
docker run --privileged -i -v /proc:/proc -v ${PWD}:/working_dir -w /working_dir debian:sid /bin/bash < live-build.sh

```
give permission to folder: `chmod 700`

