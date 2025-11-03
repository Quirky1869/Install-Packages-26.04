#!/bin/bash

# ▄    ▄ ▄▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄    ▄   ▄▄   ▄      ▄▄▄▄▄   ▄▄▄▄  ▄    ▄
# ▀▄  ▄▀   █    █   ▀█   █    █    █   ██   █      █    █ ▄▀  ▀▄  █  █ 
#  █  █    █    █▄▄▄▄▀   █    █    █  █  █  █      █▄▄▄▄▀ █    █   ██  
#  ▀▄▄▀    █    █   ▀▄   █    █    █  █▄▄█  █      █    █ █    █  ▄▀▀▄ 
#   ██   ▄▄█▄▄  █    ▀   █    ▀▄▄▄▄▀ █    █ █▄▄▄▄▄ █▄▄▄▄▀  █▄▄█  ▄▀  ▀▄

# Pour information : https://www.virtualbox.org/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

sudo apt install -y virtualbox virtualbox-ext-pack