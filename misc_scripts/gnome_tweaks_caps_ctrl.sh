#!/bin/bash

# Check if gnome-tweaks is installed
if ! command -v gnome-tweaks &> /dev/null; then
    echo "Error: gnome-tweaks is not installed. Please install it first."
    exit 1
fi

# Get the current state of the "Switch locations of Ctrl and Caps Lock" option
current_state=$(gsettings get org.gnome.desktop.input-sources xkb-options)

# Define the options for swapping Ctrl and Caps Lock
swap_options="['ctrl:swapcaps']"
normal_options="[]"

# Check if the options are already set, and toggle accordingly
if [[ "$current_state" == *"$swap_options"* ]]; then
    # Caps Lock and Ctrl are already swapped, so revert the changes
    gsettings set org.gnome.desktop.input-sources xkb-options "$normal_options"
    echo "Caps Lock and Ctrl keys reverted to normal."
else
    # Caps Lock and Ctrl are not swapped, so apply the changes
    gsettings set org.gnome.desktop.input-sources xkb-options "$swap_options"
    echo "Caps Lock and Ctrl keys swapped."
fi

