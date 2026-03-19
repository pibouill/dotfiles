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

COMMON_PACKAGES=(
    "git" "wget" "curl" "vim" "nvim" "tmux" "htop" "tree" 
    "lua" "luarocks" "python3" "nodejs" "go" "ripgrep" "fzf"
)

is_42prague() {
    [[ "$HOSTNAME" == *"42prague"* ]]
}

run_sudo() {
    if command -v sudo &> /dev/null; then
        sudo "$@"
    else
        "$@"
    fi
}

is_package_installed() {
    local pkg="$1"
    if command -v brew &> /dev/null; then
        brew list "$pkg" &> /dev/null && return 0
    fi
    command -v "$pkg" &> /dev/null
}

install_package() {
    local pkg="$1"
    if is_package_installed "$pkg"; then
        echo -e "${GREEN}✓ $pkg is already installed${RST}"
        return 0
    fi

    echo -e "${YELLOW}Installing $pkg...${RST}"
    if command -v brew &> /dev/null; then
        brew install "$pkg"
    elif [ "$OS" == "Linux" ] && command -v apt-get &> /dev/null; then
        run_sudo apt-get install -y "$pkg"
    fi
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
        echo -e "$default_content" > "$src"
        link_file "$src" "$dst"
    else
        echo -e "${YELLOW}Skipping $src${RST}"
    fi
}

if is_42prague; then
    echo -e "${GREEN}42Prague detected: Using user-space installation${RST}"
    if [ -d "/goinfre/$USER" ]; then
        HOMEBREW_DIR="/goinfre/$USER/homebrew"
    elif [ -d "$HOME/sgoinfre" ]; then
        HOMEBREW_DIR="$HOME/sgoinfre/homebrew"
    else
        HOMEBREW_DIR="$HOME/.homebrew"
    fi
    
    if ! command -v brew &> /dev/null || [[ "$PATH" != *"$HOMEBREW_DIR/bin"* ]]; then
        if [ ! -d "$HOMEBREW_DIR" ]; then
            echo -e "${YELLOW}Installing Homebrew to $HOMEBREW_DIR...${RST}"
            mkdir -p "$HOMEBREW_DIR"
            git clone https://github.com/Homebrew/brew.git "$HOMEBREW_DIR" 2>/dev/null
        fi
        export PATH="$HOMEBREW_DIR/bin:$PATH"
        for rc in "$DOTFILES_DIR/.zshrc" "$DOTFILES_DIR/.bashrc"; do
            if [ -f "$rc" ]; then
                if ! grep -q "$HOMEBREW_DIR/bin" "$rc"; then
                    echo "export PATH=\"$HOMEBREW_DIR/bin:\$PATH\"" >> "$rc"
                fi
            fi
        done
    fi
else
    if ! command -v brew &> /dev/null; then
        if [ "$OS" == "Darwin" ]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    fi
fi

for pkg in "${COMMON_PACKAGES[@]}"; do
    install_package "$pkg"
done

if [ -f "$DOTFILES_DIR/brewlist.txt" ] && command -v brew &> /dev/null; then
    read -p "Install additional packages from brewlist.txt? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        while read -r pkg; do
            [ -n "$pkg" ] && install_package "$pkg"
        done < "$DOTFILES_DIR/brewlist.txt"
    fi
fi

mkdir -p "$XDG_CONFIG_HOME" "$HOME/bin" "$HOME/.vim/autoload" "$HOME/.local/share/fonts" "$HOME/.local/share/applications"

if [ -d "$DOTFILES_DIR/font" ]; then
    cp -r "$DOTFILES_DIR"/font/JetBrainsMono* "$HOME/.local/share/fonts/" 2>/dev/null
    command -v fc-cache &> /dev/null && fc-cache -f
fi

[ ! -d "$XDG_CONFIG_HOME/alacritty/themes" ] && mkdir -p "$XDG_CONFIG_HOME/alacritty" && git clone https://github.com/dracula/alacritty.git "$XDG_CONFIG_HOME/alacritty/themes" 2>/dev/null
[ ! -d "$XDG_CONFIG_HOME/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh-syntax-highlighting" 2>/dev/null
[ ! -d "$HOME/.tmux/plugins/tpm" ] && mkdir -p "$HOME/.tmux/plugins" && git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" 2>/dev/null
[ ! -f "$HOME/.vim/autoload/plug.vim" ] && curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>/dev/null

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
    if command -v dconf &> /dev/null; then
        [ -f "$DOTFILES_DIR/dconf.txt" ] && dconf load / < "$DOTFILES_DIR/dconf.txt"
    fi

    for app_dir in "applications" "flatpack_apps"; do
        if [ -d "$DOTFILES_DIR/$app_dir" ]; then
            for file in "$DOTFILES_DIR/$app_dir"/*.desktop; do
                [ -f "$file" ] && link_file "$file" "$HOME/.local/share/applications/$(basename "$file")"
            done
        fi
    done
    [ -f "$DOTFILES_DIR/applications/mimeapps.list" ] && link_file "$DOTFILES_DIR/applications/mimeapps.list" "$XDG_CONFIG_HOME/mimeapps.list"
fi

if [ "$SHELL" != "$(which zsh 2>/dev/null)" ] && command -v zsh &> /dev/null; then
    is_42prague && echo -e "${YELLOW}Manual shell change may be needed on 42prague.${RST}"
    chsh -s "$(which zsh)" 2>/dev/null
fi

echo -e "\n${YELLOW}--- Manual Reminders ---${RST}"
[ -f "$DOTFILES_DIR/apps_config/vimium-options.json" ] && echo -e "${YELLOW}Import Vimium settings: $DOTFILES_DIR/apps_config/vimium-options.json${RST}"
[ -f "$DOTFILES_DIR/apps_config/youtube_enhancer_config.txt" ] && echo -e "${YELLOW}Import YouTube Enhancer config: $DOTFILES_DIR/apps_config/youtube_enhancer_config.txt${RST}"

echo -e "${GREEN}✓ Dotfiles installation completed successfully!${RST}"
