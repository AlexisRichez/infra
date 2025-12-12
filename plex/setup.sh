# 1. Update your system
sudo apt update && sudo apt upgrade -y

# 2. Install necessary packages
sudo apt install apt-transport-https curl gpg -y

# 3. Import Plex GPG key
curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex-archive-keyring.gpg >/dev/null

# 4. Add the Plex repository
echo deb [signed-by=/usr/share/keyrings/plex-archive-keyring.gpg] https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# 5. Update package list again
sudo apt update

# 6. Install Plex Media Server
sudo apt install plexmediaserver -y

# 7. Reboot for good measure
sudo reboot
