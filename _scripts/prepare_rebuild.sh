#!/bin/bash

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&>/dev/null && pwd)
source ${SCRIPT_DIR}/_lib.sh

[ -n "$1" ] && cd $1

get_project
[ $player -eq 1 ] && project="easyrpg-player"
[ $liblcf -eq 1 ] && project="liblcf"

# spec
perl -pi -e 's/^(Release.*)(\d+)(.*)$/$1.($2+1).$3/e' $project.spec

# dsc
perl -pi -e 's/^(Version.*)-(\d+)$/$1.-($2+1)/e' $project.dsc

$SCRIPT_DIR/add_changelog.sh "OBS rebuild"

./debianize.sh

# PKGBUILD
perl -pi -e 's/^(pkgrel=)(\d+)$/$1.($2+1)/e' PKGBUILD
