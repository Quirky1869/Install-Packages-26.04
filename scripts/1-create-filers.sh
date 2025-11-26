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

# Install wrap dot themes
# OS="$(uname -s)" && echo "Detected OS: $OS" && WARP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal" && echo "Using Warp data dir: $WARP_DIR" && mkdir -p "$WARP_DIR" && cd "$WARP_DIR" && if [ -d themes ]; then echo "Directory $WARP_DIR/themes already exists; skipping clone."; else echo "Trying SSH clone into $WARP_DIR/themes..." && if git clone git@github.com:warpdotdev/themes.git themes; then echo "Cloned via SSH."; else echo "SSH clone failed, trying HTTPS..." && if git clone https://github.com/warpdotdev/themes.git themes; then echo "Cloned via HTTPS."; else if command -v gh >/dev/null 2>&1; then echo "SSH & HTTPS failed; trying GitHub CLI..." && gh repo clone warpdotdev/themes themes; else echo "SSH & HTTPS failed and gh CLI not installed or not in PATH." && exit 1; fi; fi; fi; fi
# https://github.com/ChristianLempa/dotfiles/tree/main/.warp/themes
