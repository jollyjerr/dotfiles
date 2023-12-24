stow:
	make ensureHomebrew
	make ensureStow
	stow asdf
	stow cmd
	stow git
	stow homebrew
	stow kitty
	stow nvim
	stow pgcli
	stow zsh

ensureHomebrew:
	command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }

ensureStow:
	command -v stow >/dev/null 2>&1 || { brew install stow; }
