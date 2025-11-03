#!/bin/bash

set -e

TARGET_DIR="/home/$USER"
SCRIPTS_SRC="scripts"
INSTALL_SRC="bin/install"
SCRIPTS_DEST="$TARGET_DIR/scripts"
INSTALL_DEST="$TARGET_DIR/install"

if [ ! -d "$SCRIPTS_DEST" ]; then
    echo "Copie du dossier '$SCRIPTS_SRC' vers '$TARGET_DIR'..."
    cp -r "$SCRIPTS_SRC" "$TARGET_DIR" || { echo "Erreur: échec de la copie de $SCRIPTS_SRC"; exit 1; }
else
    echo "Le dossier '$SCRIPTS_DEST' existe déjà, pas de copie."
fi

if [ ! -f "$INSTALL_DEST" ]; then
    echo "Copie du fichier '$INSTALL_SRC' vers '$TARGET_DIR'..."
    cp "$INSTALL_SRC" "$TARGET_DIR" || { echo "Erreur: échec de la copie de $INSTALL_SRC"; exit 1; }
else
    echo "Le fichier '$INSTALL_DEST' existe déjà, pas de copie."
fi

echo "Vérification des droits d'exécution..."

for f in "$SCRIPTS_DEST"/*; do
    if [ -f "$f" ] && [ ! -x "$f" ]; then
        chmod u+x "$f" && echo "Droit d'exécution ajouté: $f"
    fi
done

if [ -f "$INSTALL_DEST" ] && [ ! -x "$INSTALL_DEST" ]; then
    chmod u+x "$INSTALL_DEST" && echo "Droit d'exécution ajouté: $INSTALL_DEST"
fi

cd "$TARGET_DIR" || { echo "Erreur: impossible d'accéder à $TARGET_DIR"; exit 1; }
echo "Lancement de ./install ..."

./install
