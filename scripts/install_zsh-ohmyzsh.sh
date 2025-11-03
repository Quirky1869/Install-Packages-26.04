#!/bin/bash

# ▄▄▄▄▄▄  ▄▄▄▄  ▄    ▄          ▄▄▄          ▄▄▄▄  ▄    ▄ ▄    ▄▄     ▄ ▄▄▄▄▄▄  ▄▄▄▄  ▄    ▄
#     █▀ █▀   ▀ █    █         █            ▄▀  ▀▄ █    █ ██  ██ ▀▄ ▄▀      █▀ █▀   ▀ █    █
#   ▄█   ▀█▄▄▄  █▄▄▄▄█         ██           █    █ █▄▄▄▄█ █ ██ █  ▀█▀     ▄█   ▀█▄▄▄  █▄▄▄▄█
#  ▄▀        ▀█ █    █        █  █▄█        █    █ █    █ █ ▀▀ █   █     ▄▀        ▀█ █    █
# ██▄▄▄▄ ▀▄▄▄█▀ █    █        ▀█▄▄█▄         █▄▄█  █    █ █    █   █    ██▄▄▄▄ ▀▄▄▄█▀ █    █

# Pour information : https://github.com/ohmyzsh/ohmyzsh

sudo apt install -y zsh git curl
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp -f ~/.zshrc  ~/.zshrc.ori
cp -f ~/scripts/Necessary/zsh/.zshrc_perso  ~/.zshrc
source ~/.zschrc
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
source ~/.zshrc
# notify-send "Zsh et ohmyzsh ont été installé" -t 2000
# notify-send "une fermeture de session sera nécessaire" -t 2000