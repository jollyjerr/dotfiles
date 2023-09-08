all:
	make stow

stow:
	stow asdf
	stow cmd
	stow git
	stow homebrew
	stow kitty
	stow nvim
	stow pgcli
	stow zsh

format:
	stylua nvim/.config/nvim/**/*.lua --config-path nvim/.config/nvim/stylua.toml

format-check:
	stylua nvim/.config/nvim/**/*.lua --config-path nvim/.config/nvim/stylua.toml --check
