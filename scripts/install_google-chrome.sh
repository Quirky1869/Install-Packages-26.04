#!/bin/bash

#   ▄▄▄   ▄▄▄▄   ▄▄▄▄    ▄▄▄  ▄      ▄▄▄▄▄▄          ▄▄▄  ▄    ▄ ▄▄▄▄▄   ▄▄▄▄  ▄    ▄ ▄▄▄▄▄▄
# ▄▀   ▀ ▄▀  ▀▄ ▄▀  ▀▄ ▄▀   ▀ █      █             ▄▀   ▀ █    █ █   ▀█ ▄▀  ▀▄ ██  ██ █     
# █   ▄▄ █    █ █    █ █   ▄▄ █      █▄▄▄▄▄        █      █▄▄▄▄█ █▄▄▄▄▀ █    █ █ ██ █ █▄▄▄▄▄
# █    █ █    █ █    █ █    █ █      █             █      █    █ █   ▀▄ █    █ █ ▀▀ █ █     
#  ▀▄▄▄▀  █▄▄█   █▄▄█   ▀▄▄▄▀ █▄▄▄▄▄ █▄▄▄▄▄         ▀▄▄▄▀ █    █ █    ▀  █▄▄█  █    █ █▄▄▄▄▄

# Pour information : https://www.google.com/intl/fr_fr/chrome/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

# cd ~/$varDownload
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o ~/$varDownload/chrome.deb
# echo Installation de Google Chrome :
sudo dpkg -i ~/$varDownload/chrome.deb
sudo rm ~/$varDownload/chrome.deb