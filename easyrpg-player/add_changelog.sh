#!/bin/bash

PKG=$(basename $PWD)

VER=$(grep '^Version:' $PKG.dsc | tr -cd '[0-9\.\-]')
DATE=$(date -R)

sed -i "1i \
$PKG ($VER) unstable; urgency=low\n\
\n\
  * (changes here)\n\
\n\
 -- carstene1ns <dev@ f4ke .de>  $DATE\n\
" debian/changelog

VER=$(grep '^Version:' $PKG.spec | tr -cd '[0-9\.\-]')
VER+="-"$(grep '^Release:' $PKG.spec | tr -cd '[0-9\.\-]')
DATE=$(LANG=C date "+%a %b %d %Y")

sed -i "/%changelog/ a \
* $DATE carstene1ns <dev@ f4ke .de> - $VER\n\
- (changes here)\n\
" $PKG.spec
