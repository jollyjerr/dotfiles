# zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

# aliases
source $HOME/.aliases

# shell
export EDITOR=nvim
export LANG="en_US.UTF-8"
set -o vi
bindkey '^R' history-incremental-search-backward # Search
setopt extendedglob nocaseglob globdots

# asdf init
. /usr/local/opt/asdf/asdf.sh
