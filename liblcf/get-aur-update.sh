#!/bin/sh

curl https://aur.archlinux.org/cgit/aur.git/snapshot/liblcf.tar.gz | tar xzf - --strip-components=1
rm -f .SRCINFO
sed '1c# Maintained here: https://aur.archlinux.org/packages/liblcf' -i PKGBUILD