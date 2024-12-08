#!/bin/bash

cd /nfs/homes/${USER}/sgoinfre 

if ! command -v brew &>/dev/null; then
    echo -e "Installing Homebrew..."
    git clone https://github.com/Homebrew/brew homebrew
    eval "$(homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"
    echo -e "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
else
    echo -e "Homebrew is already installed."
fi
