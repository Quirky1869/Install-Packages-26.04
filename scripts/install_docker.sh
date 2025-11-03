#!/bin/bash

# ▄▄▄▄    ▄▄▄▄    ▄▄▄  ▄    ▄ ▄▄▄▄▄▄ ▄▄▄▄▄ 
# █   ▀▄ ▄▀  ▀▄ ▄▀   ▀ █  ▄▀  █      █   ▀█
# █    █ █    █ █      █▄█    █▄▄▄▄▄ █▄▄▄▄▀
# █    █ █    █ █      █  █▄  █      █   ▀▄
# █▄▄▄▀   █▄▄█   ▀▄▄▄▀ █   ▀▄ █▄▄▄▄▄ █    ▀▄

# Pour information : https://www.docker.com/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

sudo apt install apt-transport-https ca-certificates curl gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce 
sudo apt install -y docker-ce-cli
sudo apt install -y containerd.io
sudo apt install -y docker-buildx-plugin
sudo apt install -y docker-compose-plugin
# echo "Etat actuel de Docker"
sudo systemctl is-active docker
sleep 2
#wget https://desktop.docker.com/linux/main/amd64/137060/docker-desktop-4.27.2-amd64.deb
curl 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64' -o ~/$varDownload/docker-desktop.deb
sudo apt install -y ~/$varDownload/docker-desktop.deb
sudo rm ~/$varDownload/docker-desktop.deb