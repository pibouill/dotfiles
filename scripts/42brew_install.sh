#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    42brew_install.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/08 14:11:38 by pibouill          #+#    #+#              #
#    Updated: 2024/12/08 14:11:56 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOTFILES_DIR="/home/pibouill/.config/dotfiles"

if ! command -v brew &>/dev/null; then
    echo -e "Installing Homebrew..."
    git clone https://github.com/Homebrew/brew homebrew
    eval "$(homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"
    echo -e "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
	xargs brew install < "$DOTFILES_DIR"/brewlist.txt
else
    echo -e "Homebrew is already installed."
fi
