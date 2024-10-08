#                                     ,---,
#   ,---,                           ,--.' |
# ,---.'|                           |  |  :      __  ,-.
# |   | :                  .--.--.  :  :  :    ,' ,'/ /|
# :   : :      ,--.--.    /  /    ' :  |  |,--.'  | |' | ,---.
# :     |,-.  /       \  |  :  /`./ |  :  '   ||  |   ,'/     \
# |   : '  | .--.  .-. | |  :  ;_   |  |   /' :'  :  / /    / '
# |   |  / :  \__\/: . .  \  \    `.'  :  | | ||  | ' .    ' /
# '   : |: |  ," .--.; |   `----.   \  |  ' | :;  : | '   ; :__
# |   | '/ : /  /  ,.  |  /  /`--'  /  :  :_:,'|  , ; '   | '.'|
# |   :    |;  :   .'   \'--'.     /|  | ,'     ---'  |   :    :
# /    \  / |  ,     .-./  `--'---' `--''              \   \  /
# `-'----'   `--`---'                                   `----'
# 

# History
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.bash_history
export HISTCONTROL=ignoreboth  # Ignores duplicates and commands starting with a space

# Prompt
PS1='\u@\h:\w\$ '

# Mac-specific setup (Darwin)
if [[ $(uname) == "Darwin" ]]; then
   export LIBRARY_PATH=/opt/homebrew/lib
fi

# Environment variables
export MYVIMRC="$HOME/.vimrc"
export DOTFILES="$HOME/.config/dotfiles"
export PROJ=~/work/minishell

# FZF (fuzzy finder) setup
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'
alias c="clear"
alias gwww="cc -Wall -Werror -Wextra"
alias rff="rm -rf"
alias vi=vim
alias i="xdg-open https://profile.intra.42.fr/"
alias gh="xdg-open https://github.com/pibouill"
alias vz="vim ~/.bashrc"
alias vrc="vim ~/.vimrc"
alias work="cd ~/work/"
alias ..="cd .."
alias grep="grep --color=auto"
alias dfl="cd ~/.config/dotfiles/"
alias gru="git remote update"
alias gst="git status -s"
alias gsta="git status"
alias gp="git pull"
alias px="exit"
alias vglc="valgrind --leak-check=full"
alias vglcs="valgrind --leak-check=full --show-leak-kinds=all"
alias workwork="cd /sgoinfre/goinfre/Perso/pibouill/work"
alias checksize='du -sh $(ls -A) | sort -rh'
alias tconf="vim ~/.tmux.conf"
alias proj="cd $PROJ"
alias libft="cd ~/work/libft"
alias tm="tmux"
alias gol="git log --graph --oneline --decorate"
alias gool="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gd="git diff"
alias sgoinfre="cd /sgoinfre/goinfre/Perso/pibouill"
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fp='vim $(ff)'
alias sb="cd ~/Documents/obsidian_vaults"
alias learn="cd ~/work/learn"
alias config="cd ~/.config/"
alias svenv="source .venv/bin/activate"
alias p="python3"
alias exam="cd ~/42-EXAM"
alias gch="git checkout"
alias drd="valgrind --tool=drd"
alias helgrind="valgrind --tool=helgrind"
alias find_word="grep -Rnw . -e"
alias cht="cht.sh"
alias lg="lazygit"

# MacOS Valgrind via Docker
if [[ $(uname) == "Darwin" ]]; then
  alias valgrind='docker run -it -v $PWD:/tmp -w /tmp valgrind:1.0'
fi

# Shortcuts
tc() {
  touch "$1.c"
}

# Dracula theme setup for Bash (Note: bash does not have native highlighting like Zsh)
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export BAT_THEME="Dracula"

# Starship prompt (bash support)
eval "$(starship init bash)"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:~/go/bin"
export PATH="$PATH:~/bin/go/bin/bin"

# Docker development station
SHARED_FOLDER="~"
alias devstation="\
  docker run \
  --cap-drop=ALL  \
  --cap-add=SYS_PTRACE \
  --privileged \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --rm \
  -it -v ${SHARED_FOLDER}:/root/shared jterrazz/devstation bash
"

# 42-specific aliases and environment
if hostname | grep -q 42prague; then
    alias v="flatpak run io.neovim.nvim"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$PATH:/nfs/homes/pibouill/.config/coc/extensions/coc-clangd-data/install/"
    export GOPATH=~/bin/go/bin/
else
    alias v="nvim"
    export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
fi

# Android-specific PATH for Termux
if uname -i | grep -q Android; then
   export PATH=/data/data/com.termux/files/usr/bin:${PATH}
fi

