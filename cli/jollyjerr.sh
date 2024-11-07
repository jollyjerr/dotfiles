#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    os="mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    os="linux"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    os="windows"
else
    os="unknown"
fi

function help {
    echo "________________jollyjerr dotfiles_______________"
    echo ""
    echo "Available commands:"
    echo "  - deps (install all dependencies for this cli)"
    echo "  - zsh_setup (configure zsh/oh-my-zsh)"
    echo "  - fonts (download and configure fonts)"
    echo "  - languages (configure asdf and install languages)"
    echo "  - update (update everything to latest)"
    echo "  - init (run full installation for fresh machine)"
}

function deps {
    if [[ "$os" == "mac" ]]; then
        brew bundle --file=./Brewfile
    elif [[ "$os" == "linux" ]]; then
        if [[ ! -f ".asdf" ]]; then
            git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
        fi
        # TODO: nvim
        # TODO: tmux
    else
        echo "ERROR: OS $OSTYPE not supported yet :("
        exit 1
    fi

    echo "INFO: All deps installed!"
}

function zsh_setup {
    if [[ ! -d "$HOME/.zsh-setup" ]]; then
		sh -c "curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	fi

    echo "INFO: ZSH configured!"
}

function fonts {
	curl -o jetbrainsmononerdfont.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip
	unzip jetbrainsmononerdfont.zip -d ~/Library/Fonts
	rm -f jetbrainsmononerdfont.zip

    echo "INFO: Fonts installed!"
}

function languages {
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf plugin add pnpm
	asdf plugin add python
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf plugin add golang https://github.com/kennyp/asdf-golang.git
	asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
	asdf install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    echo "INFO: languages installed!"
}

function update {
    $ZSH/tools/upgrade.sh

    if [[ "$os" == "mac" ]]; then
	    brew update
	    brew upgrade --greedy
	    brew upgrade --cask --greedy
    fi

	nvim --headless "+Lazy! sync" +TSUpdateSync +MasonUpdate +qa
}

function init {
    deps
    # TODO: make zsh_setup idempotent
    # zsh_setup
    # TODO: make font install idempotent
    # fonts
    languages
}

if [[ -n "$1" ]]; then
    if declare -f "$1" > /dev/null; then
        "$1"
    else
        echo "ERROR: command $1 not found :("
        help
        exit 1
    fi
else
    help
    exit 1
fi
