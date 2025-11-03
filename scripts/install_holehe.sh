#!/bin/bash

# ▄    ▄  ▄▄▄▄  ▄      ▄▄▄▄▄▄ ▄    ▄ ▄▄▄▄▄▄
# █    █ ▄▀  ▀▄ █      █      █    █ █     
# █▄▄▄▄█ █    █ █      █▄▄▄▄▄ █▄▄▄▄█ █▄▄▄▄▄
# █    █ █    █ █      █      █    █ █     
# █    █  █▄▄█  █▄▄▄▄▄ █▄▄▄▄▄ █    █ █▄▄▄▄▄

# Pour information : https://github.com/megadose/holehe

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
sudo git clone https://github.com/megadose/holehe.git
sudo chown $USER:$USER -R holehe
cd holehe/
sudo python3 setup.py install