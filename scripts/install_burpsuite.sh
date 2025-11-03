#!/bin/bash

# ▄▄▄▄▄  ▄    ▄ ▄▄▄▄▄  ▄▄▄▄▄          ▄▄▄▄  ▄    ▄ ▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄
# █    █ █    █ █   ▀█ █   ▀█        █▀   ▀ █    █   █      █    █     
# █▄▄▄▄▀ █    █ █▄▄▄▄▀ █▄▄▄█▀        ▀█▄▄▄  █    █   █      █    █▄▄▄▄▄
# █    █ █    █ █   ▀▄ █                 ▀█ █    █   █      █    █     
# █▄▄▄▄▀ ▀▄▄▄▄▀ █    ▀ █             ▀▄▄▄█▀ ▀▄▄▄▄▀ ▄▄█▄▄    █    █▄▄▄▄▄

# Pour information : https://portswigger.net/burp

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

curl 'https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.3.1.4&type=Linux' -o ~/$varDownload/burpsuite.sh
chmod +x ~/$varDownload/burpsuite.sh
sudo ~/$varDownload/burpsuite.sh
sudo rm ~/$varDownload/burpsuite.sh