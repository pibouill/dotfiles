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

	if ! command -v "${app_cmd[0]}" >/dev/null 2>&1 && ! [ -x "${app_cmd[0]}" ]; then
		echo "Command not found: ${app_cmd[0]}"
		return
	fi

	# Launch the application in the background.
	"${app_cmd[@]}" >/dev/null 2>&1 &
	local pid=$!
	disown $pid

	# Poll for the window to appear, then move it.
	# We loop for a few seconds, trying to find the window ID.
	local win_id=""
	local counter=0
	while [ $counter -lt 50 ]; do # Try for 5 seconds (50 * 100ms)
		# Get the window ID for the process ID.
		win_id=$(wmctrl -lp | grep " $pid " | awk '{print $1}')
		if [ -n "$win_id" ]; then
			break
		fi
		sleep 0.1
		counter=$((counter + 1))
	done

	# If we found a window ID, move the window to the target workspace.
	if [ -n "$win_id" ]; then
		wmctrl -i -r "$win_id" -t "$workspace"
	else
		echo "Could not find window for ${app_cmd[0]} (PID: $pid)"
	fi
}

# Launch applications on their designated workspaces.
# Workspaces are 0-indexed.
run_on_workspace 1 slack
run_on_workspace 2 /sgoinfre/pibouill/.cargo/bin/alacritty
run_on_workspace 3 firefox
run_on_workspace 4 google-chrome
run_on_workspace 4 "$HOME/bin/obsidian"
