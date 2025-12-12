#!/bin/bash

set -e

echo "=== Mise à jour du système ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installation de Git ==="
sudo apt install -y git

echo "=== Installation des dépendances Docker ==="
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg

echo "=== Ajout de la clé GPG de Docker ==="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Ajout du dépôt Docker ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Installation de Docker Engine ==="
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Ajout de l'utilisateur $USER au groupe docker ==="
sudo usermod -aG docker $USER

echo "=== Création du répertoire docker_data ==="
mkdir -p ~/docker_data/portainer

echo "=== Installation de Portainer ==="
sudo docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /home/$USER/docker_data/portainer:/data \
  portainer/portainer-ce:latest

echo ""
echo "=== Installation terminée ! ==="
echo "💻 Accès Portainer : https://media.local:9443"
echo "⚠️ Déconnecte-toi / reconnecte-toi pour que le groupe docker soit pris en compte."
