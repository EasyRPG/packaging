#!/bin/bash

set -e

ccache -M 1G

git clone https://github.com/EasyRPG/buildscripts.git

# make both shared and static, use older SDL2
sed -e 's/--disable-shared/--enable-shared/g' \
    -e 's/--enable-shared=no/--enable-shared=yes/g' \
    -e 's/-DBUILD_SHARED_LIBS=OFF/-DBUILD_SHARED_LIBS=ON/g' \
    -i buildscripts/shared/common.sh
sed -e 's/-DEXPAT_SHARED_LIBS=OFF/-DEXPAT_SHARED_LIBS=ON/' \
    -e '/lib=SDL2$/{n;s/ver=.*/ver=2.0.20/}' \
    -e 's/--with-data-packaging=static/--with-data-packaging=library/' \
    -i buildscripts/shared/packages.sh
sed '/PKG_CONFIG_LIBDIR/d' -i buildscripts/linux-static/2_build_toolchain.sh


mkdir -p /build/toolchain
cd /build/toolchain

../../buildscripts/linux-static/1_download_library.sh
../../buildscripts/linux-static/2_build_toolchain.sh
../../buildscripts/linux-static/3_cleanup.sh
cd ../..

#rm -rf buildscripts

# helper to not run old libs on newer systems 
#mkdir -p /build/checkrt
#git clone https://github.com/darealshinji/AppImageKit-checkrt.git
#cd AppImageKit-checkrt/src
#make
#mv checkrt exec.so /build/checkrt/
#cd ..
#mv AppRun /build/checkrt/
#cd ..
