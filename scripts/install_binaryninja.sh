#!/bin/bash

# ▄▄   ▄ ▄▄▄▄▄  ▄▄   ▄   ▄▄▄    ▄▄          ▄▄▄▄▄  ▄▄▄▄▄  ▄▄   ▄   ▄▄   ▄▄▄▄▄ ▄     ▄
# █▀▄  █   █    █▀▄  █     █    ██          █    █   █    █▀▄  █   ██   █   ▀█ ▀▄ ▄▀ 
# █ █▄ █   █    █ █▄ █     █   █  █         █▄▄▄▄▀   █    █ █▄ █  █  █  █▄▄▄▄▀  ▀█▀  
# █  █ █   █    █  █ █     █   █▄▄█         █    █   █    █  █ █  █▄▄█  █   ▀▄   █   
# █   ██ ▄▄█▄▄  █   ██ ▀▄▄▄▀  █    █        █▄▄▄▄▀ ▄▄█▄▄  █   ██ █    █ █    ▀   █   

# Pour information : https://binary.ninja/

# Déclaration des variables
if [[ "$LANG" == fr_* ]]; then
    varDownload="Téléchargements"
else
    varDownload="Downloads"
fi

curl -L "https://release-assets.githubusercontent.com/github-production-release-asset/45279022/dda90508-e156-4760-a33a-b9f70ef24eac?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-11-03T15%3A59%3A40Z&rscd=attachment%3B+filename%3Dbinaryninja_free_linux.zip&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2025-11-03T14%3A59%3A35Z&ske=2025-11-03T15%3A59%3A40Z&sks=b&skv=2018-11-09&sig=0o7sWMhM%2BDEtjouIvqegIVuk4BPuwzKZv4PxlWdEViI%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc2MjE4NjM2NywibmJmIjoxNzYyMTgyNzY3LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.BxuWeSeIcHPXVqU9Ry_JPSJ9W9BMFUH3nsQwY0dE6sU&response-content-disposition=attachment%3B%20filename%3Dbinaryninja_free_linux.zip&response-content-type=application%2Foctet-stream" -o ~/$varDownload/binaryninja.zip
unzip ~/$varDownload/binaryninja.zip

sudo mv -Rf ~/$varDownload/binaryninja /opt/binaryninja

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

sudo ln -s /opt/binaryninja/binaryninja /usr/local/bin/binaryninja

sudo rm ~/$varDownload/binaryninja.zip


