#!/bin/bash

function deps {
    if [[ "$OSTYPE" == "darwin"* ]];  then
        echo "INFO: Running MacOS installation"

        if ! command -v brew >/dev/null 2>&1; then
            echo "INFO: Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        if ! command -v stow >/dev/null 2>&1; then
            echo "INFO: Installing Stow"
            brew install stow
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "INFO: Running linux (Ubuntu preferred) installation"
    else
        echo "ERROR: OS $OSTYPE not supported yet :("
        exit 1
    fi

    echo "INFO: All deps installed!"
}

function install {
    for dir in */; do
        if [[ -d "$dir" ]]; then
            dir_name=${dir%/}
            echo "INFO: stowing $dir_name"
            stow "$dir_name"
        fi
    done
}

function cli_init {
    ~/jollyjerr.sh init
}

deps
install
cli_init
echo "Done! Leeeeetttttt'sssss gooooooo!!!!!!!"
