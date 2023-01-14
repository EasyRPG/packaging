#!/bin/bash

set -e

git clone https://github.com/EasyRPG/liblcf

# temp fix
sed -i '299i include(GNUInstallDirs)' liblcf/CMakeLists.txt

cmake -B liblcf-build -S liblcf -G Ninja \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DCMAKE_PREFIX_PATH="/build/toolchain"
cmake --build liblcf-build
#cmake --install liblcf-build --prefix AppDir
DESTDIR=/build/liblcf-install/ cmake --build liblcf-build --target install

rm -rf liblcf-build liblcf

git clone https://github.com/EasyRPG/Player

# normal build
d=$(date +%Y-%m-%d)
cmake -B player-build -S Player -G Ninja \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DCMAKE_PREFIX_PATH="/build/toolchain;/build/liblcf-install/usr" -DPLAYER_VERSION_APPEND="(AppImage x64, $d)"
cmake --build player-build
#cmake --install player-build --prefix AppDir
DESTDIR=/build/AppDir/ cmake --build player-build --target install

rm -rf player-build Player

# cleanup
rm -rf /build/AppDir/usr/share/bash-completion
strip /build/AppDir/usr/bin/easyrpg-player

# fixup for old name
mv /build/AppDir/usr/share/metainfo/easyrpg-player.{metainfo,appdata}.xml
