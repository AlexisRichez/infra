#!/bin/bash
# Script d'installation de Home Assistant Supervised sur Raspberry Pi

set -e

echo "=== Mise à jour du système ==="
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y software-properties-common apparmor-utils avahi-daemon dbus jq network-manager

echo "=== Installation de Docker ==="
curl -fsSL https://get.docker.com | sh

echo "=== Activation des services nécessaires ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Vérification de Docker ==="
docker --version

echo "=== Téléchargement de Home Assistant Supervised Installer ==="
sudo curl -Lo installer.sh https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb

echo "=== Installation de Home Assistant Supervised ==="
sudo dpkg -i installer.sh || sudo apt-get install -f -y

echo "=== Activation du service Home Assistant ==="
sudo systemctl enable home-assistant.service
sudo systemctl start home-assistant.service

echo "=== Installation terminée ==="
echo "Accédez à Home Assistant via http://<IP_DE_VOTRE_PI>:8123 pour finaliser la configuration et installer tous les add-ons."
