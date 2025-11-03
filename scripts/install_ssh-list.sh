#!/bin/bash

#  ▄▄▄▄   ▄▄▄▄  ▄    ▄        ▄      ▄▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄▄
# █▀   ▀ █▀   ▀ █    █        █        █    █▀   ▀   █   
# ▀█▄▄▄  ▀█▄▄▄  █▄▄▄▄█        █        █    ▀█▄▄▄    █   
#     ▀█     ▀█ █    █        █        █        ▀█   █   
# ▀▄▄▄█▀ ▀▄▄▄█▀ █    █        █▄▄▄▄▄ ▄▄█▄▄  ▀▄▄▄█▀   █ 

# Pour information : https://github.com/akinoiro/ssh-list

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

mkdir /opt/sshlist
sudo chown -R "$USER:$USER" /opt/sshlist

cp -Rf ~/scripts/Necessary/ssh-list/sshlist /opt/sshlist

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi


sudo chmod u+x /opt/sshlist/sshlist
# echo "Création du lien symbolique pour sshlist dans /usr/local/bin"
sudo ln -s /opt/sshlist/sshlist /usr/local/bin/sshlist
# Supprimer le lien : sudo rm /usr/local/bin/sshlist
# Emplacement fichier config : ~/.ssh/ssh-list.json