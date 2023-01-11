#!/bin/bash

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&>/dev/null && pwd)
source ${SCRIPT_DIR}/_lib.sh

get_project $1
[ $player -eq 1 ] && pkg="easyrpg-player"
[ $liblcf -eq 1 ] && pkg="liblcf"

curl -Ss https://aur.archlinux.org/cgit/aur.git/snapshot/${pkg}.tar.gz | tar xzf - --strip-components=1
rm -f .SRCINFO
sed "1c# Maintained here: https://aur.archlinux.org/packages/${pkg}" -i PKGBUILD
