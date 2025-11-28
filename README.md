# Install Packages 26.04

![](./_images/go.png)  

[![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04-E95420?style=plastic&logo=ubuntu)](https://www.ubuntu-fr.org/download/)
![Static Badge](https://img.shields.io/badge/Install-Packages_26.04-cyan?style=plastic)
![Static Badge](https://img.shields.io/badge/License-MIT-8A2BE2?style=plastic)
[![Go](https://img.shields.io/badge/Go-1.25+-00ADD8?style=plastic&logo=go)](https://golang.org/)
[![Bash](https://img.shields.io/badge/GNU-Bash-4EAA25?style=plastic&logo=gnubash)](https://www.gnu.org/software/bash/)

## Résumé

Install-Packages 26.04 est un outil simple et interactif pour installer rapidement tes paquets préférés sur Ubuntu 26.04.  
Grâce à une interface TUI en Go, tu peux choisir les logiciels à installer, suivre la progression en temps réel et automatiser toute la configuration sans te prendre la tête.  
Aucun besoin de Go ou de scripts compliqués — tout se lance depuis le terminal en une commande.  

## Fonctionnalités

- ✅ Interface TUI (Terminal User Interface) interactive avec [Bubble Tea](https://github.com/charmbracelet/bubbletea)
- ✅ Sélection multiple des paquets à installer
- ✅ Barre de progression dynamique pendant l’installation
- ✅ Adaptation automatique (2 ou 50 scripts — la barre s’ajuste)
- ✅ Aucun besoin de Go pour exécuter le programme final (via le binaire)

## Structure du projet
```
.  
├── cmd/  
│ └── app/  
│ └── main.go # Point d'entrée du programme  
├── ui/  
│ ├── model.go # Définition du modèle Bubble Tea  
│ ├── update.go # Logique d’interaction et installation  
│ ├── view.go # Rendu visuel (interface utilisateur)  
│ └── styles.go # Styles et couleurs (Lipgloss)  
├── scripts/ # Scripts d’installation Bash  
│ ├── install_vscode.sh  
│ ├── install_chrome.sh  
│ ├── install_burpsuite.sh  
│ └── ***
├── run.sh # Script de lancement automatique  
└── README.md  
```

## Installation

Après avoir fait un :
```bash
git clone https://github.com/Quirky1869/Install-Packages-26.04.git  
```

Il faut lancer les commandes suivantes:

```bash
cd Install-Packages-26.04  
cp -rf scripts/ bin/install /home/$USER  
cd /home/$USER  
chmod u+x scripts/* install  
./install  
```

![](./_images/gif/install-packages-26.04-Sakura.gif)  

>[!TIP]  
> Vous pouvez aussi exécuter le script `run.sh` à la place de taper toutes les commandes ci-dessus 

## Ajout de scripts

Vous pouvez si vous le souhaitez rajouter vos scripts :
- Construisez votre `install_script.sh` puis copier le dans le dossier `scripts`  
- Donner lui les droits d'exécution nécessaire
- Dans `ui/model.go` ajouter votre nom et l'emplacement de votre script (ex : "Google Chrome":      "scripts/install_chrome.sh")
- Dans `cmd/app/main.go` ajouté votre nom d'application dans le slice `items`
- Relancer le `./build.sh` pour recompiler le binaire `bin/install`
- Puis suivre la procédure [d'installation](#installation)

> [!CAUTION]  
> Pour pouvoir lancer <code>./build.sh</code> il vous faut avoir <a href="https://go.dev/doc/install" target="_blank"> installé golang </a> sur votre pc   

<details>  
<summary style="font-weight: bold; color: #a000fd;">Procédure (Cliquer pour déplier)</summary>  

```bash
# Supprimer une éventuelle ancienne version de Go
sudo rm -rf /usr/local/go  

# Dézipper le fichier téléchargé dans /usr/local
# (Adaptez le chemin et le nom du fichier si nécessaire)
sudo tar -C /usr/local -xzf ~/Téléchargements/go1.25.3.linux-amd64.tar.gz  

# Ajouter Go au PATH et définir GOPATH
# Ouvrir votre fichier ~/.bashrc ou ~/.zshrc
micro ~/.zshrc  

# Ajouter à la fin du fichier
export PATH=$PATH:/usr/local/go/bin  
export GOPATH=$HOME/go  
export PATH=$PATH:$GOPATH/bin  

# Recharger la configuration du shell
source ~/.zshrc  

# Vérifier la bonne installation
go version  
```

</details>  


## Astuces
> [!TIP]
> - Appuyez sur Espace pour sélectionner/désélectionner un paquet.  
> - Appuyez sur Entrée pour lancer les installations.  
> - Appuyez sur q pour quitter à tout moment.  

## Technologies utilisées  

| Librairie                                                    | Utilisation                          |
| ------------------------------------------------------------ | ------------------------------------ |
| [Bubble Tea](https://github.com/charmbracelet/bubbletea)     | Gestion de l’interface TUI           |
| [Lipgloss](https://github.com/charmbracelet/lipgloss)        | Stylisation du texte et des bordures |
| [Bubbles/Progress](https://github.com/charmbracelet/bubbles) | Barre de progression fluide          |
| [Bash](https://www.gnu.org/software/bash/manual/bash.html)                                                       | Scripts d’installation des paquets   |

## Auteur
Projet développé par Quirky  
<a href="https://github.com/Quirky1869" target="_blank">  
  <img src="./_images/white-github.png" alt="GitHub" width="30" height="30" style="vertical-align:middle;"> GitHub  
</a>  

## Licence
Ce projet est distribué sous licence MIT  
