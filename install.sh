#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/19 10:30:31 by pibouill          #+#    #+#              #
#    Updated: 2026/03/19 10:30:31 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RST='\033[0m'

OS="$(uname -s)"
HOSTNAME="$(hostname)"
DOTFILES_DIR="$HOME/.config/dotfiles"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
LOG_DIR="$DOTFILES_DIR/logs"
LOG_FILE="$LOG_DIR/install_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1

echo -e "${YELLOW}Starting installation. Full log at: $LOG_FILE${RST}"

is_42prague() {
	[[ "$HOSTNAME" == *"42prague"* ]]
}

run_sudo() {
	if command -v sudo &>/dev/null; then
		sudo "$@"
	else
		"$@"
	fi
}

is_package_installed() {
	local pkg="$1"
	if command -v brew &>/dev/null; then
		brew list "$pkg" && return 0
	fi
	command -v "$pkg"
}

link_file() {
	local src="$1"
	local dst="$2"

	if [ ! -e "$src" ]; then
		echo -e "${RED}Error: Source $src does not exist.${RST}"
		return 1
	fi

	mkdir -p "$(dirname "$dst")"

	if [ -L "$dst" ]; then
		rm "$dst"
	elif [ -e "$dst" ]; then
		echo -e "${YELLOW}Backing up existing $dst to $dst.bak${RST}"
		mv "$dst" "$dst.bak"
	fi

	echo -e "${GREEN}Linking $src -> $dst${RST}"
	ln -sf "$src" "$dst"
}

prompt_create() {
	local src="$1"
	local dst="$2"
	local default_content="$3"

	if [ -f "$src" ]; then
		link_file "$src" "$dst"
		return
	fi

	echo -e "${YELLOW}Optional config $src is missing.${RST}"
	read -p "Do you want to create a default one in your dotfiles? [y/N] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		mkdir -p "$(dirname "$src")"
		echo -e "$default_content" >"$src"
		link_file "$src" "$dst"
	else
		echo -e "${YELLOW}Skipping $src${RST}"
	fi
}

install_homebrew() {
	if command -v brew &>/dev/null; then
		echo -e "${GREEN}✓ Homebrew is already installed${RST}"
		return 0
	fi

	echo -e "${YELLOW}Installing Homebrew...${RST}"
	if is_42prague; then
		if [ -d "/goinfre/$USER" ]; then
			HOMEBREW_DIR="/goinfre/$USER/homebrew"
		elif [ -d "$HOME/sgoinfre" ]; then
			HOMEBREW_DIR="$HOME/sgoinfre/homebrew"
		else
			HOMEBREW_DIR="$HOME/.homebrew"
		fi
		mkdir -p "$HOMEBREW_DIR"
		git clone https://github.com/Homebrew/brew.git "$HOMEBREW_DIR"
		eval "$("$HOMEBREW_DIR"/bin/brew shellenv)"
	else
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		if [ "$OS" == "Linux" ]; then
			eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		else
			eval "$(/opt/homebrew/bin/brew shellenv)"
		fi
	fi
}

setup_homebrew_shims() {
	if ! is_42prague; then
		return 0
	fi

	HOMEBREW_SHIMS="$HOMEBREW_PREFIX/Library/Homebrew/shims/linux/super"
	if [ ! -d "$HOMEBREW_SHIMS" ]; then
		return 0
	fi

	echo -e "${YELLOW}Setting up Homebrew compiler shims for custom prefix...${RST}"

	if [ ! -f "$HOMEBREW_SHIMS/gcc-12" ] && [ -f /usr/bin/gcc-15 ]; then
		ln -sf /usr/bin/gcc-15 "$HOMEBREW_SHIMS/gcc-12"
	fi

	if [ ! -f "$HOMEBREW_SHIMS/g++-12" ] && [ -f /usr/bin/g++-15 ]; then
		ln -sf /usr/bin/g++-15 "$HOMEBREW_SHIMS/g++-12"
	fi
}

# Main installation logic
install_homebrew
setup_homebrew_shims

if command -v brew &>/dev/null; then
	if [ -f "$DOTFILES_DIR/Brewfile" ]; then
		echo -e "${YELLOW}Syncing system with Brewfile (Verbose)...${RST}"
		if is_42prague; then
			HOMEBREW_NO_BOTTLE=1 HOMEBREW_CC=gcc-15 HOMEBREW_CXX=g++-15 brew bundle install --verbose --file="$DOTFILES_DIR/Brewfile"
		else
			brew bundle install --verbose --file="$DOTFILES_DIR/Brewfile"
		fi
	fi
fi

if command -v cargo &>/dev/null; then
	if [ -f "$DOTFILES_DIR/Cargofile.txt" ]; then
		echo -e "${YELLOW}Installing Cargo packages from Cargofile.txt...${RST}"
		while read -r package; do
			[ -z "$package" ] && continue
			echo -e "${GREEN}Installing $package...${RST}"
			cargo install "$package"
		done <"$DOTFILES_DIR/Cargofile.txt"
	fi
fi

mkdir -p "$XDG_CONFIG_HOME" "$HOME/bin" "$HOME/.vim/autoload" "$HOME/.local/share/fonts" "$HOME/.local/share/applications"

if [ -d "$DOTFILES_DIR/font" ]; then
	if [ "$OS" == "Darwin" ]; then
		echo -e "${YELLOW}Installing fonts for macOS...${RST}"
		cp -rv "$DOTFILES_DIR"/font/JetBrainsMono* "$HOME/Library/Fonts/"
	else
		echo -e "${YELLOW}Installing fonts for Linux...${RST}"
		cp -rv "$DOTFILES_DIR"/font/JetBrainsMono* "$HOME/.local/share/fonts/"
		command -v fc-cache &>/dev/null && fc-cache -fv
	fi
fi

[ ! -d "$XDG_CONFIG_HOME/alacritty/themes" ] && mkdir -p "$XDG_CONFIG_HOME/alacritty" && git clone https://github.com/dracula/alacritty.git "$XDG_CONFIG_HOME/alacritty/themes"
[ ! -d "$XDG_CONFIG_HOME/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh-syntax-highlighting"
[ ! -d "$HOME/.tmux/plugins/tpm" ] && mkdir -p "$HOME/.tmux/plugins" && git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
[ ! -f "$HOME/.vim/autoload/plug.vim" ] && curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link_file "$DOTFILES_DIR/.fzf.zsh" "$HOME/.fzf.zsh"
link_file "$DOTFILES_DIR/.fzf.bash" "$HOME/.fzf.bash"
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.gdbinit" "$HOME/.gdbinit"
link_file "$DOTFILES_DIR/.dircolors" "$HOME/.dircolors"
link_file "$DOTFILES_DIR/.clang-format" "$HOME/.clang-format"
link_file "$DOTFILES_DIR/.clangd" "$HOME/.clangd"
link_file "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"

link_file "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

prompt_create "$DOTFILES_DIR/alacritty/alacritty.toml" \
	"$XDG_CONFIG_HOME/alacritty/alacritty.toml" \
	"[window]\ndimensions = { columns = 80, lines = 24 }"

prompt_create "$DOTFILES_DIR/starship.toml" \
	"$XDG_CONFIG_HOME/starship.toml" \
	"add_newline = false"

prompt_create "$DOTFILES_DIR/apps_config/gemini/settings.json" \
	"$HOME/.gemini/settings.json" \
	"{\n  \"general\": {\n    \"vimMode\": true,\n    \"enableAutoUpdate\": true\n  }\n}"

link_file "$DOTFILES_DIR/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"

[ -f "$DOTFILES_DIR/vscode/settings.json" ] && link_file "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

if [ -d "$DOTFILES_DIR/bin" ]; then
	for file in "$DOTFILES_DIR/bin"/*; do
		[ -f "$file" ] && link_file "$file" "$HOME/bin/$(basename "$file")"
	done
fi

if [ "$OS" == "Linux" ]; then
	if command -v dconf &>/dev/null; then
		[ -f "$DOTFILES_DIR/dconf.txt" ] && dconf load / <"$DOTFILES_DIR/dconf.txt" 2>/dev/null
	fi

	# Install/Link Apps in Goinfre
	if [ -f "$DOTFILES_DIR/scripts/install_apps_goinfre.sh" ]; then
		echo -e "${YELLOW}Installing/Linking Applications in Goinfre...${RST}"
		bash "$DOTFILES_DIR/scripts/install_apps_goinfre.sh"
	fi

	# Handle Icons specifically to avoid dangling symlinks
	if [ -d "$DOTFILES_DIR/apps_desktop/icons" ]; then
		mkdir -p "$HOME/.local/share/applications/icons"
		for icon in "$DOTFILES_DIR/apps_desktop/icons/"*; do
			[ -f "$icon" ] && link_file "$icon" "$HOME/.local/share/applications/icons/$(basename "$icon")"
		done
	fi

	for app_dir in "apps_desktop" "flatpack_apps"; do
		if [ -d "$DOTFILES_DIR/$app_dir" ]; then
			for file in "$DOTFILES_DIR/$app_dir"/*.desktop; do
				[ -f "$file" ] && link_file "$file" "$HOME/.local/share/applications/$(basename "$file")"
			done
		fi
	done
	[ -f "$DOTFILES_DIR/applications/mimeapps.list" ] && link_file "$DOTFILES_DIR/applications/mimeapps.list" "$XDG_CONFIG_HOME/mimeapps.list"
fi

if [ "$SHELL" != "$(which zsh 2>/dev/null)" ] && command -v zsh &>/dev/null; then
	if is_42prague; then
		echo -e "${YELLOW}Note: Manual shell change is required on 42prague.${RST}"
	else
		echo -e "${YELLOW}Changing shell to zsh...${RST}"
		chsh -s "$(which zsh)" 2>/dev/null
	fi
fi

echo -e "\n${YELLOW}--- Post-Install Audit ---${RST}"
ERRORS=$(grep -iEi "error|failed|failed to|could not|incorrect" "$LOG_FILE" | grep -v "0 errors" | sort -u)
WARNINGS=$(grep -iEi "warning|warn|deprecated" "$LOG_FILE" | grep -v "0 warnings" | sort -u)

if [ -n "$ERRORS" ]; then
	echo -e "${RED}Found the following errors during installation:${RST}"
	echo "$ERRORS"
else
	echo -e "${GREEN}✓ No critical errors found.${RST}"
fi

if [ -n "$WARNINGS" ]; then
	echo -e "\n${YELLOW}Found the following warnings:${RST}"
	echo "$WARNINGS"
fi

echo -e "\n${YELLOW}--- Manual Reminders ---${RST}"
[ -f "$DOTFILES_DIR/apps_config/vimium-options.json" ] && echo -e "${YELLOW}Import Vimium settings: $DOTFILES_DIR/apps_config/vimium-options.json${RST}"
[ -f "$DOTFILES_DIR/apps_config/youtube_enhancer_config.txt" ] && echo -e "${YELLOW}Import YouTube Enhancer config: $DOTFILES_DIR/apps_config/youtube_enhancer_config.txt${RST}"

echo -e "${GREEN}✓ Dotfiles installation completed successfully!${RST}"
echo -e "${YELLOW}Full log is available at: $LOG_FILE${RST}"
