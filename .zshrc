# Init
plugins=(
    lol
)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gnzh"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

# Options
export EDITOR=nvim
export LANG="en_US.UTF-8"

set -o vi

bindkey '^R' history-incremental-search-backward
setopt extendedglob nocaseglob globdots

## -- ALIASES
# Dotfiles 
alias gdot="git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
alias vidot="nvim ~/.config/nvim"

# Git
alias gaa="git add ."
alias gcm="git commit -m"
alias gpo="git push origin"
alias gs="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias gr="git remote -v"
alias gcb="git checkout -b"
alias gback="git checkout -"
function pull () {
    branch_name=${1:-"main"}
    git checkout $branch_name && git pull origin $branch_name && git remote update && git fetch
}
function gprunebranches () {
    branch_name_to_keep=${1:-"main"}
    git for-each-ref --format '%(refname:short)' refs/heads | grep -v $branch_name_to_keep | xargs git branch -D
}

# Docker
alias dup="docker compose up -d"
alias ddown="docker compose down -v"

# Navigation
function mkcdir() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}
alias cpwd="pwd | pbcopy"
alias fd="cd ~ && cd \$(find code -path \"*\/.*\" -prune -o -name node_modules -prune -o -type d -print | fzf)"
alias vd="fd && vim ."

# Vim
alias vim="nvim"
alias vi="nvim"
alias ci="nvim" # I can't type lol

# Tools
alias top="htop"
alias cat="bat"
alias kittytheme="kitty +kitten themes --cache-age 0"

## -- Sources
eval $(/opt/homebrew/bin/brew shellenv)
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export PATH=~/libraries/depot_tools:$PATH
