#!/bin/bash

#   ▄▄   ▄▄▄▄▄   ▄▄▄▄  ▄▄▄▄▄▄ ▄▄   ▄   ▄▄   ▄     
#   ██   █   ▀█ █▀   ▀ █      █▀▄  █   ██   █     
#  █  █  █▄▄▄▄▀ ▀█▄▄▄  █▄▄▄▄▄ █ █▄ █  █  █  █     
#  █▄▄█  █   ▀▄     ▀█ █      █  █ █  █▄▄█  █     
# █    █ █    ▀ ▀▄▄▄█▀ █▄▄▄▄▄ █   ██ █    █ █▄▄▄▄▄

# Pour information : https://github.com/Orange-Cyberdefense/arsenal

python3 -m pip install arsenal-cli

echo "alias a='arsenal'" | sudo tee -a ~/.bashrc

if [ -f "$HOME/.zshrc" ]; then
    echo "alias a='arsenal'" | sudo tee -a ~/.zshrc
else
    echo "Le fichier ~/.zshrc n'existe pas."
fi

echo "dev.tty.legacy_tiocsti=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p