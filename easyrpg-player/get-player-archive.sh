#!/bin/sh

version=`curl -s https://api.github.com/repos/EasyRPG/Player/releases/latest | grep tag_name | sed 's/.*"tag_name": "\([^"]*\)".*/\1/'`

wget -N -nv https://easyrpg.org/downloads/player/${version}/easyrpg-player-${version}.tar.xz
