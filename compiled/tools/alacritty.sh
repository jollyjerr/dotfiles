SRC="$HOME/code/@opensource/alacritty"

if [ -d "$SRC/.git" ]; then
    echo "INFO: alacritty source exists, pulling latest"
    git -C "$SRC" pull
else
    git clone https://github.com/alacritty/alacritty.git "$SRC"
fi

cargo build --release --manifest-path "$SRC/Cargo.toml"
cp "$SRC/target/release/alacritty" "$HOME/.local/bin/alacritty"
