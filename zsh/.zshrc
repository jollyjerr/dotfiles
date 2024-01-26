plugins=(
    lol
    fzf
)

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gnzh"
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export LANG="en_US.UTF-8"
set -o vi

alias gaa="git add ."
alias gcm="git commit -m"
alias gpo="git push origin"
alias gs="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias gst="git status"
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

alias dup="docker compose up -d"
alias ddown="docker compose down -v"

function mkcdir() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}
function fd() {
    cd ~ &&
    cd $(find ${1:-"code"} -path "*\.*" \
        -prune -o -name node_modules \
        -prune -o -name deps \
        -prune -o -name build \
        -prune -o -name _build \
        -prune -o -name Pods \
        -prune -o -type d \
        -print \
        | fzf
    )
}
alias cpwd="pwd | pbcopy"
alias vd="fd && vim ."

alias vim="nvim"
alias vi="nvim"
alias ci="nvim" # I can't type lol

alias top="htop"
alias cat="bat"
alias kittytheme="kitty +kitten themes --cache-age 0"

if [[ $(uname -p) = "arm" ]]
then
    eval $(/opt/homebrew/bin/brew shellenv)
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
else
    . /usr/local/opt/asdf/libexec/asdf.sh
fi

# .zshrc.local can be used for secrets or default overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=/opt/homebrew/opt/openjdk
export PATH=$HOME/libraries/depot_tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$PATH

# https://github.com/microsoft/inshellisense
[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh
