#!/bin/bash

# ▄▄▄▄▄    ▄▄    ▄▄▄▄  ▄    ▄        ▄▄▄▄▄    ▄▄▄ 
# █    █   ██   █▀   ▀ █    █        █   ▀█ ▄▀   ▀
# █▄▄▄▄▀  █  █  ▀█▄▄▄  █▄▄▄▄█        █▄▄▄▄▀ █     
# █    █  █▄▄█      ▀█ █    █        █   ▀▄ █     
# █▄▄▄▄▀ █    █ ▀▄▄▄█▀ █    █        █    ▀  ▀▄▄▄▀

cp -f ~/.bashrc ~/.bashrc.ori
        sed -i "s|^\s*alias ll='ls -al'|alias ll='ls -alhF'|" ~/.bashrc
cat << 'EOF' >> ~/.bashrc

### PATH ###
export PATH="/home/$USER/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin"
export PATH="/opt/theHarvester:$PATH"
#export PATH="/opt/sherlock/sherlock:$PATH"   #OLD SHERLOCK
export PATH="/home/$USER/.local/bin:$PATH"    #SHERLOCK
export PATH="/opt/sqlmap-dev:$PATH"

### Encore et encore des alias ###
alias dns="nmcli device show | grep IP4.DNS" # S'appui sur network-manager
alias ipls="netplan status" # S'appui sur iproute2
alias metasploit="msfconsole" # S'appui sur metasploit-framework

alias bat="batcat" # S'appui sur bat
alias logoff="skill -KILL -u $USER" # S'appui sur procps
alias getuser="cut -d: -f1 /etc/passwd" # s'appui sur cut

#alias sherlock="sherlock.py" # S'appui sur sherlock        #OLD SHERLOCK
alias harvester="theHarvester.py" # S'appui sur The Harvester
alias sqlmap="sqlmap.py" # S'appui sur SQLmap
alias ninja="/home/$USER/Public/binaryninja/binaryninja" # S'appui sur Binary Ninja

alias service="systemctl list-units --type=service" # S'appui sur systemctl
alias allservice="systemctl list-units --type=service --all" # S'appui sur systemctl
alias servicesystemd="systemctl list-unit-files" # S'appui sur systemd

alias whatfilemanager="xdg-mime query default inode/directory"
alias whatenvironment="echo $XDG_CURRENT_DESKTOP"
alias pythonserver="sudo python3 -m http.server"

alias lazydocker="/home/$USER/.local/bin/lazydocker" # S'appui sur LazyDocker
alias docker="sudo docker" # S'appui sur docker
alias docksh="docker exec -it" # S'appui sur docker

#alias sshlist="~/Public/ssh-list" # S'appui sur ssh-list (https://github.com/akinoiro/ssh-list)
EOF

cp -f ~/scripts/Necessary/bashrc/.bashrc* /home/$USER/
# notify-send -i face-smile "BashRc" "Les fichiers .bashrc ont été copiés dans /home/$USER" -t 3000
# echo "Vous pouvez faire un : cp -f <.bashrc_voulu> .bashrc"
source ~/.bashrc
cp -f ~/.bashrc ~/.bashrc.ori.with.alias