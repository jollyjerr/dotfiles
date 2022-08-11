.PHONY: all files homebrew zsh-setup asdf 

all:
	make files
	make homebrew
	make zsh-setup
	make asdf

files:
	cp ./.dotfiles/{.zshrc,.gitconfig,.tool-versions,Brewfile} ./
	cp ./.dotfiles/.config/nvim ./.config/
	cp ./.dotfiles/.config/kitty ./.config/

homebrew:
	command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
	brew bundle --file=./Brewfile

zshdir = $(HOME)/.zsh-setup
zsh-setup:
	if [ ! -d $(zshdir) ]; then \
		sh -c "curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"; \
	fi

asdf:
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git ; \
	asdf plugin-add pnpm ; \
	asdf plugin-add python ; \
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git ; \
	asdf plugin-add golang https://github.com/kennyp/asdf-golang.git ; \
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git ; \
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git ; \
	asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git ; \
	asdf install
