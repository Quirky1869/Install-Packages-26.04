#!/bin/bash

#   ▄▄     ▄▄▄    ▄▄▄ 
#   ██   ▄▀   ▀ ▄▀   ▀
#  █  █  █   ▄▄ █   ▄▄
#  █▄▄█  █    █ █    █
# █    █  ▀▄▄▄▀  ▀▄▄▄▀

# Pour information : https://github.com/asciinema/agg

mkdir /opt/agg

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
cp -rf ~/scripts/Necessary/agg/agg /opt/agg/agg
sudo ln -s /opt/agg/agg /usr/local/bin/agg
