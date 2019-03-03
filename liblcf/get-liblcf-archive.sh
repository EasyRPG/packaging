#!/bin/sh

version=`curl -s https://api.github.com/repos/EasyRPG/liblcf/releases/latest | grep tag_name | sed 's/.*"tag_name": "\([^"]*\)".*/\1/'`

wget -N -nv https://easyrpg.org/downloads/player/${version}/liblcf-${version}.tar.xz
