#!/bin/bash

#▄▄▄▄▄▄▄ ▄    ▄ ▄▄▄▄▄▄        ▄    ▄   ▄▄   ▄▄▄▄▄  ▄    ▄ ▄▄▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄ 
#   █    █    █ █             █    █   ██   █   ▀█ ▀▄  ▄▀ █      █▀   ▀   █    █      █   ▀█
#   █    █▄▄▄▄█ █▄▄▄▄▄        █▄▄▄▄█  █  █  █▄▄▄▄▀  █  █  █▄▄▄▄▄ ▀█▄▄▄    █    █▄▄▄▄▄ █▄▄▄▄▀
#   █    █    █ █             █    █  █▄▄█  █   ▀▄  ▀▄▄▀  █          ▀█   █    █      █   ▀▄
#   █    █    █ █▄▄▄▄▄        █    █ █    █ █    ▀   ██   █▄▄▄▄▄ ▀▄▄▄█▀   █    █▄▄▄▄▄ █    █

# Pour information : https://github.com/laramies/theHarvester
# Lien : https://julien.io/retrouver-les-adresses-emails-avec-theharvester/

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
sudo git clone https://github.com/laramies/theHarvester.git
sudo chown $USER:$USER -R theHarvester # Changement du owner ; si l'option -f est entrée des problèmes ont lieu lors de la génération des fichiers si le owner est root
cd theHarvester
python3 -m pip install -r requirements/base.txt