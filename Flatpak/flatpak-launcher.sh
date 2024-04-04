#!/bin/bash

# Flatpak launcher script for EasyRPG Player
# carstene1ns, 2024
#
# This script is in the public domain
# (https://creativecommons.org/publicdomain/zero/1.0/)

#set -x
set -e

ID="org.easyrpg.player"

#
# main
#

playerLauncher() {
	checkArgs "$@"
	getConfig
	mayRunWizard
	runPlayer "${args[@]}"
}

#
# helpers
#

# check and filter arguments
checkArgs() {
	args=("$@")
	for ((i=0; i<"${#args[@]}"; ++i)); do
		case ${args[i]} in
			--first-start)
				want_wizard="yes"
				unset args[i];
				;;
			--project-path)
				want_dir="yes"
				;;
			--)
				break;;
		esac
	done
}

# running in flatpak environment
isFlatpak() {
	return $(test "${FLATPAK_ID}" == "${ID}")
}

# config file handling
getConfig() {
	local XDG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}
	local CONFIG_FILE="${XDG_DIR}/EasyRPG/Player/flatpak.sh"

	if [[ -f ${CONFIG_FILE} ]]; then
		source ${CONFIG_FILE}

		# argument override of game dir
		[[ -v want_dir ]] && return

		if isFlatpak; then
			# player will pick up this variable
			export RPG_GAME_PATH
		else
			echo "Would be exporting variable RPG_GAME_PATH=\"${RPG_GAME_PATH}\" now."
		fi
	fi
}

mayRunWizard() {
	# config already done and not requested
	[[ -v RPG_GAME_PATH && ! -v want_wizard ]] && return

	if isFlatpak; then
		easyrpg-firststart
	else
		echo "Would be running firststart wizard now."
	fi

	# may have changed config file
	getConfig
}

runPlayer() {
	if isFlatpak; then
		exec ${ID}.real "$@"
	else
		echo "Would be running Player now with args: \"$@\""
	fi
}

# entrypoint
playerLauncher "$@"
