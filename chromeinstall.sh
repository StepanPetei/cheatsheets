#En caso de tener disponible Mozilla es mas facil descargar el paquete .deb e instalarlo mediante Software Installer o gdebi
curl -O https://packages.cloud.google.com/apt/doc/apt-key.gpg && sudo apt-key add apt-key.gpg
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' 

# Install Chrome
sudo apt-get update
sudo apt-get install google-chrome-stable
