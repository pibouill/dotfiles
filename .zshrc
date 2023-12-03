
# Check for OS and defines home path
if [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH_TO_HOME="/Users/pierre"
	. /Users/pierre/
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	export PATH_TO_HOME="/nfs/pibouill"
	. /nfs/homes/pibouill/
fi
echo "My path is: $PATH_TO_HOME"
#
autoload -U colors && colors

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


PROMPT='%n@%m%~%% '

# auto/tab complete
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

# ALIAS
alias ll='ls -lah --color=auto'
alias c="clear"
alias gcc="cc -Wall -Werror -Wextra"
alias rff="rm -rf"
alias vi  vim
alias i="open https://profile.intra.42.fr/"
alias gh="open https://github.com/pibouill"
alias vz="vi ~/.zshrc"
alias vrc="vi ~/.vimrc"
alias swcaps="~/.config/switch_caps_ctrl.sh"

source $PATH_TO_HOME/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias vim-be-good="docker run -it --rm brandoncc/vim-be-good:stable"
alias francinette="$HOME"/francinette/tester.sh
alias paco="$HOME"/francinette/tester.sh
alias cclean='bash ~/Cleaner_42.sh'

# shortcuts
tc() {
  touch "$1.c"
}

export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
export MAIL=pibouill@student.42prague.com
# Load Catpuccin syntax highlight
source $PATH_TO_HOME/.config/catppuccin_mocha-zsh-syntax-highlighting.zsh
# Load zsh-syntax-highlight
source $PATH_TO_HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
