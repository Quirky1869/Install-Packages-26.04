#!/bin/bash

# ▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄▄▄
# █   ▀█ █        █   
# █▄▄▄█▀ █▄▄▄▄▄   █   
# █      █        █   
# █      █▄▄▄▄▄   █  

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

wget https://github.com/knqyf263/pet/releases/download/v1.0.1/pet_1.0.1_linux_amd64.deb -o ~/$varDownload/pet.deb
sudo dpkg -i ~/$varDownload/pet.deb
sudo apt update -y && sudo apt install fzf -y
export EDITOR=micro
sleep 2
pet configure
sleep 1
rm -f ~/.config/pet/snippet.toml
cp -f ~/scripts/Necessary/Pet/snippet.toml ~/.config/pet/
# pet new
# pet list
# pet edit
# pet search
# pet exec
rm ~/$varDownload/pet.deb