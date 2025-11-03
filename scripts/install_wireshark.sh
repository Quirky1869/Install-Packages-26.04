#!/bin/bash

#▄     ▄ ▄▄▄▄▄  ▄▄▄▄▄  ▄▄▄▄▄▄  ▄▄▄▄  ▄    ▄   ▄▄   ▄▄▄▄▄  ▄    ▄
#█  █  █   █    █   ▀█ █      █▀   ▀ █    █   ██   █   ▀█ █  ▄▀ 
#▀ █▀█ █   █    █▄▄▄▄▀ █▄▄▄▄▄ ▀█▄▄▄  █▄▄▄▄█  █  █  █▄▄▄▄▀ █▄█   
# ██ ██▀   █    █   ▀▄ █          ▀█ █    █  █▄▄█  █   ▀▄ █  █▄ 
# █   █  ▄▄█▄▄  █    ▀ █▄▄▄▄▄ ▀▄▄▄█▀ █    █ █    █ █    ▀ █   ▀▄

# Pour information : https://www.wireshark.org/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

sudo apt install -y wireshark
#echo "Ajout de l'utilisateur au groupe "wireshark" :"
sudo adduser $USER wireshark