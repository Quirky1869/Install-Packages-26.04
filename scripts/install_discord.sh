#!/bin/bash

# ▄▄▄▄   ▄▄▄▄▄   ▄▄▄▄    ▄▄▄   ▄▄▄▄  ▄▄▄▄▄  ▄▄▄▄  
# █   ▀▄   █    █▀   ▀ ▄▀   ▀ ▄▀  ▀▄ █   ▀█ █   ▀▄
# █    █   █    ▀█▄▄▄  █      █    █ █▄▄▄▄▀ █    █
# █    █   █        ▀█ █      █    █ █   ▀▄ █    █
# █▄▄▄▀  ▄▄█▄▄  ▀▄▄▄█▀  ▀▄▄▄▀  █▄▄█  █    ▀ █▄▄▄▀ 

# Pour information : https://discord.com/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

wget --content-disposition "https://discord.com/api/download?platform=linux&format=deb" -O ~/$varDownload/discord.deb
# echo Installation de Discord :
sudo dpkg -i ~/$varDownload/discord.deb
sudo rm ~/$varDownload/discord.deb