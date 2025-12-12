#!/bin/bash
# Installation simplifiée de Plex sur Raspberry Pi 5 (ARM64)

set -e

echo "Mise à jour du système..."
sudo apt update
sudo apt upgrade -y

echo "Installation des dépendances nécessaires..."
sudo apt install -y curl apt-transport-https

echo "Téléchargement de Plex Media Server..."
curl -L https://downloads.plex.tv/plex-media-server-new/PlexMediaServer-latest-arm64.deb -o plexmediaserver.deb

echo "Installation du paquet Plex..."
sudo dpkg -i plexmediaserver.deb || sudo apt -f install -y

rm plexmediaserver.deb

echo "Activation et démarrage du service Plex..."
sudo systemctl enable plexmediaserver
sudo systemctl start plexmediaserver

echo "Installation terminée !"
echo "Accès à Plex : http://$(hostname -I | awk '{print $1}'):32400/web"
