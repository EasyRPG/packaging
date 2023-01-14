#!/bin/bash

set -e

# base image
docker build --rm -t appimage-builder -f Dockerfile $PWD

# toolchain
docker run -v "$PWD:/build" --rm -it appimage-builder /build/build-custom-toolchain.sh

# player+liblcf
docker run -v "$PWD:/build" --rm -it appimage-builder /build/build-liblcf-and-player.sh

# appimage
docker run -v "$PWD:/build" --rm -it appimage-builder /build/make-appimage.sh
