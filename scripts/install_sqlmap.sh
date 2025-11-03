#!/bin/bash

#  ▄▄▄▄   ▄▄▄▄  ▄      ▄    ▄   ▄▄   ▄▄▄▄▄ 
# █▀   ▀ ▄▀  ▀▄ █      ██  ██   ██   █   ▀█
# ▀█▄▄▄  █    █ █      █ ██ █  █  █  █▄▄▄█▀
#     ▀█ █    █ █      █ ▀▀ █  █▄▄█  █     
# ▀▄▄▄█▀  █▄▄█▀ █▄▄▄▄▄ █    █ █    █ █     
#            █                             

# Pour information : https://sqlmap.org/
# Lien : https://github.com/sqlmapproject/sqlmap

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
sudo chown $USER:$USER -R sqlmap-dev
sed -i 's|#!/usr/bin/env python|#!/usr/bin/env python3|' /opt/sqlmap-dev/sqlmap.py