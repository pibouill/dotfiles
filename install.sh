#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    # Install curl based on the package manager
    if [ "$(uname)" == "Darwin" ]; then
        # macOS uses brew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install curl
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux uses apt-get
        sudo apt-get update
        sudo apt-get install -y curl
    else
        echo "Unsupported operating system. Please install curl manually."
        exit 1
    fi
fi

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.config/dotfiles"

git clone https://github.com/pibouill/dotfiles.git "$DOTFILES_DIR"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.p10k.zsh"

ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Install Vim-Plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins using Vim-Plug
vim +PlugInstall +qall

echo "Dotfiles installation completed!"

