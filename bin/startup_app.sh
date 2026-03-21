#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    startup_app.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/15 15:27:40 by pibouill          #+#    #+#              #
#    Updated: 2025/01/15 15:27:40 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# This script requires wmctrl to be installed to manage workspaces.
# You can install it with a command like: sudo apt-get install wmctrl

run_on_workspace()
{
	local workspace=$1
	shift
	local app_cmd=("$@")

	if command -v "${app_cmd[0]}" >/dev/null 2>&1 || [ -x "${app_cmd[0]}" ]; then
		wmctrl -s "$workspace"
		sleep 0.2
		"${app_cmd[@]}" >/dev/null 2>&1 & disown
	fi
}

# Wait for the desktop environment to be ready.
sleep 1

# Launch applications on their designated workspaces.
# Workspaces are 0-indexed.
run_on_workspace 1 slack
run_on_workspace 2 /sgoinfre/pibouill/.cargo/bin/alacritty
run_on_workspace 3 firefox
run_on_workspace 4 google-chrome
run_on_workspace 4 "$HOME/bin/obsidian"
