#!/usr/bin/env bash
set -euo pipefail

names=(
  vscode
  sshm
  packets
  pip
  snap
  git
  doc-scripts
  themes
  chrome
  brave
  discord
  apache2
  mariadb
  docker
  github-desktop
  burpsuite
  vagrant
  ansible
  metasploit
  the-harvester
  sherlock
  holehe
  sqlmap
  aperisolve
  kitty-terminal
  zsh-ohmyzsh
  exa
  agg
  lazy-docker
  dcv
  pet
  arsenal
  bashrc
  tgpt
  ninja-binary
  sshlist
  raccourcis-clavier
  logoff
)

# Option : écraser les fichiers existants si $1 == --force
force=false
if [[ "${1:-}" == "--force" ]]; then
  force=true
fi

for name in "${names[@]}"; do
  filename="install_${name}.sh"

  if [[ -e "$filename" && "$force" != "true" ]]; then
    echo "Ignoré : $filename existe déjà (utilise --force pour écraser)."
    continue
  fi

  cat > "$filename" <<EOF
#!/usr/bin/env bash
set -euo pipefail

# Script d'installation pour : ${name}
# Remplis ce fichier avec les commandes d'installation pour "${name}"

# Exemple :
# echo "Installation de ${name}..."
# sudo apt update
# sudo apt install -y <paquet-ici>

EOF

  chmod +x "$filename"
  echo "Créé : $filename"
done

echo "Terminé."
