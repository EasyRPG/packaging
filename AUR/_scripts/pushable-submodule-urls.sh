#!/bin/bash

pkgs=(easyrpg-player easyrpg-player-git easyrpg-tools-git liblcf liblcf-git)

for p in ${pkgs[@]}; do
	git submodule set-url AUR/$p ssh://aur@aur.archlinux.org/$p.git
done

git restore .gitmodules
