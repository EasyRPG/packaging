#!/bin/bash

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&>/dev/null && pwd)
source ${SCRIPT_DIR}/_lib.sh

get_project
[ $player -eq 1 ] && PKG="easyrpg-player"
[ $liblcf -eq 1 ] && PKG="liblcf"

VER=$(grep '^Version:' $PKG.dsc | tr -cd '[0-9\.\-]')
DATE=$(date -R)
CHANGES=""
for msg in "$@"; do
  CHANGES+="  * $msg\n"
done
[ -z "$CHANGES" ]&& CHANGES="  * (changes here)\n"

sed -i "1i \
$PKG ($VER) unstable; urgency=low\n\
\n$CHANGES\n\
 -- carstene1ns <dev@ f4ke .de>  $DATE\n\
" debian/changelog

VER=$(grep '^Version:' $PKG.spec | tr -cd '[0-9\.\-]')
VER+="-"$(grep '^Release:' $PKG.spec | tr -cd '[0-9\.\-]')
DATE=$(LANG=C date "+%a %b %d %Y")
CHANGES=""
for msg in "$@"; do
  CHANGES+="- $msg\n"
done
[ -z "$CHANGES" ]&& CHANGES="- (changes here)\n"

sed -i "/%changelog/ a \
* $DATE carstene1ns <dev@ f4ke .de> - $VER\n\
$CHANGES\
" $PKG.spec
