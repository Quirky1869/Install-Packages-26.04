#!/bin/bash

#   ▄▄   ▄▄   ▄  ▄▄▄▄  ▄▄▄▄▄  ▄▄▄▄▄  ▄      ▄▄▄▄▄▄
#   ██   █▀▄  █ █▀   ▀   █    █    █ █      █     
#  █  █  █ █▄ █ ▀█▄▄▄    █    █▄▄▄▄▀ █      █▄▄▄▄▄
#  █▄▄█  █  █ █     ▀█   █    █    █ █      █     
# █    █ █   ██ ▀▄▄▄█▀ ▄▄█▄▄  █▄▄▄▄▀ █▄▄▄▄▄ █▄▄▄▄▄

# Pour information : https://docs.ansible.com/

sudo apt update -y
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible --version