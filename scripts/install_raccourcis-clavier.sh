#!/bin/bash

# ▄▄▄▄▄    ▄▄     ▄▄▄    ▄▄▄   ▄▄▄▄  ▄    ▄ ▄▄▄▄▄    ▄▄▄  ▄▄▄▄▄   ▄▄▄▄           ▄▄▄  ▄        ▄▄   ▄    ▄ ▄▄▄▄▄  ▄▄▄▄▄▄ ▄▄▄▄▄ 
# █   ▀█   ██   ▄▀   ▀ ▄▀   ▀ ▄▀  ▀▄ █    █ █   ▀█ ▄▀   ▀   █    █▀   ▀        ▄▀   ▀ █        ██   ▀▄  ▄▀   █    █      █   ▀█
# █▄▄▄▄▀  █  █  █      █      █    █ █    █ █▄▄▄▄▀ █        █    ▀█▄▄▄         █      █       █  █   █  █    █    █▄▄▄▄▄ █▄▄▄▄▀
# █   ▀▄  █▄▄█  █      █      █    █ █    █ █   ▀▄ █        █        ▀█        █      █       █▄▄█   ▀▄▄▀    █    █      █   ▀▄
# █    ▀ █    █  ▀▄▄▄▀  ▀▄▄▄▀  █▄▄█  ▀▄▄▄▄▀ █    ▀  ▀▄▄▄▀ ▄▄█▄▄  ▀▄▄▄█▀         ▀▄▄▄▀ █▄▄▄▄▄ █    █   ██   ▄▄█▄▄  █▄▄▄▄▄ █    ▀


gsettings set org.gnome.shell.keybindings toggle-message-tray "[]" # Valeur raccourci "Afficher la liste des notifications" supprimé

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/']" # Création des emplacements personnalisés des raccourcis claviers

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Discord' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'discord' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Alt>d' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Chrome' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'google-chrome' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Alt>c' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Gestionnaire des tâches' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'gnome-system-monitor' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Primary><Shift>Escape' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Paramètres' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'gnome-control-center' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Super>i' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name 'Tweaks' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command 'gnome-tweaks' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding '<Super>t' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ name 'Terminal' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ command 'gnome-terminal' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ binding '<Alt>t' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ name 'Synchro-Obsidian-Google-Drive' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ command 'synchro-obsidian-google-drive.sh' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ binding '<Primary><Alt>o' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ name 'Diodon' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ command '/usr/bin/diodon' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ binding '<Super>v' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ name 'Flameshot' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ command 'flameshot gui' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ binding '<Super><Shift>f' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ name 'Kitty' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ command 'kitty' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ binding '<Alt>t' # Raccourci clavier attribué

# Raccourci claviers non personnalisés
echo "Pensez à configurer les raccourcis clavier non personnalisés"
echo "Capture d'écran -> Effectuer une capture d'écran interactivement -> Maj + Super + S"
echo "Navigation -> Changer de fenêtre directement -> Alt + Tabulation"
echo "Lanceurs -> Dossier Personnel -> Super + E"
echo "Lanceurs -> Lancer un terminal -> Alt + T"