dotfiles:
	make zsh-setup
	make homebrew
	make asdf
	make rustup
	make nerdfont

homebrew:
	brew bundle --file=./Brewfile

zshdir = $(HOME)/.zsh-setup
zsh-setup:
	if [ ! -d $(zshdir) ]; then \
		sh -c "curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"; \
	fi

asdf:
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git ; \
	asdf plugin add pnpm ; \
	asdf plugin add python ; \
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git ; \
	asdf plugin add golang https://github.com/kennyp/asdf-golang.git ; \
	asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git ; \
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git ; \
	asdf install

rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

nerdfont:
	curl -o nerd-font-symbols.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/NerdFontsSymbolsOnly.zip
	unzip nerd-font-symbols.zip -d ~/Library/Fonts
	rm -f nerd-font-symbols.zip

update:
	$(ZSH)/tools/upgrade.sh
	brew update
	brew upgrade --greedy
	brew upgrade --cask --greedy
	nvim --headless "+Lazy! sync" +TSUpdateSync +MasonUpdate +qa

