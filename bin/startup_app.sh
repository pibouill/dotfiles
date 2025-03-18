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

# First, let's ensure we have enough workspaces
# This command might work depending on your desktop environment (GNOME)
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# Start applications
slack &
firefox &
~/bin/obsidian/obsidian &
~/.cargo/bin/alacritty &
google-chrome &
Soulseek

# Wait for windows to initialize
sleep 5

# Function to wait for window and move it
move_window() {
    local pattern=$1
    local desktop=$2
    local max_attempts=30
    local attempt=0
    
    while [ $attempt -lt $max_attempts ]; do
        window_id=$(wmctrl -l | grep "$pattern" | sort -r | head -n 1 | awk '{print $1;}')
        if [ -n "$window_id" ]; then
            # Move window to create workspace if needed
            wmctrl -ir "$window_id" -t "$desktop"
            return 0
        fi
        sleep 1
        ((attempt++))
    done
    echo "Failed to find window matching: $pattern"
    return 1
}

# Move windows to their respective workspaces
# This will create the workspaces as needed
move_window "Slack" 0
move_window "Alacritty" 1
move_window "Firefox" 2  # First Firefox window
move_window "Obsidian" 4

# Finally, switch to workspace 0
wmctrl -s 0
