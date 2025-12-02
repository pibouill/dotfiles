#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 14:14:48 by pibouill          #+#    #+#              #
#    Updated: 2024/11/26 13:07:35 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    if [ "$(uname)" == "Darwin" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install curl
	elif [ "$(uname -s | cut -c 1-5)" == "Linux" ]; then
        sudo apt-get update
        sudo apt-get install -y curl
    else
        echo "Unsupported operating system. Please install curl manually."
        exit 1
    fi
fi

#####################Cargo######################################################

# if ! command -v cargo &> /dev/null; then
#     echo "Cargo is not installed. Installing Cargo..."
#     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#     echo "maybe need to exec shell"
# else
#     echo "Cargo is already installed."
# fi
#
# packages=("starship, alacritty")
# for package in "${packages[@]}"; do
#     echo "Installing $package with Cargo..."
#     cargo install "$package" --locked
# done

################################################################################

export XDG_CONFIG_HOME="$HOME"/.config

DOTFILES_DIR="$HOME/.config/dotfiles"

mkdir -p "$XDG_CONFIG_HOME"/alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty/themes
mkdir -p "$HOME/.vim/" "$HOME/.vim/autoload"
mkdir -p "$HOME/bin"
cp -r "$DOTFILES_DIR/vim/colors/" "$HOME/.vim/colors/"

git clone https://github.com/dracula/alacritty.git "$XDG_CONFIG_HOME"/alacritty/themes
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh-syntax-highlighting"

# Fonts
mkdir -p "$HOME"/.local/share/fonts
cp -r "$PWD"/font/JetBrainsMono* "$HOME"/.local/share/fonts

git clone --depth 1 git@github.com:pibouill/dotfiles.git "$DOTFILES_DIR"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

######################Linking###################################################

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
ln -sf "$DOTFILES_DIR/starship.toml" "$XDG_CONFIG_HOME/starship.toml"
ln -sf "$DOTFILES_DIR/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
ln -sf "$DOTFILES_DIR/.gdbinit" "$HOME/.gdbinit"
for file in $DOTFILES_DIR/bin/; do
	ln -sf "$file" "$HOME/bin/"
done
ln -sf "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.dircolors" "$HOME/.dircolors"

################################################################################

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

################################################################################

chsh -s "$(which zsh)"

printf "\e[38;5;118mDotfiles installation completed.\e[0m\n"

# COLORS
# 0;30m	Black
# 0;31m	Red
# 0;32m	Green
# 0;33m	Yellow
# 0;34m	Blue
# 0;35m	Purple
# 0;36m	Cyan
# 0;37m	White
# 1;30m	Dark Gray
# 1;31m	Light Red
# 1;32m	Light Green
# 1;33m	Light Yellow
# 1;34m	Light Blue
# 1;35m	Light Purple
# 1;36m	Light Cyan
# 1;37m	Light White
