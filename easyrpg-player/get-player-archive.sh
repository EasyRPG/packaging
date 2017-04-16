#!/bin/sh

version=0.5.1

wget -N -nv https://easyrpg.org/downloads/player/easyrpg-player-${version}.tar.gz
cp -rup easyrpg-player-${version}.tar.gz easyrpg-player_${version}.orig.tar.gz
