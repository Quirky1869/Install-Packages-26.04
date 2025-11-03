#!/bin/bash

# ▄    ▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄   ▄▄    ▄▄▄▄  ▄▄▄▄▄  ▄       ▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄▄▄
# ██  ██ █        █      ██   █▀   ▀ █   ▀█ █      ▄▀  ▀▄   █      █   
# █ ██ █ █▄▄▄▄▄   █     █  █  ▀█▄▄▄  █▄▄▄█▀ █      █    █   █      █   
# █ ▀▀ █ █        █     █▄▄█      ▀█ █      █      █    █   █      █   
# █    █ █▄▄▄▄▄   █    █    █ ▀▄▄▄█▀ █      █▄▄▄▄▄  █▄▄█  ▄▄█▄▄    █   

# Pour information : https://www.metasploit.com/

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
sudo apt-get install -y build-essential zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libreadline6-dev libcurl4-openssl-dev git-core autoconf curl postgresql postgresql-contrib libpq-dev libapr1 libaprutil1 libsvn1 libpcap-dev
sudo git clone https://github.com/rapid7/metasploit-framework.git
sudo chown $USER:$USER -R metasploit-framework
cd metasploit-framework
sudo bash -c 'for MSF in $(ls msf*); do ln -s /usr/local/src/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
sudo service postgresql start
sudo snap install metasploit-framework
sudo msfdb init
msfdb init
#msfconsole     # Commande pour lancé metasploit
