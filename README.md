# dotfiles

This repo contains my dev configuration and the scripts needed to get everything installed and ready to go.

Always a WIP and changing every day :)

## Setup instructions

This repo is targeted for MacOS/Ubuntu. Many of the tools I use are cross platform and you should be able to get everything working on any OS, but you will be on your own 🫡.

The basic idea is your configuration files all live in ~/.dotfiles and are symlinked to the appropriate config location for each application.

See this blog for details: https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

```bash
cd ~
git clone git@github.com:jollyjerr/dotfiles.git .dotfiles

cd .dotfiles
make stow # this links all the files to their appropriate location

cd ..
make dotfiles # this downloads _all the things_
```

open [kitty](https://github.com/kovidgoyal/kitty), and ✨ have fun ✨
