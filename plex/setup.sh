#!/bin/bash

# Script robuste pour installer la dernière version de Plex Media Server sur Raspberry Pi 5 (64-bit)
set -e

echo "Mise à jour du système..."
sudo apt update
sudo apt upgrade -y

echo "Installation des dépendances nécessaires..."
sudo apt install -y curl jq apt-transport-https

# Détection de l'architecture
ARCH=$(dpkg --print-architecture)
if [[ "$ARCH" != "arm64" ]]; then
    echo "Erreur : ce script est conçu pour Raspberry Pi 5 64-bit (arm64)."
    exit 1
fi

# Récupération automatique du dernier lien de téléchargement Plex pour ARM64
echo "Récupération de la dernière version de Plex..."
PLEX_URL=$(curl -s https://plex.tv/api/downloads/5.json | \
    jq -r '.computer.Linux.arm64.downloadUrl')

if [[ -z "$PLEX_URL" ]]; then
    echo "Erreur : impossible de récupérer le lien de téléchargement de Plex."
    exit 1
fi

echo "Téléchargement de Plex depuis : $PLEX_URL"
curl -L "$PLEX_URL" -o plexmediaserver.deb

echo "Installation du paquet Plex..."
sudo dpkg -i plexmediaserver.deb || sudo apt -f install -y

# Nettoyage
rm plexmediaserver.deb

echo "Activation et démarrage du service Plex..."
sudo systemctl enable plexmediaserver
sudo systemctl start plexmediaserver

echo "Installation terminée !"
echo "Tu peux accéder à Plex sur : http://$(hostname -I | awk '{print $1}'):32400/web"
