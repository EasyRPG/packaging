# debian:10 debian:11 ubuntu:20.04 ubuntu:18.04
FROM --platform=linux/amd64 ubuntu:18.04 AS builder

ENV CCACHE_DIR=/build/ccache

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean && \
	apt-get update && \
	apt-get install -yqq --no-install-recommends --no-install-suggests \
		build-essential ca-certificates curl wget unzip \
		automake autoconf libtool pkg-config ninja-build git \
		python3 xxd ccache appstream \
		libasound2-dev libpulse-dev libaudio-dev libjack-dev libsndio-dev \
		libsamplerate0-dev libx11-dev libxext-dev libxrandr-dev libxcursor-dev \
		libxfixes-dev libxi-dev libxss-dev libwayland-dev libxkbcommon-dev \
		libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev \
		libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev && \
	rm -rf /var/lib/apt/lists/* && \
	wget -nv https://cmake.org/files/v3.13/cmake-3.13.0-Linux-x86_64.sh && \
	mkdir -p /opt/cmake && \
	sh cmake-3.13.0-Linux-x86_64.sh --skip-license --prefix=/opt/cmake && \
	ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
	rm -f cmake-3.13.0-Linux-x86_64.sh
