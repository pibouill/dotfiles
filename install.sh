# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 14:14:48 by pibouill          #+#    #+#              #
#    Updated: 2024/11/13 14:15:26 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    # Install curl based on the package manager
    if [ "$(uname)" == "Darwin" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install curl
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        sudo apt-get update
        sudo apt-get install -y curl
    else
        echo "Unsupported operating system. Please install curl manually."
        exit 1
    fi
fi

#####################Cargo######################################################

# Check if Cargo is installed
if ! command -v cargo &> /dev/null; then
    echo "Cargo is not installed. Installing Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "maybe need to exec shell"
else
    echo "Cargo is already installed."
fi

# Install packages with Cargo
packages=("starship")
for package in "${packages[@]}"; do
    echo "Installing $package with Cargo..."
    cargo install "$package" --locked
done

################################################################################

export XDG_CONFIG_HOME="$HOME"/.config

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.config/dotfiles"

mkdir -p "$XDG_CONFIG_HOME"/alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty/themes
mkdir -p "$HOME/.vim/" "$HOME/.vim/autoload"
mkdir -p "$HOME/bin"
cp -r "$DOTFILES_DIR/vim/colors/" "$HOME/.vim/colors/"

git clone https://github.com/dracula/alacritty.git "$XDG_CONFIG_HOME"/alacritty/themes
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh-syntax-highlighting"

# Fonts
#mkdir -p $HOME/.local/share/fonts
#cp $PWD/fonts/JetBrainsMono $HOME/.local/share/fonts

git clone https://github.com/pibouill/dotfiles.git "$DOTFILES_DIR"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

######################Linking###################################################

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
ln -sf "$DOTFILES_DIR/starship.toml" "$XDG_CONFIG_HOME/starship.toml"
ln -sf "$DOTFILES_DIR/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
ln -sf "$DOTFILES_DIR/.gdbinit" "$HOME/.gdbinit"
ln -sf "$DOTFILES_DIR/vim/coc-settings.json" "$HOME/.vim/"
ln -sf $DOTFILES_DIR/bin/* $HOME/bin/

################################################################################

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins using Vim-Plug
vim +PlugInstall +qall

#chsh -s $(which zsh)

printf "\e[38;5;118mDotfiles installation completed.\e[0m\n"
