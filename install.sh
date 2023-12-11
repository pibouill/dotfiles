#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.config/DOTFILES"

# Clone dotfiles repository (replace URL with your own repository)
git clone https://github.com/pibouill/DOTFILES.git "$DOTFILES_DIR"

# Symlink .zshrc
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Install Powerlevel10k for Oh My Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.p10.zsh"

# Symlink .p10k.zsh
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# Symlink .vimrc
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Install Vim-Plug (if not already installed)
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins using Vim-Plug
vim +PlugInstall +qall

echo "Dotfiles installation completed!"

