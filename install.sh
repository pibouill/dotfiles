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

export XDG_CONFIG_HOME="$HOME"/.config

mkdir -p "$XDG_CONFIG_HOME"/alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty/themes
mkdir "$HOME/.vim/" "$HOME/.vim/autoload"

git clone https://github.com/dracula/alacritty.git "$XDG_CONFIG_HOME"/alacritty/themes

# Fonts
#mkdir -p $HOME/.local/share/fonts
#cp $PWD/fonts/JetBrainsMono $HOME/.local/share/fonts

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.config/dotfiles"

git clone https://github.com/pibouill/dotfiles.git "$DOTFILES_DIR"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
ln -sf "$DOTFILES_DIR/starship.toml" "$XDG_CONFIG_HOME/starship.toml"
ln -sf "$DOTFILES_DIR/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
ln -sf "$DOTFILES_DIR/.gdbinit" "$HOME/.gdbinit"

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

curl -sS https://starship.rs/install.sh | sh

# Install Vim plugins using Vim-Plug
vim +PlugInstall +qall

printf "\e[38;5;118mDotfiles installation completed.\e[0m\n"
