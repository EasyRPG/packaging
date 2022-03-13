#!/bin/sh

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&>/dev/null && pwd)
source ${SCRIPT_DIR}/_lib.sh

get_project $1
[ $player -eq 1 ] && archive="easyrpg-player"
[ $liblcf -eq 1 ] && archive="liblcf"

version=$(get_version)

wget -N -nv https://easyrpg.org/downloads/player/${version}/${archive}-${version}.tar.xz
