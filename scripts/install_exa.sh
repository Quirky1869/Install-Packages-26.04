#!/bin/bash

# ▄▄▄▄▄▄ ▄    ▄   ▄▄  
# █       █  █    ██  
# █▄▄▄▄▄   ██    █  █ 
# █       ▄▀▀▄   █▄▄█ 
# █▄▄▄▄▄ ▄▀  ▀▄ █    █

# Pour information : https://github.com/ogham/exa

sudo apt install exa -y

ALIAS="alias e='exa -alFhg'"

for FILE in "$HOME/.zshrc" "$HOME/.bashrc"; do
    [ -f "$FILE" ] || touch "$FILE"

    if ! grep -Fxq "$ALIAS" "$FILE"; then
        echo "$ALIAS" >> "$FILE"
        # echo "Ajout de l'alias dans $FILE"
    else
        echo "L'alias existe déjà dans $FILE"
    fi
done
