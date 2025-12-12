#!/bin/bash
# Script d'installation de Home Assistant Supervised sur Raspberry Pi (corrigé)

set -e

echo "=== Mise à jour du système ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Installation des dépendances nécessaires ==="
sudo apt-get install -y \
    apparmor-utils \
    avahi-daemon \
    dbus \
    jq \
    network-manager \
    curl \
    lsb-release \
    gnupg \
    socat

echo "=== Installation de Docker ==="
curl -fsSL https://get.docker.com | sh

echo "=== Activation des services nécessaires ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Vérification de Docker ==="
docker --version

echo "=== Téléchargement de Home Assistant Supervised Installer ==="
curl -Lo installer.deb https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb

echo "=== Installation de Home Assistant Supervised ==="
sudo dpkg -i installer.deb || sudo apt-get install -f -y

echo "=== Activation du service Home Assistant ==="
sudo systemctl enable home-assistant.service
sudo systemctl start home-assistant.service

echo "=== Installation terminée ==="
echo "Accédez à Home Assistant via http://<IP_DE_VOTRE_PI>:8123 pour finaliser la configuration."
