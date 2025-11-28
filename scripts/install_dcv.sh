#!/bin/bash

# ▄▄▄▄     ▄▄▄  ▄    ▄
# █   ▀▄ ▄▀   ▀ ▀▄  ▄▀
# █    █ █       █  █ 
# █    █ █       ▀▄▄▀ 
# █▄▄▄▀   ▀▄▄▄▀   ██  

# Pour information : https://github.com/tokuhirom/dcv

#sudo mkdir /opt/dcv

#if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
#   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
#    sudo chown -R "$USER:$USER" /opt
#fi

#cp -rf ~/scripts/Necessary/dcv/dcv /opt/dcv/dcv
#sudo ln -s /opt/dcv/dcv /usr/local/bin/dcv

cp -rf ~/scripts/Necessary/dcv/dcv /usr/local/bin
