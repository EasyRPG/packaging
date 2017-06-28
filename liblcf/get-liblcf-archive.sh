#!/bin/sh

version=0.5.2

wget -N -nv https://easyrpg.org/downloads/player/liblcf-${version}.tar.gz
cp -rup liblcf-${version}.tar.gz liblcf_${version}.orig.tar.gz
