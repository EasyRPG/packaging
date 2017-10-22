#!/bin/sh

curl https://aur.archlinux.org/cgit/aur.git/snapshot/easyrpg-player.tar.gz | tar xzf - --strip-components=1
rm -f .SRCINFO
sed '1c# Maintained here: https://aur.archlinux.org/packages/easyrpg-player' -i PKGBUILD