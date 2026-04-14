SRC="$HOME/code/@opensource/expert"

if [ -d "$SRC/.git" ]; then
    echo "INFO: expert source exists, pulling latest"
    git -C "$SRC" pull
else
    git clone https://github.com/elixir-lang/expert.git "$SRC"
fi

cd "$SRC" && just release
