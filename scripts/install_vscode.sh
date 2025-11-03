#!/bin/bash

# ▄    ▄  ▄▄▄▄           ▄▄▄   ▄▄▄▄  ▄▄▄▄   ▄▄▄▄▄▄
# ▀▄  ▄▀ █▀   ▀        ▄▀   ▀ ▄▀  ▀▄ █   ▀▄ █     
#  █  █  ▀█▄▄▄         █      █    █ █    █ █▄▄▄▄▄
#  ▀▄▄▀      ▀█        █      █    █ █    █ █     
#   ██   ▀▄▄▄█▀         ▀▄▄▄▀  █▄▄█  █▄▄▄▀  █▄▄▄▄▄

# Pour information : https://code.visualstudio.com/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

# echo Telechargement de Visual Studio Code :
wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868 -O ~/$varDownload/vscode.deb
# echo Installation de Visual Studio Code :
sudo dpkg -i ~/$varDownload/vscode.deb
sudo rm ./vscode.deb
