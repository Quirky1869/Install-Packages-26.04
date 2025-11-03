#!/bin/bash

#   ▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄    ▄ ▄    ▄ ▄▄▄▄▄         ▄▄▄▄   ▄▄▄▄▄▄  ▄▄▄▄  ▄    ▄▄▄▄▄▄▄▄  ▄▄▄▄  ▄▄▄▄▄ 
# ▄▀   ▀   █      █    █    █ █    █ █    █        █   ▀▄ █      █▀   ▀ █  ▄▀    █    ▄▀  ▀▄ █   ▀█
# █   ▄▄   █      █    █▄▄▄▄█ █    █ █▄▄▄▄▀        █    █ █▄▄▄▄▄ ▀█▄▄▄  █▄█      █    █    █ █▄▄▄█▀
# █    █   █      █    █    █ █    █ █    █        █    █ █          ▀█ █  █▄    █    █    █ █     
#  ▀▄▄▄▀ ▄▄█▄▄    █    █    █ ▀▄▄▄▄▀ █▄▄▄▄▀        █▄▄▄▀  █▄▄▄▄▄ ▀▄▄▄█▀ █   ▀▄   █     █▄▄█  █     

# Pour information : https://desktop.github.com/download/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

sudo apt install -y apt-transport-https gnupg2 software-properties-common
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.7-linux1/GitHubDesktop-linux-3.1.7-linux1.deb -O ~/$varDownload/github-desktop.deb
sudo apt install -f ~/$varDownload/github-desktop.deb
rm ~/$varDownload/github-desktop.deb