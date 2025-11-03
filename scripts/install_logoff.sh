#!/bin/bash

# ▄       ▄▄▄▄    ▄▄▄   ▄▄▄▄  ▄▄▄▄▄▄ ▄▄▄▄▄▄
# █      ▄▀  ▀▄ ▄▀   ▀ ▄▀  ▀▄ █      █     
# █      █    █ █   ▄▄ █    █ █▄▄▄▄▄ █▄▄▄▄▄
# █      █    █ █    █ █    █ █      █     
# █▄▄▄▄▄  █▄▄█   ▀▄▄▄▀  █▄▄█  █      █     

echo "Vous avez choisi de fermer la session"
sleep 1
echo "La session va se fermer dans 5 secondes"
sleep 1
echo "La session va se fermer dans 4 secondes"
sleep 1
echo "La session va se fermer dans 3 secondes"
sleep 1
echo "La session va se fermer dans 2 secondes"
sleep 1
echo "La session va se fermer dans 1 seconde"
sleep 1
skill -KILL -u $USER
# pkill -u $USER