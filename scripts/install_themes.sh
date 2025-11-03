#!/bin/bash

#▄▄▄▄▄▄▄ ▄    ▄ ▄▄▄▄▄▄ ▄    ▄ ▄▄▄▄▄▄  ▄▄▄▄ 
#   █    █    █ █      ██  ██ █      █▀   ▀
#   █    █▄▄▄▄█ █▄▄▄▄▄ █ ██ █ █▄▄▄▄▄ ▀█▄▄▄ 
#   █    █    █ █      █ ▀▀ █ █          ▀█
#   █    █    █ █▄▄▄▄▄ █    █ █▄▄▄▄▄ ▀▄▄▄█▀

# Import Theme Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < ./scripts/Necessary/terminal-profiles/gnome-terminal-profiles.dconf
# Export
# dconf dump /org/gnome/terminal/legacy/profiles:/ > ./gnome-terminal-profiles.dconf

# Import Modeles
cp -r ./scripts/Necessary/Nouveaux-documents/* /home/$USER/Modèles 

# Import Themes
mkdir /home/$USER/.themes/ 
cp -r ./scripts/Necessary/Themes/* /home/$USER/.themes/ 

# Import Share Icons
mkdir /home/$USER/.local/share/icons/ 
cp -r ./scripts/Necessary/Share-Icons/* /home/$USER/.local/share/icons/ 

# Import Icons / Cursors
mkdir /home/$USER/.icons/ 
cp -r ./scripts/Necessary/Icons/* /home/$USER/.icons/ 