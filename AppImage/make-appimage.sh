#!/bin/bash

set -e

wget -nv https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x *.AppImage

cd /build

# allow newer libstdc++ and libgcc, leave sandbox for external processes
#install -d AppDir/usr/optional
#install -m755 checkrt/checkrt AppDir/usr/optional
#install -m644 checkrt/exec.so AppDir/usr/optional
#AppDir/usr/optional/checkrt --copy-libraries
#cp checkrt/AppRun AppDir/

# find libraries
export LD_LIBRARY_PATH=/build/toolchain/lib:/build/liblcf-install/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
# allow running without fuse
export APPIMAGE_EXTRACT_AND_RUN=1

export UPDATE_INFORMATION="zsync|https://ci.easyrpg.org/job/player-linux-appimage/lastSuccessfulBuild/artifact/easyrpg-player-x86_64.AppImage.zsync"
export VERBOSE=1
/linuxdeploy-x86_64.AppImage -v0 \
  --appdir AppDir --output appimage \
  --desktop-file AppDir/usr/share/applications/easyrpg-player.desktop \
  $(find /build/toolchain/lib \( -name "libfreetype.so*" -o -name "libharfbuzz.so*" -o -name "libexpat.so*" \) -type f -printf "--library %p ")
