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
                                                    

OS="$(uname -s)"
HOSTNAME="$(hostname)"

IS_42PRAGUE=false
if [[ "$OS" == "Linux" ]] && [[ "$HOSTNAME" == *"42prague"* ]]; then
    IS_42PRAGUE=true
fi

BREW_CACHE_FILE="$HOME/.zsh-brew-cache"

_update_brew_cache() {
    local brew_executable
    if [[ "$OS" == "Darwin" ]]; then
        brew_executable="/opt/homebrew/bin/brew"
    elif [[ "$OS" == "Linux" ]]; then
        if $IS_42PRAGUE; then
            brew_executable="/goinfre/$USER/homebrew/bin/brew"
            [ ! -f "$brew_executable" ] && brew_executable="/sgoinfre/$USER/homebrew/bin/brew"
        else
            brew_executable="/home/linuxbrew/.linuxbrew/bin/brew"
        fi
    fi

    if [[ -x "$brew_executable" ]]; then
        echo "Updating Homebrew cache..."
        "$brew_executable" shellenv > "$BREW_CACHE_FILE"
    else
        echo "# Homebrew not found" > "$BREW_CACHE_FILE"
    fi
}

# Load from cache if it exists, otherwise create it
if [[ ! -f "$BREW_CACHE_FILE" ]]; then
    _update_brew_cache
fi

source "$BREW_CACHE_FILE"

brew_refresh_cache() {
    _update_brew_cache
    source "$BREW_CACHE_FILE"
}

if $IS_42PRAGUE; then
    export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"
    export CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
fi


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
export EDITOR=$(command -v nvim || command -v vim)
export MANPAGER="less -s -M +Gg"
export MAIL="pibouill@student.42prague.com"

# -----------------------------------------------------------------------------
typeset -U path
path=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
    "$HOME/go/bin"
    "$HOME/.local/share/nvim/mason/bin"
    $path
)

if [[ "$OS" == "Darwin" ]]; then
    path=("/opt/homebrew/opt/llvm/bin" $path)
fi

if [[ "$OS" == "Linux" ]]; then
    if $IS_42PRAGUE; then
        export NVM_DIR="$HOME/sgoinfre/.nvm"
        export CARGO_HOME="$HOME/sgoinfre/.cargo"
        export RUSTUP_HOME="$HOME/sgoinfre/.rustup"

        path=(
            "$NVM_DIR/versions/node/v22.11.0/bin"
            "$CARGO_HOME/bin"
            "/nfs/homes/pibouill/bin/nvim-linux64/bin"
            "/sgoinfre/pibouill/homebrew/opt/clang-format/bin"
            $path
        )
    fi

    # Dircolors logic (Linux only)
    DIRCOLORS_CACHE_FILE="$HOME/.zsh_dircolors_cache"
    DIRCOLORS_CONFIG_FILE="$HOME/.dircolors"

    _update_dircolors_cache() {
        if [[ -f "$DIRCOLORS_CONFIG_FILE" ]] && command -v dircolors >/dev/null; then
            echo "Updating dircolors cache..."
            dircolors "$DIRCOLORS_CONFIG_FILE" > "$DIRCOLORS_CACHE_FILE"
        else
            echo "# dircolors not configured" > "$DIRCOLORS_CACHE_FILE"
        fi
    }

    if [[ ! -f "$DIRCOLORS_CACHE_FILE" ]]; then
        _update_dircolors_cache
    fi

    if [[ -s "$DIRCOLORS_CACHE_FILE" ]]; then
        eval "$(cat "$DIRCOLORS_CACHE_FILE")"
    fi

    dircolors_refresh_cache() {
        _update_dircolors_cache
        if [[ -s "$DIRCOLORS_CACHE_FILE" ]]; then
            eval "$(cat "$DIRCOLORS_CACHE_FILE")"
        fi
    }
fi

export PATH
# -----------------------------------------------------------------------------

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m+1) ]]; then
  compinit
else
  compinit -C
fi

_comp_options+=(globdots)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Custom keybinds
bindkey -s '^f' "tmux-sessionizer\n"

# -----------------------------------------------------------------------------
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
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'

alias work="cd ~/work/"
alias dfl="cd ~/.config/dotfiles/"
alias proj='cd "$PROJ"'
alias libft="cd ~/work/libft"
alias sgoinfre="cd /sgoinfre/pibouill"
alias sb="v $HOME/sgoinfre/obs_vault_good/"
alias learn="cd ~/work/learn"
alias config="cd ~/.config/"

alias svenv="source .venv/bin/activate"
alias vglc="valgrind --leak-check=full"
alias vglcs="valgrind --leak-check=full --show-leak-kinds=all"
alias drd="valgrind --tool=drd"
alias helgrind="valgrind --tool=helgrind"
alias massif='valgrind --tool=massif --massif-out-file=massif.out'
alias vim-be-good="docker run -it --rm brandoncc/vim-be-good:stable"

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

alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fp='vi $(ff)'
alias find_word="grep -Rnw . -e"

alias i="open https://profile.intra.42.fr/"
alias vz="nvim $HOME/.zshrc"
alias vrc="nvim $MYNVIMRC"
alias 42free='bash /nfs/homes/pibouill/.scripts/42free.sh'
alias tetr='firefox https://tetr.io'
alias parrot=/home/pibouill/parrot.sh

alias tm="tmux"
alias tconf="v ~/.tmux.conf"
alias swcaps="~/.config/switch_caps_ctrl.sh"
alias cht="cht.sh"
alias nt=nautilus
alias weather="bash ~/bin/weather"

tc() {
  touch "$1.c"
}

# -----------------------------------------------------------------------------

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

eval "$(starship init zsh)"

# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS=' --color=fg:#908caa,bg:#191724,hl:#ebbcba --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba --color=border:#403d52,header:#31748f,gutter:#191724 --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52 --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa --color=label:#908caa,query:#e0def4 --border=rounded --border-label=FZF --border-label-pos=0 --preview-window=border-rounded --padding=0 --margin=1 --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -----------------------------------------------------------------------------
# NVM & Node.js Lazy Loading
# -----------------------------------------------------------------------------
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"

nvm_lazy_load() {
    # Remove functions so they don't loop
    unset -f nvm node npm npx pnpm yarn gemini
    
    # Load NVM if the script exists
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi
    
    # Load bash_completion if it exists
    if [ -s "$NVM_DIR/bash_completion" ]; then
        source "$NVM_DIR/bash_completion"
    fi
}

# Create triggers for all Node-related commands
for cmd in nvm node npm npx pnpm yarn gemini; do
    eval "$cmd() { nvm_lazy_load; $cmd \"\$@\" }"
done

# -----------------------------------------------------------------------------
# Environment & Extras
# -----------------------------------------------------------------------------
[ -f "$DOTFILES/.env" ] && source "$DOTFILES/.env"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'     
export LESS_TERMCAP_so=$'\e[01;45;37m'
export LESS_TERMCAP_us=$'\e[01;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export GROFF_NO_SGR=1
