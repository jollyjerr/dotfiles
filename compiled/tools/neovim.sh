SRC="$HOME/code/@opensource/neovim"

if [ -d "$SRC/.git" ]; then
    echo "INFO: neovim source exists, pulling latest"
    git -C "$SRC" pull
else
    git clone https://github.com/neovim/neovim.git "$SRC"
fi

make -C "$SRC" CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$HOME/.local"
make -C "$SRC" install
