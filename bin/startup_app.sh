#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    startup_app.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/15 15:27:40 by pibouill          #+#    #+#              #
#    Updated: 2025/01/15 15:27:40 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

run()
{
	if command -v "$1" >/dev/null 2>&1 || [ -x "$1" ]; then
		"$@" > /dev/null 2>&1 & disown
	fi

}

run slack
run firefox
run "$HOME/bin/obsidian"
run /sgoinfre/pibouill/.cargo/bin/alacritty
run google-chrome
