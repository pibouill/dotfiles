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
                                                    

# -----------------------------------------------------------------------------
# GENERAL SHELL OPTIONS
# -----------------------------------------------------------------------------
autoload -U colors && colors

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# Prompt
PROMPT='%n@%m%~%% '

# General Environment Variables
export MYVIMRC="$HOME/.vimrc"
export MYNVIMRC="$HOME/.config/nvim/init.lua"
export DOTFILES="$HOME/.config/dotfiles"
export BAT_THEME="gruvbox-dark"
export EDITOR=/opt/homebrew/bin/nvim
export MANPAGER="/usr/bin/less -s -M +Gg"
export MAIL=pibouill@student.42prague.com
# export PROJ=~/work/cub3d # Set current working project for easy cd access

# -----------------------------------------------------------------------------
# COMPLETION & KEYBINDINGS
# -----------------------------------------------------------------------------
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Vim keys in tab complete 
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Custom keybinds
bindkey -s '^f' "tmux-sessionizer\n"

# -----------------------------------------------------------------------------
# ALIASES & FUNCTIONS
# -----------------------------------------------------------------------------
# General
alias c="clear"
alias rff="rm -rf"
alias vv=vim
alias v=nvim
alias ..="cd .."
alias grep="grep --color=auto"
alias px="exit"
alias checksize='du -sh $(ls -A) | sort -rh'
alias cat=bat
alias p="python3"
alias mr="make re"
alias cwww="c++ -Wall -Werror -Wextra -std=c++98"

# Navigation
alias work="cd ~/work/"
alias dfl="cd ~/.config/dotfiles/"
alias proj='cd "$PROJ"'
alias libft="cd ~/work/libft"
alias sgoinfre="cd /sgoinfre/pibouill"
alias sb="v $HOME/sgoinfre/obs_vault_good/"
alias learn="cd ~/work/learn"
alias config="cd ~/.config/"

# Development & Tools
alias svenv="source .venv/bin/activate"
alias vglc="valgrind --leak-check=full"
alias vglcs="valgrind --leak-check=full --show-leak-kinds=all"
alias drd="valgrind --tool=drd"
alias helgrind="valgrind --tool=helgrind"
alias massif='valgrind --tool=massif --massif-out-file=massif.out'
alias vim-be-good="docker run -it --rm brandoncc/vim-be-good:stable"

# Git
alias lg="lazygit"
alias gol="git log --graph --oneline --decorate"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla="gl --all"
alias gd="git diff"
alias gch="git checkout"
alias gsw="git switch"
alias gwt="git worktree"
alias gru="git remote update"
alias gst="git status -s"
alias gsta="git status"
alias gp="git pull"
alias gpo="git pull origin"
alias grs="git restore"

# Search (fzf, grep)
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fp='vi $(ff)'
alias find_word="grep -Rnw . -e"

# 42 School Specific
alias i="open https://profile.intra.42.fr/"
alias vz="nvim $HOME/.zshrc"
alias vrc="nvim $MYNVIMRC"
alias 42free='bash /nfs/homes/pibouill/.scripts/42free.sh'
alias tetr='firefox https://tetr.io'
alias parrot=/home/pibouill/parrot.sh

# Misc
alias tm="tmux"
alias tconf="v ~/.tmux.conf"
alias swcaps="~/.config/switch_caps_ctrl.sh"
alias cht="cht.sh"
alias nt=nautilus

# Functions
tc() {
  touch "$1.c"
}

# -----------------------------------------------------------------------------
# OS-SPECIFIC CONFIGURATIONS
# -----------------------------------------------------------------------------
case "$(uname -s)" in
    Darwin)
        # --- macOS Settings ---
        export LIBRARY_PATH=/opt/homebrew/lib
        stty -ixon # disables ctrl+s behavior

        # Homebrew PATHs
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
        export PATH="/opt/homebrew/opt/llvm/19.1.5/bin:$PATH" # Note: may be redundant if llvm is linked

        # Docker-based valgrind for macOS
        alias valgrind='docker run -it -v $PWD:/tmp -w /tmp valgrind:1.0'

        # GNU ls (from coreutils) and colors
        if [ -f "$HOME/.dircolors" ] && command -v gdircolors >/dev/null; then
            eval "$(gdircolors "$HOME/.dircolors")"
        fi
        alias ls='gls --color=auto'
        alias ll='gls -lah --color=auto'

        # Homebrew alias
        alias bup="brew update && brew upgrade && brew cleanup"
        ;;

    Linux)
        # --- Linux Settings ---

        if [ -f "$HOME/.dircolors" ] && command -v dircolors >/dev/null; then
            eval "$(dircolors "$HOME/.dircolors")"
        fi
        alias ls='ls --color=auto'
        alias ll='ls -lah --color=auto'

        alias loogo='pkill -u 101370'

        if hostname | grep -q 42prague; then
          export PATH="$HOME/.local/bin:$PATH"
          export PATH="$HOME/anaconda3/bin:$PATH"
          export PATH="$HOME/sgoinfre/.cargo:$PATH"
          export CARGO_HOME="$HOME/sgoinfre/.cargo"
          export RUSTUP_HOME="$HOME/sgoinfre/.rustup"
          export PATH="$RUSTUP_HOME:$PATH"
          export PATH="$CARGO_HOME/bin:$PATH"
          export NVM_DIR="$HOME/sgoinfre/.nvm"
          export PATH="$HOME/.nvm/versions/node/v22.11.0/bin:$PATH"
          export PATH="$PATH:/nfs/homes/pibouill/bin/nvim-linux64/bin"
          export PATH="$HOME/sgoinfre:$PATH"
          export PATH="/sgoinfre/pibouill/homebrew:$PATH"
          eval "$(/sgoinfre/pibouill/homebrew/bin/brew shellenv)"
          export PATH=$PATH:/home/pibouill/go/bin
          eval "$(/sgoinfre/pibouill/homebrew/bin/brew shellenv)"
        fi
        ;;
esac

# Android (Termux)
if uname -a | grep -q Android; then
   export PATH=/data/data/com.termux/files/usr/bin:${PATH}
fi

# -----------------------------------------------------------------------------
# ZSH THEME & SYNTAX HIGHLIGHTING
# -----------------------------------------------------------------------------

# ZSH Syntax Highlighting (Dracula theme)
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
source "$HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Starship Prompt
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# FRAMEWORK & TOOL INITIALIZATION
# -----------------------------------------------------------------------------

# fzf
# fzf rose pine
export FZF_DEFAULT_OPTS=' --color=fg:#908caa,bg:#191724,hl:#ebbcba --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba --color=border:#403d52,header:#31748f,gutter:#191724 --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52 --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa --color=label:#908caa,query:#e0def4 --border=rounded --border-label=FZF --border-label-pos=0 --preview-window=border-rounded --padding=0 --margin=1 --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
# Other fzf themes:
# export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# export FZF_DEFAULT_OPTS=' --color=fg:#d4be98,fg+:#ddc7a1,bg:#1b1b1b,bg+:#282828 --color=hl:#7daea3,hl+:#89b482,info:#afaf87,marker:#a9b665 --color=prompt:#d3869b,spinner:#af5fff,pointer:#ea6962,header:#87afaf --color=border:#32302f,label:#aeaeae,query:#d9d9d9 --border=rounded --border-label=FZF --border-label-pos=0 --preview-window=border-rounded --padding=0 --margin=1 --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm (Node Version Manager)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# envman & local environment
[ -f "$DOTFILES/.env" ] && source "$DOTFILES/.env"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# -----------------------------------------------------------------------------
# FINAL PATH MODIFICATIONS & MISC
# -----------------------------------------------------------------------------
# These are general and should apply to all systems, added at the end for priority.
export PATH="$HOME/.local/share/nvim/mason:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="/sgoinfre/pibouill/homebrew/opt/clang-format/bin:$PATH"

# Man pages colors
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'      # begin blink
export LESS_TERMCAP_so=$'\e[01;45;37m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[01;36m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
export GROFF_NO_SGR=1                   # for konsole

# legacy path configs
export PKG_CONFIG_PATH=/usr/bin/ibus
. "$HOME"
export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
