#!/bin/bash

# ▄    ▄   ▄▄   ▄▄▄▄▄  ▄▄▄▄▄    ▄▄          ▄▄▄▄   ▄▄▄▄▄ 
# ██  ██   ██   █   ▀█   █      ██          █   ▀▄ █    █
# █ ██ █  █  █  █▄▄▄▄▀   █     █  █         █    █ █▄▄▄▄▀
# █ ▀▀ █  █▄▄█  █   ▀▄   █     █▄▄█         █    █ █    █
# █    █ █    █ █    ▀ ▄▄█▄▄  █    █        █▄▄▄▀  █▄▄▄▄▀

# Pour information : https://mariadb.org/

sudo apt install -y mariadb-server
#       sudo systemctl status mariadb
##      sudo mysql_secure_installation
## 	    current password for root : enter
## 	    Switch to unix_socket authentication [Y/n] n
## 	    Change the root password? [Y/n] n
## 	    Remove anonymous users? [Y/n] Y
## 	    Disallow root login remotely? [Y/n] Y
## 	    Remove test database and access to it? [Y/n] Y
## 	    Reload privilege tables now? [Y/n] Y
#       sudo mariadb
# 	    USE mysql;
# 	    FLUSH PRIVILEGES;
# 	    ALTER USER 'root'@'localhost' IDENTIFIED BY 'monsupermotdepasse';
# 	    EXIT;
#       sudo systemctl restart mariadb
#       mariadb -u root -p     ou  mysql -u root -p