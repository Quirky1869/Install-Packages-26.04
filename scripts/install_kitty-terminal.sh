#!/bin/bash

# ▄    ▄ ▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄     ▄       ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄  ▄    ▄ ▄▄▄▄▄  ▄▄   ▄   ▄▄   ▄     
# █  ▄▀    █      █      █    ▀▄ ▄▀           █    █      █   ▀█ ██  ██   █    █▀▄  █   ██   █     
# █▄█      █      █      █     ▀█▀            █    █▄▄▄▄▄ █▄▄▄▄▀ █ ██ █   █    █ █▄ █  █  █  █     
# █  █▄    █      █      █      █             █    █      █   ▀▄ █ ▀▀ █   █    █  █ █  █▄▄█  █     
# █   ▀▄ ▄▄█▄▄    █      █      █             █    █▄▄▄▄▄ █    ▀ █    █ ▄▄█▄▄  █   ██ █    █ █▄▄▄▄▄

# Pour information : https://sw.kovidgoyal.net/kitty/
# Lien : https://sw.kovidgoyal.net/kitty/overview/#other-keyboard-shortcuts

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/local/bin

cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop

sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

echo 'kitty.desktop' > ~/.config/xdg-terminals.list

touch ~/.config/kitty/kitty.conf

cat <<EOF >> ~/.config/kitty/kitty.conf
#### Permet de lancer une application (ici lazydocker) dans un nouvel onglet (tab) ou fenetre (window) ####
map alt+l launch --type=tab lazydocker
#map alt+l launch --type=window lazydocker

#### Permet de gerer l'opacité de la fenetre kitty (ctrl + shift + a puis l ou m) ####
dynamic_background_opacity yes

### Baisse l'opacité du terminal de manière définitive ####
background_opacity 0.95

#### Permet de régler la couleur du background et foreground du terminal ####
# foreground #dddddd
# background #000000

#### Permet de rendre le background flouté ####
# background_blur 0

#### Permet de mettre une image en fond d'écran (PNG/JPEG/WEBP/TIFF/GIF/BMP) ####
# background_image none
# background_image ~/Images/wallpaper.jpg

#### Permet de récupérer les couleurs de .bashrc ou .zshrc (Inutile si un thème est installé) #### 
allow_remote_control yes
term xterm-256color

#### Permet de changer la couleur du texte sélectionné ####
# selection_foreground #000000
# selection_background #fffacd

#### Laisse passer le raccourci ctrl + shift + left ou right ####
map ctrl+shift+left send_text all \x1b[1;6D
map ctrl+shift+right send_text all \x1b[1;6C

#### Permet avec un clic droit de coller ####
mouse_map right press ungrabbed paste_from_clipboard

#### Permet de changer l'emplacement des tab des terminaux (Pour créer :ctrl + shift + t), (Pour fermer ctrl + shift + w) (Valeur possible : top ) ####
#tab_bar_edge top

#### Permet d'afficher le numéro et le titre sur les tab ####
tab_title_template {index}: {title}
#tab_title_template "Onglet {index}"

#### Permet de changer le style de la police dans les tab des terminaux ####
#inactive_tab_font_style normal
#active_tab_font_style   italic

#### Permet de naviguer entre les fenêtres splitter (créer split ctrl + shift + entrée)(Fermer un split ctrl + shift + w) ####
#map shift+alt+Down     next_window
#map shift+alt+Up       previous_window
map ctrl+Down     next_window
map ctrl+Up       previous_window

#### Permet de régler la couleur du curseur ####
# cursor red
# cursor #2a7aef

#### Permet de régler la taille du terminal par défaut ####
remember_window_size  yes
# initial_window_width  640
# initial_window_height 400

#### Permettre l'affichage de 10 000 lignes dans le terminal ####
scrollback_lines 10000
EOF

#=============== Mettre kitty en terminal par defaut ==================
# sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/kitty.app/bin/kitty 50
# sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50
# sudo update-alternatives --config x-terminal-emulator
# Puis selectionner le terminal kitty
# gsettings set org.gnome.desktop.default-applications.terminal exec kitty
# gsettings set org.gnome.desktop.default-applications.terminal exec /home/$USER/.local/kitty.app/bin/kitty

cd ~/.config/kitty
git clone https://github.com/kovidgoyal/kitty-themes.git
# Commande pour changer de theme -> kitty +kitten themes

# notify-send -i face-wink "Kitty themes" "Commande pour changer de thème : kitty +kitten themes" -t 3000

# Juste pour info : un theme dracula est disponible
# https://github.com/dracula/kitty

# Actions for Nautilus :
# https://github.com/bassmanitram/actions-for-nautilus

sudo apt install -y make

if ! find /opt -maxdepth 0 -user "$USER" -group "$USER" &>/dev/null || \
   find /opt -not -user "$USER" -o -not -group "$USER" | grep -q .; then
    sudo chown -R "$USER:$USER" /opt
fi

cd /opt
sudo apt install -y python3-nautilus python3-gi procps libjs-jquery
git clone https://github.com/bassmanitram/actions-for-nautilus.git
cd actions-for-nautilus
make install
cd ..
rm -rf actions-for-nautilus
# notify-send -i face-wink "Nouvelle application" "Application installée : actions for nautilus" -t 3000