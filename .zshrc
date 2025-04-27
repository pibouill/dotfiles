#                       ,--.' |                      
#       ,----,          |  |  :      __  ,-.         
#     .'   .`| .--.--.  :  :  :    ,' ,'/ /|         
#  .'   .'  .'/  /    ' :  |  |,--.'  | |' | ,---.   
#,---, '   ./|  :  /`./ |  :  '   ||  |   ,'/     \  
#;   | .'  / |  :  ;_   |  |   /' :'  :  / /    / '  
#`---' /  ;--,\  \    `.'  :  | | ||  | ' .    ' /   
#  /  /  / .`| `----.   \  |  ' | :;  : | '   ; :__  
#./__;     .' /  /`--'  /  :  :_:,'|  , ; '   | '.'| 
#;   |  .'   '--'.     /|  | ,'     ---'  |   :    : 
#`---'         `--'---' `--''              \   \  /  
#                                           `----'   
                                                    
autoload -U colors && colors

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

. "$HOME"

PROMPT='%n@%m%~%% '

if [[ $(uname) == "Darwin" ]]; then
   export LIBRARY_PATH=/opt/homebrew/lib
fi

# apparently need to do that but it doesnt work
# export TERM="xterm-256color"
export MYVIMRC="$HOME/.vimrc"
export MYNVIMRC="$HOME/.config/nvim/init.lua"
export DOTFILES="$HOME/.config/dotfiles"
# Set current working project for easy cd access
#export PROJ=~/work/philo
export PROJ=~/work/minishell
################################################


# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
#


##################KEYBINDS########################

# tmux-sessionizer

# Vim keys in tab complete 
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
#

# ALIAS
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'
alias c="clear"
alias gwww="cc -Wall -Werror -Wextra"
alias rff="rm -rf"
alias vv=vim
alias v=nvim
alias i="open https://profile.intra.42.fr/"
alias vz="nvim $HOME/.zshrc"
alias vrc=v $MYNVIMRC
alias swcaps="~/.config/switch_caps_ctrl.sh"
alias work="cd ~/work/"
alias ..="cd .."
alias grep="grep --color=auto"
alias dfl="cd ~/.config/dotfiles/"
alias px="exit"
alias vglc="valgrind --leak-check=full"
alias vglcs="valgrind --leak-check=full --show-leak-kinds=all"
alias checksize='du -sh $(ls -A) | sort -rh'
alias tconf="v ~/.tmux.conf"
alias proj=cd "$PROJ"
alias libft="cd ~/work/libft"
alias tm="tmux"
alias sgoinfre="cd /sgoinfre/pibouill"
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fp='vi $(ff)'
alias sb="nvim $HOME/Documents/obs_vault"
alias learn="cd ~/work/learn"
alias config="cd ~/.config/"
alias svenv="source .venv/bin/activate"
alias p="python3"
alias drd="valgrind --tool=drd"
alias helgrind="valgrind --tool=helgrind"
alias find_word="grep -Rnw . -e"
alias cht="cht.sh"
# Git aliases
alias lg="lazygit"
# alias gh="firefox https://github.com/pibouill"
alias gol="git log --graph --oneline --decorate"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gd="git diff"
alias gch="git checkout"
alias gwt="git worktree"
alias gru="git remote update"
alias gst="git status -s"
alias gsta="git status"
alias gp="git pull"
alias gpo="git pull origin"
alias grs="git restore"

alias bup="brew update && brew upgrade && brew cleanup"
# alias cat=bat
alias nt=nautilus
alias massif=valgrind --tool=massif --massif-out-file=massif.out

alias cwww="c++ -Wall -Werror -Wextra -std=c++98"

#

alias vim-be-good="docker run -it --rm brandoncc/vim-be-good:stable"

# Using docker for valgrind in macos
if [[ $(uname) == "Darwin" ]]; then
  alias valgrind='docker run -it -v $PWD:/tmp -w /tmp valgrind:1.0'
else
  alias loogo='pkill -u 101370'
fi

# shortcuts
tc() {
  touch "$1.c"
}

####### DRACULA ZSH SYNTAX #######
#################################################################
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[function]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[command]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#50FA7B,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#FFB86C,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[path]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[default]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
##################man pages###################################################
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'      # begin blink
export LESS_TERMCAP_so=$'\e[01;45;37m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[01;36m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
export GROFF_NO_SGR=1                   # for konsole
######################################################################

# Load zsh-syntax-highlight
source "$HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export MAIL=pibouill@student.42prague.com

SHARED_FOLDER="$HOME/bin"

alias devstation="\
	docker run \
  --cap-drop=ALL  \
  --cap-add=SYS_PTRACE \
  --privileged \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --rm \
  -it -v ${SHARED_FOLDER}:/root/shared jterrazz/devstation zsh
"

alias 42free='bash /nfs/homes/pibouill/.scripts/42free.sh'

export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin


if hostname | grep -q 42prague; then
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$HOME/anaconda3/bin:$PATH"
  export PATH="$HOME/sgoinfre/.cargo:$PATH"
  export CARGO_HOME="$HOME/sgoinfre/.cargo"
  export RUSTUP_HOME="$HOME/sgoinfre/.rustup"
  export PATH="$RUSTUP_HOME:$PATH"
  export PATH="$CARGO_HOME/bin:$PATH"
  export PATH="$HOME/.nvm/versions/node/v22.11.0/bin:$PATH"
  export PATH="$PATH:/nfs/homes/pibouill/bin/nvim-linux64/bin"
  eval "$(dircolors ~/.dircolors)"
  export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
  export PATH="$HOME/sgoinfre:$PATH"
  export PATH="/sgoinfre/pibouill/homebrew:$PATH"
  export PATH="$PATH:$HOME/sgoinfre/bin/go/bin/bin"
  export PATH="$PATH:$HOME/sgoinfre/bin/go/bin"
  eval "$(/sgoinfre/pibouill/homebrew/bin/brew shellenv)"
fi

if uname -a | grep -q Android; then
   export PATH=/data/data/com.termux/files/usr/bin:${PATH}
fi


# export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
#
# fzf gruvbox
export FZF_DEFAULT_OPTS=' --color=fg:#d4be98,fg+:#ddc7a1,bg:#1b1b1b,bg+:#282828 --color=hl:#7daea3,hl+:#89b482,info:#afaf87,marker:#a9b665 --color=prompt:#d3869b,spinner:#af5fff,pointer:#ea6962,header:#87afaf --color=border:#32302f,label:#aeaeae,query:#d9d9d9 --border=rounded --border-label=FZF --border-label-pos=0 --preview-window=border-rounded --padding=0 --margin=1 --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'


export BAT_THEME="gruvbox-dark"

export PATH="$HOME/.local/share/nvim/mason:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/19.1.5/bin:$PATH"
#
export MANPAGER="/usr/bin/less -s -M +Gg"

export PKG_CONFIG_PATH=/usr/bin/ibus
export EDITOR=nvim

bindkey -s '^f' "tmux-sessionizer\n"

eval "$(starship init zsh)"
source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export CXXFLAGS="-latomic"
# export CXX="/opt/homebrew/opt/llvm/bin/clang++"
# export LDFLAGS="-latomic"
# export CC=/usr/bin/clang
# export CXX=/usr/bin/clang++
# export LDFLAGS="-lc++abi"
# export CXXFLAGS="-Wno-unused-command-line-argument"
