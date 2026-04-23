#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install_apps_goinfre.sh                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/04/02 11:15:00 by pibouill          #+#    #+#              #
#    Updated: 2026/04/02 12:05:00 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Determine local storage directory
if [ -d "/goinfre/$USER" ]; then
	APPS_ROOT="/goinfre/$USER/apps"
elif [ -d "$HOME/sgoinfre" ]; then
	APPS_ROOT="$HOME/sgoinfre/apps"
else
	APPS_ROOT="$HOME/apps"
fi

BIN_DIR="$HOME/bin"
ICON_DIR="$HOME/.local/share/applications/icons"
DOTFILES_DIR="$HOME/.config/dotfiles"

mkdir -p "$APPS_ROOT" "$BIN_DIR" "$ICON_DIR"

# Clean up redundant/broken links in bin (case-insensitive and various extensions)
rm -f "$BIN_DIR/WhatsApp" "$BIN_DIR/WhatsApp.AppImage" "$BIN_DIR/whatsapp" "$BIN_DIR/whatsapp.AppImage"

install_appimage() {
	local name=$1
	local url=$2
	local target="$APPS_ROOT/$name.AppImage"

	# Check if already installed and valid (not empty)
	if [ -s "$target" ]; then
		echo -e "${GREEN}✓ $name is already installed at $target${NC}"
	else
		echo -e "${YELLOW}Installing $name from $url...${NC}"
		wget -q --show-progress -O "$target" "$url"
		if [ $? -ne 0 ] || [ ! -s "$target" ]; then
			echo -e "${RED}✗ Failed to download $name. Check URL or connection.${NC}"
			rm -f "$target"
			return 1
		fi
		chmod +x "$target"
	fi
	ln -sf "$target" "$BIN_DIR/$name"
	echo -e "${GREEN}✓ Linked $name to $BIN_DIR/$name${NC}"
}

download_icon() {
	local name=$1
	local url=$2
	local target="$ICON_DIR/$name"

	# If it's a symlink, check if it's dangling or remove it to avoid cp/wget issues
	if [ -L "$target" ]; then
		rm "$target"
	fi

	if [ ! -s "$target" ]; then
		echo -e "${YELLOW}Downloading icon for $name...${NC}"
		wget -q -O "$target" "$url"
		if [ $? -ne 0 ]; then
			echo -e "${RED}✗ Failed to download icon for $name from $url${NC}"
		fi
	fi
}

# --- Wine AppImage ---
WINE_URL="https://github.com/mmtrt/WINE_AppImage/releases/download/continuous/wine-stable_9.0-x86_64.AppImage"
install_appimage "wine" "$WINE_URL"

# --- WhatsApp (mimbrero/whatsapp-desktop-linux) ---
WHATSAPP_URL="https://github.com/mimbrero/whatsapp-desktop-linux/releases/download/v1.2.3-2/whatsapp-desktop-linux-1.2.3-2.AppImage"
install_appimage "whatsapp" "$WHATSAPP_URL"

# --- Obsidian ---
OBSIDIAN_URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.7/Obsidian-1.8.7.AppImage"
install_appimage "obsidian" "$OBSIDIAN_URL"

# --- Bambu Studio ---
BAMBU_URL="https://github.com/bambulab/BambuStudio/releases/download/v02.05.00.67/Bambu_Studio_linux_fedora-v02.05.00.66.AppImage"
install_appimage "bambu-studio" "$BAMBU_URL"

# --- Icons ---
download_icon "bambustudio.png" "https://raw.githubusercontent.com/bambulab/BambuStudio/master/resources/images/BambuStudio-mac_128px.png"

# Sync Icons from dotfiles (using ln -sf to avoid dangling/copy issues)
if [ -d "$DOTFILES_DIR/apps_desktop/icons" ]; then
	echo -e "${YELLOW}Syncing local icons from dotfiles...${NC}"
	for icon in "$DOTFILES_DIR/apps_desktop/icons/"*; do
		[ -f "$icon" ] && ln -sf "$icon" "$ICON_DIR/$(basename "$icon")"
	done
fi

echo -e "${GREEN}All apps processed!${NC}"
