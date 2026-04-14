#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/code/@opensource" "$HOME/.local/bin"

for tool in "$SCRIPT_DIR/tools/"*.sh; do
    echo "INFO: Building $(basename "$tool" .sh)"
    source "$tool"
done

echo "INFO: All compiled tools built!"
