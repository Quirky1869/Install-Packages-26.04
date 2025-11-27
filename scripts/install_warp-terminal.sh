#!/bin/bash

# ▄     ▄   ▄▄   ▄▄▄▄▄  ▄▄▄▄▄        ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄  ▄    ▄ ▄▄▄▄▄  ▄▄   ▄   ▄▄   ▄     
# █  █  █   ██   █   ▀█ █   ▀█          █    █      █   ▀█ ██  ██   █    █▀▄  █   ██   █     
# ▀ █▀█ █  █  █  █▄▄▄▄▀ █▄▄▄█▀          █    █▄▄▄▄▄ █▄▄▄▄▀ █ ██ █   █    █ █▄ █  █  █  █     
#  ██ ██▀  █▄▄█  █   ▀▄ █       ▀▀▀     █    █      █   ▀▄ █ ▀▀ █   █    █  █ █  █▄▄█  █     
#  █   █  █    █ █    ▀ █               █    █▄▄▄▄▄ █    ▀ █    █ ▄▄█▄▄  █   ██ █    █ █▄▄▄▄▄

OS="$(uname -s)" && echo "Detected OS: $OS" && WARP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal" && echo "Using Warp data dir: $WARP_DIR" && mkdir -p "$WARP_DIR" && cd "$WARP_DIR" && if [ -d themes ]; then echo "Directory $WARP_DIR/themes already exists; skipping clone."; else echo "Trying SSH clone into $WARP_DIR/themes..." && if git clone git@github.com:warpdotdev/themes.git themes; then echo "Cloned via SSH."; else echo "SSH clone failed, trying HTTPS..." && if git clone https://github.com/warpdotdev/themes.git themes; then echo "Cloned via HTTPS."; else if command -v gh >/dev/null 2>&1; then echo "SSH & HTTPS failed; trying GitHub CLI..." && gh repo clone warpdotdev/themes themes; else echo "SSH & HTTPS failed and gh CLI not installed or not in PATH." && exit 1; fi; fi; fi; fi

# https://github.com/ChristianLempa/dotfiles/tree/main/.warp/themes
cp -f /home/$USER/scripts/Necessary/warp/* ~/.local/share/warp-terminal/themes/standard/